#!/bin/sh

args="${@##-mmacosx-version-min=10.9*}"
$NN_CXX_ORIG $args -mmacosx-version-min=11
