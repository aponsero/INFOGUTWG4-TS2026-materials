#!/bin/bash
# ============================================================
#  Quality control: FastQC for every sample, then MultiQC
# ============================================================
#
#  How to run:
#     conda activate qc
#     bash run_qc.sh
#
#  The samplesheet must look like this (comma-separated):
#     sample,read1,read2
#     S1,/path/S1_1.fastq.gz,/path/S1_2.fastq.gz
# ============================================================


# ---- 1. Settings (change these if you need to) -------------

SAMPLESHEET="samplesheet.csv"   # the file with your samples
OUTDIR="manual_results"                # where the results will be saved


# ---- 2. Create the output folders --------------------------

mkdir -p "$OUTDIR/fastqc"
mkdir -p "$OUTDIR/multiqc"


# ---- 3. Run FastQC on every sample -------------------------

# "tail -n +2"  -> read the samplesheet, but skip line 1 (the header)
# "tr -d '\r'"  -> remove hidden Windows line endings, just in case
for line in $(tail -n +2 "$SAMPLESHEET" | tr -d '\r')
do
    # Cut the line at the commas and take column 1, 2 and 3
    sample=$(echo "$line" | cut -d',' -f1)
    read1=$(echo "$line"  | cut -d',' -f2)
    read2=$(echo "$line"  | cut -d',' -f3)

    echo "Starting FastQC for sample: $sample"

    # The "&" at the end runs FastQC in the background,
    # so the loop can already start the next sample.
    # This is what makes all samples run at the same time (in parallel).
    fastqc --outdir "$OUTDIR/fastqc" "$read1" "$read2" &
done


# ---- 4. Wait until all FastQC jobs are finished ------------

wait
echo "All FastQC jobs are finished."


# ---- 5. Run MultiQC to combine all reports into one --------

echo "Running MultiQC..."
multiqc --force --outdir "$OUTDIR/multiqc" "$OUTDIR/fastqc"

echo "Done! Open this file in your browser:"
echo "   $OUTDIR/multiqc/multiqc_report.html"
