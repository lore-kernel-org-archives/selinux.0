Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EGOrv027434
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:16:24 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EGNVa028716
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:16:23 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141533.310472096@hp.com>
References: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:16 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 1/5] SELinux: add secctx_to_secid() LSM hook
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a secctx_to_secid() LSM hook to go along with the existing
secid_to_secctx() LSM hook.  This patch also includes a SELinux implementation
for this hook.

---
 include/linux/security.h |   17 +++++++++++++++++
 security/dummy.c         |    6 ++++++
 security/selinux/hooks.c |    6 ++++++
 3 files changed, 29 insertions(+)

Index: linux-2.6_staticlbl/include/linux/security.h
===================================================================
--- linux-2.6_staticlbl.orig/include/linux/security.h
+++ linux-2.6_staticlbl/include/linux/security.h
@@ -1141,6 +1141,10 @@ struct request_sock;
  *	Convert secid to security context.
  *	@secid contains the security ID.
  *	@secdata contains the pointer that stores the converted security context.
+ * @secctx_to_secid:
+ *      Convert security context to secid.
+ *      @secid contains the pointer to the generated security ID.
+ *      @secdata contains the security context.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1329,6 +1333,7 @@ struct security_operations {
  	int (*getprocattr)(struct task_struct *p, char *name, char **value);
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -2122,6 +2127,13 @@ static inline int security_secid_to_secc
 	return security_ops->secid_to_secctx(secid, secdata, seclen);
 }
 
+static inline int security_secctx_to_secid(char *secdata,
+					   u32 seclen,
+					   u32 *secid)
+{
+	return security_ops->secctx_to_secid(secdata, seclen, secid);
+}
+
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 	return security_ops->release_secctx(secdata, seclen);
@@ -2800,6 +2812,11 @@ static inline int security_secid_to_secc
 	return -EOPNOTSUPP;
 }
 
+static inline int secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
Index: linux-2.6_staticlbl/security/dummy.c
===================================================================
--- linux-2.6_staticlbl.orig/security/dummy.c
+++ linux-2.6_staticlbl/security/dummy.c
@@ -926,6 +926,11 @@ static int dummy_secid_to_secctx(u32 sec
 	return -EOPNOTSUPP;
 }
 
+static int dummy_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+{
+	return -EOPNOTSUPP;
+}
+
 static void dummy_release_secctx(char *secdata, u32 seclen)
 {
 }
@@ -1083,6 +1088,7 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, getprocattr);
  	set_to_dummy_if_null(ops, setprocattr);
  	set_to_dummy_if_null(ops, secid_to_secctx);
+	set_to_dummy_if_null(ops, secctx_to_secid);
  	set_to_dummy_if_null(ops, release_secctx);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
Index: linux-2.6_staticlbl/security/selinux/hooks.c
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/hooks.c
+++ linux-2.6_staticlbl/security/selinux/hooks.c
@@ -4656,6 +4656,11 @@ static int selinux_secid_to_secctx(u32 s
 	return security_sid_to_context(secid, secdata, seclen);
 }
 
+static int selinux_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
+{
+	return security_context_to_sid(secdata, seclen, secid);
+}
+
 static void selinux_release_secctx(char *secdata, u32 seclen)
 {
 	kfree(secdata);
@@ -4842,6 +4847,7 @@ static struct security_operations selinu
 	.setprocattr =                  selinux_setprocattr,
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
+	.secctx_to_secid =		selinux_secctx_to_secid,
 	.release_secctx =		selinux_release_secctx,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
