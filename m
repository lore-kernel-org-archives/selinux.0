Date: Mon, 25 Oct 2004 23:31:23 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Message-Id: <20041025213122.GA2535@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com> <20041018205136.GA2536@jmh.mhn.de> <200410260138.19426.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
In-Reply-To: <200410260138.19426.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JYK4vJDZwFMowpUq
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-10-25 19:09]:
> On Tue, 19 Oct 2004 06:51, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > One thing to note here is that restorecon becomes more dangerous with
> > your changes. Right now restorecon is relatively safe in that you can
> > only change file labels to their system default. It would probably be
> > acceptable in most environments to give users access to restorecon so
> > they could properly set labels for files in their home dir.
> >
> > With your changes and this scenario, users could do something like
> >         restorecon -p /home/foo /home/foo/sbin/unix_chkpwd
>=20
> If the user is to run restorecon then they must run it in their own domai=
n. =20
> There is no harm in allowing a user to run restorecon as user_t.  They ca=
n=20
> only relabel files that have their own identity and a certain set of type=
s.
>=20
> Maybe we should even have a script to run restorecon -R on the user's hom=
e=20
> directory that they can run at any time if SE Linux stops them doing what=
=20
> they want?

OK, what do you guys think about the following patch:
It adds an attribute $1_domain_file_type, so all file types from derived
user domains can be grouped together. It also adds a restorecon_domain()
macro, so users can call restorecon to reset the labels on their files.

It is very lightly tested and probably missing a few permissions but
should give a good overview of the general idea.

Is such a thing safe?

Thomas

