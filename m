Subject: Contributed manual pages for libselinux
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-uhOq3xQ+mt2HCM/KuPqD"
Date: Tue, 03 Nov 2009 00:57:56 +0100
Message-Id: <1257206276.24413.26.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uhOq3xQ+mt2HCM/KuPqD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello !

I found from http://userspace.selinuxproject.org/trac/wiki/Todo that the
following manual pages were missing for libselinux:

* matchpathcon_checkmatches
* matchpathcon_filespec_add
* matchpathcon_filespec_destroy
* matchpathcon_filespec_eval
* matchpathcon_index
* matchpathcon_init_prefix
* print_access_vector
security_canonicalize_context
* security_disable
* security_set_boolean_list
* selinux_check_passwd_access
selinux_customizable_types_path
selinux_get_callback
* selinux_init_load_policy
* selinux_lsetfilecon_default
* selinux_mkload_policy
selinux_raw_to_trans_context
selinux_trans_to_raw_context
selinux_translations_path
selinux_users_path
* set_selinuxmnt

So, I have contributed the ones marked with a "*" in the attached patch.
I might do the rest at a later time, if possible (and if needed).

Guido Trentalancia


diff -pruN libselinux/man/man3/fini_selinuxmnt.3
libselinux-new/man/man3/fini_selinuxmnt.3
--- libselinux/man/man3/fini_selinuxmnt.3	1970-01-01 01:00:00.000000000
+0100
+++ libselinux-new/man/man3/fini_selinuxmnt.3	2009-11-03
00:09:04.000000000 +0100
@@ -0,0 +1 @@
+.so man3/init_selinuxmnt.3
diff -pruN libselinux/man/man3/init_selinuxmnt.3
libselinux-new/man/man3/init_selinuxmnt.3
--- libselinux/man/man3/init_selinuxmnt.3	1970-01-01 01:00:00.000000000
+0100
+++ libselinux-new/man/man3/init_selinuxmnt.3	2009-11-03
00:30:08.000000000 +0100
@@ -0,0 +1,31 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Guido Trentalancia (guido@trentalancia.com) 2009
+.TH "init_selinuxmnt" "3" "02 Nov 2009" "" "SELinux API documentation"
+.SH "NAME"
+init_selinuxmnt \- initialize the global variable selinux_mnt.
+
+.SH "SYNOPSIS"
+.BI "static void init_selinuxmnt(void);"
+.sp
+.BI "static void fini_selinuxmnt(void);"
+.sp
+.BI "void set_selinuxmnt(char *" mnt ");"
+
+.SH "DESCRIPTION"
+.B init_selinuxmnt 
+initializes the global variable selinux_mnt to the selinuxfs
mountpoint.
+
+.B fini_selinuxmnt
+deinitializes the global variable selinux_mnt that stores the selinuxfs
+mountpoint.
+
+.B set_selinuxmnt
+changes the selinuxfs mountpoint to
+.I mnt. 
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia
<guido@trentalancia.com>
+
+.SH "SEE ALSO"
+.BR selinux (8),
diff -pruN libselinux/man/man3/matchpathcon.3
libselinux-new/man/man3/matchpathcon.3
--- libselinux/man/man3/matchpathcon.3	2009-11-01 22:23:01.000000000
+0100
+++ libselinux-new/man/man3/matchpathcon.3	2009-11-03 00:44:53.000000000
+0100
@@ -7,21 +7,35 @@ matchpathcon \- get the default SELinux 
 .sp
 .BI "int matchpathcon_init(const char *" path ");"
 
+.BI "int matchpathcon_init_prefix(const char *" path ", const char *"
subset ");"
+
 .BI "int matchpathcon_fini(void);"
 
-.BI "int matchpathcon(const char *" path ", mode_t " mode ",
security_context_t *" con);
+.BI "int matchpathcon(const char *" path ", mode_t " mode ",
security_context_t *" con ");
+.sp
+
+.BI "int matchpathcon_index(const char *" name ", mode_t " mode ",
security_context_t * " con ");"
+
+.BI "int matchpathcon_filespec_add(ino_t " ino ", int " specind ",
const char *" file ");"
+
+.BI "void matchpathcon_filespec_destroy(void);"
+
+.BI "void matchpathcon_filespec_eval(void);"
+
+.BI "void matchpathcon_checkmatches(char *" str ");"
 .sp
 
 .BI "void set_matchpathcon_printf(void (*" f ")(const char *" fmt
