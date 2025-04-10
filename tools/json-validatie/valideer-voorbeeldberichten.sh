#!/bin/bash

docker build --tag rvig/perl-json-validation .
cd ../../
docker run -v .:/repo -ti --rm rvig/perl-json-validation
