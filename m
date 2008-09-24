Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8OCvp9K005074
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 08:57:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8OCusbr012224
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 12:56:54 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8OCvmNV026659
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 08:57:48 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8OCvemI001028
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 08:57:42 -0400
Received: from localhost.localdomain (vpn-10-61.bos.redhat.com [10.16.10.61])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8OCvemO024540
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 08:57:40 -0400
Message-ID: <48DA3948.9060003@redhat.com>
Date: Wed, 24 Sep 2008 08:57:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Some missing man pages from libselinux
Content-Type: multipart/mixed;
 boundary="------------010503050403050605090802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010503050403050605090802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We are still missing the following man pages.
Perhaps some of these functions should be removed?
selinux_users_path seems to return a bogus directory?
Also do not have _raw functions defined in man pages.

matchpathcon_checkmatches
matchpathcon_filespec_add
matchpathcon_filespec_destroy
matchpathcon_filespec_eval
matchpathcon_index
matchpathcon_init_prefix
print_access_vector
security_canonicalize_context
security_disable
security_set_boolean_list
selinux_check_passwd_access
selinux_customizable_types_path
selinux_file_context_cmp
selinux_file_context_verify
selinux_get_callback
selinux_init_load_policy
selinux_lsetfilecon_default
selinux_mkload_policy
selinux_raw_to_trans_context
selinux_trans_to_raw_context
selinux_translations_path
selinux_users_path
set_selinuxmnt

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjaOUgACgkQrlYvE4MpobOiewCeJmyth4NPBeNu4rvnvc8fcsMd
UxEAn0mDTAiDHVzyhvG2QNaBUKBzemE9
=dElU
-----END PGP SIGNATURE-----

--------------010503050403050605090802
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_get_initial_sid.3 libselinux-2.0.71/man/man3/avc_get_initial_sid.3
--- nsalibselinux/man/man3/avc_get_initial_sid.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/avc_get_initial_sid.3	2008-09-24 08:44:16.000000000 -0400
@@ -0,0 +1 @@
+.so man3/avc_context_to_sid.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/fgetfilecon.3 libselinux-2.0.71/man/man3/fgetfilecon.3
--- nsalibselinux/man/man3/fgetfilecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/fgetfilecon.3	2008-09-24 07:41:57.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/get_default_type.3 libselinux-2.0.71/man/man3/get_default_type.3
--- nsalibselinux/man/man3/get_default_type.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/get_default_type.3	2008-09-24 08:40:51.000000000 -0400
@@ -0,0 +1 @@
+.so man3/get_ordered_context_list.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getkeycreatecon.3 libselinux-2.0.71/man/man3/getkeycreatecon.3
--- nsalibselinux/man/man3/getkeycreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/getkeycreatecon.3	2008-09-24 07:41:57.000000000 -0400
@@ -0,0 +1,38 @@
+.TH "getkeycreatecon" "3" "9 September 2008" "dwalsh@redhat.com from russell@coker.com.au" "SELinux API documentation"
+.SH "NAME"
+getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used for creating a new kernel keyrings.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int getkeycreatecon(security_context_t *" con );
+
+.BI "int setkeycreatecon(security_context_t "context );
+
+.SH "DESCRIPTION"
+.B getkeycreatecon
+retrieves the context used for creating a new kernel keyring.
+This returned context should be freed with freecon if non-NULL.  
+getkeycreatecon sets *con to NULL if no keycreate context has been explicitly 
+set by the program (i.e. using the default policy behavior).
+
+.B setkeycreatecon
+sets the context used for creating a new kernel keyring.
+NULL can be passed to
+setkeycreatecon to reset to the default policy behavior.  
+The keycreate context is automatically reset after the next execve, so a
+program doesn't need to explicitly sanitize it upon startup.  
+
+setkeycreatecon can be applied prior to library
+functions that internally perform an file creation,
+in order to set an file context on the objects.
+
+
+Note: Signal handlers that perform an setkeycreate must take care to
+save, reset, and restore the keycreate context to avoid unexpected behavior.
+.SH "RETURN VALUE"
+On error -1 is returned.
+On success 0 is returned.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " freecon "(3), " getcon "(3), " getexeccon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getsockcreatecon.3 libselinux-2.0.71/man/man3/getsockcreatecon.3
--- nsalibselinux/man/man3/getsockcreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/getsockcreatecon.3	2008-09-24 08:49:48.000000000 -0400
@@ -0,0 +1,38 @@
+.TH "getsockcreatecon" "3" "24 September 2008" "dwalsh@redhat.com from russell@coker.com.au" "SELinux API documentation"
+.SH "NAME"
+getsockcreatecon, setsockcreatecon \- get or set the SELinux security context used for creating a new labeled sockets.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int getsockcreatecon(security_context_t *" con );
+
+.BI "int setsockcreatecon(security_context_t "context );
+
+.SH "DESCRIPTION"
+.B getsockcreatecon
+retrieves the context used for creating a new labeled network socket.
+This returned context should be freed with freecon if non-NULL.  
+getsockcreatecon sets *con to NULL if no sockcreate context has been explicitly 
+set by the program (i.e. using the default policy behavior).
+
+.B setsockcreatecon
+sets the context used for creating a new labeled network sockets
+NULL can be passed to
+setsockcreatecon to reset to the default policy behavior.  
+The sockcreate context is automatically reset after the next execve, so a
+program doesn't need to explicitly sanitize it upon startup.  
+
+setsockcreatecon can be applied prior to library
+functions that internally perform an file creation,
+in order to set an file context on the objects.
+
+
+Note: Signal handlers that perform an setsockcreate must take care to
+save, reset, and restore the sockcreate context to avoid unexpected behavior.
+.SH "RETURN VALUE"
+On error -1 is returned.
+On success 0 is returned.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " freecon "(3), " getcon "(3)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_selinux_enabled.3 libselinux-2.0.71/man/man3/is_selinux_enabled.3
--- nsalibselinux/man/man3/is_selinux_enabled.3	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/man/man3/is_selinux_enabled.3	2008-09-24 07:48:20.000000000 -0400
@@ -1,14 +1,22 @@
 .TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 is_selinux_enabled \- check whether SELinux is enabled