", ...));"
 
-.BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *"path ",
unsigned " lineno ", char * " context "));"
+.BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *" path
", unsigned " lineno ", char * " context "));"
 
 .BI "void set_matchpathcon_flags(unsigned int " flags ");"
 
-.BI "int selinux_file_context_cmp(const security_context_t a,
-				     const security_context_t b);"
+.BI "int selinux_file_context_cmp(const security_context_t " a ", const
security_context_t " b ");"
 
-.BI "int selinux_file_context_verify(const char *path, mode_t mode);"
+.BI "int selinux_file_context_verify(const char *" path ", mode_t "
mode ");"
+
+.BI "int selinux_lsetfilecon_default(const char *" path ");"
 
 .SH "DESCRIPTION"
 .B matchpathcon_init
@@ -44,7 +58,16 @@ and
 .B .local
 suffix are also looked up and loaded if present.  These files provide
 dynamically generated entries for user home directories and for local
-customizations.
+customizations. Returns zero on success or \-1 on error.
+
+.sp
+.B matchpathcon_init_prefix
+is the same as
+.B matchpathcon_init
+but only loads entries with regexes that have stems that are prefixes
+of
+.I prefix.
+Returns zero on success or \-1 on error.
 
 .sp
 .B matchpathcon_fini
@@ -78,6 +101,43 @@ its first invocation with a NULL
 defaulting to the active file contexts configuration.
 .sp
 
+.B matchpathcon_index
+is the same as
+.B matchpathcon
+but returns a specification index that can be used later in a
+.B matchpathcon_filespec_add
+call.
+.sp
+
+.B matchpathcon_filespec_add
+maintains an association between an inode
+.I ino
+and a specification index
+.I specind,
+and checks whether a conflicting specification is already associated
+with the same inode (e.g. due to multiple hard links). If so, then
+it uses the latter of the two specifications based on their order in
the 
+.I file
+context configuration. Returns the specification index used or \-1 on
+error.
+.sp
+
+.B matchpathcon_filespec_destroy
+destroys any inode associations that have been added, e.g. to restart
+for a new filesystem.
+.sp
+
+.B matchpathcon_filespec_eval
+displays statistics on the hash table usage for the inode associations.
+.sp
+
+.B matchpathcon_checkmatches
+checks whether any specification has no matches and reports them.
+The
+.I str
+argument is used as a prefix for any warning messages.
+.sp
+
 .B set_matchpathcon_printf
 sets the function used by 
 .B matchpathcon_init
@@ -98,7 +158,7 @@ This can be set to instead perform check
 e.g. using 
 .B sepol_check_context(3),
 as is done by 
-.B setfiles -c.
+.B setfiles \-c.
 The function is also responsible for reporting any such error, and
 may include the 
 .I path
@@ -122,10 +182,13 @@ compares two file contexts to see if the
 .sp
 .B selinux_file_context_verify
 compares the file context on disk to the system default.
+.sp
+.B selinux_lsetfilecon_default
+sets the file context to the system defaults.
 
 .sp
 .SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise.
+Returns zero on success or \-1 otherwise.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " freecon "(3), " setfilecon "(3), " setfscreatecon
"(3)"
diff -pruN libselinux/man/man3/matchpathcon_checkmatches.3
libselinux-new/man/man3/matchpathcon_checkmatches.3
--- libselinux/man/man3/matchpathcon_checkmatches.3	1970-01-01
01:00:00.000000000 +0100
+++ libselinux-new/man/man3/matchpathcon_checkmatches.3	2009-11-02
17:54:56.000000000 +0100
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff -pruN libselinux/man/man3/print_access_vector.3
libselinux-new/man/man3/print_access_vector.3
--- libselinux/man/man3/print_access_vector.3	1970-01-01
01:00:00.000000000 +0100
+++ libselinux-new/man/man3/print_access_vector.3	2009-11-02
19:34:40.000000000 +0100
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
diff -pruN libselinux/man/man3/security_class_to_string.3
libselinux-new/man/man3/security_class_to_string.3
--- libselinux/man/man3/security_class_to_string.3	2009-11-01
22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_class_to_string.3	2009-11-03
00:23:55.000000000 +0100
@@ -6,6 +6,8 @@
 security_class_to_string, security_av_perm_to_string,
string_to_security_class, string_to_av_perm, security_av_string \-
convert
 between SELinux class and permission values and string names.
 
