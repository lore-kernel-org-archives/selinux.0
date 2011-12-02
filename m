Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB2Aw6sC002273
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 05:58:06 -0500
Received: from nm2-vm1.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pB2Aw4Fg007007
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 10:58:04 GMT
Message-ID: <1322823483.77329.YahooMailClassic@web87003.mail.ird.yahoo.com>
Date: Fri, 2 Dec 2011 10:58:03 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/3] libselinux: Add man/man5 man pages
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add failsafe_context(5), local.users(5), removable_contexts(5) and
securetty_types(5) man pages.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man5/failsafe_context.5  |   63 +++++++++++++++++++++++++++++
 libselinux/man/man5/local.users.5       |   67 +++++++++++++++++++++++++++++++
 libselinux/man/man5/removable_context.5 |   37 +++++++++++++++++
 libselinux/man/man5/securetty_types.5   |   44 ++++++++++++++++++++
 4 files changed, 211 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/man/man5/failsafe_context.5
 create mode 100644 libselinux/man/man5/local.users.5
 create mode 100644 libselinux/man/man5/removable_context.5
 create mode 100644 libselinux/man/man5/securetty_types.5

diff --git a/libselinux/man/man5/failsafe_context.5 b/libselinux/man/man5/failsafe_context.5
new file mode 100644
index 0000000..ef8e9ac
--- /dev/null
+++ b/libselinux/man/man5/failsafe_context.5
@@ -0,0 +1,63 @@
+.TH "failsafe_context" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+failsafe_context \- The SELinux fail safe context configuration file.
+
+.SH "DESCRIPTION"
+The
+.I failsafe_context
+file allows SELinux-aware applications such as
+.BR PAM "(8) "
+to obtain a known valid login context for an administrator if no valid default entries can be found elsewhere.
+.sp
+.BR selinux_failsafe_context_path "(3) "
+will return the active policy path to this file. The default failsafe context file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/failsafe_context
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+The following functions read this file from the active policy path if they cannot obtain a default context:
+.br
+.RS
+.BR get_default_context "(3) "
+.br
+.BR get_ordered_context_list "(3) "
+.br
+.BR get_ordered_context_list_with_level "(3) "
+.br
+.BR get_default_context_with_level "(3) "
+.br
+.BR get_default_context_with_role "(3) "
+.br
+.BR get_default_context_with_rolelevel "(3) "
+.br
+.BR query_user_context "(3) "
+.br
+.BR manual_user_enter_context "(3) "
+.RE
+
+.SH "FILE FORMAT"
+The file consists of a single line entry as follows:
+.RS
+\fIrole\fB:\fItype\fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+.I role
+.I type
+.I range
+.RS
+A role, type and optional range (for MCS/MLS), separated by colons (:) to form a valid login process context for an administrator to access the system.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/failsafe_context
+.br
+unconfined_r:unconfined_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_failsafe_context_path "(3), " PAM "(8), " selinux_default_type_path "(3), " get_default_context "(3), " get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/local.users.5 b/libselinux/man/man5/local.users.5
new file mode 100644
index 0000000..8347ae8
--- /dev/null
+++ b/libselinux/man/man5/local.users.5
@@ -0,0 +1,67 @@
+.TH "local.users" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+local.users \- The SELinux local users configuration file.
+
+.SH "DESCRIPTION"
+The file contains local user definitions in the form of policy language user statements and is only found on older SELinux systems as it has been deprecated and replaced by the \fBsemange\fR(8) services.
+.sp
+This file is only read by \fBselinux_mkload_policy\fR(3) when \fBSETLOCALDEFS\fR in the SELinux \fIconfig\fR file (see \fBselinux_config\fR(5)) is set to \fI1\fR.
+.sp
+.BR selinux_users_path "(3) "
+will return the active policy path to the directory where this file is located. The default local users file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/users/local.users
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+The file consists of one or more entries terminated with '\fB;\fR', each on a separate line as follows:
+.RS
+\fBuser \fIseuser_id \fBroles \fIrole_id\fR [[\fBlevel \fIlevel\fR] [\fBrange \fIrange\fR]]\fB;\fR
+.RE
+.sp
+Where:
+.RS
+.B user
+.RS
+The user keyword.
+.RE
+.I seuser_id
+.RS
+The SELinux user identifier.
+.RE
+.B roles
+.RS
+The roles keyword.
+.RE
+.I role_id
+.RS
+One or more previously declared role identifiers. Multiple role identifiers consist of a space separated list enclosed in braces '{}'.
+.RE
+.B level
+.RS
+If MLS/MCS is configured, the level keyword.
+.RE
+.I level
+.RS
+The users default security level. Note that only the sensitivity component of the level (e.g. s0) is required.
+.RE
+.B range
+.RS
+If MLS/MCS is configured, the range keyword.
+.RE
+.I range
+.RS
+The current and clearance levels that the user can run. These are separated by a hyphen '\fB-\fR' as shown in the \fBEXAMPLE\fR section.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./users/local.users
+.br
+user test_u roles staff_r level s0 range s0 - s15:c0.c1023;
+
+.SH "SEE ALSO"
+.BR selinux "(8), " semanage "(8), " selinux_users_path "(3), " selinux_config "(5), " selinux_mkload_policy "(3) "
diff --git a/libselinux/man/man5/removable_context.5 b/libselinux/man/man5/removable_context.5
new file mode 100644
index 0000000..72d3d4c
--- /dev/null
+++ b/libselinux/man/man5/removable_context.5
@@ -0,0 +1,37 @@
+.TH "removable_context" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+removable_context \- The SELinux removable devices context configuration file.
+
+.SH "DESCRIPTION"
+This file contains the default label that should be used for removable devices that are not defined in the \fImedia\fR file (that is described in
+.BR selabel_media "(5)). "
+.sp
+.BR selinux_removable_context_path "(3) "
+will return the active policy path to this file. The default removable context file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/removable_context
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+The file consists of a single line entry as follows:
+.RS
+.IB user : role : type \fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+.I user role type range
+.RS
+A user, role, type and optional range (for MCS/MLS) separated by colons (:) that will be applied to removable devices.
+.RE
+.RE
+.SH "EXAMPLE"
+# ./contexts/removable_contexts
+.br
+system_u:object_r:removable_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_removable_context_path "(3), " selabel_media "(5), " selinux_config "(5) "
diff --git a/libselinux/man/man5/securetty_types.5 b/libselinux/man/man5/securetty_types.5
new file mode 100644
index 0000000..3f13fdd
--- /dev/null
+++ b/libselinux/man/man5/securetty_types.5
@@ -0,0 +1,44 @@
+.TH "securetty_types" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+securetty_types \- The SELinux secure tty type configuration file.
+
+.SH "DESCRIPTION"
+The
+.I securetty_types
+file contains a list of types associated to secure tty type that are defined in the policy for use by SELinux-aware applications.
+.sp
+.BR selinux_securetty_types_path "(3) "
+will return the active policy path to this file. The default securetty types file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/securetty_types
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+.BR selinux_check_securetty_context "(3) reads this file to determine if a context is for a secure tty defined in the active policy. "
+.sp
+SELinux-aware applications such as
+.BR newrole "(1) use this information to check the status of a tty. "
+
+.SH "FILE FORMAT"
+Each line in the file consists of the following entry:
+.sp
+.RS
+.I type
+.RS
+One or more type entries that are defined in the policy for secure tty devices.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/securetty_types
+.br
+sysadm_tty_device_t
+.br
+user_tty_device_t
+.br
+staff_tty_device_t
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_securetty_types_path "(3), " newrole "(1), " selinux_check_securetty_context "(3), " selinux_config "(5) "
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
