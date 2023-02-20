SAMPLES = ['Sample1', 'Sample2', 'Sample3']

rule all:
    input:
        'results/test.txt'

rule quantify_genes:
    input:
        genome = 'resources/genome.fa',
        r1 = 'resources/{sample}.R1.fastq.gz',
        r2 = 'resources/{sample}.R2.fastq.gz'
    output:
        'results/{sample}.txt'
    shell:
        'echo {input.genome} {input.r1} {input.r2} > {output}'


rule clean:
    shell:
        'rm results/*.txt'

rule een:
    input:
        expand('results/{sample}.txt', sample = SAMPLES)
    output:
        'results/test.txt'
    run:
        with open(output[0], "w") as out:
            for i in input:
                sample = i.split("/")[1]
                out.write(sample + " has been processed\n")