+print_access_vector \- display an access vector in human-readable
form. 
+
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 
@@ -20,6 +22,8 @@ between SELinux class and permission val
 .BI "security_class_t string_to_security_class(const char *" name ");"
 .sp
 .BI "access_vector_t string_to_av_perm(security_class_t " tclass ",
const char *" name ");"
+.sp
+.BI "void print_access_vector(security_class_t " tclass ",
access_vector_t " av ");"
 
 .SH "DESCRIPTION"
 .B security_class_to_string
@@ -56,11 +60,17 @@ and security class
 .IR tclass ,
 or zero if no such value exists.
 
+.B print_access_vector
+displays an access vector in human-readable form on the standard output
+stream.
+
 .SH "RETURN VALUE"
 .B security_av_string
-returns returns zero on success or \-1 on error with
+returns zero on success or \-1 on error with
 .I errno
-set appropriately.  All other functions return zero or NULL on error.
+set appropriately.
+.B print_access_vector
+does not return a value. All other functions return zero or NULL on
error.
 
 .SH "ERRORS"
 .TP
diff -pruN libselinux/man/man3/security_compute_av.3
libselinux-new/man/man3/security_compute_av.3
--- libselinux/man/man3/security_compute_av.3	2009-11-01
22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_compute_av.3	2009-11-02
23:34:49.000000000 +0100
@@ -24,6 +24,8 @@ the SELinux policy database in the kerne
 .BI "int security_get_initial_context(const char *" name ",
security_context_t
 "con );
 .sp
+.BI "int selinux_check_passwd_access(access_vector_t " requested );
+.sp
 .BI "int checkPasswdAccess(access_vector_t " requested );
 
 .SH "DESCRIPTION"
@@ -65,18 +67,29 @@ instance.
 
 .B security_compute_user
 is used to determine the set of user contexts that can be reached from
a
-source context. Is mainly used by
+source context. It is mainly used by
 .B get_ordered_context_list.
 
 .B security_get_initial_context
 is used to get the context of a kernel initial security identifier
specified by 
 .I name
 
+.B selinux_check_passwd_access
+is used to check for a permission in the
+.I passwd
+class.
+.B selinux_check_passwd_access
+uses getprevcon() for the source and target security contexts.
+
+.B checkPasswdAccess
+is a helper function that allows you to check for a permission in the
+.I passwd
+class.
 .B checkPasswdAccess
-This functions is a helper functions that allows you to check for a
permission in the passwd class. checkPasswdAccess uses getprevcon() for
the source and target security contexts.
+uses getprevcon() for the source and target security contexts.
 
 .SH "RETURN VALUE"
-0 for success and on error -1 is returned.
+0 for success and on error \-1 is returned.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " getcon "(3), " getfilecon "(3), "
get_ordered_context_list "(3)"
diff -pruN libselinux/man/man3/security_disable.3
libselinux-new/man/man3/security_disable.3
--- libselinux/man/man3/security_disable.3	1970-01-01 01:00:00.000000000
+0100
+++ libselinux-new/man/man3/security_disable.3	2009-11-03
00:30:18.000000000 +0100
@@ -0,0 +1,26 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Guido Trentalancia (guido@trentalancia.com) 2009
+.TH "security_disable" "3" "02 Nov 2009" "" "SELinux API documentation"
+.SH "NAME"
+security_disable \- disable the SELinux kernel code at runtime.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int security_disable(void);"
+
+.SH "DESCRIPTION"
+.B security_disable
+disables the SELinux kernel code, unregisters selinuxfs
from /proc/filesystems,
+and then umounts /selinux.
+
+.SH "RETURN VALUE"
+.B security_disable
+returns returns zero on success or \-1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia
<guido@trentalancia.com>
+
+.SH "SEE ALSO"
+.BR selinux (8),
diff -pruN libselinux/man/man3/security_load_booleans.3
libselinux-new/man/man3/security_load_booleans.3
--- libselinux/man/man3/security_load_booleans.3	2009-11-01
22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_load_booleans.3	2009-11-02
20:23:28.000000000 +0100
@@ -6,17 +6,19 @@ security_get_boolean_pending \- routines
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-extern int security_load_booleans(char *path);
-
-extern int security_get_boolean_names(char ***names, int *len);
-
-extern int security_get_boolean_pending(const char *name);
-
-extern int security_get_boolean_active(const char *name);
-
-extern int security_set_boolean(const char *name, int value);
-
-extern int security_commit_booleans(void);
+.BI "int security_load_booleans(char *" path ");"
+.sp 
+.BI "int security_get_boolean_names(char ***" names ", int *" len ");"
+.sp
+.BI "int security_get_boolean_pending(const char *" name ");"
+.sp
+.BI "int security_get_boolean_active(const char *" name ");"
+.sp
+.BI "int security_set_boolean(const char *" name ", int " value ");"
+.sp
+.BI "int security_set_boolean_list(size_t " boolcnt ", SELboolean *"
boollist ", int " permanent ");"
+.sp
+.BI "int security_commit_booleans(void);"
 
 
 .SH "DESCRIPTION"
