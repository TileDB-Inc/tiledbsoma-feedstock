#!/bin/sh

args="${@##-mmacosx-version-min=10.9*}"
$NN_CC_ORIG $args -mmacosx-version-min=11.0
