Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2MHZK0w004348
 for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2016 13:35:20 -0400
Received: by mail-io0-f181.google.com with SMTP id c63so70753176iof.0
 for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2016 10:35:18 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 22 Mar 2016 10:35:18 -0700
Message-ID: <CAN=9EoR_QojJRY6egdWUQQHemEwxBKNdQE+6Lc7TdHboPeKDEQ@mail.gmail.com>
Subject: selinux-query
From: Naina Emmanuel <nemmanuel1992@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113ea71c09c24d052ea6a368
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ea71c09c24d052ea6a368
Content-Type: text/plain; charset=UTF-8

Good evening!
I am master's student and working on SELinux... As a project
Scenario: I had mysql policy module and in mysql.te file made some changes
(commented some allow rules, bold in the code below) and then tried to
reload it through <semodule. -R mysql.pp> but everytime I get the failed
message. "failed on mysql.pp"
Even in my own created modules I get the failed message (not a base module)
and i am using centos 7.
Please guide me through this.

Thanks in advance

# Copyright (C) 2007 MySQL AB
# Use is subject to license terms
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
USA

policy_module(mysql,1.0.0)

########################################
#
# Declarations
#

type mysqld_t;
type mysqld_exec_t;
init_daemon_domain(mysqld_t,mysqld_exec_t)

type mysqld_var_run_t;
files_pid_file(mysqld_var_run_t)

type mysqld_db_t;
files_type(mysqld_db_t)

type mysqld_etc_t alias etc_mysqld_t;
files_config_file(mysqld_etc_t)

type mysqld_log_t;
logging_log_file(mysqld_log_t)

type mysqld_tmp_t;
files_tmp_file(mysqld_tmp_t)

########################################
#
# Local policy
#

allow mysqld_t self:capability { dac_override setgid setuid sys_resource
net_bind_service };
dontaudit mysqld_t self:capability sys_tty_config;
allow mysqld_t self:process { setsched getsched setrlimit signal_perms
rlimitinh };
allow mysqld_t self:fifo_file { read write };
allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
allow mysqld_t self:tcp_socket create_stream_socket_perms;
allow mysqld_t self:udp_socket create_socket_perms;


*#allow mysqld_t mysqld_db_t:dir create_dir_perms;#allow mysqld_t
mysqld_db_t:file create_file_perms;*
allow mysqld_t mysqld_db_t:lnk_file create_lnk_perms;
files_var_lib_filetrans(mysqld_t,mysqld_db_t,{ dir file })

allow mysqld_t mysqld_etc_t:file { getattr read };
allow mysqld_t mysqld_etc_t:lnk_file { getattr read };
allow mysqld_t mysqld_etc_t:dir list_dir_perms;

allow mysqld_t mysqld_log_t:file create_file_perms;
logging_log_filetrans(mysqld_t,mysqld_log_t,file)

allow mysqld_t mysqld_tmp_t:dir create_dir_perms;
allow mysqld_t mysqld_tmp_t:file create_file_perms;
files_tmp_filetrans(mysqld_t, mysqld_tmp_t, { file dir })

allow mysqld_t mysqld_var_run_t:dir rw_dir_perms;
allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;
allow mysqld_t mysqld_var_run_t:file create_file_perms;
files_pid_filetrans(mysqld_t,mysqld_var_run_t,file)

kernel_read_system_state(mysqld_t)
kernel_read_kernel_sysctls(mysqld_t)

corenet_non_ipsec_sendrecv(mysqld_t)
corenet_tcp_sendrecv_all_if(mysqld_t)
corenet_udp_sendrecv_all_if(mysqld_t)
corenet_tcp_sendrecv_all_nodes(mysqld_t)
corenet_udp_sendrecv_all_nodes(mysqld_t)
corenet_tcp_sendrecv_all_ports(mysqld_t)
corenet_udp_sendrecv_all_ports(mysqld_t)
corenet_tcp_bind_all_nodes(mysqld_t)
corenet_tcp_bind_mysqld_port(mysqld_t)
corenet_tcp_connect_mysqld_port(mysqld_t)
corenet_sendrecv_mysqld_client_packets(mysqld_t)
corenet_sendrecv_mysqld_server_packets(mysqld_t)