@@ -26,31 +28,37 @@ disabled based on the current values of 
 These policy booleans allow runtime modification of the security
 policy without having to load a new policy.  
 
-The SELinux API allows for a transaction based update.  So you can set
several boolean values and the commit them all at once.
+The SELinux API allows for a transaction based update. So you can
+set several boolean values and then commit them all at once.
+
+.B security_load_booleans
+
+loads policy boolean settings. Path may be NULL, in which case the
+booleans are loaded from the active policy boolean configuration file.
 
-security_load_booleans
+.B security_get_boolean_names
 
-Load policy boolean settings. Path may be NULL, in which case the
booleans are loaded from the active policy boolean configuration file.
+returns a list of boolean names, currently supported by the loaded
policy.
 
-security_get_boolean_names
+.B security_get_boolean_pending
 
-Returns a list of boolean names, currently supported by the loaded
policy.
+returns pending value for boolean
 
-security_set_boolean 
+.B security_get_boolean_active
 
-Sets the pending value for boolean 
+returns active value for boolean
 
-security_get_boolean_pending
+.B security_set_boolean 
 
-Return pending value for boolean
+sets the pending value for boolean 
 
-security_get_boolean_active
+.B security_set_boolean_list
 
-Return active value for boolean
+saves a list of booleans in a single transaction.
 
-security_commit_booleans
+.B security_commit_booleans
 
-Commit all pending values for the booleans.
+commits all pending values for the booleans.
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff -pruN libselinux/man/man3/security_load_policy.3
libselinux-new/man/man3/security_load_policy.3
--- libselinux/man/man3/security_load_policy.3	2009-11-01
22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_load_policy.3	2009-11-03
00:30:45.000000000 +0100
@@ -1,14 +1,46 @@
-.TH "security_load_policy" "3" "1 January 2004" "russell@coker.com.au"
"SELinux API documentation"
+.TH "security_load_policy" "3" "3 November 2009"
"guido@trentalancia.com" "SELinux API documentation"
 .SH "NAME"
 security_load_policy \- load a new SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
 .BI "int security_load_policy(void *" data ", size_t "len );
+.sp
+.BI "int selinux_mkload_policy(int " preservebools ");"
+.sp
+.BI "int selinux_init_load_policy(int *" enforce ");"
 
 .SH "DESCRIPTION"
 .B security_load_policy
-loads a new policy, returns 0 for success and -1 for error.
+loads a new policy, returns 0 for success and \-1 for error.
+
+.B selinux_mkload_policy
+makes a policy image and loads it. This function provides a higher
level
+interface for loading policy than
+.B security_load_policy,
+internally determining the right policy version, locating and opening
+the policy file, mapping it into memory, manipulating it as needed for
+current boolean settings and/or local definitions, and then calling
+security_load_policy to load it.
+.I preservebools
+is a boolean flag indicating whether current policy boolean values
should
+be preserved into the new policy (if 1) or reset to the saved policy
+settings (if 0). The former case is the default for policy reloads,
while
+the latter case is an option for policy reloads but is primarily used
for
+the initial policy load.
+.B selinux_init_load_policy
+performs the initial policy load. This function determines the desired
+enforcing mode, sets the
+.I enforce
+argument accordingly for the caller to use, sets the SELinux kernel
+enforcing status to match it, and loads the policy. It also internally
+handles the initial selinuxfs mount required to perform these actions.
+
+.SH "RETURN VALUE"
+returns zero on success or \-1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia
<guido@trentalancia.com>
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff -pruN libselinux/man/man3/security_mkload_policy.3
libselinux-new/man/man3/security_mkload_policy.3
--- libselinux/man/man3/security_mkload_policy.3	1970-01-01
01:00:00.000000000 +0100
+++ libselinux-new/man/man3/security_mkload_policy.3	2009-11-03
00:21:00.000000000 +0100
@@ -0,0 +1 @@
+.so man3/security_load_policy.3
diff -pruN libselinux/man/man3/selinux_lsetfilecon_default.3
libselinux-new/man/man3/selinux_lsetfilecon_default.3
--- libselinux/man/man3/selinux_lsetfilecon_default.3	1970-01-01
01:00:00.000000000 +0100
+++ libselinux-new/man/man3/selinux_lsetfilecon_default.3	2009-11-03
00:45:13.000000000 +0100
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff -pruN libselinux/man/man3/set_selinuxmnt.3
libselinux-new/man/man3/set_selinuxmnt.3
--- libselinux/man/man3/set_selinuxmnt.3	1970-01-01 01:00:00.000000000
+0100
+++ libselinux-new/man/man3/set_selinuxmnt.3	2009-11-03
00:08:40.000000000 +0100
@@ -0,0 +1 @@
+.so man3/init_selinuxmnt.3

