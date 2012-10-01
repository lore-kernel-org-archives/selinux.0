Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWvZw017398
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 7809B1AAD9
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:39 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KLH5f2IftdZh for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:36 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A46FB1AAEE
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:35 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/15] libselinux: Fix cases where hyphen were used as minus sign in manpages
Date: Mon,  1 Oct 2012 18:31:53 +0200
Message-Id: <1349109117-593-12-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

And also other minor formating issues
---
 libselinux/man/man3/avc_netlink_loop.3         |    2 +-
 libselinux/man/man3/context_new.3              |    2 +-
 libselinux/man/man3/get_ordered_context_list.3 |    8 ++++----
 libselinux/man/man3/getcon.3                   |    2 +-
 libselinux/man/man3/getexeccon.3               |    2 +-
 libselinux/man/man3/getfscreatecon.3           |    2 +-
 libselinux/man/man3/getkeycreatecon.3          |    2 +-
 libselinux/man/man3/getsockcreatecon.3         |    2 +-
 libselinux/man/man3/is_context_customizable.3  |    2 +-
 libselinux/man/man3/matchmediacon.3            |    2 +-
 libselinux/man/man3/security_check_context.3   |    2 +-
 libselinux/man/man3/security_getenforce.3      |    6 +++---
 libselinux/man/man3/security_policyvers.3      |    2 +-
 libselinux/man/man3/security_setenforce.3      |    2 +-
 libselinux/man/man3/selinux_boolean_sub.3      |    2 +-
 libselinux/man/man3/selinux_getenforcemode.3   |    4 ++--
 libselinux/man/man3/selinux_getpolicytype.3    |    2 +-
 libselinux/man/man3/selinux_set_mapping.3      |    2 +-
 libselinux/man/man3/selinux_status_open.3      |   12 ++++++------
 libselinux/man/man3/setfilecon.3               |    6 +++---
 libselinux/man/man5/selabel_db.5               |    2 +-
 libselinux/man/man8/booleans.8                 |    8 ++++----
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index 785be4c..5eea889 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -73,7 +73,7 @@ the socket, in which case the socket is closed.
 .SH "RETURN VALUE"
 .B avc_netlink_acquire_fd
 returns a non-negative file descriptor number on success.  Other functions
-with a return value return zero on success.  On error, -1 is returned and
+with a return value return zero on success.  On error, \-1 is returned and
 .I errno
 is set appropriately.
 
diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3
index 820f927..ea1c896 100644
--- a/libselinux/man/man3/context_new.3
+++ b/libselinux/man/man3/context_new.3
@@ -54,7 +54,7 @@ context_type_set, context_range_set, context_role_set, context_user_set
  Set a context component
 
 .SH "RETURN VALUE"
-On success, zero is returned. On failure, -1 is returned and errno is
+On success, zero is returned. On failure, \-1 is returned and errno is
 set appropriately.
 
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index c3fa956..59e8dd1 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -41,7 +41,7 @@ file if it exists.  The
 .I fromcon
 parameter may be NULL to indicate that the current context should
 be used.  The function returns the number of contexts in the
-list, or -1 upon errors.  The list must be freed using the
+list, or \-1 upon errors.  The list must be freed using the
 .B freeconary
 function.
 
@@ -56,7 +56,7 @@ which has to be freed with freecon.
 invokes the get_default_context function and applies the specified level.
 
 .B get_default_context_with_role
-is the same as get_default_context but only returns a context with the specified role, returning -1 if no such context is reachable for the user.
+is the same as get_default_context but only returns a context with the specified role, returning \-1 if no such context is reachable for the user.
 
 .B get_default_context_with_rolelevel
 invokes the get_default_context_with_role function and applies the specified level.
@@ -73,8 +73,8 @@ allows the user to manually enter a context as a fallback if a list of authorize
 Get the default type (domain) for 'role' and set 'type' to refer to it, which has to be freed with free.
 
 .SH "RETURN VALUE"
