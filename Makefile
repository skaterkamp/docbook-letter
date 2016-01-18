
examples: ad-template.pdf gabler-test.pdf

gabler-test.pdf:
	mkdir -p target
	xsltproc dinbriefFormB.xsl examples/gabler-test.xml | xmllint --format - > target/gabler-test.fo
	fop -r -fo target/gabler-test.fo -pdf target/gabler-test.pdf

ad-template.pdf:
	mkdir -p target
	cp examples/ad-template.ad target
	cp examples/caterpillar* target
	(cd target; asciidoctor ad-template.ad)
	(cd target; xsltproc ../dinbriefFormB.xsl ad-template.xml | xmllint --format - > ad-template.fo)
	(cd target; fop -r -fo ad-template.fo -pdf ad-template.pdf)

clean:
	rm target/*
	rmdir target