--=-uhOq3xQ+mt2HCM/KuPqD
Content-Disposition: attachment; filename="new-manpages.patch"
Content-Type: text/x-patch; name="new-manpages.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -pruN libselinux/man/man3/fini_selinuxmnt.3 libselinux-new/man/man3/fini_selinuxmnt.3
--- libselinux/man/man3/fini_selinuxmnt.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/fini_selinuxmnt.3	2009-11-03 00:09:04.000000000 +0100
@@ -0,0 +1 @@
+.so man3/init_selinuxmnt.3
diff -pruN libselinux/man/man3/init_selinuxmnt.3 libselinux-new/man/man3/init_selinuxmnt.3
--- libselinux/man/man3/init_selinuxmnt.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/init_selinuxmnt.3	2009-11-03 00:30:08.000000000 +0100
@@ -0,0 +1,31 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Guido Trentalancia (guido@trentalancia.com) 2009
+.TH "init_selinuxmnt" "3" "02 Nov 2009" "" "SELinux API documentation"
+.SH "NAME"
+init_selinuxmnt \- initialize the global variable selinux_mnt.
+
+.SH "SYNOPSIS"
+.BI "static void init_selinuxmnt(void);"
+.sp
+.BI "static void fini_selinuxmnt(void);"
+.sp
+.BI "void set_selinuxmnt(char *" mnt ");"
+
+.SH "DESCRIPTION"
+.B init_selinuxmnt 
+initializes the global variable selinux_mnt to the selinuxfs mountpoint.
+
+.B fini_selinuxmnt
+deinitializes the global variable selinux_mnt that stores the selinuxfs
+mountpoint.
+
+.B set_selinuxmnt
+changes the selinuxfs mountpoint to
+.I mnt. 
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+
+.SH "SEE ALSO"
+.BR selinux (8),
diff -pruN libselinux/man/man3/matchpathcon.3 libselinux-new/man/man3/matchpathcon.3
--- libselinux/man/man3/matchpathcon.3	2009-11-01 22:23:01.000000000 +0100
+++ libselinux-new/man/man3/matchpathcon.3	2009-11-03 00:44:53.000000000 +0100
@@ -7,21 +7,35 @@ matchpathcon \- get the default SELinux 
 .sp
 .BI "int matchpathcon_init(const char *" path ");"
 
+.BI "int matchpathcon_init_prefix(const char *" path ", const char *" subset ");"
+
 .BI "int matchpathcon_fini(void);"
 
-.BI "int matchpathcon(const char *" path ", mode_t " mode ", security_context_t *" con);
+.BI "int matchpathcon(const char *" path ", mode_t " mode ", security_context_t *" con ");
+.sp
+
+.BI "int matchpathcon_index(const char *" name ", mode_t " mode ", security_context_t * " con ");"
+
+.BI "int matchpathcon_filespec_add(ino_t " ino ", int " specind ", const char *" file ");"
+
+.BI "void matchpathcon_filespec_destroy(void);"
+
+.BI "void matchpathcon_filespec_eval(void);"
+
+.BI "void matchpathcon_checkmatches(char *" str ");"
 .sp
 
 .BI "void set_matchpathcon_printf(void (*" f ")(const char *" fmt ", ...));"
 
-.BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *"path ", unsigned " lineno ", char * " context "));"
+.BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *" path ", unsigned " lineno ", char * " context "));"
 
 .BI "void set_matchpathcon_flags(unsigned int " flags ");"
 
