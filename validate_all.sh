#!/bin/bash

# just for faster testing of validation on all input files
for f in in/*.xhtml
do
	java XSDValidator stylesheet.xsd $f
done