+
+.SH "NAME"
+is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Securty) MLS 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
 .B int is_selinux_enabled();
 
+.B int is_selinux_mls_enabled();
+
 .SH "DESCRIPTION"
 .B is_selinux_enabled
-returns 1 if SELinux is running or 0 if it is not.  May change soon.
+returns 1 if SELinux is running or 0 if it is not. 
+
+.B is_selinux_mls_enabled
+returns 1 if SELinux is running in MLS mode or 0 if it is not. 
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_selinux_mls_enabled.3 libselinux-2.0.71/man/man3/is_selinux_mls_enabled.3
--- nsalibselinux/man/man3/is_selinux_mls_enabled.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/is_selinux_mls_enabled.3	2008-09-24 07:47:56.000000000 -0400
@@ -0,0 +1 @@
+.so man3/is_selinux_enabled.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/lgetfilecon.3 libselinux-2.0.71/man/man3/lgetfilecon.3
--- nsalibselinux/man/man3/lgetfilecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/lgetfilecon.3	2008-09-24 07:41:57.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchpathcon_fini.3 libselinux-2.0.71/man/man3/matchpathcon_fini.3
--- nsalibselinux/man/man3/matchpathcon_fini.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/matchpathcon_fini.3	2008-09-24 08:38:17.000000000 -0400
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchpathcon_init.3 libselinux-2.0.71/man/man3/matchpathcon_init.3
--- nsalibselinux/man/man3/matchpathcon_init.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/matchpathcon_init.3	2008-09-24 08:38:00.000000000 -0400
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_binary_policy_path.3 libselinux-2.0.71/man/man3/selinux_binary_policy_path.3
--- nsalibselinux/man/man3/selinux_binary_policy_path.3	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/man/man3/selinux_binary_policy_path.3	2008-09-24 08:18:47.000000000 -0400
@@ -1,6 +1,6 @@
 .TH "selinux_binary_policy_path" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
 .SH "NAME"
-selinux_policy_root, selinux_binary_policy_path,
+selinux_path, selinux_policy_root, selinux_binary_policy_path,
 selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path,
 selinux_file_context_path, selinux_media_context_path,
@@ -11,6 +11,8 @@
 .B #include <selinux/selinux.h>
 .sp
 
+extern const char *selinux_path(void);
+
 extern const char *selinux_policy_root(void);
 
 extern const char *selinux_binary_policy_path(void);
@@ -23,6 +25,10 @@
 
 extern const char *selinux_user_contexts_path(void);
 
+extern const char *selinux_usersconf_path(void);
+
+extern const char *selinux_x_context_path(void);
+
 extern const char *selinux_file_context_path(void);
 
 extern const char *selinux_media_context_path(void);
@@ -40,10 +46,14 @@
 directories and files based on the settings in /etc/selinux/config.
 
 .sp
+selinux_path() - top-level SELinux configuration directory
+.sp
 selinux_policy_root() - top-level policy directory 
 .sp
 selinux_binary_policy_path() - binary policy file loaded into kernel
 .sp