dev_read_sysfs(mysqld_t)

fs_getattr_all_fs(mysqld_t)
fs_search_auto_mountpoints(mysqld_t)

term_dontaudit_use_console(mysqld_t)

domain_use_interactive_fds(mysqld_t)

files_getattr_var_lib_dirs(mysqld_t)
files_read_etc_runtime_files(mysqld_t)
files_read_etc_files(mysqld_t)
files_read_usr_files(mysqld_t)
files_search_var_lib(mysqld_t)

auth_use_nsswitch(mysqld_t)

init_use_fds(mysqld_t)
init_use_script_ptys(mysqld_t)

libs_use_ld_so(mysqld_t)
libs_use_shared_libs(mysqld_t)

logging_send_syslog_msg(mysqld_t)

miscfiles_read_localization(mysqld_t)

sysnet_read_config(mysqld_t)

userdom_dontaudit_use_unpriv_user_fds(mysqld_t)
# for /root/.my.cnf - should not be needed:
userdom_read_sysadm_home_content_files(mysqld_t)

ifdef(`distro_redhat',`
    # because Fedora has the sock_file in the database directory
    type_transition mysqld_t mysqld_db_t:sock_file mysqld_var_run_t;
')

ifdef(`targeted_policy',`
    term_dontaudit_use_unallocated_ttys(mysqld_t)
    term_dontaudit_use_generic_ptys(mysqld_t)
    files_dontaudit_read_root_files(mysqld_t)
')

optional_policy(`
    daemontools_service_domain(mysqld_t, mysqld_exec_t)
')

optional_policy(`
    seutil_sigchld_newrole(mysqld_t)
')

optional_policy(`
    udev_read_db(mysqld_t)
')








*Engr. Naina Emmanuel*
*Linux Essential Certified (LEPDC)*
*Cisco Certified Network Associate (CCNA)*

*Computer Engineering Department, UET Taxila*

*Information Security, CS Department, CIIT Islamabad*

--001a113ea71c09c24d052ea6a368
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div class=3D"gmail_signature"><div=
 dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><di=
v style=3D"font-size:12.8px"><p dir=3D"ltr" style=3D"font-size:12.8px">Good=
 evening!<br>I am master&#39;s student and working on SELinux... As a proje=
ct<br>Scenario: I had mysql policy module and in mysql.te file made some ch=
anges (commented some allow rules, bold in the code below) and then tried t=
o reload it through &lt;semodule. -R mysql.pp&gt; but everytime I get the f=
ailed message. &quot;failed on mysql.pp&quot;<br>Even in my own created mod=
ules I get the failed message (not a base module) and i am using centos 7.<=
br>Please guide me through this.</p><p dir=3D"ltr" style=3D"font-size:12.8p=
x">Thanks in advance</p><br style=3D"font-size:12.8px"><span style=3D"font-=
size:12.8px"># Copyright (C) 2007 MySQL AB</span><br style=3D"font-size:12.=
8px"><span style=3D"font-size:12.8px"># Use is subject to license terms</sp=
an><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">#</span>=
<br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># This prog=
ram is free software; you can redistribute it and/or modify</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># it under the terms=
 of the GNU General Public License as published by</span><br style=3D"font-=
size:12.8px"><span style=3D"font-size:12.8px"># the Free Software Foundatio=
n; version 2 of the License.</span><br style=3D"font-size:12.8px"><span sty=
le=3D"font-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px"># This program is distributed in the hope that it wil=
l be useful,</span><br style=3D"font-size:12.8px"><span style=3D"font-size:=
12.8px"># but WITHOUT ANY WARRANTY; without even the implied warranty of</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the</span><br sty=
le=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># GNU General Publ=
ic License for more details.</span><br style=3D"font-size:12.8px"><span sty=
le=3D"font-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px"># You should have received a copy of the GNU General =
Public License</span><br style=3D"font-size:12.8px"><span style=3D"font-siz=
e:12.8px"># along with this program; if not, write to the Free Software</sp=
an><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># Founda=
tion, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA</sp=
an><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span styl=
e=3D"font-size:12.8px">policy_module(mysql,1.0.0)</span><br style=3D"font-s=
ize:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
>##############################</span><span style=3D"font-size:12.8px">####=
######</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">#</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">#=
 Declarations</span><br style=3D"font-size:12.8px"><span style=3D"font-size=
:12.8px">#</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8=
px"><span style=3D"font-size:12.8px">type mysqld_t;</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">type mysqld_exec_t;</span><b=
r style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">init_daemon_d=
omain(mysqld_t,</span><span style=3D"font-size:12.8px">mysqld_exec_t)</span=
><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">type mysqld_var_run_t;</span><br style=3D"font-size:1=
2.8px"><span style=3D"font-size:12.8px">files_pid_file(mysqld_var_run_</spa=
n><span style=3D"font-size:12.8px">t)</span><br style=3D"font-size:12.8px">=
<br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">type mysqld=
_db_t;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">files_type(mysqld_db_t)</span><br style=3D"font-size:12.8px"><br style=3D=
"font-size:12.8px"><span style=3D"font-size:12.8px">type mysqld_etc_t alias=
 etc_mysqld_t;</span><br style=3D"font-size:12.8px"><span style=3D"font-siz=
e:12.8px">files_config_file(mysqld_etc_</span><span style=3D"font-size:12.8=
px">t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px">=
<span style=3D"font-size:12.8px">type mysqld_log_t;</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">logging_log_file(mysqld_log_=
t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><spa=
n style=3D"font-size:12.8px">type mysqld_tmp_t;</span><br style=3D"font-siz=
e:12.8px"><span style=3D"font-size:12.8px">files_tmp_file(mysqld_tmp_t)</sp=
an><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span styl=
e=3D"font-size:12.8px">##############################</span><span style=3D"=
font-size:12.8px">##########</span><br style=3D"font-size:12.8px"><span sty=
le=3D"font-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px"># Local policy</span><br style=3D"font-size:12.8px"><=
span style=3D"font-size:12.8px">#</span><br style=3D"font-size:12.8px"><br =
style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t =
self:capability { dac_override setgid setuid sys_resource net_bind_service =
};</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">do=
ntaudit mysqld_t self:capability sys_tty_config;</span><br style=3D"font-si=
ze:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:process { s=
etsched getsched setrlimit signal_perms rlimitinh };</span><br style=3D"fon=
t-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:fifo_fi=
le { read write };</span><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px">allow mysqld_t self:unix_stream_socket create_stream_socket_p=
erms;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
>allow mysqld_t self:tcp_socket create_stream_socket_perms;</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:=
udp_socket create_socket_perms;</span><br style=3D"font-size:12.8px"><br st=
yle=3D"font-size:12.8px"><b style=3D"font-size:12.8px">#allow mysqld_t mysq=
ld_db_t:dir create_dir_perms;<br>#allow mysqld_t mysqld_db_t:file create_fi=
le_perms;</b><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">allow mysqld_t mysqld_db_t:lnk_file create_lnk_perms;</span><br style=3D"=
font-size:12.8px"><span style=3D"font-size:12.8px">files_var_lib_filetrans(=
</span><span style=3D"font-size:12.8px">mysqld_t,mysqld_db_t,{ dir file })<=
/span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span s=
tyle=3D"font-size:12.8px">allow mysqld_t mysqld_etc_t:file { getattr read }=
;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">all=
ow mysqld_t mysqld_etc_t:lnk_file { getattr read };</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_etc_t:=
dir list_dir_perms;</span><br style=3D"font-size:12.8px"><br style=3D"font-=
size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_log_t:f=
ile create_file_perms;</span><br style=3D"font-size:12.8px"><span style=3D"=
font-size:12.8px">logging_log_filetrans(mysqld_</span><span style=3D"font-s=
ize:12.8px">t,mysqld_log_t,file)</span><br style=3D"font-size:12.8px"><br s=
tyle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t m=
ysqld_tmp_t:dir create_dir_perms;</span><br style=3D"font-size:12.8px"><spa=
n style=3D"font-size:12.8px">allow mysqld_t mysqld_tmp_t:file create_file_p=
erms;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
>files_tmp_filetrans(mysqld_t, mysqld_tmp_t, { file dir })</span><br style=
=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-si=
ze:12.8px">allow mysqld_t mysqld_var_run_t:dir rw_dir_perms;</span><br styl=
e=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysq=
ld_var_run_t:sock_file create_file_perms;</span><br style=3D"font-size:12.8=
px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_var_run_t:file c=
reate_file_perms;</span><br style=3D"font-size:12.8px"><span style=3D"font-=
size:12.8px">files_pid_filetrans(mysqld_t,</span><span style=3D"font-size:1=
2.8px">mysqld_var_run_t,file)</span><br style=3D"font-size:12.8px"><br styl=
e=3D"font-size:12.8px"><span style=3D"font-size:12.8px">kernel_read_system_=
state(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"=
font-size:12.8px"><span style=3D"font-size:12.8px">kernel_read_kernel_sysct=
ls(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"fon=
t-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8=
px">corenet_non_ipsec_sendrecv(</span><span style=3D"font-size:12.8px">mysq=
ld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
>corenet_tcp_sendrecv_all_if(</span><span style=3D"font-size:12.8px">mysqld=
_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">c=
orenet_udp_sendrecv_all_if(</span><span style=3D"font-size:12.8px">mysqld_t=
)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">cor=
enet_tcp_sendrecv_all_</span><span style=3D"font-size:12.8px">nodes(mysqld_=
t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">co=
renet_udp_sendrecv_all_</span><span style=3D"font-size:12.8px">nodes(mysqld=
_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">c=
orenet_tcp_sendrecv_all_</span><span style=3D"font-size:12.8px">ports(mysql=
d_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
corenet_udp_sendrecv_all_</span><span style=3D"font-size:12.8px">ports(mysq=
ld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
>corenet_tcp_bind_all_nodes(</span><span style=3D"font-size:12.8px">mysqld_=
t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">co=
renet_tcp_bind_mysqld_port(</span><span style=3D"font-size:12.8px">mysqld_t=
)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">cor=
enet_tcp_connect_mysqld_</span><span style=3D"font-size:12.8px">port(mysqld=
_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">c=
orenet_sendrecv_mysqld_</span><span style=3D"font-size:12.8px">client_packe=
ts(mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:=
12.8px">corenet_sendrecv_mysqld_</span><span style=3D"font-size:12.8px">ser=
ver_packets(mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"fon=
t-size:12.8px"><span style=3D"font-size:12.8px">dev_read_sysfs(mysqld_t)</s=
pan><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span sty=
le=3D"font-size:12.8px">fs_getattr_all_fs(mysqld_t)</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">fs_search_auto_mountpoints(<=
/span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-si=
ze:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
term_dontaudit_use_console(</span><span style=3D"font-size:12.8px">mysqld_t=
)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span=
 style=3D"font-size:12.8px">domain_use_interactive_fds(</span><span style=
=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-size:12.8px"><br st=
yle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">files_getattr_var=
_lib_dirs(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">files_read_etc_runti=
me_files(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">files_read_etc_files=
(mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12=
.8px">files_read_usr_files(mysqld_t)</span><br style=3D"font-size:12.8px"><=
span style=3D"font-size:12.8px">files_search_var_lib(mysqld_t)</span><br st=
yle=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px">auth_use_nsswitch(mysqld_t)</span><br style=3D"font-size:12.8=
px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">init_us=
e_fds(mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-si=
ze:12.8px">init_use_script_ptys(mysqld_t)</span><br style=3D"font-size:12.8=
px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">libs_us=
e_ld_so(mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-=
size:12.8px">libs_use_shared_libs(mysqld_t)</span><br style=3D"font-size:12=
.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">loggi=
ng_send_syslog_msg(</span><span style=3D"font-size:12.8px">mysqld_t)</span>=
<br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">miscfiles_read_localization(</span><span style=3D"fon=
t-size:12.8px">mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"=
font-size:12.8px"><span style=3D"font-size:12.8px">sysnet_read_config(mysql=
d_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><s=
pan style=3D"font-size:12.8px">userdom_dontaudit_use_unpriv_</span><span st=
yle=3D"font-size:12.8px">user_fds(mysqld_t)</span><br style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px"># for /root/.my.cnf - should not be =
needed:</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8p=
x">userdom_read_sysadm_home_</span><span style=3D"font-size:12.8px">content=
_files(mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-siz=
e:12.8px"><span style=3D"font-size:12.8px">ifdef(`distro_redhat&#39;,`</spa=
n><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=
=A0=C2=A0 # because Fedora has the sock_file in the database directory</spa=
n><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=
=A0=C2=A0 type_transition mysqld_t mysqld_db_t:sock_file mysqld_var_run_t;<=
/span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&#39;=
)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span=
 style=3D"font-size:12.8px">ifdef(`targeted_policy&#39;,`</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0 t=
erm_dontaudit_use_</span><span style=3D"font-size:12.8px">unallocated_ttys(=
mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">=C2=A0=C2=A0=C2=A0 term_dontaudit_use_generic_</span><span style=3D"fo=
nt-size:12.8px">ptys(mysqld_t)</span><br style=3D"font-size:12.8px"><span s=
tyle=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0 files_dontaudit_read_root_</sp=
an><span style=3D"font-size:12.8px">files(mysqld_t)</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"fo=
nt-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">optional_policy(`</span><br style=3D"font-size:12.8px"><span style=3D"=
font-size:12.8px">=C2=A0=C2=A0=C2=A0 daemontools_service_domain(</span><spa=
n style=3D"font-size:12.8px">mysqld_t, mysqld_exec_t)</span><br style=3D"fo=
nt-size:12.8px"><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"=
font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:1=
2.8px">optional_policy(`</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0 seutil_sigchld_newrole(mysqld_</sp=
an><span style=3D"font-size:12.8px">t)</span><br style=3D"font-size:12.8px"=
><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"font-size:12.8p=
x"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">optional=
_policy(`</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">=C2=A0=C2=A0=C2=A0 udev_read_db(mysqld_t)</span><br style=3D"font-size=
:12.8px"><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"font-si=
ze:12.8px"></div><div><span style=3D"font-size:12.8px"><br></span></div><fo=
nt size=3D"4"><b></b></font></div><font size=3D"4"><b><div><font size=3D"4"=
><b><br></b></font></div><div><font size=3D"4"><b><br></b></font></div><div=
><font size=3D"4"><b><br></b></font></div><div><font size=3D"4"><b><br></b>=
</font></div><div><font size=3D"4"><b><br></b></font></div><div><font size=
=3D"4"><b><br></b></font></div><div><font size=3D"4"><b><br></b></font></di=
v><font color=3D"#666666"><i>Engr. Naina Emmanuel</i></font></b></font><div=
><b style=3D"color:rgb(102,102,102);font-size:small">Linux Essential Certif=
ied (LEPDC)</b><font color=3D"#666666" size=3D"2"><b><br></b></font></div><=
div><font color=3D"#666666" size=3D"2"><b>Cisco Certified Network Associate=
 (CCNA)</b></font></div><div><b style=3D"color:rgb(102,102,102);font-size:s=
mall">Computer Engineering Department, UET Taxila<br></b></div><div><b styl=
e=3D"color:rgb(102,102,102);font-size:small">Information Security, CS Depar=
tment, CIIT Islamabad<br></b></div></div></div></div></div></div></div></di=
v></div></div></div></div></div>
</div>

--001a113ea71c09c24d052ea6a368--
