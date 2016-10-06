install_dependencies:
  pkg.installed:
    - pkgs:
       - curl 
       - openssh-server 
       - ca-certificates 
       - postfix     

get_gitlabpackage:
  file.managed:
    - name: /tmp/gitlab-ce_8.12.4-ce.0_amd64.deb
    - source: https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/precise/gitlab-ce_8.12.4-ce.0_amd64.deb/download
    - source_hash: md5=8b2afa54a9b699c667753509df0d8a08

install_gitlab_deb:
   cmd.run:
    - name: dpkg -i /tmp/gitlab-ce_8.12.4-ce.0_amd64.deb
    - require:
      - install_dependencies
      - get_gitlabpackage

configure_gitlab:
   cmd.run:
    - name: gitlab-ctl reconfigure
    - require:
      - install_dependencies
      - get_gitlabpackage
      - install_gitlab_deb


#install_gitlab_deb:
#  pkg.installed:
#    - sources:
#      - gitlab-ce: https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/precise/gitlab-ce_8.12.4-ce.0_amd64.deb/download 
#    - require:
#      - install_dependencies