+selinux_default_type_path - context file mapping roles to default types.
+.sp
 selinux_failsafe_context_path() - failsafe context for emergency logins
 .sp
 selinux_removable_context_path() - filesystem context for removable media
@@ -52,7 +62,17 @@
 .sp
 selinux_user_contexts_path() - directory containing per-user default contexts
 .sp
-selinux_file_context_path() - file contexts configuration
+selinux_usersconf_path() - file containing mapping between Linux Users and SELinux users
+.sp
+selinux_x_context_path() - file containing configuration for XSELinux extension
+.sp
+selinux_netfilter_context_path - default netfilter context 
+.sp
+selinux_file_context_path() - default sysstem file contexts configuration
+.sp
+selinux_file_context_local_path() - local customization file contexts configuration
+.sp
+selinux_file_context_homedir_path() - home directory file contexts configuration
 .sp
 selinux_media_context_path() - file contexts for media device nodes
 .sp
@@ -67,4 +87,3 @@
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
-
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_default_type_path.3 libselinux-2.0.71/man/man3/selinux_default_type_path.3
--- nsalibselinux/man/man3/selinux_default_type_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_default_type_path.3	2008-09-24 08:19:09.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_file_context_homedir_path.3 libselinux-2.0.71/man/man3/selinux_file_context_homedir_path.3
--- nsalibselinux/man/man3/selinux_file_context_homedir_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_file_context_homedir_path.3	2008-09-24 08:17:07.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_file_context_local_path.3 libselinux-2.0.71/man/man3/selinux_file_context_local_path.3
--- nsalibselinux/man/man3/selinux_file_context_local_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_file_context_local_path.3	2008-09-24 08:17:14.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_getpolicytype.3 libselinux-2.0.71/man/man3/selinux_getpolicytype.3
--- nsalibselinux/man/man3/selinux_getpolicytype.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_getpolicytype.3	2008-09-24 07:42:23.000000000 -0400
@@ -0,0 +1,21 @@
+.TH "selinux_getpolicytype" "3" "24 Sep 2008" "dwalsh@redhat.com" "SELinux API documentation"
+.SH "NAME"
+selinux_getpolicytype \- get the type of SELinux policy running on the system
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B int selinux_getpolicytype();
+
+
+.SH "DESCRIPTION"
+.B selinux_getpolicytype
+Reads the contents of the /etc/selinux/config file to determine the SELinux policy used on the system.
+
+.SH "RETURN VALUE"
+On success, zero is returned.
+On failure, -1 is returned.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_homedir_context_path.3 libselinux-2.0.71/man/man3/selinux_homedir_context_path.3
--- nsalibselinux/man/man3/selinux_homedir_context_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_homedir_context_path.3	2008-09-24 08:36:35.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_netfilter_context_path.3 libselinux-2.0.71/man/man3/selinux_netfilter_context_path.3
--- nsalibselinux/man/man3/selinux_netfilter_context_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_netfilter_context_path.3	2008-09-24 08:36:44.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_path.3 libselinux-2.0.71/man/man3/selinux_path.3
--- nsalibselinux/man/man3/selinux_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_path.3	2008-09-24 08:02:28.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_usersconf_path.3 libselinux-2.0.71/man/man3/selinux_usersconf_path.3
--- nsalibselinux/man/man3/selinux_usersconf_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_usersconf_path.3	2008-09-24 08:36:00.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_x_context_path.3 libselinux-2.0.71/man/man3/selinux_x_context_path.3
--- nsalibselinux/man/man3/selinux_x_context_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_x_context_path.3	2008-09-24 08:36:08.000000000 -0400
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/set_matchpathcon_flags.3 libselinux-2.0.71/man/man3/set_matchpathcon_flags.3
--- nsalibselinux/man/man3/set_matchpathcon_flags.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/set_matchpathcon_flags.3	2008-09-24 08:42:03.000000000 -0400
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/setkeycreatecon.3 libselinux-2.0.71/man/man3/setkeycreatecon.3
--- nsalibselinux/man/man3/setkeycreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/setkeycreatecon.3	2008-09-24 07:41:57.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getkeycreatecon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/setsockcreatecon.3 libselinux-2.0.71/man/man3/setsockcreatecon.3
--- nsalibselinux/man/man3/setsockcreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/setsockcreatecon.3	2008-09-24 08:46:55.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getsockcreatecon.3

--------------010503050403050605090802
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkjaOUgACgkQrlYvE4MpobODgwCfYhYEOBw8uofUaL6K1nFcAw9KTNQAnjtJ
/qhUTI5AvhNtGzJZPd4kHFpn
--------------010503050403050605090802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
