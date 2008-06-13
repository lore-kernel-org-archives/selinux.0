Message-ID: <4852BC27.5030203@tycho.nsa.gov>
Date: Fri, 13 Jun 2008 14:27:51 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Xavier Toth <txtoth@gmail.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>
Subject: [PATCH] libselinux: new and updated man pages for AVC, mapping, label
 - try 2
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>	 <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>	 <1213298430.17842.297.camel@moss-spartans.epoch.ncsc.mil>	 <1213300336.17842.309.camel@moss-spartans.epoch.ncsc.mil>	 <48518F23.6080406@tycho.nsa.gov> <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-06-12 at 17:03 -0400, Eamon Walsh wrote:
>   
>> New and updated man pages for AVC, mapping, label.
>>
>> Includes avc_open() call, deprecated avc_init(), selinux_set_mapping(), 
>> and new options to the selabel X backend.
>>     

Revised per comments.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 man3/avc_cleanup.3         |    2 -
 man3/avc_destroy.3         |    2 -
 man3/avc_init.3            |   40 +++++---------------
 man3/avc_open.3            |   70 ++++++++++++++++++++++++++++++++++++
 man3/avc_reset.3           |    2 -
 man3/selinux_set_mapping.3 |   87 +++++++++++++++++++++++++++++++++++++++++++++
 man5/selabel_x.5           |   27 +++++++++++++
 7 files changed, 198 insertions(+), 32 deletions(-)


Index: libselinux/man/man3/avc_destroy.3
===================================================================
--- libselinux/man/man3/avc_destroy.3	(revision 2908)
+++ libselinux/man/man3/avc_destroy.3	(working copy)
@@ -1 +1 @@
-.so man3/avc_init.3
+.so man3/avc_open.3
Index: libselinux/man/man3/avc_open.3
===================================================================
--- libselinux/man/man3/avc_open.3	(revision 0)
+++ libselinux/man/man3/avc_open.3	(revision 0)
@@ -0,0 +1,70 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2008
+.TH "avc_open" "3" "12 Jun 2008" "" "SELinux API documentation"
+.SH "NAME"
+avc_open, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and teardown.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+
+.B #include <selinux/avc.h>
+.sp
+.BI "int avc_open(struct selinux_opt *" options ", unsigned " nopt ");"
+.sp
+.BI "void avc_destroy(void);"
+.sp
+.BI "int avc_reset(void);"
+.sp
+.BI "void avc_cleanup(void);"
+.SH "DESCRIPTION"
+.B avc_open
+initializes the userspace AVC and must be called before any other AVC operation can be performed.
+
+.B avc_destroy
+destroys the userspace AVC, freeing all internal memory structures.  After this call has been made, 
+.B avc_open
+must be called again before any AVC operations can be performed.
+
+.B avc_reset
+flushes the userspace AVC, causing it to forget any cached access decisions.  The userspace AVC normally calls this function automatically when needed, see
+.B NETLINK NOTIFICATION
+below.
+
+.B avc_cleanup
+forces the userspace AVC to search for and free all unused SID's and any access decision entries that refer to them.  Normally, the userspace AVC lazily reclaims unused SID's.  
+
+.SH "OPTIONS"
+The userspace AVC obeys callbacks set via
+.BR selinux_set_callback (3),
+in particular the logging and audit callbacks.
+
+The options which may be passed to
+.B avc_open
+include the following:
+
+.TP
+.B AVC_OPT_SETENFORCE
+This option forces the userspace AVC into enforcing mode if the option value is non-NULL; permissive mode otherwise.  The system enforcing mode will be ignored.
+
+.SH "NETLINK NOTIFICATION"
+Beginning with version 2.6.4, the Linux kernel supports SELinux status change notification via netlink.  Two message types are currently implemented, indicating changes to the enforcing mode and to the loaded policy in the kernel, respectively.  The userspace AVC listens for these messages and takes the appropriate action, modifying the behavior of
+.BR avc_has_perm (3)
+to reflect the current enforcing mode and flushing the cache on receipt of a policy load notification.  Audit messages are produced when netlink notifications are processed.
+
+.SH "RETURN VALUE"
+Functions with a return value return zero on success.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+
+.SH "AUTHOR"
+Eamon Walsh <ewalsh@tycho.nsa.gov>
+
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR avc_has_perm (3),
+.BR avc_context_to_sid (3),
+.BR avc_cache_stats (3),
+.BR avc_add_callback (3),
+.BR selinux_set_callback (3),
+.BR security_compute_av (3)
+
Index: libselinux/man/man3/avc_cleanup.3
===================================================================
--- libselinux/man/man3/avc_cleanup.3	(revision 2908)
+++ libselinux/man/man3/avc_cleanup.3	(working copy)
@@ -1 +1 @@
-.so man3/avc_init.3
+.so man3/avc_open.3
Index: libselinux/man/man3/avc_init.3
===================================================================
--- libselinux/man/man3/avc_init.3	(revision 2908)
+++ libselinux/man/man3/avc_init.3	(working copy)
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
 .TH "avc_init" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
