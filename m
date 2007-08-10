Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG6hnh017772
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:06:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG6e1t020750
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:06:41 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/16] CacheFiles: Get the SID under which the CacheFiles
	module should operate [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:05:58 +0100
Message-ID: <20070810160558.24698.11275.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Get the SID under which the CacheFiles module should operate so that the
SELinux security system can control the accesses it makes.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h |   20 ++++++++++++++++++++
 security/dummy.c         |    7 +++++++
 security/selinux/hooks.c |    7 +++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a54958a..593a4d0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1173,6 +1173,14 @@ struct request_sock;
  *      previously acting.
  *	@oldsecid points the location in which to return the displaced security ID.
  *
+ * @cachefiles_get_secid:
+ *	Determine the security ID for the CacheFiles module to use when
+ *	accessing the filesystem containing the cache.
+ *	@secid contains the security ID under which cachefiles daemon is
+ *      running.
+ *	@modsecid contains the pointer to where the security ID for the module
+ *	is to be stored.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1361,6 +1369,7 @@ struct security_operations {
 	int (*set_fscreate_secid)(u32 secid, u32 *oldsecid);
 	int (*act_as_secid)(u32 secid, u32 *oldsecid);
 	int (*act_as_self)(u32 *oldsecid);
+	int (*cachefiles_get_secid)(u32 secid, u32 *modsecid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2185,6 +2194,11 @@ static inline int security_act_as_self(u32 *oldsecid)
 	return security_ops->act_as_self(oldsecid);
 }
 
+static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_ops->cachefiles_get_secid(secid, modsecid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2897,6 +2911,12 @@ static inline u32 security_act_as_self(u32 *oldsecid)
 	return 0;
 }
 
+static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	*modsecid = 0;
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 6be18fe..6e79dd4 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -960,6 +960,12 @@ static int dummy_act_as_self(u32 *oldsecid)
 	return 0;
 }
 
+static int dummy_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	*modsecid = 0;
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1119,6 +1125,7 @@ void security_fixup_ops (struct security_operations *ops)
  	set_to_dummy_if_null(ops, set_fscreate_secid);
  	set_to_dummy_if_null(ops, act_as_secid);
  	set_to_dummy_if_null(ops, act_as_self);
+ 	set_to_dummy_if_null(ops, cachefiles_get_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 34646f8..54542b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4723,6 +4723,12 @@ static int selinux_act_as_self(u32 *oldsecid)
 	return 0;
 }
 
+static int selinux_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_transition_sid(secid, SECINITSID_KERNEL,
+				       SECCLASS_PROCESS, modsecid);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4910,6 +4916,7 @@ static struct security_operations selinux_ops = {
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
 	.act_as_secid =			selinux_act_as_secid,
 	.act_as_self =			selinux_act_as_self,
+	.cachefiles_get_secid =		selinux_cachefiles_get_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
