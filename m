Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9Gp3Ii013817
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 11:51:03 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9GnNPU005120
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 16:49:26 GMT
Message-ID: <41B8826D.30105@redhat.com>
Date: Thu, 09 Dec 2004 11:50:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux ML <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <rcoker@redhat.com>, Colin Walters <walters@redhat.com>
CC: Nalin Dahyabhai <nalin@redhat.com>
Subject: Single home directory type for all roles.
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080709000402000709000002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080709000402000709000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

One of the things that we de-emphasized in the Fedora Releases of 
SELinux up til not is the RBAC support.  We
have basically made staff_r and user_r almost equivalent.  The reason we 
did this, is that we felt the system was
unmanagable for a normal administrators and would just result in SELinux 
getting a bad name and being turned off.
So for the first release of FC2 we turned off alot of the handling of 
roles.  Now that we have developed targeted policy
we are reviting some of the decisions we made around strict policy and 
working to make it "stricter".  

One problem I still have with RBAC though is the labeling of files based 
on the role of the user.  IE (staff_home_t versus
user_home_t).  I believe this causes many problems, without much benefit.

1.  Causes problems with sharing files between users,   IE a staff user 
coping a file to tmp and then the user
can't read it, because it has the wrong type. 
2.  Requirement that selinux-policy-strict-sources be installed and a 
rebuild of policy in order to change the roles of a user.
3.  But the number one problem I have is with relabeling files.  If I 
were to implement roles management in
system-config-securitylevel/adduser, I would need to trigger a relabel 
any time a role of a user was changed.  This
relabel would have to be inteligent enough to figure out not only the 
home directories, but also the files in /tmp and potentially
files in html files scattered over the system.  I find this an 
unworkable situation.

