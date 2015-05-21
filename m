Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LGEgtp022663
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 12:14:42 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4LGEcYV010090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 12:14:39 -0400
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: add selinux_openssh_contexts_path()
Date: Thu, 21 May 2015 18:14:22 +0200
Message-Id: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

openssh in Fedora uses "sshd_net_t" type for privilege separated
processes in the preauthentication phase. Similarly, openssh portable uses
"sftp_t" for internal-sftp processes. Both type are hardcoded what is not ideal.
Therefore selinux_openssh_contexts_path() was created to get a path where sshd
can get a correct types prepared by a distribution or an administrator.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/include/selinux/selinux.h |  1 +
 libselinux/src/file_path_suffixes.h  |  1 +
 libselinux/src/selinux_config.c      | 12 ++++++++++--
 libselinux/src/selinux_internal.h    |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index d0eb5c6..4beb170 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -543,6 +543,7 @@ extern const char *selinux_virtual_image_context_path(void);
 extern const char *selinux_lxc_contexts_path(void);
 extern const char *selinux_x_context_path(void);
 extern const char *selinux_sepgsql_context_path(void);
+extern const char *selinux_openssh_contexts_path(void);
 extern const char *selinux_systemd_contexts_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 3c92424..d1f9b48 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -23,6 +23,7 @@ S_(BINPOLICY, "/policy/policy")
     S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
     S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
     S_(LXC_CONTEXTS, "/contexts/lxc_contexts")
+    S_(OPENSSH_CONTEXTS, "/contexts/openssh_contexts")
     S_(SYSTEMD_CONTEXTS, "/contexts/systemd_contexts")
     S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
     S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dist")
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 0a80141..bec5f3b 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -48,8 +48,9 @@
 #define FILE_CONTEXT_SUBS_DIST 25
 #define LXC_CONTEXTS      26
 #define BOOLEAN_SUBS      27
-#define SYSTEMD_CONTEXTS  28
-#define NEL               29
+#define OPENSSH_CONTEXTS  28
+#define SYSTEMD_CONTEXTS  29
+#define NEL               30
 
 /* Part of one-time lazy init */
 static pthread_once_t once = PTHREAD_ONCE_INIT;
@@ -491,6 +492,13 @@ const char *selinux_lxc_contexts_path(void)
 
 hidden_def(selinux_lxc_contexts_path)
 
+const char *selinux_openssh_contexts_path(void)
+{
+    return get_path(OPENSSH_CONTEXTS);
+}
+
+hidden_def(selinux_openssh_contexts_path)
+
 const char *selinux_systemd_contexts_path(void)
 {
 	return get_path(SYSTEMD_CONTEXTS);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 0abf1b4..844e408 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -83,6 +83,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_x_context_path)
     hidden_proto(selinux_sepgsql_context_path)
+    hidden_proto(selinux_openssh_contexts_path)
     hidden_proto(selinux_systemd_contexts_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
-- 
2.4.1