-.BI "int selinux_file_context_cmp(const security_context_t a,
-				     const security_context_t b);"
+.BI "int selinux_file_context_cmp(const security_context_t " a ", const security_context_t " b ");"
 
-.BI "int selinux_file_context_verify(const char *path, mode_t mode);"
+.BI "int selinux_file_context_verify(const char *" path ", mode_t " mode ");"
+
+.BI "int selinux_lsetfilecon_default(const char *" path ");"
 
 .SH "DESCRIPTION"
 .B matchpathcon_init
@@ -44,7 +58,16 @@ and
 .B .local
 suffix are also looked up and loaded if present.  These files provide
 dynamically generated entries for user home directories and for local
-customizations.
+customizations. Returns zero on success or \-1 on error.
+
+.sp
+.B matchpathcon_init_prefix
+is the same as
+.B matchpathcon_init
+but only loads entries with regexes that have stems that are prefixes
+of
+.I prefix.
+Returns zero on success or \-1 on error.
 
 .sp
 .B matchpathcon_fini
@@ -78,6 +101,43 @@ its first invocation with a NULL
 defaulting to the active file contexts configuration.
 .sp
 
+.B matchpathcon_index
+is the same as
+.B matchpathcon
+but returns a specification index that can be used later in a
+.B matchpathcon_filespec_add
+call.
+.sp
+
+.B matchpathcon_filespec_add
+maintains an association between an inode
+.I ino
+and a specification index
+.I specind,
+and checks whether a conflicting specification is already associated
+with the same inode (e.g. due to multiple hard links). If so, then
+it uses the latter of the two specifications based on their order in the 
+.I file
+context configuration. Returns the specification index used or \-1 on
+error.
+.sp
+
+.B matchpathcon_filespec_destroy
+destroys any inode associations that have been added, e.g. to restart
+for a new filesystem.
+.sp
+
+.B matchpathcon_filespec_eval
+displays statistics on the hash table usage for the inode associations.
+.sp
+
+.B matchpathcon_checkmatches
+checks whether any specification has no matches and reports them.
+The
+.I str
+argument is used as a prefix for any warning messages.
+.sp
+
 .B set_matchpathcon_printf
 sets the function used by 
 .B matchpathcon_init
@@ -98,7 +158,7 @@ This can be set to instead perform check
 e.g. using 
 .B sepol_check_context(3),
 as is done by 
-.B setfiles -c.
+.B setfiles \-c.
 The function is also responsible for reporting any such error, and
 may include the 
 .I path
@@ -122,10 +182,13 @@ compares two file contexts to see if the
 .sp
 .B selinux_file_context_verify
 compares the file context on disk to the system default.
+.sp
+.B selinux_lsetfilecon_default
+sets the file context to the system defaults.
 
 .sp
 .SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise.
+Returns zero on success or \-1 otherwise.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
diff -pruN libselinux/man/man3/matchpathcon_checkmatches.3 libselinux-new/man/man3/matchpathcon_checkmatches.3
--- libselinux/man/man3/matchpathcon_checkmatches.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/matchpathcon_checkmatches.3	2009-11-02 17:54:56.000000000 +0100
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff -pruN libselinux/man/man3/print_access_vector.3 libselinux-new/man/man3/print_access_vector.3
--- libselinux/man/man3/print_access_vector.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/print_access_vector.3	2009-11-02 19:34:40.000000000 +0100
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
diff -pruN libselinux/man/man3/security_class_to_string.3 libselinux-new/man/man3/security_class_to_string.3
--- libselinux/man/man3/security_class_to_string.3	2009-11-01 22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_class_to_string.3	2009-11-03 00:23:55.000000000 +0100
@@ -6,6 +6,8 @@
 security_class_to_string, security_av_perm_to_string, string_to_security_class, string_to_av_perm, security_av_string \- convert
 between SELinux class and permission values and string names.
 
+print_access_vector \- display an access vector in human-readable form. 
+
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 
@@ -20,6 +22,8 @@ between SELinux class and permission val
 .BI "security_class_t string_to_security_class(const char *" name ");"
 .sp
 .BI "access_vector_t string_to_av_perm(security_class_t " tclass ", const char *" name ");"
+.sp
+.BI "void print_access_vector(security_class_t " tclass ", access_vector_t " av ");"
 
 .SH "DESCRIPTION"
 .B security_class_to_string
@@ -56,11 +60,17 @@ and security class
 .IR tclass ,
 or zero if no such value exists.
 