So yesterday I went though the policy and created a new tunable 
single_user_file_type, that causes the policy to share a common
filetypes between staff and users.  (Haven't completed this for http yet). 

With this tunable and the new SELinux Policy Modules.  I believe we can 
begin to implement a sane mechanism for handling roles
without causing the problems addressed above.

With SELinux Policy Modules, can I build an system-config-user/adduser 
that would modify a file under /etc/selinux/strict/roles/
(the users file) and then reload just that policy?

Comments????

Dan

--------------080709000402000709000002
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/global_macros.te policy-1.19.12.new/macros/global_macros.te
--- policy-1.19.12/macros/global_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/global_macros.te	2004-12-09 11:03:11.374549265 -0500
@@ -573,3 +573,19 @@
 ')
 
 ')dnl end unconfined_domain
+
+define(`create_user_file_type', `
+ifdef(`single_user_file_type', `
+ifelse($1, user, `
+type $1_$2, file_type, sysadmfile $3;
+', `
+ifelse($1, sysadm, `
+type $1_$2, file_type, sysadmfile $3;
+', `
+typealias user_$2 alias $1_$2;
+') dnl ifelse sysadm
+') dnl ifelse user
+', `
+type $1_$2, file_type, sysadmfile $3;
+') dnl ifdef single_user_file_type
+') dnl define create_user_file_type
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/fingerd_macros.te policy-1.19.12.new/macros/program/fingerd_macros.te
--- policy-1.19.12/macros/program/fingerd_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/fingerd_macros.te	2004-12-09 11:03:11.375549152 -0500
@@ -10,6 +10,6 @@
 # allow fingerd to create a fingerlog file in the user home dir
 #
 define(`fingerd_macro', `
-type $1_home_fingerlog_t, file_type, sysadmfile, $1_file_type;
+create_user_file_type($1, `home_fingerlog_t', `, $1_file_type')
 file_type_auto_trans(fingerd_t, $1_home_dir_t, $1_home_fingerlog_t)
 ')
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/gpg_macros.te policy-1.19.12.new/macros/program/gpg_macros.te
--- policy-1.19.12/macros/program/gpg_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/gpg_macros.te	2004-12-09 11:03:11.376549040 -0500
@@ -19,7 +19,7 @@
 define(`gpg_domain', `
 # Derived domain based on the calling user domain and the program.
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, $1_file_type, sysadmfile, $1_file_type;
+create_user_file_type($1, `gpg_secret_t', `, $1_file_type')
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/irc_macros.te policy-1.19.12.new/macros/program/irc_macros.te
--- policy-1.19.12/macros/program/irc_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/irc_macros.te	2004-12-09 11:03:11.377548927 -0500
@@ -20,7 +20,7 @@
 define(`irc_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `home_irc_t', `, $1_file_type')
 type $1_irc_exec_t, file_type, sysadmfile;
 
 ifdef(`slocate.te', `
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/mount_macros.te policy-1.19.12.new/macros/program/mount_macros.te
--- policy-1.19.12/macros/program/mount_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/mount_macros.te	2004-12-09 11:03:11.377548927 -0500
@@ -83,7 +83,7 @@
 # mount domain. 
 #
 define(`mount_loopback_privs',`
-type $1_$2_source_t, file_type, sysadmfile, $1_file_type;
+create_user_file_type($1, `$2_source_t', `, $1_file_type')
 allow $1_t $1_$2_source_t:file create_file_perms;
 allow $1_t $1_$2_source_t:file { relabelto relabelfrom };
 allow $2_t $1_$2_source_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/screen_macros.te policy-1.19.12.new/macros/program/screen_macros.te
--- policy-1.19.12/macros/program/screen_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/screen_macros.te	2004-12-09 11:03:11.378548815 -0500
@@ -22,7 +22,7 @@
 define(`screen_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `home_screen_t', `, $1_file_type')
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/spamassassin_macros.te policy-1.19.12.new/macros/program/spamassassin_macros.te
--- policy-1.19.12/macros/program/spamassassin_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/spamassassin_macros.te	2004-12-09 11:03:11.379548702 -0500
@@ -80,7 +80,7 @@
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
 # The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `home_spamassassin_t', `, $1_file_type')
 create_dir_file($1_t, $1_home_spamassassin_t)
 allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
 allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/ssh_macros.te policy-1.19.12.new/macros/program/ssh_macros.te
--- policy-1.19.12/macros/program/ssh_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/ssh_macros.te	2004-12-09 11:03:11.380548590 -0500
@@ -22,7 +22,7 @@
 define(`ssh_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_ssh_t, domain, privlog, nscd_client_domain;
-type $1_home_ssh_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `home_ssh_t', `, $1_file_type')
 
 ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/tvtime_macros.te policy-1.19.12.new/macros/program/tvtime_macros.te
--- policy-1.19.12/macros/program/tvtime_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/tvtime_macros.te	2004-12-09 11:03:11.381548478 -0500
@@ -19,7 +19,7 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `home_tvtime_t', `, $1_file_type')
 
 x_client_domain($1, tvtime)
 
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/uml_macros.te policy-1.19.12.new/macros/program/uml_macros.te
--- policy-1.19.12/macros/program/uml_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/uml_macros.te	2004-12-09 11:03:11.381548478 -0500
@@ -22,8 +22,8 @@
 # Derived domain based on the calling user domain and the program.
 type $1_uml_t, domain;
 type $1_uml_exec_t, file_type, sysadmfile, $1_file_type;
-type $1_uml_ro_t, file_type, sysadmfile, $1_file_type;
-type $1_uml_rw_t, file_type, sysadmfile, $1_file_type;
+create_user_file_type($1, `uml_ro_t', `, $1_file_type')
+create_user_file_type($1, `uml_rw_t', `, $1_file_type')
 
 can_ptrace($1_t, $1_uml_t)
 
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/vmware_macros.te policy-1.19.12.new/macros/program/vmware_macros.te
--- policy-1.19.12/macros/program/vmware_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/vmware_macros.te	2004-12-09 11:03:11.382548365 -0500
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
 
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, $1_file_type, file_type, sysadmfile;
+create_user_file_type($1, `vmware_file_t', `, $1_file_type')
 
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile;
+type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile, $1_file_type;
 
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/xauth_macros.te policy-1.19.12.new/macros/program/xauth_macros.te
--- policy-1.19.12/macros/program/xauth_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/xauth_macros.te	2004-12-09 11:15:54.468740331 -0500
@@ -20,7 +20,8 @@
 define(`xauth_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, $1_file_type, sysadmfile;
+
+create_user_file_type($1, `home_xauth_t', `, $1_file_type')
 
 allow $1_xauth_t self:process signal;
 
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/program/x_client_macros.te policy-1.19.12.new/macros/program/x_client_macros.te
--- policy-1.19.12/macros/program/x_client_macros.te	2004-12-09 11:01:28.000000000 -0500
+++ policy-1.19.12.new/macros/program/x_client_macros.te	2004-12-09 11:16:14.973434606 -0500
@@ -25,9 +25,9 @@
 # Derived domain based on the calling user domain and the program.
 type $1_$2_t, domain $3;
 # Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, $1_file_type, sysadmfile, tmpfile;
+create_user_file_type($1, `$2_rw_t', `, tmpfile, $1_file_type')
 # Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, $1_file_type, sysadmfile;
+create_user_file_type($1, `$2_ro_t', `, $1_file_type')
 
 # Transition from the user domain to the derived domain.
 ifelse($2, games, `
diff --exclude-from=exclude -N -u -r policy-1.19.12/macros/user_macros.te policy-1.19.12.new/macros/user_macros.te
--- policy-1.19.12/macros/user_macros.te	2004-12-09 11:22:43.634730157 -0500
+++ policy-1.19.12.new/macros/user_macros.te	2004-12-09 11:03:11.384548140 -0500
@@ -18,8 +18,8 @@
 # Use capabilities
 
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
-type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type;
+create_user_file_type($1, `home_dir_t', `, home_dir_type, home_type, user_home_dir_type')
+create_user_file_type($1, `home_t', `, home_type, user_home_type, $1_file_type')
 
 tmp_domain($1, `, user_tmpfile, $1_file_type')
 
@@ -109,7 +109,13 @@
 
 ifdef(`ftpd.te', `
 if (ftp_home_dir) {
+ifdef(`single_user_file_type', `
+ifelse($1, user, `
 file_type_auto_trans(ftpd_t, $1_home_dir_t, $1_home_t)
+')
+', `
+file_type_auto_trans(ftpd_t, $1_home_dir_t, $1_home_t)
+')
 }
 ')dnl end ifdef ftpd
 

--------------080709000402000709000002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
