Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2MHp7SH008461
 for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2016 13:51:07 -0400
Received: by mail-ig0-f176.google.com with SMTP id l20so14698637igf.0
 for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2016 10:51:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN=9EoR_QojJRY6egdWUQQHemEwxBKNdQE+6Lc7TdHboPeKDEQ@mail.gmail.com>
References: <CAN=9EoR_QojJRY6egdWUQQHemEwxBKNdQE+6Lc7TdHboPeKDEQ@mail.gmail.com>
Date: Tue, 22 Mar 2016 10:51:04 -0700
Message-ID: <CAN=9EoQn6o+YY=jfxQJ_HOQbxv1=7a_brQkEyQ-+YpBOBv=VZA@mail.gmail.com>
Subject: Re: selinux-query
From: Naina Emmanuel <nemmanuel1992@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bd7585a6c31ee052ea6db37
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bd7585a6c31ee052ea6db37
Content-Type: text/plain; charset=UTF-8

Good evening!
i am working on selinux, centos 7... i have downloaded some .te files from
the internet (squid.te, ftp.te, rpc.te, samba.te .. etc)
but when i compile these .te file through #make -f
/usr/share/selinux/devel/include/MakeFile
but shows error in all mentioned .te files
not even getting installed through #semodule -i ftp.pp   (for all mentioned
.te files) plz help me regarding this..
thanks in advanced









*Engr. Naina Emmanuel*
*Linux Essential Certified (LEPDC)*
*Cisco Certified Network Associate (CCNA)*

*Computer Engineering Department, UET Taxila*

*Information Security, CS Department, CIIT Islamabad*

On Tue, Mar 22, 2016 at 10:35 AM, Naina Emmanuel <nemmanuel1992@gmail.com>
wrote:

>
> Good evening!
> I am master's student and working on SELinux... As a project
> Scenario: I had mysql policy module and in mysql.te file made some changes
> (commented some allow rules, bold in the code below) and then tried to
> reload it through <semodule. -R mysql.pp> but everytime I get the failed
> message. "failed on mysql.pp"
> Even in my own created modules I get the failed message (not a base
> module) and i am using centos 7.
> Please guide me through this.
>
> Thanks in advance
>
> # Copyright (C) 2007 MySQL AB
> # Use is subject to license terms
> #
> # This program is free software; you can redistribute it and/or modify
> # it under the terms of the GNU General Public License as published by
> # the Free Software Foundation; version 2 of the License.
> #
> # This program is distributed in the hope that it will be useful,
> # but WITHOUT ANY WARRANTY; without even the implied warranty of
> # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> # GNU General Public License for more details.
> #
> # You should have received a copy of the GNU General Public License
> # along with this program; if not, write to the Free Software
> # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301, USA
>
> policy_module(mysql,1.0.0)
>
> ########################################
> #
> # Declarations
> #
>
> type mysqld_t;
> type mysqld_exec_t;
> init_daemon_domain(mysqld_t,mysqld_exec_t)
>
> type mysqld_var_run_t;
> files_pid_file(mysqld_var_run_t)
>
> type mysqld_db_t;
> files_type(mysqld_db_t)
>
> type mysqld_etc_t alias etc_mysqld_t;
> files_config_file(mysqld_etc_t)
>
> type mysqld_log_t;
> logging_log_file(mysqld_log_t)
>
> type mysqld_tmp_t;
> files_tmp_file(mysqld_tmp_t)
>
> ########################################
> #
> # Local policy
> #
>
> allow mysqld_t self:capability { dac_override setgid setuid sys_resource
> net_bind_service };
> dontaudit mysqld_t self:capability sys_tty_config;
> allow mysqld_t self:process { setsched getsched setrlimit signal_perms
> rlimitinh };
> allow mysqld_t self:fifo_file { read write };
> allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
> allow mysqld_t self:tcp_socket create_stream_socket_perms;
> allow mysqld_t self:udp_socket create_socket_perms;
>
>
> *#allow mysqld_t mysqld_db_t:dir create_dir_perms;#allow mysqld_t
> mysqld_db_t:file create_file_perms;*
> allow mysqld_t mysqld_db_t:lnk_file create_lnk_perms;
> files_var_lib_filetrans(mysqld_t,mysqld_db_t,{ dir file })
>
> allow mysqld_t mysqld_etc_t:file { getattr read };
> allow mysqld_t mysqld_etc_t:lnk_file { getattr read };
> allow mysqld_t mysqld_etc_t:dir list_dir_perms;
>
> allow mysqld_t mysqld_log_t:file create_file_perms;
> logging_log_filetrans(mysqld_t,mysqld_log_t,file)
>
> allow mysqld_t mysqld_tmp_t:dir create_dir_perms;
> allow mysqld_t mysqld_tmp_t:file create_file_perms;
> files_tmp_filetrans(mysqld_t, mysqld_tmp_t, { file dir })
>
> allow mysqld_t mysqld_var_run_t:dir rw_dir_perms;
> allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;
> allow mysqld_t mysqld_var_run_t:file create_file_perms;
> files_pid_filetrans(mysqld_t,mysqld_var_run_t,file)
>
> kernel_read_system_state(mysqld_t)
> kernel_read_kernel_sysctls(mysqld_t)
>
> corenet_non_ipsec_sendrecv(mysqld_t)
> corenet_tcp_sendrecv_all_if(mysqld_t)
> corenet_udp_sendrecv_all_if(mysqld_t)
> corenet_tcp_sendrecv_all_nodes(mysqld_t)
> corenet_udp_sendrecv_all_nodes(mysqld_t)
> corenet_tcp_sendrecv_all_ports(mysqld_t)
> corenet_udp_sendrecv_all_ports(mysqld_t)
> corenet_tcp_bind_all_nodes(mysqld_t)
> corenet_tcp_bind_mysqld_port(mysqld_t)
> corenet_tcp_connect_mysqld_port(mysqld_t)
> corenet_sendrecv_mysqld_client_packets(mysqld_t)
> corenet_sendrecv_mysqld_server_packets(mysqld_t)
>
> dev_read_sysfs(mysqld_t)
>
> fs_getattr_all_fs(mysqld_t)
> fs_search_auto_mountpoints(mysqld_t)
>
> term_dontaudit_use_console(mysqld_t)
>
> domain_use_interactive_fds(mysqld_t)
>
> files_getattr_var_lib_dirs(mysqld_t)
> files_read_etc_runtime_files(mysqld_t)
> files_read_etc_files(mysqld_t)
> files_read_usr_files(mysqld_t)
> files_search_var_lib(mysqld_t)
>
> auth_use_nsswitch(mysqld_t)
>
> init_use_fds(mysqld_t)
> init_use_script_ptys(mysqld_t)
>
> libs_use_ld_so(mysqld_t)
> libs_use_shared_libs(mysqld_t)
>
> logging_send_syslog_msg(mysqld_t)
>
> miscfiles_read_localization(mysqld_t)
>
> sysnet_read_config(mysqld_t)
>
> userdom_dontaudit_use_unpriv_user_fds(mysqld_t)
> # for /root/.my.cnf - should not be needed:
> userdom_read_sysadm_home_content_files(mysqld_t)
>
> ifdef(`distro_redhat',`
>     # because Fedora has the sock_file in the database directory
>     type_transition mysqld_t mysqld_db_t:sock_file mysqld_var_run_t;
> ')
>
> ifdef(`targeted_policy',`
>     term_dontaudit_use_unallocated_ttys(mysqld_t)
>     term_dontaudit_use_generic_ptys(mysqld_t)
>     files_dontaudit_read_root_files(mysqld_t)
> ')
>
> optional_policy(`
>     daemontools_service_domain(mysqld_t, mysqld_exec_t)
> ')
>
> optional_policy(`
>     seutil_sigchld_newrole(mysqld_t)
> ')
>
> optional_policy(`
>     udev_read_db(mysqld_t)
> ')
>
>
>
>
>
>
>
>
> *Engr. Naina Emmanuel*
> *Linux Essential Certified (LEPDC)*
> *Cisco Certified Network Associate (CCNA)*
>
> *Computer Engineering Department, UET Taxila*
>
> *Information Security, CS Department, CIIT Islamabad*
>

--047d7bd7585a6c31ee052ea6db37
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good evening!<div>i am working on selinux, centos 7... i h=
ave downloaded some .te files from the internet (squid.te, ftp.te, rpc.te, =
samba.te .. etc)</div><div>but when i compile these .te file through #make =
-f <font color=3D"#545454"><span style=3D"line-height:18.2px">/usr/share/se=
linux/devel/include/MakeFile but shows error in all mentioned .te files</sp=
an></font></div><div><font color=3D"#545454"><span style=3D"line-height:18.=
2px">not even getting installed through #semodule -i ftp.pp =C2=A0 (for all=
 mentioned .te files) plz help me regarding this..</span></font></div><div>=
<font color=3D"#545454"><span style=3D"line-height:18.2px">thanks in advanc=
ed</span></font></div></div><div class=3D"gmail_extra"><br clear=3D"all"><d=
iv><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div><font size=3D"4"><b><br></b></font></div=
><font size=3D"4"><b><div><font size=3D"4"><b><br></b></font></div><div><fo=
nt size=3D"4"><b><br></b></font></div><div><font size=3D"4"><b><br></b></fo=
nt></div><div><font size=3D"4"><b><br></b></font></div><div><font size=3D"4=
"><b><br></b></font></div><div><font size=3D"4"><b><br></b></font></div><di=
v><font size=3D"4"><b><br></b></font></div><font color=3D"#666666"><i>Engr.=
 Naina Emmanuel</i></font></b></font><div><b style=3D"color:rgb(102,102,102=
);font-size:small">Linux Essential Certified (LEPDC)</b><font color=3D"#666=
666" size=3D"2"><b><br></b></font></div><div><font color=3D"#666666" size=
=3D"2"><b>Cisco Certified Network Associate (CCNA)</b></font></div><div><b =
style=3D"color:rgb(102,102,102);font-size:small">Computer Engineering Depar=
tment, UET Taxila<br></b></div><div><b style=3D"color:rgb(102,102,102);font=
-size:small">Information Security, CS Department, CIIT Islamabad<br></b></d=
iv></div></div></div></div></div></div></div></div></div></div></div></div>
<br><div class=3D"gmail_quote">On Tue, Mar 22, 2016 at 10:35 AM, Naina Emma=
nuel <span dir=3D"ltr">&lt;<a href=3D"mailto:nemmanuel1992@gmail.com" targe=
t=3D"_blank">nemmanuel1992@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr"><br clear=3D"all"><div><div><div dir=3D"=
ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><div style=
=3D"font-size:12.8px"><p dir=3D"ltr" style=3D"font-size:12.8px">Good evenin=
g!<br>I am master&#39;s student and working on SELinux... As a project<br>S=
cenario: I had mysql policy module and in mysql.te file made some changes (=
commented some allow rules, bold in the code below) and then tried to reloa=
d it through &lt;semodule. -R mysql.pp&gt; but everytime I get the failed m=
essage. &quot;failed on mysql.pp&quot;<br>Even in my own created modules I =
get the failed message (not a base module) and i am using centos 7.<br>Plea=
se guide me through this.</p><p dir=3D"ltr" style=3D"font-size:12.8px">Than=
ks in advance</p><br style=3D"font-size:12.8px"><span style=3D"font-size:12=
.8px"># Copyright (C) 2007 MySQL AB</span><br style=3D"font-size:12.8px"><s=
pan style=3D"font-size:12.8px"># Use is subject to license terms</span><br =
style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">#</span><br sty=
le=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># This program is =
free software; you can redistribute it and/or modify</span><br style=3D"fon=
t-size:12.8px"><span style=3D"font-size:12.8px"># it under the terms of the=
 GNU General Public License as published by</span><br style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px"># the Free Software Foundation; vers=
ion 2 of the License.</span><br style=3D"font-size:12.8px"><span style=3D"f=
ont-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px"># This program is distributed in the hope that it will be use=
ful,</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
# but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br =
style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the</span><br style=3D"fo=
nt-size:12.8px"><span style=3D"font-size:12.8px"># GNU General Public Licen=
se for more details.</span><br style=3D"font-size:12.8px"><span style=3D"fo=
nt-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=3D"font-=
size:12.8px"># You should have received a copy of the GNU General Public Li=
cense</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"=
># along with this program; if not, write to the Free Software</span><br st=
yle=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># Foundation, Inc=
., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA</span><br st=
yle=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px">policy_module(mysql,1.0.0)</span><br style=3D"font-size:12.8p=
x"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">########=
######################</span><span style=3D"font-size:12.8px">##########</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">#</span=
><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"># Declarat=
ions</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
#</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span=
 style=3D"font-size:12.8px">type mysqld_t;</span><br style=3D"font-size:12.=
8px"><span style=3D"font-size:12.8px">type mysqld_exec_t;</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">init_daemon_domain(m=
ysqld_t,</span><span style=3D"font-size:12.8px">mysqld_exec_t)</span><br st=
yle=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px">type mysqld_var_run_t;</span><br style=3D"font-size:12.8px"><=
span style=3D"font-size:12.8px">files_pid_file(mysqld_var_run_</span><span =
style=3D"font-size:12.8px">t)</span><br style=3D"font-size:12.8px"><br styl=
e=3D"font-size:12.8px"><span style=3D"font-size:12.8px">type mysqld_db_t;</=
span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">files_=
type(mysqld_db_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-si=
ze:12.8px"><span style=3D"font-size:12.8px">type mysqld_etc_t alias etc_mys=
qld_t;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">files_config_file(mysqld_etc_</span><span style=3D"font-size:12.8px">t)</=
span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span st=
yle=3D"font-size:12.8px">type mysqld_log_t;</span><br style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px">logging_log_file(mysqld_log_t)</span=
><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">type mysqld_tmp_t;</span><br style=3D"font-size:12.8p=
x"><span style=3D"font-size:12.8px">files_tmp_file(mysqld_tmp_t)</span><br =
style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"fo=
nt-size:12.8px">##############################</span><span style=3D"font-si=
ze:12.8px">##########</span><br style=3D"font-size:12.8px"><span style=3D"f=
ont-size:12.8px">#</span><br style=3D"font-size:12.8px"><span style=3D"font=
-size:12.8px"># Local policy</span><br style=3D"font-size:12.8px"><span sty=
le=3D"font-size:12.8px">#</span><br style=3D"font-size:12.8px"><br style=3D=
"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:cap=
ability { dac_override setgid setuid sys_resource net_bind_service };</span=
><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">dontaudit =
mysqld_t self:capability sys_tty_config;</span><br style=3D"font-size:12.8p=
x"><span style=3D"font-size:12.8px">allow mysqld_t self:process { setsched =
getsched setrlimit signal_perms rlimitinh };</span><br style=3D"font-size:1=
2.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:fifo_file { rea=
d write };</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12=
.8px">allow mysqld_t self:unix_stream_socket create_stream_socket_perms;</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow m=
ysqld_t self:tcp_socket create_stream_socket_perms;</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t self:udp_sock=
et create_socket_perms;</span><br style=3D"font-size:12.8px"><br style=3D"f=
ont-size:12.8px"><b style=3D"font-size:12.8px">#allow mysqld_t mysqld_db_t:=
dir create_dir_perms;<br>#allow mysqld_t mysqld_db_t:file create_file_perms=
;</b><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow =
mysqld_t mysqld_db_t:lnk_file create_lnk_perms;</span><br style=3D"font-siz=
e:12.8px"><span style=3D"font-size:12.8px">files_var_lib_filetrans(</span><=
span style=3D"font-size:12.8px">mysqld_t,mysqld_db_t,{ dir file })</span><b=
r style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"=
font-size:12.8px">allow mysqld_t mysqld_etc_t:file { getattr read };</span>=
<br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">allow mysql=
d_t mysqld_etc_t:lnk_file { getattr read };</span><br style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_etc_t:dir list=
_dir_perms;</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.=
8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_log_t:file crea=
te_file_perms;</span><br style=3D"font-size:12.8px"><span style=3D"font-siz=
e:12.8px">logging_log_filetrans(mysqld_</span><span style=3D"font-size:12.8=
px">t,mysqld_log_t,file)</span><br style=3D"font-size:12.8px"><br style=3D"=
font-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_tm=
p_t:dir create_dir_perms;</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">allow mysqld_t mysqld_tmp_t:file create_file_perms;</=
span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">files_=
tmp_filetrans(mysqld_t, mysqld_tmp_t, { file dir })</span><br style=3D"font=
-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8p=
x">allow mysqld_t mysqld_var_run_t:dir rw_dir_perms;</span><br style=3D"fon=
t-size:12.8px"><span style=3D"font-size:12.8px">allow mysqld_t mysqld_var_r=
un_t:sock_file create_file_perms;</span><br style=3D"font-size:12.8px"><spa=
n style=3D"font-size:12.8px">allow mysqld_t mysqld_var_run_t:file create_fi=
le_perms;</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">files_pid_filetrans(mysqld_t,</span><span style=3D"font-size:12.8px">m=
ysqld_var_run_t,file)</span><br style=3D"font-size:12.8px"><br style=3D"fon=
t-size:12.8px"><span style=3D"font-size:12.8px">kernel_read_system_state(</=
span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-siz=
e:12.8px"><span style=3D"font-size:12.8px">kernel_read_kernel_sysctls(</spa=
n><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-size:1=
2.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">core=
net_non_ipsec_sendrecv(</span><span style=3D"font-size:12.8px">mysqld_t)</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet=
_tcp_sendrecv_all_if(</span><span style=3D"font-size:12.8px">mysqld_t)</spa=
n><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_u=
dp_sendrecv_all_if(</span><span style=3D"font-size:12.8px">mysqld_t)</span>=
<br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_tcp=
_sendrecv_all_</span><span style=3D"font-size:12.8px">nodes(mysqld_t)</span=
><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_ud=
p_sendrecv_all_</span><span style=3D"font-size:12.8px">nodes(mysqld_t)</spa=
n><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_t=
cp_sendrecv_all_</span><span style=3D"font-size:12.8px">ports(mysqld_t)</sp=
an><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_=
udp_sendrecv_all_</span><span style=3D"font-size:12.8px">ports(mysqld_t)</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet=
_tcp_bind_all_nodes(</span><span style=3D"font-size:12.8px">mysqld_t)</span=
><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_tc=
p_bind_mysqld_port(</span><span style=3D"font-size:12.8px">mysqld_t)</span>=
<br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_tcp=
_connect_mysqld_</span><span style=3D"font-size:12.8px">port(mysqld_t)</spa=
n><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">corenet_s=
endrecv_mysqld_</span><span style=3D"font-size:12.8px">client_packets(mysql=
d_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
corenet_sendrecv_mysqld_</span><span style=3D"font-size:12.8px">server_pack=
ets(mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:1=
2.8px"><span style=3D"font-size:12.8px">dev_read_sysfs(mysqld_t)</span><br =
style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"fo=
nt-size:12.8px">fs_getattr_all_fs(mysqld_t)</span><br style=3D"font-size:12=
.8px"><span style=3D"font-size:12.8px">fs_search_auto_mountpoints(</span><s=
pan style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-size:12.8p=
x"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">term_don=
taudit_use_console(</span><span style=3D"font-size:12.8px">mysqld_t)</span>=
<br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">domain_use_interactive_fds(</span><span style=3D"font=
-size:12.8px">mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"f=
ont-size:12.8px"><span style=3D"font-size:12.8px">files_getattr_var_lib_dir=
s(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font=
-size:12.8px"><span style=3D"font-size:12.8px">files_read_etc_runtime_files=
(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=3D"font-=
size:12.8px"><span style=3D"font-size:12.8px">files_read_etc_files(mysqld_t=
)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">fil=
es_read_usr_files(mysqld_t)</span><br style=3D"font-size:12.8px"><span styl=
e=3D"font-size:12.8px">files_search_var_lib(mysqld_t)</span><br style=3D"fo=
nt-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.=
8px">auth_use_nsswitch(mysqld_t)</span><br style=3D"font-size:12.8px"><br s=
tyle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">init_use_fds(mys=
qld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">init_use_script_ptys(mysqld_t)</span><br style=3D"font-size:12.8px"><br s=
tyle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">libs_use_ld_so(m=
ysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8=
px">libs_use_shared_libs(mysqld_t)</span><br style=3D"font-size:12.8px"><br=
 style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">logging_send_s=
yslog_msg(</span><span style=3D"font-size:12.8px">mysqld_t)</span><br style=
=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D"font-si=
ze:12.8px">miscfiles_read_localization(</span><span style=3D"font-size:12.8=
px">mysqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:1=
2.8px"><span style=3D"font-size:12.8px">sysnet_read_config(mysqld_t)</span>=
<br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">userdom_dontaudit_use_unpriv_</span><span style=3D"fo=
nt-size:12.8px">user_fds(mysqld_t)</span><br style=3D"font-size:12.8px"><sp=
an style=3D"font-size:12.8px"># for /root/.my.cnf - should not be needed:</=
span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">userdo=
m_read_sysadm_home_</span><span style=3D"font-size:12.8px">content_files(my=
sqld_t)</span><br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"=
><span style=3D"font-size:12.8px">ifdef(`distro_redhat&#39;,`</span><br sty=
le=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0=
 # because Fedora has the sock_file in the database directory</span><br sty=
le=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0=
 type_transition mysqld_t mysqld_db_t:sock_file mysqld_var_run_t;</span><br=
 style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&#39;)</span><=
br style=3D"font-size:12.8px"><br style=3D"font-size:12.8px"><span style=3D=
"font-size:12.8px">ifdef(`targeted_policy&#39;,`</span><br style=3D"font-si=
ze:12.8px"><span style=3D"font-size:12.8px">=C2=A0=C2=A0=C2=A0 term_dontaud=
it_use_</span><span style=3D"font-size:12.8px">unallocated_ttys(mysqld_t)</=
span><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=
=C2=A0=C2=A0 term_dontaudit_use_generic_</span><span style=3D"font-size:12.=
8px">ptys(mysqld_t)</span><br style=3D"font-size:12.8px"><span style=3D"fon=
t-size:12.8px">=C2=A0=C2=A0=C2=A0 files_dontaudit_read_root_</span><span st=
yle=3D"font-size:12.8px">files(mysqld_t)</span><br style=3D"font-size:12.8p=
x"><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"font-size:12.=
8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">option=
al_policy(`</span><br style=3D"font-size:12.8px"><span style=3D"font-size:1=
2.8px">=C2=A0=C2=A0=C2=A0 daemontools_service_domain(</span><span style=3D"=
font-size:12.8px">mysqld_t, mysqld_exec_t)</span><br style=3D"font-size:12.=
8px"><span style=3D"font-size:12.8px">&#39;)</span><br style=3D"font-size:1=
2.8px"><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">opti=
onal_policy(`</span><br style=3D"font-size:12.8px"><span style=3D"font-size=
:12.8px">=C2=A0=C2=A0=C2=A0 seutil_sigchld_newrole(mysqld_</span><span styl=
e=3D"font-size:12.8px">t)</span><br style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px">&#39;)</span><br style=3D"font-size:12.8px"><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">optional_policy(`</s=
pan><br style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=C2=A0=
=C2=A0=C2=A0 udev_read_db(mysqld_t)</span><br style=3D"font-size:12.8px"><s=
pan style=3D"font-size:12.8px">&#39;)</span><br style=3D"font-size:12.8px">=
</div><div><span style=3D"font-size:12.8px"><br></span></div><font size=3D"=
4"><b></b></font></div><font size=3D"4"><b><div><font size=3D"4"><b><br></b=
></font></div><div><font size=3D"4"><b><br></b></font></div><div><font size=
=3D"4"><b><br></b></font></div><div><font size=3D"4"><b><br></b></font></di=
v><div><font size=3D"4"><b><br></b></font></div><div><font size=3D"4"><b><b=
r></b></font></div><div><font size=3D"4"><b><br></b></font></div><font colo=
r=3D"#666666"><i>Engr. Naina Emmanuel</i></font></b></font><div><b style=3D=
"color:rgb(102,102,102);font-size:small">Linux Essential Certified (LEPDC)<=
/b><font color=3D"#666666" size=3D"2"><b><br></b></font></div><div><font co=
lor=3D"#666666" size=3D"2"><b>Cisco Certified Network Associate (CCNA)</b><=
/font></div><div><b style=3D"color:rgb(102,102,102);font-size:small">Comput=
er Engineering Department, UET Taxila<br></b></div><div><b style=3D"color:r=
gb(102,102,102);font-size:small">Information Security, CS Department, CIIT =
Islamabad<br></b></div></div></div></div></div></div></div></div></div></di=
v></div></div></div>
</div>
</blockquote></div><br></div>

--047d7bd7585a6c31ee052ea6db37--
