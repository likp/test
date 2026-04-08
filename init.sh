#!/bin/bash

git config --global --add http.https://devopstest.scb.intra/SCB/SCB/_git/.extraHeader "AUTHORIZATION: Basic $(printf ":$GIT_PERSONAL_ACCESS_TOKEN" | base64 -w0)"

