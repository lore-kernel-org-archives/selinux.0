Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB2AuaO8002209
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 05:56:36 -0500
Received: from nm2-vm1.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pB2AuYFg006654
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 10:56:35 GMT
Message-ID: <1322823393.7316.YahooMailClassic@web87001.mail.ird.yahoo.com>
Date: Fri, 2 Dec 2011 10:56:33 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/3] libselinux: Add man/man5 man pages
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add booleans(5), customizable_types(5), default_contexts(5) and
default_type(5) man pages.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man5/booleans.5           |   79 ++++++++++++++++++++++++++++++
 libselinux/man/man5/customizable_types.5 |   56 +++++++++++++++++++++
 libselinux/man/man5/default_contexts.5   |   70 ++++++++++++++++++++++++++
 libselinux/man/man5/default_type.5       |   38 ++++++++++++++
 4 files changed, 243 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/man/man5/booleans.5
 create mode 100644 libselinux/man/man5/customizable_types.5
 create mode 100644 libselinux/man/man5/default_contexts.5
 create mode 100644 libselinux/man/man5/default_type.5

diff --git a/libselinux/man/man5/booleans.5 b/libselinux/man/man5/booleans.5
new file mode 100644
index 0000000..8efc889
--- /dev/null
+++ b/libselinux/man/man5/booleans.5
@@ -0,0 +1,79 @@
+.TH "booleans" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+booleans \- The SELinux booleans configuration files.
+
+.SH "DESCRIPTION"
+The \fIbooleans\fR file, if present contains booleans to support a specific distribution.
+.sp
+The \fIbooleans.local\fR file, if present contains locally generated booleans.
+.sp
+Both files contain a list of boolean names and their associated values.
+.sp
+Generally the \fIbooleans\fR and/or \fIbooleans.local\fR files are not present (they have been deprecated). However if there is an SELinux-aware application that uses the libselinux functions listed below, then these files may be present:
+.sp
+.RS
+.BR security_set_boolean_list "(3) "
+.RS
+Writes a \fIbooleans.local\fR file if flag \fIpermanent\fR = \fI1\fR.
+.sp
+.RE
+.RE
+.RS
+.BR security_load_booleans "(3) "
+.RS
+Looks for a \fIbooleans\fR and/or \fIbooleans.local\fR file at \fBselinux_booleans_path\fR(3) unless a specific path is specified as a parameter.
+.RE
+.RE
+.sp
+\fBbooleans\fR(8) has details on booleans and \fBsetsebool\fR(8) describes how booleans can now be set persistent across reboots.
+.sp
+\fBselinux_booleans_path\fR(3) will return the active policy path to these files. The default boolean files are:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/booleans
+.br
+.I /etc/selinux/{SELINUXTYPE}/booleans.local
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+Both boolean files have the same format and contain one or more boolean names and their value.
+.sp
+The format is:
+.RS
+.I boolean_name
+.I value
+.sp
+.RE
+Where:
+.RS
+.I boolean_name
+.RS
+The name of the boolean.
+.RE
+.I value
+.RS
+The default setting for the boolean. This can be one of the following:
+.RS
+.IR true " | " false " | " 1 " | " 0
+.RE
+.RE
+.RE
+.sp
+Note that if
+.B SETLOCALDEFS
+is set in the SELinux
+.I config
+file (see
+.BR selinux_config "(5)), then " selinux_mkload_policy "(3) will check for a "
+.I booleans.local
+file in the
+.B selinux_booleans_path
+and also a
+.I local.users
+file (see
+.BR local.users "(5)) in the " selinux_users_path "(3). "
+
+.SH "SEE ALSO"
+.BR selinux "(8), " booleans "(8), " setsebool "(8), " semanage "(8), " selinux_booleans_path "(3), " security_set_boolean_list "(3), " security_load_booleans "(3), " selinux_mkload_policy "(3), " selinux_users_path "(3), " selinux_config "(5), " local.users "(5) "
diff --git a/libselinux/man/man5/customizable_types.5 b/libselinux/man/man5/customizable_types.5
new file mode 100644
index 0000000..c2180f9
--- /dev/null
+++ b/libselinux/man/man5/customizable_types.5
@@ -0,0 +1,56 @@
+.TH "customizable_types" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+customizable_types \- The SELinux customizable types configuration file.
+
+.SH "DESCRIPTION"
+The \fIcustomizable_types\fR file contains a list of types that can be customised in some way by SELinux-aware applications.
+.sp
+Generally this is a file context type that is usually set on files that need to be shared among certain domains and where the administrator wants to manually manage the type.
+.sp
+The  use  of customizable types is deprecated as the preferred approach is to use
+.B semanage fcontext ...
+(8). However, SELinux-aware applications such as
+.BR setfiles "(8) "
+will use this information to obtain a list of types relating to files that should not be relabeled.
+.sp
+.BR selinux_customizable_types_path "(3) "
+will return the active policy path to this file. The default customizable types file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/customizable_types
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+.BR is_context_customizable "(3) "
+reads this file to determine if a context is customisable or not for the active policy.
+
+.SH "FILE FORMAT"
+Each line in the file consists of the following:
+.RS
+.I type
+.RE
+.sp
+Where:
+.RS
+.I type
+.RS
+The type defined in the policy that can be customised.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/customizable_types
+.br
+mount_loopback_t
+.br
+public_content_rw_t
+.br
+public_content_t
+.br
+swapfile_t
+.br
+sysadm_untrusted_content_t
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_customizable_types_path "(3), " is_context_customizable "(3), " semanage "(8), " setfiles "(8), " selinux_config "(5) "
diff --git a/libselinux/man/man5/default_contexts.5 b/libselinux/man/man5/default_contexts.5
new file mode 100644
index 0000000..e377e55
--- /dev/null
+++ b/libselinux/man/man5/default_contexts.5
@@ -0,0 +1,70 @@
+.TH "default_contexts" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+default_contexts \- The SELinux default contexts configuration file.
+
+.SH "DESCRIPTION"
+The default contexts configuration file \fIdefault_contexts\fR contains entries that allow SELinux-aware login applications such as
+.BR PAM "(8) "
+.sp
+SELinux-aware login applications generally use one or more of the following libselinux functions that read these files from the active policy path:
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
+.sp
+The default context configuration file path for the active policy is returned by \fBselinux_default_contexts_path\fR(3). The default, default contexts file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/default_contexts
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+Each line in the default configuration file consists of the following:
+.RS
+.I login_process user_login_process [user_login_process] ...
+.RE
+.sp
+Where:
+.RS
+.I login_process
+.RS
+This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entry that represents the login process context that are defined in the policy.
+.RE
+.I user_login_process
+.RS
+This consists of one or more \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entries that represent the user login process context defined in the policy.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/default_contexts
+.br
+system_r:crond_t:s0			 system_r:system_crond_t:s0
+.br
+system_r:local_login_t:s0	 user_r:user_t:s0 staff_r:staff_t:s0
+.br
+system_r:remote_login_t:s0	 user_r:user_t:s0
+.br
+system_r:sshd_t:s0			 user_r:user_t:s0
+.br
+system_r:sulogin_t:s0		 sysadm_r:sysadm_t:s0
+.br
+system_r:xdm_t:s0			 user_r:user_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_default_contexts_path "(3), " PAM "(8), " selinux_default_type_path "(3), " get_default_context "(3), " get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/default_type.5 b/libselinux/man/man5/default_type.5
new file mode 100644
index 0000000..45f4806
--- /dev/null
+++ b/libselinux/man/man5/default_type.5
@@ -0,0 +1,38 @@
+.TH "default_type" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+default_type \- The SELinux default type configuration file.
+
+.SH "DESCRIPTION"
+The \fIdefault_type\fR file contains entries that allow SELinux-aware applications such as \fBnewrole\fR(1) to select a default type for a role if one is not supplied.
+.sp
+\fBselinux_default_type_path\fR(3) will return the active policy path to this file. The default, default type file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/default_type
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+\fBget_default_type\fR(3) reads this file to determine a type for the active policy.
+
+.SH "FILE FORMAT"
+Each line within the \fIdefault_type\fR file is formatted with \fIrole\fB:\fItype\fR entries where:
+.RS
+.I role
+.RS
+The SELinux role.
+.RE
+.I type
+.RS
+The domain type that is returned for this role.
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/default_type
+.br
+auditadm_r:auditadm_t
+.br
+user_r:user_t
+
+.SH "SEE ALSO"
+.BR selinux "(8), " get_default_type "(3), " newrole "(1), " selinux_default_type_path "(3), " selinux_config "(5) "
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
