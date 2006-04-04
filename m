Date: Tue, 4 Apr 2006 19:50:27 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: qmail policy
Message-ID: <20060404165027.GA6245@peter.sunspire.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--b5gNqxB1S1yM7hjW
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

attached you'll find the qmail policy and a small patch needed to integrate=
 it into serefpol.

the qmail_smtpd_service_domain and qmail_queue_domtrans interfaces will be =
used at a later date by antivirus or antispam filters.

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qmail.fc"


/var/qmail/alias		-d	gen_context(system_u:object_r:qmail_alias_home_t,s0)
/var/qmail/alias(/.*)?			gen_context(system_u:object_r:qmail_alias_home_t,s0)
/var/qmail/bin/qmail-clean	--	gen_context(system_u:object_r:qmail_clean_exec_t,s0)
/var/qmail/bin/qmail-getpw	--	gen_context(system_u:object_r:qmail_exec_t,s0)
/var/qmail/bin/qmail-inject	--	gen_context(system_u:object_r:qmail_inject_exec_t,s0)
/var/qmail/bin/qmail-local	--	gen_context(system_u:object_r:qmail_local_exec_t,s0)
/var/qmail/bin/qmail-lspawn	--	gen_context(system_u:object_r:qmail_lspawn_exec_t,s0)
/var/qmail/bin/qmail-queue	--	gen_context(system_u:object_r:qmail_queue_exec_t,s0)
/var/qmail/bin/qmail-remote	--	gen_context(system_u:object_r:qmail_remote_exec_t,s0)
/var/qmail/bin/qmail-rspawn	--	gen_context(system_u:object_r:qmail_rspawn_exec_t,s0)
/var/qmail/bin/qmail-send	--	gen_context(system_u:object_r:qmail_send_exec_t,s0)
/var/qmail/bin/qmail-smtpd	--	gen_context(system_u:object_r:qmail_smtpd_exec_t,s0)
/var/qmail/bin/qmail-start	--	gen_context(system_u:object_r:qmail_start_exec_t,s0)
/var/qmail/bin/splogger		--	gen_context(system_u:object_r:qmail_splogger_exec_t,s0)
/var/qmail/bin/tcp-env		--	gen_context(system_u:object_r:qmail_tcp_env_exec_t,s0)
/var/qmail/control(/.*)?		gen_context(system_u:object_r:qmail_etc_t,s0)
/var/qmail/queue(/.*)?			gen_context(system_u:object_r:qmail_spool_t,s0)

