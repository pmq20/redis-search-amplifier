not finished yet!!
-----------------------------



Commander, this is the psychic amplifier.

![RA2-Psychic-Amplifier.jpg](https://github.com/pmq20/redis-search-amplifier/raw/master/RA2-Psychic-Amplifier.jpg)

I'm just kidding. But seriously, we are talking about `redis-search-amplifier` here.

redis-search-amplifier
======================

Those below are no easy tasks:

1. Segmenting Chineses sentences into words
2. Transferring Chinesee characters into its Pinyin forms

They are difficult in that:

1. Effective Chinese wrod-segmentation requires sophisticated algorithms and accumulated statistical data.
2. Through one of Chinese Homographs rules -- 多音字, contexts affect the Pinyinize process

Those difficult tasks lies at the core of the effectiveness of `redis-search`([huacnlee/redis-search](https://github.com/huacnlee/redis-search)). The solutions that `redis-search` takes are to depend upon ruby gem `chinese_pinyin` and gem `rmmseg-cpp-huacnlee`, which only provides naive support for the in-fact much harder problem.

In real-world experiments, we found that the two gems are far from satisfaction. We found `chinese_pinyin` transforming `银行` into `yin xing` and `rmmseg-cpp-huacnlee` not seeing `分析` as a word inside the sentence `我们上了一节电路分析课`.

## So?

Yeah, `redis-search` combined with the two gems is good, it is fast like a lightening when generating indexes. We will continue using them. But we want somehow better, in the same time.

So who best handles the above difficult tasks? Search Engines! They've been doing this all the time, having spent a lot of money and human intelligence.

We shall do it in this way.
1. `redis-search` generates indexes as usual
2. every time `redis-search` updates or creates an index-item, `redis-search-amplifier` asynchronously got a task
3. In handling the task, we contact the remote search engine, input the `title` sentence as a search query, see how the search engine handles the segmentation task, get more words, and use them to optimize the redis index that redis-search has produced before
4. Also, we contact the Google Translate API, which features sophisticated Romanization support for Chinese to see if we have a better Pinyin, and in case we had, we shall update redis-search to reflect this discovery.
5. Yeah, it keeps running and running like this!

## Install

Go get a API Access ID and Secret from [https://code.google.com/apis/console/?api=translate&promo=tr&pli=1](https://code.google.com/apis/console/?api=translate&promo=tr&pli=1)

## Credits

* [huacnlee](https://github.com/huacnlee/): I learnt a lot from your code, thank you.
* [yunlong](https://github.com/yunlong): You enlightened me, thanks a lot!
