#!/usr/bin/env bash

set -x

zip_name_prefix="eflows-pycompss-"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
root_dir="$(readlink -f "${script_dir}/..")"

csar_dir="${script_dir}/csars"

rm -fr ${csar_dir}
mkdir -p ${csar_dir}

find ${root_dir} -type f \( -name 'types.yml' -o -name 'types.yaml' \) -exec bash -c "cd \$(dirname {}); rm -f types.zip; version=\$(grep template_version types.y*ml | head -1 | cut -d ':' -f 2  | sed -e 's/[[:space:]]*//'); zip -r ${csar_dir}/${zip_name_prefix}\$(dirname {} | sed -e "s@${root_dir}/@@" |tr '/' '-')-types-\${version}.zip ." \;

