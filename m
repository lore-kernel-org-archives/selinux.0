Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB2AxbBi002333
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 05:59:37 -0500
Received: from nm3-vm1.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pB2Axa7x012851
	for <selinux@tycho.nsa.gov>; Fri, 2 Dec 2011 10:59:36 GMT
Message-ID: <1322823575.8496.YahooMailClassic@web87002.mail.ird.yahoo.com>
Date: Fri, 2 Dec 2011 10:59:35 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 3/3] libselinux: Add man/man5 man pages
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add service_seusers(5) - those in the ./logins directory, seusers(5),
user_contexts(5) - those in the ./contexts/users directory,
virtual_domain_context(5) and virtual_image_context(5) man pages.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man5/service_seusers.5        |   66 +++++++++++++++++++++
 libselinux/man/man5/seusers.5                |   62 ++++++++++++++++++++
 libselinux/man/man5/user_contexts.5          |   81 ++++++++++++++++++++++++++
 libselinux/man/man5/virtual_domain_context.5 |   39 ++++++++++++
 libselinux/man/man5/virtual_image_context.5  |   41 +++++++++++++
 5 files changed, 289 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/man/man5/service_seusers.5
 create mode 100644 libselinux/man/man5/seusers.5
 create mode 100644 libselinux/man/man5/user_contexts.5
 create mode 100644 libselinux/man/man5/virtual_domain_context.5
 create mode 100644 libselinux/man/man5/virtual_image_context.5

