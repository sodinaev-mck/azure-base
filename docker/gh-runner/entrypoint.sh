#!/bin/bash
export RUNNER_ALLOW_RUNASROOT="1"
./config.sh --name $GH_RUNNER_NAME --url $GH_RUNNER_URL --token $GH_RUNNER_TOKEN --unattended --replace --labels $GH_RUNNER_LABELS
./run.sh