ifdef(`distro_debian', `
/etc/qmail(/.*)?		gen_context(system_u:object_r:qmail_etc_t,s0)
/usr/bin/tcp-env	--	gen_context(system_u:object_r:qmail_tcp_env_exec_t,s0)
/usr/local/bin/serialmail/.* -- gen_context(system_u:object_r:qmail_serialmail_exec_t,s0)
/usr/sbin/qmail-clean	--	gen_context(system_u:object_r:qmail_clean_exec_t,s0)
/usr/sbin/qmail-getpw	--	gen_context(system_u:object_r:qmail_exec_t,s0)
/usr/sbin/qmail-inject	--	gen_context(system_u:object_r:qmail_inject_exec_t,s0)
/usr/sbin/qmail-local	--	gen_context(system_u:object_r:qmail_local_exec_t,s0)
/usr/sbin/qmail-lspawn	--	gen_context(system_u:object_r:qmail_lspawn_exec_t,s0)
/usr/sbin/qmail-queue	--	gen_context(system_u:object_r:qmail_queue_exec_t,s0)
/usr/sbin/qmail-remote	--	gen_context(system_u:object_r:qmail_remote_exec_t,s0)
/usr/sbin/qmail-rspawn	--	gen_context(system_u:object_r:qmail_rspawn_exec_t,s0)
/usr/sbin/qmail-send	--	gen_context(system_u:object_r:qmail_send_exec_t,s0)
/usr/sbin/qmail-smtpd	--	gen_context(system_u:object_r:qmail_smtpd_exec_t,s0)
/usr/sbin/qmail-start	--	gen_context(system_u:object_r:qmail_start_exec_t,s0)
/usr/sbin/splogger	--	gen_context(system_u:object_r:qmail_splogger_exec_t,s0)
/var/qmail(/.*)?		gen_context(system_u:object_r:qmail_etc_t,s0)
/var/spool/qmail(/.*)?		gen_context(system_u:object_r:qmail_spool_t,s0)
')


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qmail.if"
Content-Transfer-Encoding: quoted-printable

## <summary>policy for qmail MTA</summary>


########################################
## <summary>
##	Template for qmail parent/sub-domain pairs
## </summary>
## <param name=3D"domain_prefix">
##	<summary>
##		The name of the child domain
##	</summary>
## </param>
## <param name=3D"domain">
##	<summary>
##		The name of the parent domain
##	</summary>
## </param>
#
template(`qmail_child_domain_template', `
	gen_require(`
		type qmail_etc_t;
		type qmail_start_t;
	')

	type $1_t;
	domain_type($1_t)
	type $1_exec_t;
	domain_entry_file($1_t,$1_exec_t)
	domain_auto_trans($2, $1_exec_t, $1_t)
	role system_r types $1_t;

	allow $1_t $2:fd use;
	allow $1_t $2:fifo_file rw_file_perms;
	allow $1_t $2:process sigchld;
	allow $1_t self:process signal_perms;
	allow $1_t qmail_etc_t:dir { getattr read search };
	allow $1_t qmail_etc_t:file { getattr read };
	allow $1_t qmail_etc_t:lnk_file { getattr read };
	allow $1_t qmail_start_t:fd use;

	kernel_list_proc($2)
	kernel_read_proc_symlinks($2)
	corecmd_search_bin($1_t)
	files_search_var($1_t)
	fs_getattr_xattr_fs($1_t)
	libs_use_ld_so($1_t)
	libs_use_shared_libs($1_t)
	miscfiles_read_localization($1_t)
')


#######################################
## <summary>
##      The per user domain template for qmail
## </summary>
## <desc>
##      <p>
##      This template is invoked automatically for each user, and
##      generally does not need to be invoked directly
##      by policy writers.
##      </p>
## </desc>
## <param name=3D"userdomain_prefix">
##      <summary>
##      The prefix of the user domain (e.g., user
##      is the prefix for user_t).
##      </summary>
## </param>
## <param name=3D"user_domain">
##      <summary>
##      The type of the user domain.
##      </summary>
## </param>
## <param name=3D"user_role">
##      <summary>
##      The role associated with the user domain.
##      </summary>
## </param>
#
template(`qmail_per_userdomain_template',`
	gen_require(`
		attribute qmail_user_domains;
		type qmail_inject_t;
		type qmail_queue_t;
	')

	role $3 types qmail_inject_t;
	role $3 types qmail_queue_t;

	qmail_inject_domtrans($1_t)

	allow qmail_user_domains $2:process sigchld;
	allow qmail_user_domains $2:fifo_file { write getattr };
	allow qmail_user_domains $2:fd use;

')


########################################
## <summary>
##	Transition to qmail_inject_t
## </summary>
## <param name=3D"domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
#
interface(`qmail_inject_domtrans',`
	gen_require(`
		type qmail_inject_t;
		type qmail_inject_exec_t;
	')

	domain_auto_trans($1, qmail_inject_exec_t, qmail_inject_t)
	allow qmail_inject_t $1:fd use;
	allow qmail_inject_t $1:fifo_file { read write };
	allow qmail_inject_t $1:process sigchld;
')


########################################
## <summary>
##	Transition to qmail_queue_t
## </summary>
## <param name=3D"domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
#
interface(`qmail_queue_domtrans', `
	gen_require(`
		type qmail_queue_t;
		type qmail_queue_exec_t;
	')

	domain_auto_trans($1, qmail_queue_exec_t, qmail_queue_t)

	allow qmail_queue_t $1:fd use;
	allow qmail_queue_t $1:fifo_file { read write };
	allow qmail_queue_t $1:process sigchld;
')


########################################
## <summary>
##	Read qmail configuration files.
## </summary>
## <param name=3D"domain">
##	<summary>
##		Domain allowed access.
##	</summary>
## </param>
#
interface(`qmail_read_config',`
	gen_require(`
		type qmail_etc_t;
	')

	allow $1 qmail_etc_t:dir { getattr read search };
	allow $1 qmail_etc_t:file { getattr read };
	allow $1 qmail_etc_t:lnk_file { getattr read };
')


########################################
## <summary>
##	Define the specified domain as a qmail-smtp service.=20
##	Needed by antivirus/antispam filters.
## </summary>
## <param name=3D"domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
## <param name=3D"entrypoint">
##	<summary>
##		The type associated with the process program.
##	</summary>
## </param>
#
interface(`qmail_smtpd_service_domain', `
	gen_require(`
		type qmail_smtpd_t;
	')

        domain_auto_trans(qmail_smtpd_t, $2, $1)

	allow $1 qmail_smtpd_t:fd use;
	allow $1 qmail_smtpd_t:fifo_file { read write };
	allow $1 qmail_smtpd_t:process sigchld;
')


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qmail.patch"
Content-Transfer-Encoding: quoted-printable

Index: policy/modules/kernel/corecommands.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/kernel/corecommands=
=2Efc,v
retrieving revision 1.11
diff -u -B -r1.11 corecommands.fc
--- policy/modules/kernel/corecommands.fc	24 Mar 2006 21:44:38 -0000	1.11
+++ policy/modules/kernel/corecommands.fc	4 Apr 2006 16:36:38 -0000
@@ -164,6 +164,7 @@
=20
 ifdef(`distro_gentoo', `
 /usr/.*-.*-linux-gnu/gcc-bin/.*(/.*)?	gen_context(system_u:object_r:bin_t,=
s0)
+/usr/.*-.*-linux-gnu/binutils-bin(/.*)?	gen_context(system_u:object_r:bin_=
t,s0)
 ')
=20
 ifdef(`distro_redhat', `
@@ -224,3 +225,8 @@
 ifdef(`distro_suse',`
 /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
 ')
+
+/var/qmail/bin                  -d      gen_context(system_u:object_r:bin_=
t,s0)
+/var/qmail/bin(/.*)?                    gen_context(system_u:object_r:bin_=
t,s0)
+/var/qmail/rc                   --      gen_context(system_u:object_r:bin_=
t,s0)
+
Index: policy/modules/services/mta.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/services/mta.fc,v
retrieving revision 1.5
diff -u -B -r1.5 mta.fc
--- policy/modules/services/mta.fc	2 Feb 2006 21:12:27 -0000	1.5
+++ policy/modules/services/mta.fc	4 Apr 2006 16:36:38 -0000
@@ -12,6 +12,7 @@
 /usr/sbin/sendmail.postfix --	gen_context(system_u:object_r:sendmail_exec_=
t,s0)
 /usr/sbin/sendmail(.sendmail)? -- gen_context(system_u:object_r:sendmail_e=
xec_t,s0)
=20
+/var/qmail/bin/sendmail	--	gen_context(system_u:object_r:sendmail_exec_t,s=
0)
 /var/mail(/.*)?			gen_context(system_u:object_r:mail_spool_t,s0)
=20
 /var/spool/imap(/.*)?		gen_context(system_u:object_r:mail_spool_t,s0)
Index: policy/modules/services/mta.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/services/mta.if,v
retrieving revision 1.47
diff -u -B -r1.47 mta.if
--- policy/modules/services/mta.if	24 Mar 2006 16:15:50 -0000	1.47
+++ policy/modules/services/mta.if	4 Apr 2006 16:36:39 -0000
@@ -112,6 +112,10 @@
 	')
=20
 	optional_policy(`
+		qmail_inject_domtrans($1_mail_t)
+	')
+
+	optional_policy(`
 		gen_require(`
 			type etc_mail_t, mail_spool_t, mqueue_spool_t;
 		')
@@ -138,12 +142,6 @@
 		sendmail_create_log($1_mail_t)
 	')
=20
-	ifdef(`TODO',`
-	ifdef(`qmail.te', `
-		allow $1_mail_t qmail_etc_t:dir search;
-		allow $1_mail_t qmail_etc_t:{ file lnk_file } read;
-	')
-	') dnl end TODO
 ')
=20
 #######################################
Index: policy/modules/services/mta.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/services/mta.te,v
retrieving revision 1.42
diff -u -B -r1.42 mta.te
--- policy/modules/services/mta.te	24 Mar 2006 16:15:50 -0000	1.42
+++ policy/modules/services/mta.te	4 Apr 2006 16:36:39 -0000
@@ -162,6 +162,10 @@
 ')
=20
 optional_policy(`
+	qmail_inject_domtrans(system_mail_t)
+')
+
+optional_policy(`
 	userdom_dontaudit_use_unpriv_users_ptys(system_mail_t)
=20
 	optional_policy(`
Index: policy/modules/services/ucspitcp.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/services/ucspitcp.t=
e,v
retrieving revision 1.2
diff -u -B -r1.2 ucspitcp.te
--- policy/modules/services/ucspitcp.te	24 Mar 2006 16:15:50 -0000	1.2
+++ policy/modules/services/ucspitcp.te	4 Apr 2006 16:36:39 -0000
@@ -56,6 +56,7 @@
 allow ucspitcp_t self:fifo_file { read write };
 allow ucspitcp_t self:process { fork sigchld };
 allow ucspitcp_t self:tcp_socket create_stream_socket_perms;
+allow ucspitcp_t self:udp_socket create_stream_socket_perms;
=20
 corecmd_search_bin(ucspitcp_t)
 corecmd_search_sbin(ucspitcp_t)
@@ -65,6 +66,7 @@
 corenet_tcp_sendrecv_all_nodes(ucspitcp_t)
 corenet_udp_sendrecv_all_nodes(ucspitcp_t)
 corenet_tcp_sendrecv_all_ports(ucspitcp_t)
+corenet_udp_bind_inaddr_any_node(ucspitcp_t)
 corenet_udp_sendrecv_all_ports(ucspitcp_t)
 corenet_non_ipsec_sendrecv(ucspitcp_t)
 corenet_tcp_bind_all_nodes(ucspitcp_t)
Index: policy/modules/system/daemontools.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/system/daemontools.=
fc,v
retrieving revision 1.1
diff -u -B -r1.1 daemontools.fc
--- policy/modules/system/daemontools.fc	16 Jan 2006 18:55:42 -0000	1.1
+++ policy/modules/system/daemontools.fc	4 Apr 2006 16:36:39 -0000
@@ -36,6 +36,10 @@
 /var/dnscache/run	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
 /var/dnscache/log/run	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
=20
+/var/qmail/supervise(/.*)?		gen_context(system_u:object_r:svc_svc_t,s0)
+/var/qmail/supervise/.*/run	--	gen_context(system_u:object_r:svc_run_exec_=
t,s0)
+/var/qmail/supervise/.*/log/run	--	gen_context(system_u:object_r:svc_run_e=
xec_t,s0)
+
 /var/service/.*			gen_context(system_u:object_r:svc_svc_t,s0)
 /var/service/.*/env(/.*)?	gen_context(system_u:object_r:svc_conf_t,s0)
 /var/service/.*/log/main(/.*)?	gen_context(system_u:object_r:svc_log_t,s0)
Index: policy/modules/system/daemontools.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/system/daemontools.=
te,v
retrieving revision 1.4
diff -u -B -r1.4 daemontools.te
--- policy/modules/system/daemontools.te	2 Mar 2006 23:45:56 -0000	1.4
+++ policy/modules/system/daemontools.te	4 Apr 2006 16:36:39 -0000
@@ -90,6 +90,10 @@
 daemontools_domtrans_multilog(svc_run_t)
 daemontools_read_svc(svc_run_t)
=20
+optional_policy(`
+	qmail_read_config(svc_run_t)
+')
+
 ########################################
 #
 # local policy for service monitoring programs

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qmail.te"


policy_module(qmail,1.0.0)


########################################
#
# Declarations
#

attribute qmail_user_domains;

type qmail_alias_home_t;
files_type(qmail_alias_home_t)

type qmail_etc_t;
files_type(qmail_etc_t)

type qmail_exec_t;
files_type(qmail_exec_t)

type qmail_inject_t;
type qmail_inject_exec_t;
domain_type(qmail_inject_t)
domain_entry_file(qmail_inject_t,qmail_inject_exec_t)
role system_r types qmail_inject_t;

type qmail_spool_t;
files_type(qmail_spool_t)

type qmail_start_t;
type qmail_start_exec_t;

type qmail_tcp_env_t;
type qmail_tcp_env_exec_t;

type qmail_var_run_t;
files_type(qmail_var_run_t)


#######################################
#
# qmail-clean local policy
#   this component cleans up the queue directory

qmail_child_domain_template(qmail_clean, qmail_start_t)

allow qmail_clean_t qmail_spool_t:dir rw_dir_perms;
allow qmail_clean_t qmail_spool_t:file { unlink read getattr };


########################################
#
# qmail-inject local policy
#   this component preprocesses mail from stdin and invokes qmail-queue

typeattribute qmail_inject_t qmail_user_domains;

allow qmail_inject_t self:fifo_file { write };
allow qmail_inject_t self:process { fork signal_perms };
allow qmail_inject_t qmail_queue_exec_t:file read;
corecmd_search_bin(qmail_inject_t)
corecmd_search_sbin(qmail_inject_t)
files_search_var(qmail_inject_t)
libs_use_ld_so(qmail_inject_t)
libs_use_shared_libs(qmail_inject_t)
qmail_read_config(qmail_inject_t)
mta_mailserver_user_agent(qmail_inject_t)


########################################
#
# qmail-local local policy
#   this component delivers a mail message

qmail_child_domain_template(qmail_local, qmail_lspawn_t)
qmail_queue_domtrans(qmail_local_t)

allow qmail_local_t qmail_alias_home_t:dir create_dir_perms;
allow qmail_local_t qmail_alias_home_t:file create_file_perms;
allow qmail_local_t qmail_queue_exec_t:file read;
allow qmail_local_t qmail_spool_t:file r_file_perms;
allow qmail_local_t self:fifo_file write;
allow qmail_local_t self:process { fork signal_perms };
allow qmail_local_t self:unix_stream_socket create_stream_socket_perms;
corecmd_exec_shell(qmail_local_t)
corecmd_search_sbin(qmail_local_t)
files_read_etc_files(qmail_local_t)
files_read_etc_runtime_files(qmail_local_t)
kernel_read_system_state(qmail_local_t)
mta_append_spool(qmail_local_t)
mta_mailserver_delivery(qmail_local_t)


########################################
#
# qmail-lspawn local policy
#   this component schedules local deliveries

qmail_child_domain_template(qmail_lspawn, qmail_start_t)

allow qmail_lspawn_t self:capability { setuid setgid };
allow qmail_lspawn_t self:fifo_file { read write };
allow qmail_lspawn_t self:process { fork signal_perms };
allow qmail_lspawn_t self:unix_stream_socket create_socket_perms;
allow qmail_lspawn_t qmail_local_exec_t:file read;
allow qmail_lspawn_t qmail_spool_t:dir search;
allow qmail_lspawn_t qmail_spool_t:file { read getattr };
can_exec(qmail_lspawn_t, qmail_exec_t)
corecmd_search_sbin(qmail_lspawn_t)
files_read_etc_files(qmail_lspawn_t)
files_search_pids(qmail_lspawn_t)
files_search_tmp(qmail_lspawn_t)
mta_mailserver_delivery(qmail_lspawn_t)


########################################
#
# qmail-queue local policy
#   this component places a mail in a delivery queue, later to be processed by qmail-send

qmail_child_domain_template(qmail_queue, qmail_inject_t)

typeattribute qmail_queue_t qmail_user_domains;

allow qmail_queue_t qmail_lspawn_t:fd use;
allow qmail_queue_t qmail_lspawn_t:fifo_file write;
allow qmail_queue_t qmail_smtpd_t:fd use;
allow qmail_queue_t qmail_smtpd_t:fifo_file read;
allow qmail_queue_t qmail_smtpd_t:process sigchld;
allow qmail_queue_t qmail_spool_t:dir create_dir_perms;
allow qmail_queue_t qmail_spool_t:fifo_file { read write };
allow qmail_queue_t qmail_spool_t:file create_file_perms;
mta_mailserver_user_agent(qmail_queue_t)


########################################
#
# qmail-remote local policy
#   this component sends mail via SMTP

qmail_child_domain_template(qmail_remote, qmail_rspawn_t)

corenet_non_ipsec_sendrecv(qmail_remote_t)
corenet_tcp_sendrecv_generic_if(qmail_remote_t)
corenet_tcp_sendrecv_generic_node(qmail_remote_t)
corenet_tcp_sendrecv_smtp_port(qmail_remote_t)
corenet_udp_sendrecv_dns_port(qmail_remote_t)
corenet_udp_sendrecv_generic_if(qmail_remote_t)
corenet_udp_sendrecv_generic_node(qmail_remote_t)

allow qmail_remote_t qmail_spool_t:dir search;
allow qmail_remote_t qmail_spool_t:file rw_file_perms;
allow qmail_remote_t self:tcp_socket create_socket_perms;
allow qmail_remote_t self:udp_socket create_socket_perms;
allow qmail_remote_t smtp_port_t:tcp_socket name_connect;
dev_read_rand(qmail_remote_t)
dev_read_urand(qmail_remote_t)
mta_mailserver_sender(qmail_remote_t)
sysnet_read_config(qmail_remote_t)


########################################
#
# qmail-rspawn local policy
#   this component scedules remote deliveries

qmail_child_domain_template(qmail_rspawn, qmail_start_t)

allow qmail_rspawn_t qmail_remote_exec_t:file read;
allow qmail_rspawn_t qmail_spool_t:dir search;
allow qmail_rspawn_t qmail_spool_t:file rw_file_perms;
allow qmail_rspawn_t self:process { fork signal_perms };
allow qmail_rspawn_t self:fifo_file read;
corecmd_search_bin(qmail_rspawn_t)
corecmd_search_sbin(qmail_rspawn_t)


########################################
#
# qmail-send local policy
#   this component delivers mail messages from the queue

qmail_child_domain_template(qmail_send, qmail_start_t)
qmail_queue_domtrans(qmail_send_t)

allow qmail_send_t qmail_spool_t:dir create_dir_perms;
allow qmail_send_t qmail_spool_t:file create_file_perms;
allow qmail_send_t qmail_spool_t:fifo_file read;
allow qmail_send_t self:process { fork signal_perms };
allow qmail_send_t self:fifo_file write;
corecmd_search_sbin(qmail_send_t)


########################################
#
# qmail-smtpd local policy
#   this component receives mails via SMTP

qmail_child_domain_template(qmail_smtpd, qmail_tcp_env_t)
qmail_queue_domtrans(qmail_smtpd_t)

# when controlled by tcpserver
optional_policy(`ucspitcp', `
	ucspitcp_service_domain(qmail_smtpd_t, qmail_smtpd_exec_t)
')

allow qmail_smtpd_t self:process { fork signal_perms };
allow qmail_smtpd_t self:fifo_file write;
allow qmail_smtpd_t self:tcp_socket create_socket_perms;
allow qmail_smtpd_t qmail_queue_exec_t:file read;
corecmd_search_sbin(qmail_smtpd_t)
dev_read_rand(qmail_smtpd_t)
dev_read_urand(qmail_smtpd_t)


########################################
#
# splogger local policy
#   this component creates entries in syslog

qmail_child_domain_template(qmail_splogger, qmail_start_t)

allow qmail_splogger_t self:unix_dgram_socket create_socket_perms;
files_read_etc_files(qmail_splogger_t)
miscfiles_read_localization(qmail_splogger_t)

dontaudit qmail_splogger_t initrc_t:fd use;


########################################
#
# qmail-start local policy
#   this component starts up the mail delivery component

init_daemon_domain(qmail_start_t,qmail_start_exec_t)

allow qmail_start_t self:capability { setgid setuid };
allow qmail_start_t self:fifo_file { getattr read write };
allow qmail_start_t self:process signal_perms;
can_exec(qmail_start_t, qmail_start_exec_t)
corecmd_search_bin(qmail_start_t)
corecmd_search_sbin(qmail_start_t)
files_search_var(qmail_start_t)
libs_use_ld_so(qmail_start_t)
libs_use_shared_libs(qmail_start_t)
qmail_read_config(qmail_start_t)

optional_policy(`daemontools',`
	daemontools_service_domain(qmail_start_t, qmail_start_exec_t)
	daemontools_ipc_domain(qmail_send_t)
	daemontools_ipc_domain(qmail_start_t)
	daemontools_ipc_domain(qmail_queue_t)
	daemontools_ipc_domain(qmail_smtpd_t)
')

dontaudit qmail_start_t self:capability sys_tty_config;


########################################
#
# tcp-env local policy
#   this component sets up TCP-related environment variables

allow qmail_tcp_env_t qmail_smtpd_exec_t:file read;
sysnet_read_config(qmail_tcp_env_t)
corecmd_search_sbin(qmail_tcp_env_t)

optional_policy(`ucspitcp', `
	ucspitcp_service_domain(qmail_tcp_env_t, qmail_tcp_env_exec_t)
')

# untested territory
optional_policy(`inetd', `
	inetd_tcp_service_domain(qmail_tcp_env_t, qmail_tcp_env_exec_t)
')


--G4iJoqBmSsgzjUCe--

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQFEMqPTGSBEIeh4AEYRAr68AJ4kCjsyhBG68sA0tk+nHBWic37v6ACdEkbw
gU/AvwkZ0VGkD3Q3DLNDhCg=
=iKro
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
