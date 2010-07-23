From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 5/5] SELinux: Move execmod to the common perms
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 23 Jul 2010 11:44:15 -0400
Message-ID: <20100723154415.13217.49052.stgit@paris.rdu.redhat.com>
In-Reply-To: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
References: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

execmod "could" show up on non regular files and non chr files.  The current
implementation would actually make these checks against non-existant bits
since the code assumes the execmod permission is same for all file types.
To make this line up for chr files we had to define execute_no_trans and
entrypoint permissions.  These permissions are unreachable and only existed
to to make FILE__EXECMOD and CHR_FILE__EXECMOD the same.  This patch drops
those needless perms as well.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/include/classmap.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 41990cb..b4c9eb4 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -3,7 +3,7 @@
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
     "rename", "execute", "swapon", "quotaon", "mounton", "audit_access", \
-    "open"
+    "open", "execmod"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
@@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] = {
 	    "quotaget", NULL } },
 	{ "file",
 	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", "execmod", NULL } },
+	    "execute_no_trans", "entrypoint", NULL } },
 	{ "dir",
 	  { COMMON_FILE_PERMS, "add_name", "remove_name",
 	    "reparent", "search", "rmdir", NULL } },
@@ -52,8 +52,7 @@ struct security_class_mapping secclass_map[] = {
 	{ "lnk_file",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "chr_file",
-	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", "execmod", NULL } },
+	  { COMMON_FILE_PERMS, NULL } },
 	{ "blk_file",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "sock_file",


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
