Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75JMt0L022974
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:22:55 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75JMnw3009403
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 19:22:50 GMT
Received: by fk-out-0910.google.com with SMTP id 18so2283660fks.2
        for <selinux@tycho.nsa.gov>; Tue, 05 Aug 2008 12:22:49 -0700 (PDT)
Subject: [refpolicy patchJ updated Git daemon domain.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fVByRzskgrcpjPJPAHWz"
Date: Tue, 05 Aug 2008 21:16:15 +0200
Message-Id: <1217963775.7747.17.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fVByRzskgrcpjPJPAHWz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is my latest take on confining Git daemon. I removed Git user
domain and userdom_git_user_template and added a
git_daemon_git_user_template instead. There is no user domain able to
read or write git_daemon_system_content. One would have to create a user
domain, call git_daemon_git_user_template in it, and since the Git user
domain has to be a primary domain, one would also have a default user
context.

Also note that apache calls git_daemon_read_all_git_content in an
optional policy block. I have tried to wrap this call into a tunable
block first and then into optional policy. Although this did compile, it
did not yield the expected results. This is why i decided to not make
this tunable. It has to optional in my view.

The Git daemon domain is a coarse implementation. Content only has two
general types, system content and user content. Because Git daemon uses
SSH daemon to push content, the system ACLs are transparent. This means
i may be able to implement finer grained access control. For example
which Git user domain may access which Git daemon content?

diff --git a/man/man8/git_daemon_selinux.8
b/man/man8/git_daemon_selinux.8
new file mode 100644
index 0000000..c47a51a
--- /dev/null
+++ b/man/man8/git_daemon_selinux.8
@@ -0,0 +1,65 @@
+.TH  "git_daemon_selinux"  "8"  "03 Aug 2008" "domg472@gmail.com" "Git
daemon SELinux Policy documentation"
+.de EX
+.nf
+.ft CW
+..
+.de EE
+.ft R
+.fi
+..
+.SH "NAME"
+.PP
+git_daemon_selinux \- Security-Enhanced Linux policy for Git daemon.
+.SH "DESCRIPTION"
+.PP
+Security-Enhanced Linux provides security for Git daemon via flexible
mandatory access control.
+.SH FILE_CONTEXTS
+.PP
+SELinux requires files to have a files type. Files types may be
specified system wide by the administrator with the semanage command and
are restored with the restorecon command. Users may use the chcon
command to change the files type of it's files.   Policy governs the
access that Git daemon has to files.
+.TP
+Allow Git daemon to read the shared repository by adding the
git_daemon_system_content_t files type to the files and directories and
by restoring the files types.
+.PP
+.B
+semanage fcontext -a -t git_daemon_system_content_t "/srv/git(/.*)?"
+.TP
+.B
+restorecon -R -v /srv/git
+.TP
+Allow Git daemon to read the user personal repository directories by
adding the git_daemon_user_content_t files type to the files and
directories and by restoring the files types.  This also requires the
git_daemon_enable_homedirs boolean is set to true.
+.PP
+.B
+semanage fcontext -a -t git_daemon_user_content_t
"/home/*/public_git(/.*)?"
+.TP
+.B
+restorecon -R -v /home/*/public_git
+.TP
+Allow Git daemon to read the user personal configuration file.
+.PP
+.B
+chcon -t git_daemon_user_content_t /home/joe/.gitconfig
+.SH BOOLEANS
+.PP
+SELinux policy is based on least privilege required and may also be
customizable by setting a boolean with the setsebool command.
+.TP
+Allow Git daemon to read user personal repository directories with the
git_daemon_user_content_t files type.
+.PP
+.B
+setsebool -P git_daemon_enable_homedirs on
+.TP
+Allow Git daemon to use cifs for public file transfer services.
+.PP
+.B
+setsebool -P git_daemon_use_cifs on
+.TP
+Allow Git daemon to use nfs for public file transfer services.
+.PP
+.B
+setsebool -P git_daemon_use_nfs on
+.TP
+system-config-selinux is a GUI tool available to customize SELinux
policy settings.
+.SH AUTHOR
+.PP
+This manual page was written by Dominick Grift <domg472@gmail.com>.
+.SH "SEE ALSO"
+.PP
+selinux(8), git-daemon(8), setsebool(8), semanage(8), restorecon(8),
chcon(8)
diff --git a/policy/modules/kernel/corenetwork.te.in
b/policy/modules/kernel/corenetwork.te.in
index 8ccf467..0f12de4 100644
--- a/policy/modules/kernel/corenetwork.te.in
+++ b/policy/modules/kernel/corenetwork.te.in
@@ -95,6 +95,7 @@ network_port(ftp_data, tcp,20,s0)
 network_port(ftp, tcp,21,s0)
 network_port(gatekeeper, udp,1718,s0, udp,1719,s0, tcp,1721,s0,
tcp,7000,s0)
 network_port(giftd, tcp,1213,s0)
+network_port(git_daemon, tcp,9418,s0)
 network_port(gopher, tcp,70,s0, udp,70,s0)
 network_port(http_cache, tcp,3128,s0, udp,3130,s0, tcp,8080,s0,
tcp,8118,s0) # 8118 is for privoxy
 network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0,
tcp,8009,s0, tcp,8443,s0) #8443 is mod_nss default port
diff --git a/policy/modules/services/apache.te
b/policy/modules/services/apache.te
index f08dbee..ce16d08 100644
--- a/policy/modules/services/apache.te
+++ b/policy/modules/services/apache.te
@@ -441,6 +441,10 @@ optional_policy(`
 ')
=20
 optional_policy(`
+	git_daemon_read_all_git_daemon_content(httpd_t)
+')
+
+optional_policy(`
 	kerberos_use(httpd_t)
 	kerberos_read_kdc_config(httpd_t)
 ')
diff --git a/policy/modules/services/git_daemon.fc
b/policy/modules/services/git_daemon.fc
new file mode 100644
index 0000000..c50b6f3
--- /dev/null
+++ b/policy/modules/services/git_daemon.fc
@@ -0,0 +1,10 @@
+
+/srv/git/(.*)?
gen_context(system_u:object_r:git_daemon_system_content_t, s0)
+
+/usr/bin/git-daemon		--
gen_context(system_u:object_r:git_daemon_exec_t, s0)
+
+/var/www/git/gitweb.cgi	--
gen_context(system_u:object_r:httpd_gitweb_script_exec_t, s0)
+
+HOME_DIR/public_git(/.*)?
gen_context(system_u:object_r:git_daemon_user_content_t, s0)
+
+HOME_DIR/\.gitconfig	--
gen_context(system_u:object_r:git_daemon_user_content_t, s0)
diff --git a/policy/modules/services/git_daemon.if
b/policy/modules/services/git_daemon.if
new file mode 100644
index 0000000..a848240
--- /dev/null
+++ b/policy/modules/services/git_daemon.if
@@ -0,0 +1,459 @@
+## <summary>SELinux policy for Git daemon.</summary>
+## <desc>
+##	<p>
+##	Applies SELinux security to Git daemon.
+##	</p>
+## </desc>
+
+#######################################
+## <summary>
+##  The per role template for the Git daemon module.
+## </summary>
+## <desc>
+## 	<p>
+## 	This template creates derived domains which are used
+## 	for the Git daemon.
+## 	</p>
+## 	<p>
+## 	This template is invoked automatically for each user, and
+## 	generally does not need to be invoked directly
+## 	by policy writers.
+## 	</p>
+## </desc>
+## <param name=3D"userdomain_prefix">
+## 	<summary>
+## 	The prefix of the user domain (e.g., user
+## 	is the prefix for user_t).
+## 	</summary>
+## </param>
+## <param name=3D"user_domain">
+## 	<summary>
+## 	The type of the user domain.
+## 	</summary>
+## 	</param>
+## 	<param name=3D"user_role">
+## 	<summary>
+## 	The role associated with the user domain.
+## 	</summary>
+## </param>
+#
+template(`git_daemon_per_role_template', `
+	gen_require(`
+		type git_daemon_exec_t, git_daemon_user_content_t;
+	')
+
+	########################################
+	#
+	#  Git daemon public declarations.
+	#
+	type $1_git_daemon_t;
+	application_domain($1_git_daemon_t, git_daemon_exec_t)
+	role $3 types $1_git_daemon_t;
+
+	########################################
+	#
+	# Git daemon public policy.
+	#
+	allow $1_git_daemon_t self:fifo_file rw_fifo_file_perms;
+	allow $1_git_daemon_t self:netlink_route_socket { write getattr read
bind create nlmsg_read };
+	allow $1_git_daemon_t self:tcp_socket { bind read write accept create
setopt listen };
+	allow $1_git_daemon_t self:udp_socket { create connect write read
getattr };=09
+
+	allow $1_git_daemon_t $2:process sigchld;
+
+	allow $2 $1_git_daemon_t:process { ptrace signal_perms };
+
+	list_dirs_pattern($1_git_daemon_t, git_daemon_user_content_t,
git_daemon_user_content_t)
+	read_files_pattern($1_git_daemon_t, git_daemon_user_content_t,
git_daemon_user_content_t)
+	userdom_search_user_home_dirs($1, $1_git_daemon_t)
+
+	manage_dirs_pattern($2, git_daemon_user_content_t,
git_daemon_user_content_t)
+	manage_files_pattern($2, git_daemon_user_content_t,
git_daemon_user_content_t)
+	exec_files_pattern($2, git_daemon_user_content_t,
git_daemon_user_content_t)
+	userdom_user_home_dir_filetrans($1, $1_git_daemon_t,
git_daemon_user_content_t, { dir file })
+
+	relabel_dirs_pattern($2, git_daemon_user_content_t,
git_daemon_user_content_t)
+	relabel_files_pattern($2, git_daemon_user_content_t,
git_daemon_user_content_t)
+
+	domain_auto_trans($2, git_daemon_exec_t, $1_git_daemon_t)
+
+	ps_process_pattern($2, $1_git_daemon_t)
+
+	corecmd_exec_bin($1_git_daemon_t)
+	corecmd_search_bin($1_git_daemon_t)
+
+	corenet_all_recvfrom_unlabeled($1_git_daemon_t)
+	corenet_all_recvfrom_netlabel($1_git_daemon_t)
+
+ 	corenet_tcp_sendrecv_all_if($1_git_daemon_t)
+	corenet_tcp_sendrecv_all_nodes($1_git_daemon_t)
+
+ 	corenet_tcp_bind_all_nodes($1_git_daemon_t)
+
+	corenet_tcp_bind_git_daemon_port($1_git_daemon_t)
+
+	files_read_etc_files($1_git_daemon_t)
+
+	files_search_home($1_git_daemon_t)
+	files_search_usr($1_git_daemon_t)
+
+	kernel_read_system_state($1_git_daemon_t)
+
+	libs_use_ld_so($1_git_daemon_t)
+	libs_use_shared_libs($1_git_daemon_t)
+
+	logging_send_syslog_msg($1_git_daemon_t)
+
+	miscfiles_read_localization($1_git_daemon_t)
+
+	sysnet_read_config($1_git_daemon_t)
+
+	userdom_use_user_terminals($1, $1_git_daemon_t)
+
+	tunable_policy(`use_nfs_home_dirs', `
+		fs_list_nfs($1_git_daemon_t)
+ 		fs_read_nfs_files($1_git_daemon_t)
+	')
+
+	tunable_policy(`use_samba_home_dirs', `
+		fs_list_cifs($1_git_daemon_t)
+		fs_read_cifs_files($1_git_daemon_t)
+	')
+
+	optional_policy(`
+		automount_dontaudit_getattr_tmp_dirs($1_git_daemon_t)
+		fs_search_auto_mountpoints($1_git_daemon_t)
+	')
+
+	optional_policy(`
+		nscd_read_pid($1_git_daemon_t)
+	')
+
+	optional_policy(`
+		nis_use_ypbind($1_git_daemon_t)
+	')
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to read
+##	Git daemon system content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_read_git_daemon_system_content', `
+	gen_require(`
+		type git_daemon_system_content_t;
+	')
+
+	list_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+	read_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to manage
+##	Git daemon system content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_manage_git_daemon_system_content', `
+	gen_require(`
+		type git_daemon_system_content_t;
+	')
+
+	manage_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+	manage_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to execute
+##	Git daemon system content files.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_execute_git_daemon_system_content_files', `
+	gen_require(`
+		type git_daemon_system_content_t;
+	')
+
+	exec_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	All of the rules required to administrate=20
+##	an Git daemon environment
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name=3D"role">
+##	<summary>
+##	The role to be allowed to manage the Git daemon domain.
+##	</summary>
+## </param>
+## <param name=3D"terminal">
+##	<summary>
+##	The type of the user terminal.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_admin',`
+	gen_require(`
+		type git_daemon_t, git_daemon_exec_t, git_daemon_system_content_t,
git_daemon_user_content_t;
+	')
+
+	allow $1 git_daemon_t:process { ptrace signal_perms getattr };
+
+	git_daemon_manage_all_git_daemon_content($1)
+	git_daemon_relabel_all_git_daemon_content($1)
+
+# TODO
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to read
+##	Git daemon user content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_read_git_daemon_user_content', `
+	gen_require(`
+		type git_daemon_user_content_t;
+	')
+
+	list_dirs_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+	read_files_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to manage
+##	Git daemon user content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_manage_git_daemon_user_content', `
+	gen_require(`
+		type git_daemon_user_content_t;
+	')
+
+	manage_dirs_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+	manage_files_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to manage
+##	all Git daemon content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_manage_all_git_daemon_content', `
+	gen_require(`
+		type git_daemon_user_content_t, git_daemon_system_content_t;
+	')
+
+	manage_dirs_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+	manage_files_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+
+	manage_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+	manage_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to read
+##	all Git daemon content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_read_all_git_daemon_content', `
+	gen_require(`
+		type git_daemon_user_content_t, git_daemon_system_content_t;
+	')
+
+	list_dirs_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+	read_files_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+
+	list_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+	read_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to relabel
+##	all Git daemon content.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_relabel_all_git_daemon_content', `
+	gen_require(`
+		type git_daemon_user_content_t, git_daemon_system_content_t;
+	')
+
+	relabel_dirs_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+	relabel_files_pattern($1, git_daemon_user_content_t,
git_daemon_user_content_t)
+
+	relabel_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+	relabel_files_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to list
+##	Git daemon system content directories.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_list_git_daemon_system_content_dirs', `
+	gen_require(`
+		type git_daemon_system_content_t;
+	')
+
+	list_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to search
+##	Git daemon system content directories.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`git_daemon_search_git_daemon_system_content_dirs', `
+	gen_require(`
+		type git_daemon_system_content_t;
+	')
+
+	search_dirs_pattern($1, git_daemon_system_content_t,
git_daemon_system_content_t)
+')
+
+#######################################
+## <summary>
+##	The template for creating a Git user domain.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a user domain, types, and
+##	rules for the user's pty.
+##	</p>
+## </desc>
+## <param name=3D"userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+#
+template(`git_daemon_git_user_template',`
+	gen_require(`
+		attribute unpriv_userdomain, userdomain;
+		class context contains;
+	')
+	##############################
+	#
+	# Git user public declarations
+	#
+	attribute $1_file_type;
+	attribute $1_usertype;
+
+	type $1_t, userdomain, $1_usertype;
+	domain_type($1_t)
+
+	corecmd_shell_entry_type($1_t) # test me
+	corecmd_bin_entry_type($1_t) # test me
+	domain_user_exemption_target($1_t) # test me
+
+	role $1_r types $1_t;
+	allow system_r $1_r;
+
+	typeattribute $1_t unpriv_userdomain;
+	domain_interactive_fd($1_t)
+
+	##############################
+	#
+	# Git user public policy
+	#
+	allow $1_usertype self:context contains;
+
+	allow $1_usertype $1_usertype:fifo_file rw_fifo_file_perms;
+
+	corecmd_exec_bin($1_usertype)
+
+	kernel_read_system_state($1_usertype)
+
+	files_read_etc_files($1_usertype)
+
+	files_search_home($1_usertype)
+
+	git_daemon_manage_git_daemon_system_content($1_usertype)
+	git_daemon_execute_git_daemon_system_content_files($1_usertype)
+
+	libs_use_ld_so($1_usertype)
+	libs_use_shared_libs($1_usertype)
+
+	miscfiles_read_localization($1_usertype)
+
+	ssh_rw_stream_sockets($1_usertype)
+
+	optional_policy(`=20
+		nscd_read_pid($1_usertype)
+	')
+')
diff --git a/policy/modules/services/git_daemon.te
b/policy/modules/services/git_daemon.te
new file mode 100644
index 0000000..c8673e3
--- /dev/null
+++ b/policy/modules/services/git_daemon.te
@@ -0,0 +1,112 @@
+
+policy_module(git_daemon, 0.0.1)=20
+
+########################################
+#
+# Git daemon private declarations.
+#
+type git_daemon_t;
+type git_daemon_exec_t;
+inetd_service_domain(git_daemon_t, git_daemon_exec_t)
+role system_r types git_daemon_t;
+
+application_executable_file(git_daemon_exec_t)
+
+type git_daemon_system_content_t;
+files_type(git_daemon_system_content_t)
+
+type git_daemon_user_content_t;
+files_poly_member(git_daemon_user_content_t)
+userdom_user_home_content(user, git_daemon_user_content_t)
+
+## <desc>
+## <p>
+## Allow Git daemon to read home directories
+## </p>
+## </desc>
+gen_tunable(git_daemon_enable_homedirs, false)
+
+## <desc>
+## <p>
+## Allow Git daemon to access nfs file systems
+## </p>
+## </desc>
+gen_tunable(git_daemon_use_nfs, false)
+
+## <desc>
+## <p>
+## Allow Git daemon to access cifs file systems
+## </p>
+## </desc>
+gen_tunable(git_daemon_use_cifs, false)
+
+
+########################################
+#
+# Git daemon private policy.
+#
+allow git_daemon_t self:fifo_file rw_fifo_file_perms;
+allow git_daemon_t self:netlink_route_socket { write getattr read bind
create nlmsg_read };
+allow git_daemon_t self:udp_socket { write read create connect
getattr };
+allow git_daemon_t self:unix_dgram_socket { write create connect };
+
+list_dirs_pattern(git_daemon_t, git_daemon_system_content_t,
git_daemon_system_content_t)
+read_files_pattern(git_daemon_t, git_daemon_system_content_t,
git_daemon_system_content_t)
+
+corecmd_exec_bin(git_daemon_t)
+corecmd_search_bin(git_daemon_t)
+
+corenet_all_recvfrom_unlabeled(git_daemon_t)
+corenet_all_recvfrom_netlabel(git_daemon_t)
+
+files_read_etc_files(git_daemon_t)
+
+files_search_usr(git_daemon_t)
+
+kernel_read_system_state(git_daemon_t)
+
+libs_use_ld_so(git_daemon_t)
+libs_use_shared_libs(git_daemon_t)
+
+logging_send_syslog_msg(git_daemon_t)
+
+miscfiles_read_localization(git_daemon_t)
+
+sysnet_read_config(git_daemon_t)
+
+optional_policy(`
+	apache_content_template(gitweb)
+	apache_search_sys_content(httpd_gitweb_script_t)
+	files_getattr_tmp_dirs(httpd_gitweb_script_t)
+	git_daemon_read_git_daemon_system_content(httpd_gitweb_script_t)
+')
+
+optional_policy(`
+	nscd_read_pid(git_daemon_t)
+')
+
+tunable_policy(`git_daemon_enable_homedirs && use_nfs_home_dirs', `
+	fs_list_nfs(git_daemon_t)
+	fs_read_nfs_files(git_daemon_t)
+')
+
+tunable_policy(`git_daemon_use_nfs', `
+	fs_list_nfs(git_daemon_t)
+	fs_read_nfs_files(git_daemon_t)
+')
+
+tunable_policy(`git_daemon_enable_homedirs && use_samba_home_dirs', `
+	fs_list_cifs(git_daemon_t)
+	fs_read_cifs_files(git_daemon_t)
+')
+
+tunable_policy(`git_daemon_use_cifs', `
+	fs_list_cifs(git_daemon_t)
+	fs_read_cifs_files(git_daemon_t)
+')
+
+tunable_policy(`git_daemon_enable_homedirs', `
+	list_dirs_pattern(git_daemon_t, git_daemon_user_content_t,
git_daemon_user_content_t)
+	read_files_pattern(git_daemon_t, git_daemon_user_content_t,
git_daemon_user_content_t)
+	userdom_search_user_home_dirs(user, git_daemon_t)
+')
diff --git a/policy/modules/system/userdomain.if
b/policy/modules/system/userdomain.if
index 96d11e2..db33e79 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -1203,6 +1203,12 @@ template(`userdom_unpriv_user_template', `
 		corenet_tcp_bind_generic_port($1_t)
 	')
=20
+	ifdef(`distro_redhat', `
+		optional_policy(`
+			git_daemon_per_role_template($1, $1_t, $1_r)
+		')
+	')
+
 	optional_policy(`
 		netutils_run_ping_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
 		netutils_run_traceroute_cond($1_t,$1_r,{ $1_tty_device_t
$1_devpts_t })
--=20
Dominick Grift <domg472@gmail.com>

--=-fVByRzskgrcpjPJPAHWz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiYpvYACgkQL00QnzrVtlwtbgCeN+9czQrIz0Qw3yvH268SEpYA
6aMAmwb/Xs4De8+sJ0XyJIG/GFDbKC8y
=4H9e
-----END PGP SIGNATURE-----

--=-fVByRzskgrcpjPJPAHWz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
