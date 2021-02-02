
if __name__ == '__main__':

    from argparse import ArgumentParser
    import fileinput

    parser = ArgumentParser()
    parser.add_argument('--kind', choices=['sexism', 'racism'])
    args = parser.parse_args()

    print('doc_id\ttext\tis_hate')

    for i, line in enumerate(fileinput.input('-')):
        line = line.strip()
        if not line:
            continue
        _, tweet, cls = line.split('\t')
        cls = '1' if cls in (args.kind, 'both') else '0'
        print(i, tweet, cls, sep='\t')

