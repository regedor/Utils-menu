#!/bin/bash
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
cpanm --sudo YAML::XS
cpanm --sudo Data::Dumper
exit 0
