Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79HsCeq025150
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79HsBVe011641
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:54:11 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hs9Fn023979
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:09 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hs8w4002292
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:09 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79Hs8LB020602
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:54:08 +0100
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Date: Thu, 09 Aug 2007 17:05:40 +0100
Message-ID: <20070809160540.17906.72214.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070809160438.17906.76348.stgit@warthog.cambridge.redhat.com>
References: <20070809160438.17906.76348.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [Linux-cachefs] [PATCH 12/14] CacheFiles: Get the SID under which
	the CacheFiles module should operate [try #2]
Reply-To: Linux filesystem caching discussion list <linux-cachefs@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
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
index 21cadea..9cb417e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1164,6 +1164,14 @@ struct request_sock;
  *      owning security ID, and return the security ID as which the process was
  *      previously acting.
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
@@ -1352,6 +1360,7 @@ struct security_operations {
 	u32 (*set_fscreate_secid)(u32 secid);
 	u32 (*act_as_secid)(u32 secid);
 	u32 (*act_as_self)(void);
+	int (*cachefiles_get_secid)(u32 secid, u32 *modsecid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2176,6 +2185,11 @@ static inline u32 security_act_as_self(void)
 	return security_ops->act_as_self();
 }
 
+static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_ops->cachefiles_get_secid(secid, modsecid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2883,6 +2897,12 @@ static inline u32 security_act_as_self(void)
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
index 6a7a317..2c1fd16 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -955,6 +955,12 @@ static u32 dummy_act_as_self(void)
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
@@ -1114,6 +1120,7 @@ void security_fixup_ops (struct security_operations *ops)
  	set_to_dummy_if_null(ops, set_fscreate_secid);
  	set_to_dummy_if_null(ops, act_as_secid);
  	set_to_dummy_if_null(ops, act_as_self);
+ 	set_to_dummy_if_null(ops, cachefiles_get_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c05d662..725f657 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4718,6 +4718,12 @@ static u32 selinux_act_as_self(void)
 	return oldactor_sid;
 }
 
+static int selinux_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_transition_sid(secid, SECINITSID_KERNEL,
+				       SECCLASS_PROCESS, modsecid);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4905,6 +4911,7 @@ static struct security_operations selinux_ops = {
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
 	.act_as_secid =			selinux_act_as_secid,
 	.act_as_self =			selinux_act_as_self,
+	.cachefiles_get_secid =		selinux_cachefiles_get_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,

--
Linux-cachefs mailing list
Linux-cachefs@redhat.com
https://www.redhat.com/mailman/listinfo/linux-cachefs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
