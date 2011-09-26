#!/bin/bash
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
cpanm --sudo YAML::XS
cpanm --sudo Hash::Merge
exit 0
