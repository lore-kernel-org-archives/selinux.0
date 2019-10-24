Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08785CA9EBB
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE03B21929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hsntVr7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfJXUyW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:22 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:35854
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbfJXUyW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950459; bh=oUzl4GeCHb4TsNNt33aui+mLMgHF+10V6sz7nUNFjYM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hsntVr7EtzM4CD1rYAmJdwl41ySUqq0rG6AeiN4SHQfvHcqNqjET6WAercCz1vu2q3+/e2R9X58IkDrYmGzE6jqaZ9uqrWs40kr8dLMu+6IfslNFWhFb3GYObPubYECTrlKUCJDKydbe9QvEnI6YfscghwH/q+ClHze5ow8iMKate+DkbYcAabxzTqryGjW/2G0SGbYIvDX+pdoSSikzpDrRLH7F7oW96Ff9bfq9f9QPKHDRICGC1//7x3jqenbVxo0/xbj0MWDALT3F16hdUaoDyW9UyB44wvhHROFLofkoPg6vYjAN5sHlz9Vf8VhSJDD0FRes9LeCd5WDQjrHog==
X-YMail-OSG: peT2dT0VM1nipcgSgEk9WWow96Jlbd1ju3WRFnSHsWrC5QBOlXfpcZMj0QPdag.
 la_EsxwZXram.OrYneHvtmS53L1ONVRZ6sBryn72doJjakff1__etPrFqaPU17dIffws.oKBj0Io
 2HUQ.WYrtgWCF2pDXkD5ocP7dfpxBxAWKB8Lf7fCYiSFSiFHYsDPPMb2__Sy62_Ts.yRH6jmQM1u
 mXBrqK1P4b8.5wdl7SRHU_rdYHr4035tI4N6GWd4w6_qN0Rz6nCZZAhbZU8Mz12x0s2Rb5QYvTMh
 YLgi0inqJ0PlTJIru9JxcZkxDftIiDtn89QpP6_0YAk5JsbYHn1jgjiGCBiDuuRxKUwjIkVSUo9u
 LVclrBeO7zUB9ZcWhwNYNfX2yELVaR50h5d0kIVIR_8WHbWaeneKZV3wPnEdM1l5b2LF1.y.CgLH
 avqDuMjVFjTWgk_yEjajwnHSW.xIVPnLjVYfoaOrls1OelL.tpZgjB9uY3E9_lx8A_fr_5TfbaV7
 nmfqi.sIrhn.PkFPP74.J2tCUWxj038H8HiACfJk_Lza4WQsGhiclxu7PQl_jKcRMSlPxETroQpk
 TJZmN4k7xzJvt0LdK_vCPT40kVaNCNnVFq5KB0ZbuGZVFjvRku2.I9r6wmLSZnIzWy_exlFLxHRI
 Q4ieLy1V9yS6hlwqvWvRyCiFpccsYFLKtNAqI7h4wfEWFGi_9XBjbk0alPAAV7YAaWHY0SiS6KU2
 DLxBVBjx5Jznc3ABxB0FUkTqziaowQA5yAW2ZNzd_9.jrdfNOJLCKYuciM68j_LqpeyIu8awS5Yq
 aGHjY3A2x.hiyYk4G4AkuJ1uOpw4bgxkYKKc0R__mRb6RAr7OJi.ViAIm2CJksLHM6XLPnB5b83o
 MX4vvvZqTn1UNLjb_0lefvYjtZoaigCcndS4GMuaFrAMqzext.CPbLsBRwUSZPmbJxbwFMdSWeBd
 m70gP6jXvikaPY47V.fpUl3kxl2vWZ9h7QEHP6204YPBeRdnTF2ao8FvDCjq9.2pb1.Lw1RS5k9d
 09dv_5JEQJNLhgkzvu2ennVPhKHlRigvJHx67HRx2Xa34NFkqC9JxhDf3zG71lqwtRc8255xUe3s
 Ht8aV43Yo6nZI3F..vNd340NEkrBb2fF_RhbWo5cj7d0W_69CNQUIfuqb8otdYvIO9Rl8Tvlud6i
 FQU8saece9ury8GjTPT7VkquG.ufnuU1viymV1SVJswxWS4gPUS41NPt_P_fDHxVunrAiEmQPobG
 Vwmj1o8KMDOr5k.kC5zslFhQabHDv6xGI05jV2Geh9bQW8GP0knLc_Y3iBl0VBETjslGjKBgwNaN
 xRT7PqSgCEJi75Sf5Pm8c21JuDhHDuAPZ6raMMBjNnZzB6lrhPuQ.vvT.5mc3zVMfw_C6KBbCwfU
 R13zneNdzKi0z7Z_oxVunaqU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:19 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 656d248acb5116d5cebde187ab2fdbab;
          Thu, 24 Oct 2019 20:54:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Date:   Thu, 24 Oct 2019 13:52:26 -0700