-get_ordered_context_list and get_ordered_context_list_with_level return the number of contexts in the list upon success or -1 upon errors.
-The other functions return 0 for success or -1 for errors.
+get_ordered_context_list and get_ordered_context_list_with_level return the number of contexts in the list upon success or \-1 upon errors.
+The other functions return 0 for success or \-1 for errors.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " freeconary "(3), " freecon "(3), " security_compute_av "(3)", getseuserbyname"(3)"
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index c620c51..d31c1cf 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -72,7 +72,7 @@ operation, ptrace permission will be revalidated against the new
 context and the setcon() will fail if it is not allowed by policy.
 
 .SH "RETURN VALUE"
-On error -1 is returned.  On success 0 is returned.
+On error \-1 is returned.  On success 0 is returned.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " setexeccon "(3)"
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index 4b832a2..b95daa2 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -49,7 +49,7 @@ environment arrays.
 
 
 .SH "RETURN VALUE"
-On error -1 is returned.
+On error \-1 is returned.
 
 On success getexeccon and setexeccon returns 0.
 rpm_execcon only returns upon errors, as it calls execve(2).
diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index 474aa28..10960f5 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -31,7 +31,7 @@ in order to set an file context on the objects.
 Note: Signal handlers that perform an setfscreate must take care to
 save, reset, and restore the fscreate context to avoid unexpected behavior.
 .SH "RETURN VALUE"
-On error -1 is returned.
+On error \-1 is returned.
 On success 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index 3b594a0..a7ab86b 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -31,7 +31,7 @@ in order to set an file context on the objects.
 Note: Signal handlers that perform an setkeycreate must take care to
 save, reset, and restore the keycreate context to avoid unexpected behavior.
 .SH "RETURN VALUE"
-On error -1 is returned.
+On error \-1 is returned.
 On success 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 24f2cc0..65fb195 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -31,7 +31,7 @@ in order to set an file context on the objects.
 Note: Signal handlers that perform an setsockcreate must take care to
 save, reset, and restore the sockcreate context to avoid unexpected behavior.
 .SH "RETURN VALUE"
-On error -1 is returned.
+On error \-1 is returned.
 On success 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/is_context_customizable.3 b/libselinux/man/man3/is_context_customizable.3
index d230ace..0fe30c9 100644
--- a/libselinux/man/man3/is_context_customizable.3
+++ b/libselinux/man/man3/is_context_customizable.3
@@ -15,7 +15,7 @@ administrators set on files, usually to allow certain domains to share the file
  
 .SH "RETURN VALUE"
 returns 1 if security context is customizable or 0 if it is not. 
-returns -1 on error
+returns \-1 on error
 
 .SH "FILE"
 /etc/selinux/SELINUXTYPE/context/customizable_types
diff --git a/libselinux/man/man3/matchmediacon.3 b/libselinux/man/man3/matchmediacon.3
index 1a3a561..414ae52 100644
--- a/libselinux/man/man3/matchmediacon.3
+++ b/libselinux/man/man3/matchmediacon.3
@@ -17,7 +17,7 @@ matches the specified media type with the media contexts configuration and sets
 .B Note: 
    Caller must free returned security context "con" using freecon.
 .SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise.
+Returns 0 on success or \-1 otherwise.
 
 .SH Files
 /etc/selinux/POLICYTYPE/contexts/files/media
diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index af55f06..ff01723 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -9,7 +9,7 @@ security_check_context \- check the validity of a SELinux context
 .SH "DESCRIPTION"
 .B security_check_context
 returns 0 if SELinux is running and the context is valid, otherwise it
-returns -1.
+returns \-1.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
index 86771b5..920f0da 100644
--- a/libselinux/man/man3/security_getenforce.3
+++ b/libselinux/man/man3/security_getenforce.3
@@ -13,16 +13,16 @@ security_getenforce, security_setenforce, security_deny_unknown \- get or set th
 .SH "DESCRIPTION"
 .B security_getenforce
 returns 0 if SELinux is running in permissive mode, 1 if it is running in
-enforcing mode, and -1 on error.
+enforcing mode, and \-1 on error.
 
 .B security_setenforce
 sets SELinux to enforcing mode if the value 1 is passed in, and sets it to