diff --git a/libselinux/man/man5/service_seusers.5 b/libselinux/man/man5/service_seusers.5
new file mode 100644
index 0000000..59a135a
--- /dev/null
+++ b/libselinux/man/man5/service_seusers.5
@@ -0,0 +1,66 @@
+.TH "service_seusers" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+service_seusers \- The SELinux GNU/Linux user and service to SELinux user mapping configuration files.
+
+.SH "DESCRIPTION"
+These are optional files that allow services to define an SELinux user when authenticating via SELinux-aware login applications such as
+.BR PAM "(8). "
+.sp
+There is one file for each GNU/Linux user name that will be required to run a service with a specific SELinux user name.
+.sp
+The path for each configuration file is formed by the path returned by
+.BR selinux_policy_root "(3) with  "
+.IR /logins/username
+appended (where \fIusername\fR is a file representing the GNU/Linux user name). The default services directory is located at:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/logins
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+.BR getseuser "(3) reads this file to map services to an SELinux user. "
+
+.SH "FILE FORMAT"
+Each line within the \fIusername\fR file is formatted as follows with each component separated by a colon:
+.RS
+.IB service : seuser \fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+.I service
+.RS
+The service name used by the application.
+.RE
+.I seuser
+.RS
+The SELinux user name.
+.RE
+.I range
+.RS
+The range for MCS/MLS policies.
+.RE
+.RE
+
+.SH "EXAMPLES"
+Example 1 \- for the 'root' user:
+.RS
+# ./logins/root
+.br
+ipa:user_u:s0
+.br
+this_service:unconfined_u:s0
+.RE
+.sp
+Example 2 \- for GNU/Linux user 'rch':
+.RS
+# ./logins/rch
+.br
+ipa:unconfined_u:s0
+.br
+that_service:unconfined_u:s0
+.RE
+
+.SH "SEE ALSO"
+.BR selinux "(8), " PAM "(8), " selinux_policy_root "(3), " getseuser "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/seusers.5 b/libselinux/man/man5/seusers.5
new file mode 100644
index 0000000..8c99ee8
--- /dev/null
+++ b/libselinux/man/man5/seusers.5
@@ -0,0 +1,62 @@
+.TH "seusers" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+seusers \- The SELinux GNU/Linux user to SELinux user mapping configuration file.
+
+.SH "DESCRIPTION"
+The
+.I seusers
+file contains a list GNU/Linux user to SELinux user mapping for use by SELinux-aware login applications such as \fBPAM\fR(8).
+.sp
+.BR selinux_usersconf_path "(3) "
+will return the active policy path to this file. The default SELinux users mapping file is located at:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/seusers
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+.BR getseuserbyname "(3) reads this file to map a GNU/Linux user or group to an SELinux user. "
+
+.SH "FILE FORMAT"
+Each line of the
+.I seusers
+configuration file consists of the following:
+.sp
+.RS
+\fR[\fB%\fIgroup_id\fR]|[\fIuser_id\fR]\fB:\fIseuser_id\fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+\fIgroup_id\fR|\fIuser_id
+.RS
+\fRThe  GNU/Linux user id, or if preceded by the percentage (\fB%\fR) symbol, then a GNU/Linux group id.
+.br
+An optional entry set to \fB__default__\fR can be provided as a fall back if required.
+.RE
+.I seuser_id
+.RS
+The SELinux  user identity.
+.RE
+.I range
+.RS
+The optional level or range for an MLS/MCS policy.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./seusers
+.br
+system_u:system_u:s0\-s15:c0.c255
+.br
+root:root:s0-s15:c0.c255
+.br
+fred:user_u:s0
+.br
+__default__:user_u:s0
+.br
+%user_group:user_u:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " PAM "(8), " selinux_usersconf_path "(3), " getseuserbyname "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/user_contexts.5 b/libselinux/man/man5/user_contexts.5
new file mode 100644
index 0000000..2b3df7a
--- /dev/null
+++ b/libselinux/man/man5/user_contexts.5
@@ -0,0 +1,81 @@
+.TH "user_contexts" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+user_contexts \- The SELinux user contexts configuration files.
+
+.SH "DESCRIPTION"
+These optional user context configuration files contain entries that allow SELinux-aware login applications such as
+.BR PAM (8)
+(running in their own process context), to determine the context that a users login session should run under.
+.sp
+SELinux-aware login applications generally use one or more of the following libselinux functions that read these files from the active policy path:
+.RS
+.BR get_default_context (3)
+.br
+.BR get_ordered_context_list (3)
+.br
+.BR get_ordered_context_list_with_level (3)
+.br
+.BR get_default_context_with_level (3)
+.br
+.BR get_default_context_with_role (3)
+.br
+.BR get_default_context_with_rolelevel (3)
+.br
+.BR query_user_context (3)
+.br
+.BR manual_user_enter_context (3)
+.RE
+.sp
+There can be one file for each SELinux user configured on the system. The file  path is formed using the path returned by
+.BR selinux_user_contexts_path (3)
+for the active policy, with the SELinux user name appended, for example:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/users/unconfined_u
+.br
+.I /etc/selinux/{SELINUXTYPE}/contexts/users/xguest_u
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+.sp
+These files contain context information as described in the
+.B FILE FORMAT
+section.
+
+.SH "FILE FORMAT"
+Each line in the user context configuration file consists of the following:
+.RS
+.I login_process user_login_process
+.RE
+.sp
+Where:
+.RS
+.I login_process
+.RS
+This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entry that represents the login process context.
+.RE
+.I user_login_process
+.RS
+This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entry that represents the user login process context.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# Example for xguest_u at /etc/selinux/targeted/contexts/users/xguest_u
+.br
+system_r:crond_t:s0			xguest_r:xguest_t:s0
+.br
+system_r:initrc_t:s0		xguest_r:xguest_t:s0
+.br
+system_r:local_login_t:s0	xguest_r:xguest_t:s0
+.br
+system_r:remote_login_t:s0	xguest_r:xguest_t:s0
+.br
+system_r:sshd_t:s0			xguest_r:xguest_t:s0
+.br
+system_r:xdm_t:s0			xguest_r:xguest_t:s0
+.br
+xguest_r:xguest_t:s0		xguest_r:xguest_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_user_contexts_path "(3), " PAM "(8), "  get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/virtual_domain_context.5 b/libselinux/man/man5/virtual_domain_context.5
new file mode 100644
index 0000000..6048f98
--- /dev/null
+++ b/libselinux/man/man5/virtual_domain_context.5
@@ -0,0 +1,39 @@
+.TH "virtual_domain_context" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+virtual_domain_context \- The SELinux virtual machine domain context configuration file.
+
+.SH "DESCRIPTION"
+The
+.I virtual_domain_context
+file contains a list of domain contexts that are available for use by the SELinux-aware virtulization API libvirt (see \fBlibvirtd\fR(8)).
+.sp
+.BR selinux_virtual_domain_context_path "(3) "
+will return the active policy path to this file. The default virtual domain context file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_domain_context
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+Each line in the file consists of an entry as follows:
+.RS
+.IB user : role : type \fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+.I user role type range
+.RS
+A user, role, type and optional range (for MCS/MLS) separated by colons (:) that can be used as a virtual domain context.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/virtual_domain_context
+.br
+system_u:object_r:svirt_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " libvirtd "(8), " selinux_virtual_domain_context_path "(3), " selinux_config "(5) "
diff --git a/libselinux/man/man5/virtual_image_context.5 b/libselinux/man/man5/virtual_image_context.5
new file mode 100644
index 0000000..4e9809b
--- /dev/null
+++ b/libselinux/man/man5/virtual_image_context.5
@@ -0,0 +1,41 @@
+.TH "virtual_image_context" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
+
+.SH "NAME"
+virtual_image_context \- The SELinux virtual machine image context configuration file.
+
+.SH "DESCRIPTION"
+The
+.I virtual_image_context
+file contains a list of image contexts for use by the SELinux-aware virtulization API libvirt (see \fBlibvirtd\fR(8)).
+.sp
+.BR selinux_virtual_image_context_path "(3) "
+will return the active policy path to this file. The default virtual image context file is:
+.RS
+.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_image_context
+.RE
+.sp
+Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
+
+.SH "FILE FORMAT"
+Each line in the file consists of an entry as follows:
+.RS
+.IB user : role : type \fR[\fB:\fIrange\fR]
+.RE
+.sp
+Where:
+.RS
+.I user role type range
+.RS
+A user, role, type and optional range (for MCS/MLS) separated by colons (:) that can be used as a virtual image context.
+.RE
+.RE
+
+.SH "EXAMPLE"
+# ./contexts/virtual_image_context
+.br
+system_u:object_r:svirt_image_t:s0
+.br
+system_u:object_r:svirt_content_t:s0
+
+.SH "SEE ALSO"
+.BR selinux "(8), " libvirtd "(8), " selinux_virtual_image_context_path "(3), " selinux_config "(5) "
-- 
1.7.7.1






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
