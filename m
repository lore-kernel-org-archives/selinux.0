From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: drop unused packet flow permissions
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 22 Feb 2011 21:54:17 -0500
Message-ID: <20110223025417.17492.97152.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These permissions are not used and can be dropped in the kernel
definitions.

Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/include/classmap.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index e9a8eb7..fffd855 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -132,8 +132,7 @@ struct security_class_mapping secclass_map[] = {
 	{ "appletalk_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "packet",
-	  { "send", "recv", "relabelto", "flow_in", "flow_out",
-	    "forward_in", "forward_out", NULL } },
+	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
 	{ "key",
 	  { "view", "read", "write", "search", "link", "setattr", "create",
 	    NULL } },


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