-permissive mode if 0 is passed in.  On success 0 is returned, on error -1 is
+permissive mode if 0 is passed in.  On success 0 is returned, on error \-1 is
 returned.
 
 .B security_deny_unknown
 returns 0 if SELinux treats policy queries on undefined object classes or
-permissions as being allowed, 1 if such queries are denied, and -1 on error.
+permissions as being allowed, 1 if such queries are denied, and \-1 on error.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/security_policyvers.3 b/libselinux/man/man3/security_policyvers.3
index 9e5dfd2..b73bc15 100644
--- a/libselinux/man/man3/security_policyvers.3
+++ b/libselinux/man/man3/security_policyvers.3
@@ -8,7 +8,7 @@ security_policyvers \- get the version of the SELinux policy
 
 .SH "DESCRIPTION"
 .B security_policyvers
-returns the version of the policy (a positive integer) on success, or -1 on
+returns the version of the policy (a positive integer) on success, or \-1 on
 error.
 
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/security_setenforce.3 b/libselinux/man/man3/security_setenforce.3
index 24bca10..d59e5c2 100644
--- a/libselinux/man/man3/security_setenforce.3
+++ b/libselinux/man/man3/security_setenforce.3
@@ -1 +1 @@
-.so security_getenforce.3
+.so man3/security_getenforce.3
diff --git a/libselinux/man/man3/selinux_boolean_sub.3 b/libselinux/man/man3/selinux_boolean_sub.3
index 8d54c88..d78f7c1 100644
--- a/libselinux/man/man3/selinux_boolean_sub.3
+++ b/libselinux/man/man3/selinux_boolean_sub.3
@@ -1,6 +1,6 @@
 .TH "selinux_boolean_subs" "3" "11 June 2012" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-selinux_boolean_subs
+selinux_boolean_subs \- returns the boolean substitution name if existing.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
diff --git a/libselinux/man/man3/selinux_getenforcemode.3 b/libselinux/man/man3/selinux_getenforcemode.3
index a6a753e..861029e 100644
--- a/libselinux/man/man3/selinux_getenforcemode.3
+++ b/libselinux/man/man3/selinux_getenforcemode.3
@@ -14,10 +14,10 @@ system was setup to run SELinux.
 
 Sets the value of enforce to 1 if SELinux should be run in enforcing mode.
 Sets the value of enforce to 0 if SELinux should be run in permissive mode.
-Sets the value of enforce to -1 if SELinux should be disabled.
+Sets the value of enforce to \-1 if SELinux should be disabled.
 .SH "RETURN VALUE"
 On success, zero is returned.
-On failure, -1 is returned.
+On failure, \-1 is returned.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/selinux_getpolicytype.3 b/libselinux/man/man3/selinux_getpolicytype.3
index 67f9518..ccb7c86 100644
--- a/libselinux/man/man3/selinux_getpolicytype.3
+++ b/libselinux/man/man3/selinux_getpolicytype.3
@@ -13,7 +13,7 @@ Reads the contents of the /etc/selinux/config file to determine the SELinux poli
 
 .SH "RETURN VALUE"
 On success, zero is returned.
-On failure, -1 is returned.
+On failure, \-1 is returned.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index 7ac069a..03d462d 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -35,7 +35,7 @@ field should refer to an array of permission bit names terminated by a NULL stri
 The object classes named in the mapping and the bit indexes of each set of permission bits named in the mapping are numbered in order starting from 1.  These numbers are the values that should be passed to subsequent libselinux calls.
 
 .SH "RETURN VALUE"
-Zero is returned on success.  On error, -1 is returned and
+Zero is returned on success.  On error, \-1 is returned and
 .I errno
 is set appropriately.
 
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index e897939..7e88a2a 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -58,24 +58,24 @@ netlink socket if fallbacked.
 .BR selinux_status_updated
 informs us whether something has been updated since the last call.
 It returns 0 if nothing was happened, however, 1 if something has been
-updated in this duration, or -1 on error.
+updated in this duration, or \-1 on error.
 .sp
 .BR selinux_status_getenforce
 returns 0 if SELinux is running in permissive mode, 1 if enforcing mode,
