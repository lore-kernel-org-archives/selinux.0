Subject: [PATCH 2/7] SELinux: make it harder to get the number of mnt opts
 wrong
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:58:53 -0400
Message-ID: <20120824195853.22970.7577.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of just hard coding a value, use the enum to out benefit.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index df35dd6..74a738d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -96,8 +96,6 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-#define NUM_SEL_MNT_OPTS 5
-
 extern struct security_operations *security_ops;
 
 /* SECMARK reference count */
@@ -309,8 +307,11 @@ enum {
 	Opt_defcontext = 3,
 	Opt_rootcontext = 4,
 	Opt_labelsupport = 5,
+	Opt_nextmntopt = 6,
 };
 
+#define NUM_SEL_MNT_OPTS	(Opt_nextmntopt - 1)
+
 static const match_table_t tokens = {
 	{Opt_context, CONTEXT_STR "%s"},
 	{Opt_fscontext, FSCONTEXT_STR "%s"},


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
