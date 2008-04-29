Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3TJsrYk002824
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 15:54:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3TJsqtX008077
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 19:54:52 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Security: Make secctx_to_secid() take const secdata
To: torvalds@osdl.org, akpm@linux-foundation.org, jmorris@namei.org,
        casey@schaufler-ca.com
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Date: Tue, 29 Apr 2008 20:52:51 +0100
Message-ID: <20080429195250.12265.62856.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make secctx_to_secid() take constant secdata.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/security.h            |    6 +++---
 security/dummy.c                    |    2 +-
 security/security.c                 |    2 +-
 security/selinux/hooks.c            |    2 +-
 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |    4 ++--
 security/smack/smack_lsm.c          |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)


diff --git a/include/linux/security.h b/include/linux/security.h
index 594abd8..e7882ef 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1488,7 +1488,7 @@ struct security_operations {
 	int (*getprocattr) (struct task_struct *p, char *name, char **value);
 	int (*setprocattr) (struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx) (u32 secid, char **secdata, u32 *seclen);
-	int (*secctx_to_secid) (char *secdata, u32 seclen, u32 *secid);
+	int (*secctx_to_secid) (const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx) (char *secdata, u32 seclen);
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -1739,7 +1739,7 @@ int security_setprocattr(struct task_struct *p, char *name, void *value, size_t
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_netlink_recv(struct sk_buff *skb, int cap);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
 #else /* CONFIG_SECURITY */
@@ -2463,7 +2463,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 	return -EOPNOTSUPP;
 }
 
-static inline int security_secctx_to_secid(char *secdata,
+static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
 					   u32 *secid)
 {
diff --git a/security/dummy.c b/security/dummy.c
index d254a0c..d3116f2 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -983,7 +983,7 @@ static int dummy_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return -EOPNOTSUPP;
 }
 
-static int dummy_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+static int dummy_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index a5daaac..885c776 100644
--- a/security/security.c
+++ b/security/security.c
@@ -891,7 +891,7 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	return security_ops->secctx_to_secid(secdata, seclen, secid);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81ce29f..fb25441 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5255,7 +5255,7 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return security_sid_to_context(secid, secdata, seclen);
 }
 
-static int selinux_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	return security_context_to_sid(secdata, seclen, secid);
 }
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cdb14ad..ad30ac4 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,7 +96,7 @@ int security_sid_to_context(u32 sid, char **scontext,
 int security_context_to_sid(const char *scontext, u32 scontext_len,
 	u32 *out_sid);
 
-int security_context_to_sid_default(char *scontext, u32 scontext_len,
+int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
 
 int security_get_user_sids(u32 callsid, char *username,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 25cac5a..dcc2e1c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -858,8 +858,8 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid,
-				    u32 def_sid, gfp_t gfp_flags)
+int security_context_to_sid_default(const char *scontext, u32 scontext_len,
+				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 					    sid, def_sid, gfp_flags);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 45a690e..1e6c5af 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2421,7 +2421,7 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	*secid = smack_to_secid(secdata);
 	return 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
