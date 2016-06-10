#!/bin/bash

for f in in/*.xhtml
do
	java XSDValidator stylesheet.xsd $f
done
