#!/usr/bin/env nextflow

// Usage: nextflow run main.nf --samplesheet samplesheet.csv -with-conda environment.yml
//
// samplesheet.csv format:
//   sample,read1,read2
//   S1,/path/S1_R1.fastq.gz,/path/S1_R2.fastq.gz
//   S2,/path/S2_R1.fastq.gz,            <- leave fastq_2 empty for single-end

params.samplesheet = 'samplesheet.csv'
params.outdir      = 'results'

process FASTQC {
    tag "$sample"
    publishDir "${params.outdir}/fastqc", mode: 'copy'

    input:
    tuple val(sample), path(reads)

    output:
    path "*_fastqc.{zip,html}"

    script:
    """
    fastqc --threads ${task.cpus} ${reads}
    """
}

process MULTIQC {
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    input:
    path fastqc_files

    output:
    path "multiqc_report.html"
    path "multiqc_data"

    script:
    """
    multiqc .
    """
}

workflow {
    reads_ch = Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->
            def reads = row.read2 ? [file(row.read1), file(row.read2)] : [file(row.read1)]
            tuple(row.sample, reads)
        }

    fastqc_out = FASTQC(reads_ch)

    MULTIQC(fastqc_out.collect())
}
