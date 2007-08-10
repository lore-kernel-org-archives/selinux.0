Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG6U7F017728
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:06:30 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG6S1t020704
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:06:28 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/16] CacheFiles: Permit a process's create SID to be
	overridden [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:05:43 +0100
Message-ID: <20070810160543.24698.80481.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make it possible for a process's file creation SID to be temporarily overridden
by CacheFiles so that files created in the cache have the right label attached.

Without this facility, files created in the cache will be given the current
file creation SID of whatever process happens to have invoked CacheFiles
indirectly by means of opening a netfs file at the time the cache file is
created.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h |   39 +++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |   14 ++++++++++++++
 security/selinux/hooks.c |   20 ++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c11dc8a..edd1677 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1147,6 +1147,15 @@ struct request_sock;
  *	@secdata contains the security context.
  *	@seclen contains the length of the security context.
  *
+ * @get_fscreate_secid:
+ *	Get the current FS security ID.
+ *	@secid points the location in which to return the security ID.
+ *
+ * @set_fscreate_secid:
+ *	Set the current FS security ID.
+ *	@secid contains the security ID to set.
+ *	@oldsecid points the location in which to return the old security ID.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1330,6 +1339,8 @@ struct security_operations {
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
+	int (*get_fscreate_secid)(u32 *secid);
+	int (*set_fscreate_secid)(u32 secid, u32 *oldsecid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2127,6 +2138,16 @@ static inline void security_release_secctx(char *secdata, u32 seclen)
 	return security_ops->release_secctx(secdata, seclen);
 }
 
+static inline int security_get_fscreate_secid(u32 *secid)
+{
+	return security_ops->get_fscreate_secid(secid);
+}
+
+static inline int security_set_fscreate_secid(u32 secid, u32 *oldsecid)
+{
+	return security_ops->set_fscreate_secid(secid, oldsecid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2795,6 +2816,11 @@ static inline void securityfs_remove(struct dentry *dentry)
 {
 }
 
+static inline int security_to_secctx_secid(char *secdata, u32 seclen, u32 *secid)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
@@ -2803,6 +2829,19 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
+
+static inline int security_get_fscreate_secid(u32 *secid)
+{
+	*secid = 0;
+	return 0;
+}
+
+static inline int security_set_fscreate_secid(u32 secid, u32 *oldsecid)
+{
+	*oldsecid = 0;
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 19d813d..9e81edb 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -930,6 +930,18 @@ static void dummy_release_secctx(char *secdata, u32 seclen)
 {
 }
 
+static int dummy_get_fscreate_secid(u32 *secid)
+{
+	*secid = 0;
+	return 0;
+}
+
+static int dummy_set_fscreate_secid(u32 secid, u32 *oldsecid)
+{
+	*oldsecid = 0;
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1084,6 +1096,8 @@ void security_fixup_ops (struct security_operations *ops)
  	set_to_dummy_if_null(ops, setprocattr);
  	set_to_dummy_if_null(ops, secid_to_secctx);
  	set_to_dummy_if_null(ops, release_secctx);
+ 	set_to_dummy_if_null(ops, get_fscreate_secid);
+ 	set_to_dummy_if_null(ops, set_fscreate_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6237933..f82a03d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4661,6 +4661,24 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 	kfree(secdata);
 }
 
+static int selinux_get_fscreate_secid(u32 *secid)
+{
+	struct task_security_struct *tsec = current->security;
+
+	*secid = tsec->create_sid;
+	return 0;
+}
+
+static int selinux_set_fscreate_secid(u32 secid, u32 *oldsecid)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldsid = tsec->create_sid;
+
+	tsec->create_sid = secid;
+	*oldsecid = oldsid;
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4843,6 +4861,8 @@ static struct security_operations selinux_ops = {
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.release_secctx =		selinux_release_secctx,
+	.get_fscreate_secid =		selinux_get_fscreate_secid,
+	.set_fscreate_secid =		selinux_set_fscreate_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