+.B print_access_vector
+displays an access vector in human-readable form on the standard output
+stream.
+
 .SH "RETURN VALUE"
 .B security_av_string
-returns returns zero on success or \-1 on error with
+returns zero on success or \-1 on error with
 .I errno
-set appropriately.  All other functions return zero or NULL on error.
+set appropriately.
+.B print_access_vector
+does not return a value. All other functions return zero or NULL on error.
 
 .SH "ERRORS"
 .TP
diff -pruN libselinux/man/man3/security_compute_av.3 libselinux-new/man/man3/security_compute_av.3
--- libselinux/man/man3/security_compute_av.3	2009-11-01 22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_compute_av.3	2009-11-02 23:34:49.000000000 +0100
@@ -24,6 +24,8 @@ the SELinux policy database in the kerne
 .BI "int security_get_initial_context(const char *" name ", security_context_t
 "con );
 .sp
+.BI "int selinux_check_passwd_access(access_vector_t " requested );
+.sp
 .BI "int checkPasswdAccess(access_vector_t " requested );
 
 .SH "DESCRIPTION"
@@ -65,18 +67,29 @@ instance.
 
 .B security_compute_user
 is used to determine the set of user contexts that can be reached from a
-source context. Is mainly used by
+source context. It is mainly used by
 .B get_ordered_context_list.
 
 .B security_get_initial_context
 is used to get the context of a kernel initial security identifier specified by 
 .I name
 
+.B selinux_check_passwd_access
+is used to check for a permission in the
+.I passwd
+class.
+.B selinux_check_passwd_access
+uses getprevcon() for the source and target security contexts.
+
+.B checkPasswdAccess
+is a helper function that allows you to check for a permission in the
+.I passwd
+class.
 .B checkPasswdAccess
-This functions is a helper functions that allows you to check for a permission in the passwd class. checkPasswdAccess uses getprevcon() for the source and target security contexts.
+uses getprevcon() for the source and target security contexts.
 
 .SH "RETURN VALUE"
-0 for success and on error -1 is returned.
+0 for success and on error \-1 is returned.
 
 .SH "SEE ALSO"
 .BR selinux "(8), " getcon "(3), " getfilecon "(3), " get_ordered_context_list "(3)"
diff -pruN libselinux/man/man3/security_disable.3 libselinux-new/man/man3/security_disable.3
--- libselinux/man/man3/security_disable.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/security_disable.3	2009-11-03 00:30:18.000000000 +0100
@@ -0,0 +1,26 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Guido Trentalancia (guido@trentalancia.com) 2009
+.TH "security_disable" "3" "02 Nov 2009" "" "SELinux API documentation"
+.SH "NAME"
+security_disable \- disable the SELinux kernel code at runtime.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int security_disable(void);"
+
+.SH "DESCRIPTION"
+.B security_disable
+disables the SELinux kernel code, unregisters selinuxfs from /proc/filesystems,
+and then umounts /selinux.
+
+.SH "RETURN VALUE"
+.B security_disable
+returns returns zero on success or \-1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+
+.SH "SEE ALSO"
+.BR selinux (8),
diff -pruN libselinux/man/man3/security_load_booleans.3 libselinux-new/man/man3/security_load_booleans.3
--- libselinux/man/man3/security_load_booleans.3	2009-11-01 22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_load_booleans.3	2009-11-02 20:23:28.000000000 +0100
@@ -6,17 +6,19 @@ security_get_boolean_pending \- routines
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-extern int security_load_booleans(char *path);
-
-extern int security_get_boolean_names(char ***names, int *len);
-
-extern int security_get_boolean_pending(const char *name);
-
-extern int security_get_boolean_active(const char *name);
-
-extern int security_set_boolean(const char *name, int value);
-
-extern int security_commit_booleans(void);
+.BI "int security_load_booleans(char *" path ");"
+.sp 
+.BI "int security_get_boolean_names(char ***" names ", int *" len ");"
+.sp
+.BI "int security_get_boolean_pending(const char *" name ");"
+.sp
+.BI "int security_get_boolean_active(const char *" name ");"
+.sp
+.BI "int security_set_boolean(const char *" name ", int " value ");"
+.sp
+.BI "int security_set_boolean_list(size_t " boolcnt ", SELboolean *" boollist ", int " permanent ");"
+.sp
+.BI "int security_commit_booleans(void);"
 
 
 .SH "DESCRIPTION"
@@ -26,31 +28,37 @@ disabled based on the current values of 
 These policy booleans allow runtime modification of the security
 policy without having to load a new policy.  
 