Message-Id: <20191024205228.6922-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The getsockopt SO_PEERSEC provides the LSM based security
information for a single module, but for reasons of backward
compatibility cannot include the information for multiple
modules. A new option SO_PEERCONTEXT is added to report the
security "context" of multiple modules using a "compound" format

        lsm1\0value\0lsm2\0value\0

This is expected to be used by system services, including dbus-daemon.
The exact format of a compound context has been the subject of
considerable debate. This format was suggested by Simon McVittie,
a dbus maintainer with a significant stake in the format being
usable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h  |   1 +
 arch/mips/include/uapi/asm/socket.h   |   1 +
 arch/parisc/include/uapi/asm/socket.h |   1 +
 arch/sparc/include/uapi/asm/socket.h  |   1 +
 include/linux/lsm_hooks.h             |   9 +-
 include/linux/security.h              |  11 ++-
 include/uapi/asm-generic/socket.h     |   1 +
 kernel/audit.c                        |   4 +-
 net/core/sock.c                       |   7 +-
 net/netlabel/netlabel_unlabeled.c     |   9 +-
 net/netlabel/netlabel_user.c          |   2 +-
 security/apparmor/lsm.c               |  20 ++---
 security/security.c                   | 118 +++++++++++++++++++++++---
 security/selinux/hooks.c              |  20 ++---
 security/smack/smack_lsm.c            |  31 +++----
 15 files changed, 164 insertions(+), 72 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 976e89b116e5..019e5fa8bcda 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -121,6 +121,7 @@
 
 #define SO_RCVTIMEO_NEW         66
 #define SO_SNDTIMEO_NEW         67
+#define SO_PEERCONTEXT          68
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index d41765cfbc6e..df8d984d76ed 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -132,6 +132,7 @@
 
 #define SO_RCVTIMEO_NEW         66
 #define SO_SNDTIMEO_NEW         67
+#define SO_PEERCONTEXT          68
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 66c5dd245ac7..9ae358309f46 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -113,6 +113,7 @@
 
 #define SO_RCVTIMEO_NEW         0x4040
 #define SO_SNDTIMEO_NEW         0x4041
+#define SO_PEERCONTEXT          0x4042
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 9265a9eece15..e8a53ef65210 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -114,6 +114,7 @@
 
 #define SO_RCVTIMEO_NEW          0x0044
 #define SO_SNDTIMEO_NEW          0x0045
+#define SO_PEERCONTEXT           0x0046
 
 #if !defined(__KERNEL__)
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 706fd6d3d46e..0187943835aa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -864,8 +864,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
+ *	@optval memory where the security state is to be copied.
+ *	@optlen int where the module should copy the actual length
  *	of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