-avc_init, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and teardown.
+avc_init - legacy userspace SELinux AVC setup.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 
@@ -18,34 +18,19 @@
 .BI "const struct avc_thread_callback *" thread_callbacks ,
 
 .BI "const struct avc_lock_callback *" lock_callbacks ");"
-.in
-.sp
-.BI "void avc_destroy(void);"
-.sp
-.BI "int avc_reset(void);"
-.sp
-.BI "void avc_cleanup(void);"
 .SH "DESCRIPTION"
 .B avc_init
+is deprecated; please use
+.BR avc_open (3)
+in conjunction with
+.BR selinux_set_callback (3)
+in all new code.
+
+.B avc_init
 initializes the userspace AVC and must be called before any other AVC operation can be performed.  A non-NULL
 .I msgprefix
-will be prepended to all audit messages produced by the userspace AVC.  The default is `uavc'.  The remaining arguments, if non-NULL, specify callbacks to be used by the userspace AVC.  See 
-.B CALLBACKS
-below.
+will be prepended to all audit messages produced by the userspace AVC.  The default is `uavc'.  The remaining arguments, if non-NULL, specify callbacks to be used by the userspace AVC.
 
-.B avc_destroy
-destroys the userspace AVC, freeing all internal memory structures.  After this call has been made, 
-.B avc_init
-must be called again before any AVC operations can be performed.
-
-.B avc_reset
-flushes the userspace AVC, causing it to forget any cached access decisions.  The userspace AVC normally calls this function automatically when needed, see
-.B NETLINK NOTIFICATION
-below.
-
-.B avc_cleanup
-forces the userspace AVC to search for and free all unused SID's and any access decision entries that refer to them.  Normally, the userspace AVC lazily reclaims unused SID's.  
-
 .SH "CALLBACKS"
 The userspace AVC can be directed how to perform memory allocation, logging, thread creation, and locking via callback functions passed to
 .BR avc_init .
@@ -204,10 +189,7 @@
 Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
-.BR avc_has_perm (3),
-.BR avc_context_to_sid (3),
-.BR avc_cache_stats (3),
-.BR avc_add_callback (3),
-.BR security_compute_av (3)
+.BR avc_open (3),
+.BR selinux_set_callback (3),
 .BR selinux (8)
 