-The SELinux API allows for a transaction based update.  So you can set several boolean values and the commit them all at once.
+The SELinux API allows for a transaction based update. So you can
+set several boolean values and then commit them all at once.
+
+.B security_load_booleans
+
+loads policy boolean settings. Path may be NULL, in which case the
+booleans are loaded from the active policy boolean configuration file.
 
-security_load_booleans
+.B security_get_boolean_names
 
-Load policy boolean settings. Path may be NULL, in which case the booleans are loaded from the active policy boolean configuration file.
+returns a list of boolean names, currently supported by the loaded policy.
 
-security_get_boolean_names
+.B security_get_boolean_pending
 
-Returns a list of boolean names, currently supported by the loaded policy.
+returns pending value for boolean
 
-security_set_boolean 
+.B security_get_boolean_active
 
-Sets the pending value for boolean 
+returns active value for boolean
 
-security_get_boolean_pending
+.B security_set_boolean 
 
-Return pending value for boolean
+sets the pending value for boolean 
 
-security_get_boolean_active
+.B security_set_boolean_list
 
-Return active value for boolean
+saves a list of booleans in a single transaction.
 
-security_commit_booleans
+.B security_commit_booleans
 
-Commit all pending values for the booleans.
+commits all pending values for the booleans.
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff -pruN libselinux/man/man3/security_load_policy.3 libselinux-new/man/man3/security_load_policy.3
--- libselinux/man/man3/security_load_policy.3	2009-11-01 22:23:01.000000000 +0100
+++ libselinux-new/man/man3/security_load_policy.3	2009-11-03 00:30:45.000000000 +0100
@@ -1,14 +1,46 @@
-.TH "security_load_policy" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
+.TH "security_load_policy" "3" "3 November 2009" "guido@trentalancia.com" "SELinux API documentation"
 .SH "NAME"
 security_load_policy \- load a new SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
 .BI "int security_load_policy(void *" data ", size_t "len );
+.sp
+.BI "int selinux_mkload_policy(int " preservebools ");"
+.sp
+.BI "int selinux_init_load_policy(int *" enforce ");"
 
 .SH "DESCRIPTION"
 .B security_load_policy
-loads a new policy, returns 0 for success and -1 for error.
+loads a new policy, returns 0 for success and \-1 for error.
+
+.B selinux_mkload_policy
+makes a policy image and loads it. This function provides a higher level
+interface for loading policy than
+.B security_load_policy,
+internally determining the right policy version, locating and opening
+the policy file, mapping it into memory, manipulating it as needed for
+current boolean settings and/or local definitions, and then calling
+security_load_policy to load it.
+.I preservebools
+is a boolean flag indicating whether current policy boolean values should
+be preserved into the new policy (if 1) or reset to the saved policy
+settings (if 0). The former case is the default for policy reloads, while
+the latter case is an option for policy reloads but is primarily used for
+the initial policy load.
+.B selinux_init_load_policy
+performs the initial policy load. This function determines the desired
+enforcing mode, sets the
+.I enforce
+argument accordingly for the caller to use, sets the SELinux kernel
+enforcing status to match it, and loads the policy. It also internally
+handles the initial selinuxfs mount required to perform these actions.
+
+.SH "RETURN VALUE"
+returns zero on success or \-1 on error.
+
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff -pruN libselinux/man/man3/security_mkload_policy.3 libselinux-new/man/man3/security_mkload_policy.3
--- libselinux/man/man3/security_mkload_policy.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/security_mkload_policy.3	2009-11-03 00:21:00.000000000 +0100
@@ -0,0 +1 @@
+.so man3/security_load_policy.3
diff -pruN libselinux/man/man3/selinux_lsetfilecon_default.3 libselinux-new/man/man3/selinux_lsetfilecon_default.3
--- libselinux/man/man3/selinux_lsetfilecon_default.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/selinux_lsetfilecon_default.3	2009-11-03 00:45:13.000000000 +0100
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff -pruN libselinux/man/man3/set_selinuxmnt.3 libselinux-new/man/man3/set_selinuxmnt.3
--- libselinux/man/man3/set_selinuxmnt.3	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-new/man/man3/set_selinuxmnt.3	2009-11-03 00:08:40.000000000 +0100
@@ -0,0 +1 @@
+.so man3/init_selinuxmnt.3

--=-uhOq3xQ+mt2HCM/KuPqD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