@@ -1697,9 +1697,8 @@ union security_list_options {
 	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
 	int (*socket_shutdown)(struct socket *sock, int how);
 	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-	int (*socket_getpeersec_stream)(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned len);
+	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
+					int *optlen, unsigned len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb, u32 *secid);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
diff --git a/include/linux/security.h b/include/linux/security.h
index 35b03b57bce2..636de93d1a5f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -129,7 +129,7 @@ struct lsmblob {
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
 #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
-#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
+#define LSMBLOB_COMPOUND	-5	/* A compound "display" */
 
 /**
  * lsmblob_init - initialize an lsmblob structure.
@@ -1316,7 +1316,8 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+				      int __user *optlen, unsigned len,
+				      int display);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
@@ -1450,8 +1451,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    char __user *optval,
+						    int __user *optlen,
+						    unsigned len, int display)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8c1391c89171..b38d080c2802 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -116,6 +116,7 @@
 
 #define SO_RCVTIMEO_NEW         66
 #define SO_SNDTIMEO_NEW         67
+#define SO_PEERCONTEXT          68
 
 #if !defined(__KERNEL__)
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 45ea36f1f1c5..24a3e8423e84 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1437,7 +1437,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		len = 0;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context, LSMBLOB_FIRST);
+						       &context, 0);
 			if (err)
 				return err;
 		}
@@ -2112,7 +2112,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
+	error = security_secid_to_secctx(&blob, &context, 0);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/net/core/sock.c b/net/core/sock.c
index 782343bb925b..b0955a34167c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1412,7 +1412,12 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock, optval, optlen,
+							 len, LSMBLOB_DISPLAY);
+
+	case SO_PEERCONTEXT:
+		return security_socket_getpeersec_stream(sock, optval, optlen,
+							 len, LSMBLOB_COMPOUND);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index cf34c163af20..e2a134286eb7 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -450,8 +450,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context, 0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -507,7 +506,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+					     0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -568,7 +567,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+					     0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -1139,7 +1138,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
+	ret_val = security_secid_to_secctx(lsmb, &context, 0);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 193200955dbd..b39a009974a8 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -114,7 +114,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
+	    security_secid_to_secctx(&blob, &context, 0) == 0) {
 		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c4835d05c5ea..ef6035a4fa7e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1073,10 +1073,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
  *
  * Note: for tcp only valid if using ipsec or cipso on lan
  */
-static int apparmor_socket_getpeersec_stream(struct socket *sock,
-					     char __user *optval,
-					     int __user *optlen,
-					     unsigned int len)
+static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
+					     int *optlen, unsigned int len)
 {
 	char *name;
 	int slen, error = 0;
@@ -1096,17 +1094,11 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	if (slen < 0) {
 		error = -ENOMEM;
 	} else {
-		if (slen > len) {
+		if (slen > len)
 			error = -ERANGE;
-		} else if (copy_to_user(optval, name, slen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (put_user(slen, optlen))
-			error = -EFAULT;
-out:
-		kfree(name);
-
+		else
+			*optval = name;
+		*optlen = slen;
 	}
 
 done:
diff --git a/security/security.c b/security/security.c
index 4e878907f12b..91626536343d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -691,6 +691,42 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	int llen;
+
+	llen = strlen(lsm) + 1;
+	newlen = strnlen(new, newlen) + 1;
+
+	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
+	if (final == NULL)
+		return -ENOMEM;
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, newlen);
+	kfree(*ctx);
+	*ctx = final;
+	*ctxlen = *ctxlen + llen + newlen;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -2105,8 +2141,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-		if (lsm == NULL && *display != LSMBLOB_INVALID &&
-		    *display != hp->lsmid->slot)
+		if (lsm == NULL && display != NULL &&
+		    *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -2137,7 +2173,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
 	 */
 	if (display == LSMBLOB_DISPLAY)
 		display = lsm_task_display(current);
-	else if (display == LSMBLOB_FIRST)
+	else if (display == 0)
 		display = LSMBLOB_INVALID;
 	else if (display < 0) {
 		WARN_ONCE(true,
@@ -2187,6 +2223,15 @@ void security_release_secctx(struct lsmcontext *cp)
 	struct security_hook_list *hp;
 	bool found = false;
 
+	if (cp->slot == LSMBLOB_INVALID)
+		return;
+
+	if (cp->slot == LSMBLOB_COMPOUND) {
+		kfree(cp->context);
+		found = true;
+		goto clear_out;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
 		if (cp->slot == hp->lsmid->slot) {
 			hp->hook.release_secctx(cp->context, cp->len);
@@ -2194,6 +2239,7 @@ void security_release_secctx(struct lsmcontext *cp)
 			break;
 		}
 
+clear_out:
 	memset(cp, 0, sizeof(*cp));
 
 	if (!found)
@@ -2330,17 +2376,67 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len)
+				      int __user *optlen, unsigned len,
+				      int display)
 {
-	int display = lsm_task_display(current);
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	unsigned finallen = 0;
+	unsigned clen = 0;
 
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
-			     list)
-		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
-			return hp->hook.socket_getpeersec_stream(sock, optval,
-								 optlen, len);
-	return -ENOPROTOOPT;
+	switch (display) {
+	case LSMBLOB_DISPLAY:
+		rc = -ENOPROTOOPT;
+		display = lsm_task_display(current);
+		hlist_for_each_entry(hp,
+				&security_hook_heads.socket_getpeersec_stream,
+				list)
+			if (display == LSMBLOB_INVALID ||
+			    display == hp->lsmid->slot) {
+				rc = hp->hook.socket_getpeersec_stream(sock,
+							&final, &finallen, len);
+				break;
+			}
+		break;
+	case LSMBLOB_COMPOUND:
+		/*
+		 * A compound context, in the form [lsm\0value\0]...
+		 */
+		hlist_for_each_entry(hp,
+				&security_hook_heads.socket_getpeersec_stream,
+				list) {
+			rc = hp->hook.socket_getpeersec_stream(sock, &cp, &clen,
+							       len);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT) {
+				rc = 0;
+				continue;
+			}
+			if (rc) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, clen);
+		}
+		if (final == NULL)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (finallen > len)
+		rc = -ERANGE;
+	else if (copy_to_user(optval, final, finallen))
+		rc = -EFAULT;
+
+	if (put_user(finallen, optlen))
+		rc = -EFAULT;
+
+	kfree(final);
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b07f9b8c7670..5b46c1ba614b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4903,10 +4903,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock,
-					    char __user *optval,
-					    int __user *optlen,
-					    unsigned int len)
+static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
+					    int *optlen, unsigned int len)
 {
 	int err = 0;
 	char *scontext;
@@ -4926,18 +4924,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	if (err)
 		return err;
 
-	if (scontext_len > len) {
+	if (scontext_len > len)
 		err = -ERANGE;
-		goto out_len;
-	}
-
-	if (copy_to_user(optval, scontext, scontext_len))
-		err = -EFAULT;
+	else
+		*optval = scontext;
 
-out_len:
-	if (put_user(scontext_len, optlen))
-		err = -EFAULT;
-	kfree(scontext);
+	*optlen = scontext_len;
 	return err;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8b2730e02044..507f16adbc41 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3943,28 +3943,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  *
  * returns zero on success, an error code otherwise
  */
-static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
+					  int *optlen, unsigned len)
 {
-	struct socket_smack *ssp;
-	char *rcp = "";
-	int slen = 1;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	char *rcp;
+	int slen;
 	int rc = 0;
 
-	ssp = smack_sock(sock->sk);
-	if (ssp->smk_packet != NULL) {
-		rcp = ssp->smk_packet->smk_known;
-		slen = strlen(rcp) + 1;
+	if (ssp->smk_packet == NULL) {
+		*optlen = 0;
+		return -EINVAL;
 	}
 
+	rcp = ssp->smk_packet->smk_known;
+	slen = strlen(rcp) + 1;
 	if (slen > len)
 		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
-
-	if (put_user(slen, optlen) != 0)
-		rc = -EFAULT;
+	else {
+		*optval = kstrdup(rcp, GFP_KERNEL);
+		if (*optval == NULL)
+			rc = -ENOMEM;
+	}
+	*optlen = slen;
 
 	return rc;
 }
-- 
2.20.1