PS: It may be good to add a password check before restorecon (like
newrole does) so we are sure that it's the user who wants to relabel
his files.

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="restorecon.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/macros/admin_macros.te mod/macros/admin_macros.te
--- orig/macros/admin_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/admin_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -14,9 +14,12 @@
 #
 undefine(`admin_domain')
 define(`admin_domain',`
+# define an attribute for all files created by this role
+attribute $1_domain_file_type;
+
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
-type $1_home_t, file_type, sysadmfile, home_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, $1_do=
main_file_type;
+type $1_home_t, file_type, sysadmfile, home_type, $1_domain_file_type;
=20
 # Type and access for pty devices.
 can_create_pty($1)
diff -urN orig/macros/program/apache_macros.te mod/macros/program/apache_ma=
cros.te
--- orig/macros/program/apache_macros.te	2004-10-17 13:07:14.000000000 +0200
+++ mod/macros/program/apache_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -18,18 +18,23 @@
 file_type_auto_trans(httpd_$1_script_t, tmp_t, $1_tmp_t)
 ', `
=20
+ifelse($1, sys, `
 #This type is for webpages
 #
 type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
-ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
-')
=20
 # This type is used for .htaccess files
 #
 type httpd_$1_htaccess_t, file_type, sysadmfile;
=20
 type httpd_$1_script_exec_t, file_type, sysadmfile;
+', `
+# same as above, add $1_domain_file_type attribute
+type httpd_$1_content_t, file_type, homedirfile, sysadmfile, $1_domain_fil=
e_type;
+type httpd_$1_htaccess_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_exec_t, file_type, sysadmfile, $1_domain_file_type;
+')
=20
 # Type that CGI scripts run as
 type httpd_$1_script_t, domain, privmail;
@@ -69,13 +74,20 @@
 uncond_can_ypbind(httpd_$1_script_t)
 }
 ')
+
+ifelse($1, `sys', `
 # The following are the only areas that=20
 # scripts can read, read/write, or append to
 #
 type httpd_$1_script_ro_t, file_type, sysadmfile;
 type httpd_$1_script_rw_t, file_type, sysadmfile;
-file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
 type httpd_$1_script_ra_t, file_type, sysadmfile;
+', `
+type httpd_$1_script_ro_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_rw_t, file_type, sysadmfile, $1_domain_file_type;
+type httpd_$1_script_ra_t, file_type, sysadmfile, $1_domain_file_type;
+')
+file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
=20
 ifdef(`slocate.te', `
 ifelse($1, `sys', `', `
diff -urN orig/macros/program/crond_macros.te mod/macros/program/crond_macr=
os.te
--- orig/macros/program/crond_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/crond_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -36,7 +36,7 @@
 r_dir_file($1_crond_t, selinux_config_t)
=20
 # Type of user crontabs once moved to cron spool.
-type $1_cron_spool_t, file_type, sysadmfile;
+type $1_cron_spool_t, file_type, sysadmfile ifelse($1, `system', `', `, $1=
_domain_file_type');
=20
 ifdef(`fcron.te', `
 allow crond_t $1_cron_spool_t:file create_file_perms;
diff -urN orig/macros/program/fingerd_macros.te mod/macros/program/fingerd_=
macros.te
--- orig/macros/program/fingerd_macros.te	2003-08-14 14:37:36.000000000 +02=
00
+++ mod/macros/program/fingerd_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -10,6 +10,6 @@
 # allow fingerd to create a fingerlog file in the user home dir
 #
 define(`fingerd_macro', `
-type $1_home_fingerlog_t, file_type, sysadmfile;
+type $1_home_fingerlog_t, file_type, sysadmfile, $1_domain_file_type;
 file_type_auto_trans(fingerd_t, $1_home_dir_t, $1_home_fingerlog_t)
 ')
diff -urN orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_ag=
ent_macros.te
--- orig/macros/program/gpg_agent_macros.te	2004-09-21 22:24:44.000000000 +=
0200
+++ mod/macros/program/gpg_agent_macros.te	2004-10-25 23:26:44.000000000 +0=
200
@@ -58,7 +58,7 @@
 allow $1_gpg_agent_t self:fifo_file { getattr read write };
=20
 # create /tmp files
-tmp_domain($1_gpg_agent)
+tmp_domain($1_gpg_agent, `, $1_domain_file_type')
=20
 # gpg connect
 allow $1_gpg_t $1_gpg_agent_tmp_t:dir { search };
diff -urN orig/macros/program/gpg_macros.te mod/macros/program/gpg_macros.te
--- orig/macros/program/gpg_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/gpg_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -25,7 +25,7 @@
 allow $1_t self:capability { setuid };
 ', `
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, homedirfile, sysadmfile;
+type $1_gpg_secret_t, file_type, homedirfile, sysadmfile, $1_domain_file_t=
ype;
 ')dnl end ifdef single_userdomain
=20
 # Transition from the user domain to the derived domain.
diff -urN orig/macros/program/irc_macros.te mod/macros/program/irc_macros.te
--- orig/macros/program/irc_macros.te	2004-03-23 21:58:10.000000000 +0100
+++ mod/macros/program/irc_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -24,8 +24,8 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, homedirfile, sysadmfile;
-type $1_irc_exec_t, file_type, sysadmfile;
+type $1_home_irc_t, file_type, homedirfile, sysadmfile, $1_domain_file_typ=
e;
+type $1_irc_exec_t, file_type, sysadmfile, $1_domain_file_type;
=20
 ifdef(`slocate.te', `
 allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:dir { getattr search };
diff -urN orig/macros/program/lpr_macros.te mod/macros/program/lpr_macros.te
--- orig/macros/program/lpr_macros.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/macros/program/lpr_macros.te	2004-10-25 23:28:02.000000000 +0200
@@ -54,11 +54,11 @@
 r_dir_file($1_lpr_t, printconf_t)
 ')
=20
-tmp_domain($1_lpr)
+tmp_domain($1_lpr, `, $1_domain_file_type')
 r_dir_file($1_lpr_t, $1_tmp_t)
=20
 # Type for spool files.
-type $1_print_spool_t, file_type, sysadmfile;
+type $1_print_spool_t, file_type, sysadmfile, $1_domain_file_type;
 # Use this type when creating files in /var/spool/lpd and /var/spool/cups.
 file_type_auto_trans($1_lpr_t, print_spool_t, $1_print_spool_t, file)
 allow $1_lpr_t var_spool_t:dir { search };
diff -urN orig/macros/program/restorecon_macros.te mod/macros/program/resto=
recon_macros.te
--- orig/macros/program/restorecon_macros.te	1970-01-01 01:00:00.000000000 =
+0100
+++ mod/macros/program/restorecon_macros.te	2004-10-25 23:26:44.000000000 +=
0200
@@ -0,0 +1,34 @@
+# Macro for the user restorecon domain
+#
+# Allow the user to call restorecon and to relabel all his files
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+
+define(`restorecon_domain', `
+
+type $1_restorecon_t, domain;
+role $1_r types $1_restorecon_t;
+
+domain_auto_trans($1_t, restorecon_exec_t, $1_restorecon_t)
+
+base_file_read_access($1_restorecon_t)
+uses_shlib($1_restorecon_t)
+
+allow $1_restorecon_t $1_devpts_t:chr_file { read write };
+
+allow $1_restorecon_t privfd:fd use;
+
+r_dir_file($1_restorecon_t, selinux_config_t)
+r_dir_file($1_restorecon_t, default_context_t)
+r_dir_file($1_restorecon_t, file_context_t)
+r_dir_file($1_restorecon_t, policy_config_t)
+
+allow $1_restorecon_t proc_t:dir search;
+allow $1_restorecon_t proc_t:file { getattr read };
+dontaudit $1_restorecon_t proc_t:lnk_file { getattr read };
+
+allow $1_restorecon_t { tmp_t $1_domain_file_type }:dir { getattr search };
+allow $1_restorecon_t $1_domain_file_type:{ notdevfile_class_set dir } { g=
etattr relabelfrom relabelto };
+=20
+')
diff -urN orig/macros/program/rssh_macros.te mod/macros/program/rssh_macros=
=2Ete
--- orig/macros/program/rssh_macros.te	2004-09-23 11:38:30.000000000 +0200
+++ mod/macros/program/rssh_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -19,8 +19,8 @@
 role rssh_$1_r types rssh_$1_t;
 allow system_r rssh_$1_r;
=20
-type rssh_$1_rw_t, file_type, sysadmfile;
-type rssh_$1_ro_t, file_type, sysadmfile;
+type rssh_$1_rw_t, file_type, sysadmfile, $1_domain_file_type;
+type rssh_$1_ro_t, file_type, sysadmfile, $1_domain_file_type;
=20
 general_domain_access(rssh_$1_t);
 uses_shlib(rssh_$1_t);
diff -urN orig/macros/program/screen_macros.te mod/macros/program/screen_ma=
cros.te
--- orig/macros/program/screen_macros.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/macros/program/screen_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -26,12 +26,12 @@
 typealias $1_home_t alias $1_home_screen_t;
 ', `
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, homedirfile, sysadmfile;
+type $1_home_screen_t, file_type, homedirfile, sysadmfile, $1_domain_file_=
type;
=20
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
=20
-tmp_domain($1_screen)
+tmp_domain($1_screen, `, $1_domain_file_type')
 base_file_read_access($1_screen_t)
 # The user role is authorized for this domain.
 role $1_r types $1_screen_t;
@@ -72,7 +72,7 @@
 # Create fifo
 allow $1_screen_t var_t:dir search;
 file_type_auto_trans($1_screen_t, var_run_t, screen_dir_t, dir)
-type $1_screen_var_run_t, file_type, sysadmfile, pidfile;
+type $1_screen_var_run_t, file_type, sysadmfile, pidfile, $1_domain_file_t=
ype;
 file_type_auto_trans($1_screen_t, screen_dir_t, $1_screen_var_run_t, fifo_=
file)
=20
 allow $1_screen_t self:process { fork signal_perms };
diff -urN orig/macros/program/spamassassin_macros.te mod/macros/program/spa=
massassin_macros.te
--- orig/macros/program/spamassassin_macros.te	2004-10-14 13:09:56.00000000=
0 +0200
+++ mod/macros/program/spamassassin_macros.te	2004-10-25 23:26:44.000000000=
 +0200
@@ -80,7 +80,7 @@
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
=20
 # The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile;
+type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile, $1_domain=
_file_type;
 create_dir_file($1_t, $1_home_spamassassin_t)
 allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relab=
elto };
 allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
diff -urN orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2004-10-17 13:07:15.000000000 +0200
+++ mod/macros/program/ssh_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -26,7 +26,7 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_ssh_t, domain, privlog;
-type $1_home_ssh_t, file_type, homedirfile, sysadmfile;
+type $1_home_ssh_t, file_type, homedirfile, sysadmfile, $1_domain_file_typ=
e;
=20
 ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
diff -urN orig/macros/program/tvtime_macros.te mod/macros/program/tvtime_ma=
cros.te
--- orig/macros/program/tvtime_macros.te	2004-10-05 20:52:36.000000000 +0200
+++ mod/macros/program/tvtime_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -19,7 +19,7 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, homedirfile, sysadmfile;
+type $1_home_tvtime_t, file_type, homedirfile, sysadmfile, $1_domain_file_=
type;
=20
 x_client_domain($1, tvtime)
=20
diff -urN orig/macros/program/uml_macros.te mod/macros/program/uml_macros.te
--- orig/macros/program/uml_macros.te	2004-07-12 23:41:25.000000000 +0200
+++ mod/macros/program/uml_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -25,9 +25,9 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_uml_t, domain;
-type $1_uml_exec_t, file_type, sysadmfile;
-type $1_uml_ro_t, file_type, sysadmfile;
-type $1_uml_rw_t, file_type, sysadmfile;
+type $1_uml_exec_t, file_type, sysadmfile, $1_domain_file_type;
+type $1_uml_ro_t, file_type, sysadmfile, $1_domain_file_type;
+type $1_uml_rw_t, file_type, sysadmfile, $1_domain_file_type;
=20
 ifdef(`slocate.te', `
 allow $1_locate_t { $1_uml_exec_t $1_uml_ro_t $1_uml_rw_t }:dir { getattr =
search };
diff -urN orig/macros/program/vmware_macros.te mod/macros/program/vmware_ma=
cros.te
--- orig/macros/program/vmware_macros.te	2004-09-24 17:42:14.000000000 +0200
+++ mod/macros/program/vmware_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
=20
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_file_t, homedirfile, file_type, sysadmfile, $1_domain_file_=
type;
=20
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_conf_t, homedirfile, file_type, sysadmfile, $1_domain_file_=
type;
=20
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;
diff -urN orig/macros/program/xauth_macros.te mod/macros/program/xauth_macr=
os.te
--- orig/macros/program/xauth_macros.te	2004-06-19 10:31:44.000000000 +0200
+++ mod/macros/program/xauth_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -24,7 +24,7 @@
 ', `
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, homedirfile, sysadmfile;
+type $1_home_xauth_t, file_type, homedirfile, sysadmfile, $1_domain_file_t=
ype;
=20
 ifdef(`slocate.te', `
 allow $1_locate_t $1_home_xauth_t:file { getattr read };
@@ -84,7 +84,7 @@
 allow $1_xauth_t home_root_t:dir search;
 file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_home_xauth_t, file)
=20
-tmp_domain($1_xauth)
+tmp_domain($1_xauth, `, $1_domain_file_type')
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
=20
 ifdef(`nfs_home_dirs', `
diff -urN orig/macros/program/x_client_macros.te mod/macros/program/x_clien=
t_macros.te
--- orig/macros/program/x_client_macros.te	2004-09-11 14:31:47.000000000 +0=
200
+++ mod/macros/program/x_client_macros.te	2004-10-25 23:26:44.000000000 +02=
00
@@ -30,9 +30,9 @@
 ', `
 type $1_$2_t, domain $3;
 # Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, homedirfile, sysadmfile, tmpfile;
+type $1_$2_rw_t, file_type, homedirfile, sysadmfile, tmpfile, $1_domain_fi=
le_type;
 # Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, homedirfile, sysadmfile;
+type $1_$2_ro_t, file_type, homedirfile, sysadmfile, $1_domain_file_type;
 ')
=20
 # Transition from the user domain to the derived domain.
diff -urN orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2004-10-19 21:15:26.000000000 +0200
+++ mod/macros/user_macros.te	2004-10-25 23:26:44.000000000 +0200
@@ -23,16 +23,16 @@
 ')dnl end single_userdomain
=20
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_=
home_dir_type;
-type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_=
home_dir_type, $1_domain_file_type;
+type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_domai=
n_file_type;
=20
-tmp_domain($1, `, user_tmpfile')
+tmp_domain($1, `, user_tmpfile, $1_domain_file_type')
=20
 # Type and access for pty devices.
-can_create_pty($1, `, userpty_type, user_tty_type')
+can_create_pty($1, `, userpty_type, user_tty_type, $1_domain_file_type')
=20
 #Type for tty devices.
-type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_f=
s;
+type $1_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, dev_f=
s, $1_domain_file_type;
 =20
 base_user_domain($1)
=20
@@ -61,6 +61,7 @@
 # user domains.
 ifdef(`apache.te', `apache_domain($1)')
 ifdef(`slocate.te', `locate_domain($1)')
+ifdef(`restorecon.te', `restorecon_domain($1)')
=20
 allow $1_t krb5_conf_t:file { getattr read };
 # allow port_t name binding for UDP because it is not very usable otherwise
@@ -135,6 +136,9 @@
 # user_t/$1_t is an unprivileged users domain.
 type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, nscd_=
client_domain, privfd;
=20
+# define an attribute for all files created by this role
+attribute $1_domain_file_type;
+
 # Grant read/search permissions to some of /proc.
 allow $1_t proc_t:dir r_dir_perms;
 allow $1_t proc_t:{ file lnk_file } r_file_perms;

--T4sUOijqQbZv57TR--

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfXCqxWIrrrL0q+cRAhjpAJ9hJYZVabCzKvjbIX/WdJ62y++SvwCfblEQ
IQRV3r6lRgIINU3SwhYpoF8=
=2fIm
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