Index: libselinux/man/man3/avc_reset.3
===================================================================
--- libselinux/man/man3/avc_reset.3	(revision 2908)
+++ libselinux/man/man3/avc_reset.3	(working copy)
@@ -1 +1 @@
-.so man3/avc_init.3
+.so man3/avc_open.3
Index: libselinux/man/man3/selinux_set_mapping.3
===================================================================
--- libselinux/man/man3/selinux_set_mapping.3	(revision 0)
+++ libselinux/man/man3/selinux_set_mapping.3	(revision 0)
@@ -0,0 +1,87 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2008
+.TH "selinux_set_mapping" "3" "12 Jun 2008" "" "SELinux API documentation"
+.SH "NAME"
+selinux_set_mapping \- establish dynamic object class and permission mapping.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.nf
+struct security_class_mapping {
+	const char *name;
+	const char *perms[];
+};
+.fi
+.sp
+.BI "int selinux_set_mapping(struct security_class_mapping *" map ");"
+
+.SH "DESCRIPTION"
+.B selinux_set_mapping
+establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy.  Use of this function is highly preferred over the generated constants in the libselinux header files, as this method allows the policy's class and permission values to change over time.
+
+After the mapping is established, all libselinux functions that operate on class and permission values take the user-provided numbers, which are determined as follows:
+
+The
+.I map
+argument consists of an array of 
+.B security_class_mapping
+structures, which must be terminated by a structure having a NULL name field.  Except for this last structure, the
+.I name 
+field should refer to the string name of an object class, and the corresponding
+.I perms
+field should refer to an array of permission bit names terminated by a NULL string.
+
+The object classes named in the mapping and the bit indexes of each set of permission bits named in the mapping are numbered in order starting from 1.  These numbers are the values that should be passed to subsequent libselinux calls.
+
+.SH "RETURN VALUE"
+Zero is returned on success.  On error, -1 is returned and
+.I errno
+is set appropriately.
+
+.SH "ERRORS"
+.TP
+.B EINVAL
+One of the class or permission names requested in the mapping is not present in the loaded policy.
+.TP
+.B ENOMEM
+An attempt to allocate memory failed.
+
+.SH "EXAMPLE"
+.RS
+.ta 4n 10n
+.nf
+struct security_class_mapping map[] = {
+	{ "file", { "create", "unlink", "read", "write", NULL } },
+	{ "socket", { "bind", NULL } },
+	{ "process", { "signal", NULL } },
+	{ NULL }
+};
+
+if (selinux_set_mapping(map) < 0)
+	exit(1);
+.fi
+.ta
+.RE
+
+In this example, after the call has succeeded, classes
+.BR file ,
+.BR socket ,
+and
+.B process
+will be identified by 1, 2 and 3, respectively.  Permissions
+.IR create ,
+.IR unlink ,
+.IR read ,
+and
+.I write
+(for the 
+.B file
+class) will be identified by 1, 2, 4, and 8 respectively.  Classes and permissions not listed in the mapping cannot be used.
+
+.SH "AUTHOR"
+Eamon Walsh <ewalsh@tycho.nsa.gov>
+
+.SH "SEE ALSO"
+.BR avc_open (8),
+.BR selinux (8)
Index: libselinux/man/man5/selabel_x.5
===================================================================
--- libselinux/man/man5/selabel_x.5	(revision 2908)
+++ libselinux/man/man5/selabel_x.5	(working copy)
@@ -27,15 +27,39 @@
 .I object_name
 argument specifies the name of a window property, such as "WM_NAME".
 .TP
+.B SELABEL_X_SELN
+The
+.I object_name
+argument specifies the name of a selection, such as "PRIMARY".
+.TP
 .B SELABEL_X_EXT
 The
 .I object_name
 argument specifies the name of a protocol extension, such as "RENDER".
 .TP
+.B SELABEL_X_EVENT
+The
+.I object_name
+argument specifies the name of an event type, such as "X11:ButtonPress".
+.TP
 .B SELABEL_X_CLIENT
 The
 .I object_name
 argument is ignored and should be set to NULL.  The default context for labeling remote X clients is returned.
+.TP
+.B SELABEL_X_POLYPROP
+Like
+.BR SELABEL_X_PROP ,
+but checks if the property was marked as being polyinstantiated.  See
+.B NOTES
+below.
+.TP
+.B SELABEL_X_POLYSELN
+Like
+.BR SELABEL_X_SELN ,
+but checks if the selection was marked as being polyinstantiated.  See
+.B NOTES
+below.
 
 .SH "OPTIONS"
 In addition to the global options described in 
@@ -46,6 +70,9 @@
 .B SELABEL_OPT_PATH
 A non-null value for this option specifies a path to a file that will be opened in lieu of the standard X contexts file.  
 
+.SH "NOTES"
+Properties and selections are marked as either polyinstantiated or not.  For these name types, the "POLY" option searches only the names marked as being polyinstantiated, while the other option searches only the names marked as not being polyinstantiated.  Users of the interface should check both mappings, optionally taking action based on the result (e.g. polyinstantiating the object).
+
 .SH "SEE ALSO"
 .BR selabel_open (3),
 .BR selabel_lookup (3),


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
