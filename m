Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKEWWUg026951
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 09:32:35 -0500
Received: from gaara.hadrons.org (85.137.229.25) by resmaa12.ono.com (8.6.048.02) (authenticated as guillemj@ono.com)
        id 5052D7630150E78D for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 15:31:57 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.80)
	(envelope-from <guillemj@ono.com>)
	id 1TantG-00022C-4Y
	for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 14:29:26 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] libselinux: Fix program synopsis and function prototypes in man pages
Date: Tue, 20 Nov 2012 14:25:27 +0100
Message-Id: <1353417930-7707-2-git-send-email-guillem@debian.org>
In-Reply-To: <1353417930-7707-1-git-send-email-guillem@debian.org>
References: <1353417930-7707-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix typos, or wrong function prototypes.

Signed-off-by: Guillem Jover <guillem@debian.org>
---
 libselinux/man/man3/selabel_stats.3              |  2 +-
 libselinux/man/man3/selinux_binary_policy_path.3 | 30 ++++++++++++------------
 libselinux/man/man3/selinux_boolean_sub.3        | 10 ++++----
 libselinux/man/man3/selinux_getpolicytype.3      |  2 +-
 libselinux/man/man3/selinux_policy_root.3        |  2 +-
 libselinux/man/man3/selinux_status_open.3        |  2 +-
 libselinux/man/man5/selabel_db.5                 |  2 +-
 libselinux/man/man8/selinuxexeccon.8             |  2 +-
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/libselinux/man/man3/selabel_stats.3 b/libselinux/man/man3/selabel_stats.3
index 441f422..d39accc 100644
--- a/libselinux/man/man3/selabel_stats.3
+++ b/libselinux/man/man3/selabel_stats.3
@@ -9,7 +9,7 @@ selabel_stats \- obtain SELinux labeling statistics.
 
 .B #include <selinux/label.h>
 .sp
-.BI "void selabel_lookup(struct selabel_handle *" hnd ");"
+.BI "void selabel_stats(struct selabel_handle *" hnd ");"
 
 .SH "DESCRIPTION"
 .B selabel_stats
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 8ead1a4..b4f6590 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -11,35 +11,35 @@ directories and files.
 .B #include <selinux/selinux.h>
 .sp
 
-extern const char *selinux_path(void);
+const char *selinux_path(void);
 
-extern const char *selinux_policy_root(void);
+const char *selinux_policy_root(void);
 
-extern const char *selinux_binary_policy_path(void);
+const char *selinux_binary_policy_path(void);
 
-extern const char *selinux_failsafe_context_path(void);
+const char *selinux_failsafe_context_path(void);
 
-extern const char *selinux_removable_context_path(void);
+const char *selinux_removable_context_path(void);
 
-extern const char *selinux_default_context_path(void);
+const char *selinux_default_context_path(void);
 
-extern const char *selinux_user_contexts_path(void);
+const char *selinux_user_contexts_path(void);
 
-extern const char *selinux_usersconf_path(void);
+const char *selinux_usersconf_path(void);
 
-extern const char *selinux_x_context_path(void);
+const char *selinux_x_context_path(void);
 
-extern const char *selinux_sepgsql_context_path(void);
+const char *selinux_sepgsql_context_path(void);
 
-extern const char *selinux_file_context_path(void);
+const char *selinux_file_context_path(void);
 
-extern const char *selinux_media_context_path(void);
+const char *selinux_media_context_path(void);
 
-extern const char *selinux_securetty_types_path(void);
+const char *selinux_securetty_types_path(void);
 
-extern const char *selinux_contexts_path(void);
+const char *selinux_contexts_path(void);
 
-extern const char *selinux_booleans_path(void);
+const char *selinux_booleans_path(void);
 
 
 .SH "DESCRIPTION"
diff --git a/libselinux/man/man3/selinux_boolean_sub.3 b/libselinux/man/man3/selinux_boolean_sub.3
index 8d54c88..8693d57 100644
--- a/libselinux/man/man3/selinux_boolean_sub.3
+++ b/libselinux/man/man3/selinux_boolean_sub.3
@@ -1,10 +1,10 @@
-.TH "selinux_boolean_subs" "3" "11 June 2012" "dwalsh@redhat.com" "SELinux API documentation"
+.TH "selinux_boolean_sub" "3" "11 June 2012" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-selinux_boolean_subs
+selinux_boolean_sub
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "char *selinux_boolean_subs(const char * " boolean_name, ");"
+.BI "char *selinux_boolean_sub(const char * " boolean_name ");"
 .sp
 .SH "DESCRIPTION"
 .B selinux_boolean_sub
@@ -14,12 +14,12 @@ for a maching boolean_name record.  If the record exists the boolean substitutio
 returns the original boolean_name.
 
 .SH "RETURN VALUE"
-.BR selinux_boolean_subs
+.BR selinux_boolean_sub
 returns the
 .I boolean_name
 or the substituted name on success.  The returned value must be freed with
 .BR free "(3)."
-.BR selinux_boolean_subs
+.BR selinux_boolean_sub
 returns NULL on error.
 .SH "SEE ALSO"
 security_get_boolean_names.3
diff --git a/libselinux/man/man3/selinux_getpolicytype.3 b/libselinux/man/man3/selinux_getpolicytype.3
index 67f9518..b93e66e 100644
--- a/libselinux/man/man3/selinux_getpolicytype.3
+++ b/libselinux/man/man3/selinux_getpolicytype.3
@@ -4,7 +4,7 @@ selinux_getpolicytype \- get the type of SELinux policy running on the system
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.B int selinux_getpolicytype();
+.BI "int selinux_getpolicytype(char **" policytype );
 
 
 .SH "DESCRIPTION"
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index 7499c75..c69e16e 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -4,7 +4,7 @@ selinux_policy_root \- return the path of the SELinux policy files for this mach
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.B char *selinux_policy_root();
+.B const char *selinux_policy_root(void);
 
 
 .SH "DESCRIPTION"
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index e897939..9cb9249 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -7,7 +7,7 @@ without invocation of system calls.
 .SH "SYNOPSIS"
 .B #include <selinux/avc.h>
 .sp
-.BI "int selinux_status_open(int " fallback, ");"
+.BI "int selinux_status_open(int " fallback ");"
 .sp
 .BI "void selinux_status_close(void);"
 .sp
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
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index 6482d74..ebc5f4a 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -3,7 +3,7 @@
 selinuxexeccon \- report SELinux context used for this executable
 
 .SH "SYNOPSIS"
-.B selinuxexeccon command [ fromcon] o
+.B selinuxexeccon command [ fromcon]
 
 .SH "DESCRIPTION"
 .B selinuxexeccon
-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
