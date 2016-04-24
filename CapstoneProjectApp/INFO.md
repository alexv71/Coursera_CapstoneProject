### Model description

- In this Capstone Project the NGram model with "Stupid Backoff" is using.
- Model dataset was bulit with *quanteda* R package, which is so much faster than *tm* package.
- 3% of the entire datasets were used. In this case it is a compromise value between speed, size, Shinyapp server technical requirements and accuracy.
- 2-gram, 3-gram, 4-gram and 5-gram sub-models were used with no stopwords.
- Entire model contains ~6.8 million observations.
- There is "standard" test performed:

        Overall top-3 score:     13.39 %
        Overall top-1 precision: 10.40 %
        Overall top-3 precision: 15.98 %
        Average runtime:         753.63 msec
        Number of predictions:   5751
        Total memory used:       440.42 MB    
        
        Dataset details
        Dataset "blogs" (119 lines, 2986 words, hash 5855cb01f7e86a55a6af5cd572e71bcd39803f41e70889e861a5af0f6353541b)
        Score: 13.11 %, Top-1 precision: 10.38 %, Top-3 precision: 15.54 %
        Dataset "tweets" (159 lines, 2808 words, hash c876eeb44e5d990242129629cb23a30c3328989b9777bfcae1ec5d047076e9b1)
        Score: 13.67 %, Top-1 precision: 10.42 %, Top-3 precision: 16.42 %
        
It is not a bad results.

### Problems

- Cleaning real texts from blogs and similar sources is the most important and dissicult task.
- Some non-letter symbols not only should be replaced with spaces. In this model **@** was replaced to **as** word after manual analysis ngram tables.
- misspellings, abbreviations, and acronyms added complexity.

### Further steps
- More sophisticated algorithms: "Good Turing", "Kneser-Ney" smoothing are interested to realize. Also it need some experiments with Amazon EC2 instances to determine and optimize memory and other resources usage. Amazon EC2 may be a good decision to compute Kneser-Ney smoothig and related algorithms. Some tests on local computer and EC2 instances were made. This algorithms takes a very long time on the local computer,
- Requires further study the issue of real text cleaning.
- User interface is very simple. It need to improve usability.