-or -1 on error.
+or \-1 on error.
 Same as
 .BR security_getenforce (3)
 except with or without system call invocation.
 .sp
 .BR selinux_status_policyload
-returns times of policy reloaded on the running system, or -1 on error.
+returns times of policy reloaded on the running system, or \-1 on error.
 Note that it is not a reliable value on fallback-mode until it receive
 the first event message via netlink socket.
 Thus, don't use this value to know actual times of policy reloaded.
 .sp
 .BR selinux_status_deny_unknown
 returns 0 if SELinux treats policy queries on undefined object classes or
-permissions as being allowed, 1 if such queries are denied, or -1 on error.
+permissions as being allowed, 1 if such queries are denied, or \-1 on error.
 .sp
 Also note that these interfaces are not thread-safe, so you have to protect
 them from concurrent calls using exclusive locks when multiple threads are
@@ -84,10 +84,10 @@ performing.
 .BR selinux_status_open
 returns 0 or 1 on success. 1 means we are ready to use these interfaces,
 but netlink socket was opened as fallback instead of the kernel status page.
-On error, -1 shall be returned.
+On error, \-1 shall be returned.
 .sp
 Any other functions with a return value shall return its characteristic
-value as described above, or -1 on errors.
+value as described above, or \-1 on errors.
 .sp
 .SH "SEE ALSO"
 .BR mmap (2)
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 18030cd..c34d358 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -24,15 +24,15 @@ is identical to setfilecon, only the open file pointed to by filedes (as
 returned by open(2)) has it's context set in place of path.
 
 .SH "RETURN VALUE"
-On success, zero is returned. On failure, -1 is returned and errno is
+On success, zero is returned. On failure, \-1 is returned and errno is
 set appropriately.
 
 If there is insufficient space remaining to store the extended
 attribute, errno is set to either ENOSPC, or EDQUOT if quota enforce-
 ment was the cause.
 
-If extended attributes are not supported by the filesystem, or are dis-
-abled, errno is set to ENOTSUP.
+If extended attributes are not supported by the filesystem, or are disabled,
+errno is set to ENOTSUP.
 
 The errors documented for the stat(2) system call are also applicable
 here.
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
index c809d18..6de8b5f 100644
--- a/libselinux/man/man5/selabel_db.5
+++ b/libselinux/man/man5/selabel_db.5
@@ -5,7 +5,7 @@
 .SH "NAME"
 selabel_db \- userspace SELinux labeling interface and configuration file format for the RDBMS objects context backend.
 .SH "SYNOPSIS"
-..B #include <selinux/label.h>
+.B #include <selinux/label.h>
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
diff --git a/libselinux/man/man8/booleans.8 b/libselinux/man/man8/booleans.8
index 89c7654..29d374e 100644
--- a/libselinux/man/man8/booleans.8
+++ b/libselinux/man/man8/booleans.8
@@ -19,7 +19,7 @@ value.
 The policy defines a default value for each boolean, typically false.
 These default values can be overridden via local settings created via the
 .B setsebool(8)
-utility, using -P to make the setting persistent across reboots.
+utility, using \-P to make the setting persistent across reboots.
 The 
 .B system-config-securitylevel
 tool provides a graphical interface for altering
@@ -27,11 +27,11 @@ the settings.  The
 .B load_policy(8)
 program will preserve
 current boolean settings upon a policy reload by default, or can
-optionally reset booleans to the boot-time defaults via the -b option.
+optionally reset booleans to the boot-time defaults via the \-b option.
 
 Boolean values can be listed by using the
 .B getsebool(8)
-utility and passing it the -a option.
+utility and passing it the \-a option.
 
 Boolean values can also be changed at runtime via the
 .B setsebool(8)
@@ -39,7 +39,7 @@ utility or the
 .B togglesebool
 utility.  By default, these utilities only change the
 current boolean value and do not affect the persistent settings,
-unless the -P option is used to setsebool.
+unless the \-P option is used to setsebool.
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
