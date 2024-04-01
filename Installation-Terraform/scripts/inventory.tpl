[ec2]
%{ for instance in input_list ~}
${instance}
%{ endfor ~}

