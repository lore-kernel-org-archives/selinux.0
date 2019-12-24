Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A6C2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B568220679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T4gN+n4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLYADU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:03:20 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43023
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbfLYADU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232196; bh=bywCGGumEasJ7z5/nI4xVR7i1z8dhO2rCAtskFh94TI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T4gN+n4oD70mkJs0pBsS4y60xC+4ba6Hde+1JXhT1Ok2Mdk5TmCC9NMjZCZYRp2hEoj8forxsQ09Hn7KT2cLe245LXTv1G0nXEUH9rZGZwcq1VSHQmDXnYubiwAk59XlATOTdKdhsJSXBxVZ4dQuFLafCaQwKXoKb+5uaBuyNkxB0YFcDvEGO7IZWcu8WSHfoQjUnCWjOF/ndv0yDrkw3X+zV/E8GBbs4iKiDvn6nsi37AVUMU15ngl0Xx/GLiKOY/Rfj24bexWpSxfQgj1XnCWQy1zpu/Fs3F8zI1Yoi37sBH7AodPDvxgllyKZkDpBraCIR/aSvakug4EWCnSlKg==
X-YMail-OSG: 9dvIcFYVM1kYTHPwYRWh6uThHikXYXxx9AuzCPa9auVHynM__MMb1UO1F1Ud7hF
 QnEBAd9oEO7L_YfjsO5GPSXt82tR6VAKTuP1QKS9LeIrTtIuBBjkOS3NZdG0vxtH_NYQRskwYNHm
 R4PXR5JMlhyxSOLz96uKnofSyfUHy24J7gjUAwBLj04urvY1XNYo.rM4m6aYgp.vWKw6lKBFXfke
 IZecN9oxdT79k.mWMh4LiqU_BWqdvZXE6rvCkhavOzGn2iF3M5p5M_f5zq.p7Ri9ETldfMWdvFqE
 DyJjhkeLGBo23b0Us84Hy.0F6u7.i3VOx9DpfvtbGQKS2mlsIKhzcQbK3OFOy5dBSHodxzTXHqwq
 l8tckxfNB3fzcx7FGbu7kECebcKLo3268_D3rEud.JFeG9J66jAIWvgIGPwyPlGdKf1mPh13uLIL
 7Ra36PJP1JpCDRLarb_LgmnWekn4doAuWdgUpYOvfWtxeYSUs54XjjC0DzjzyCvqD8laJVys5azS
 vcnH3elSNXAKlhdE_migdr7sMl5etw2PEfzNsUcC2ABf6jCEnAkechp8QcpnThD_OQaRcdGPiuwU
 aQGjTs.N8zDleSxdUF27XXMIqACShBIdJkoVsFWcy8ckVU58Q5rPwPNW14r9WPrHRSurxBTzRv.M
 rDP10QLuyiOKF8hxY5CF2g20wt8JLJugRwG2WTd9y0QUjbHoSVAkyXJl3GXs63dMu34XeafHv1QV
 E8oBS2ww0g9K2NW7wrYed0aqMTAPUaotWEIg1K2eAta6LoSnSMeMmS3zq1quvsjobaSLW5hRQzPZ
 nPXX87NOfcwSZ._qQ6Wsk_H5y0sPy46My97MvsBSZpzYf8QEY2ieUFVlCNhBmq8JTEQdCvfY_eae
 3qQAanK7qDI16YF5SdeA4B6h83nvCSV4BfnX.PvuudEzQ1D41._1Y06lPEcyyPouf5fsi0FfMONB
 fFv9b4bqLk2PJmo.oXy79WahcqDU_CA5kxmjcxvBPA1gAAJhWXLBPZKRD1rUZElvTW9.KmKgBVxO
 MskcrL3reYWc3T_ab6aybtLUi30cJQtAw0Z3lRb4fGIrPdNTPxwT6abwTyGeMXWj7tjd2zQjhF7j
 sF.0UPdvwrv_5x31mJN_DPmFv9s2s8BZ5VQ.CjomomsNyEFJ.0vsbto8trv0XL_Xy6pZM.ukM1il
 4WYVA.r_MhqysGuIqTwNxcl5PFpgWuVp1RTzAPOzq0o7_AYTokg.6Y4y_FyyCsu6CjR.pDWbYtZS
 mljDBGalevaov_tkj.GI7tcbx5GNgXeWLv_yz6yf485B1IBQQGy4bW0sE.h6e.CKLxjZZ4_sqEW8
 UGtQZHTM94E3.tvW65fvG3m5q5ka6KXyZSIm3RozhSaCUFkiQ8oPLsyaDPR_iiCj0FLhDbBlb70.
 nDQGVNypR0zZkRuhFPRL4ix8xZXIPfVmxiBVOOPOHE5IujTJNn74WieKVchK8y1a0LqcrRXM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:03:16 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aedf02fec9fe6bb4a4ffd9636b4dac63;
          Wed, 25 Dec 2019 00:03:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Date:   Tue, 24 Dec 2019 15:59:37 -0800
Message-Id: <20191224235939.7483-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
cc: netdev@vger.kernel.org
cc: linux-api@vger.kernel.org
---
 Documentation/security/lsm.rst        |  15 ++++
 arch/alpha/include/uapi/asm/socket.h  |   1 +
 arch/mips/include/uapi/asm/socket.h   |   1 +
 arch/parisc/include/uapi/asm/socket.h |   1 +
 arch/sparc/include/uapi/asm/socket.h  |   1 +
 include/linux/lsm_hooks.h             |   9 +-
 include/linux/security.h              |  10 ++-
 include/uapi/asm-generic/socket.h     |   1 +
 net/core/sock.c                       |   7 +-
 security/apparmor/lsm.c               |  20 ++---
 security/security.c                   | 115 +++++++++++++++++++++++---
 security/selinux/hooks.c              |  20 ++---
 security/smack/smack_lsm.c            |  31 +++----
 13 files changed, 170 insertions(+), 62 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index aadf47c808c0..77cc326a52cc 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -199,3 +199,18 @@ capability-related fields:
 -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
 
 -  ``fs/proc/array.c``::c:func:`task_cap()`
+
+LSM External Interfaces
+=======================
+
+The LSM infrastructure does not generally provide external interfaces.
+The individual security modules provide what external interfaces they
+require. The infrastructure does provide two interfaces for the special
+case where multiple security modules provide a process context. This
+is provided in compound context format.
+
+-  `lsm1\0value\0lsm2\0value\0`
+
+The special file ``/proc/pid/attr/context`` provides the security
+context of the identified process. The socket option SO_PEERCONTEXT
+provides the security context of a packet.
diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index de6c4df61082..b26fb34e4226 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -123,6 +123,7 @@
 #define SO_SNDTIMEO_NEW         67
 
 #define SO_DETACH_REUSEPORT_BPF 68
+#define SO_PEERCONTEXT          69
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index d0a9ed2ca2d6..10e03507b1ed 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -134,6 +134,7 @@
 #define SO_SNDTIMEO_NEW         67
 
 #define SO_DETACH_REUSEPORT_BPF 68
+#define SO_PEERCONTEXT          69
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 10173c32195e..e11df59a84d1 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -115,6 +115,7 @@
 #define SO_SNDTIMEO_NEW         0x4041
 
 #define SO_DETACH_REUSEPORT_BPF 0x4042
+#define SO_PEERCONTEXT          0x4043
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 8029b681fc7c..5b41ef778040 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -116,6 +116,7 @@
 #define SO_SNDTIMEO_NEW          0x0045
 
 #define SO_DETACH_REUSEPORT_BPF  0x0047
+#define SO_PEERCONTEXT           0x0048
 
 #if !defined(__KERNEL__)
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2bf82e1cf347..2ae10e7f81a7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -880,8 +880,8 @@
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
@@ -1724,9 +1724,8 @@ union security_list_options {
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
index d7af2bbbc878..26967055a002 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -178,6 +178,7 @@ struct lsmblob {
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
 #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
 #define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
+#define LSMBLOB_COMPOUND	-6	/* A compound "display" */
 
 /**
  * lsmblob_init - initialize an lsmblob structure.
@@ -1396,7 +1397,8 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+				      int __user *optlen, unsigned len,
+				      int display);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
@@ -1530,8 +1532,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
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
index 77f7c1638eb1..e3a853d53705 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -118,6 +118,7 @@
 #define SO_SNDTIMEO_NEW         67
 
 #define SO_DETACH_REUSEPORT_BPF 68
+#define SO_PEERCONTEXT          69
 
 #if !defined(__KERNEL__)
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 043db3ce023e..63b7eda81a90 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1411,7 +1411,12 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
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
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 16b992235c11..34edfd29c32f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1078,10 +1078,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
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
@@ -1101,17 +1099,11 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
index 6d05222aac9c..80539dfd0245 100644
--- a/security/security.c
+++ b/security/security.c
@@ -723,6 +723,42 @@ static void __init lsm_early_task(struct task_struct *task)
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
@@ -2164,8 +2200,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
@@ -2245,12 +2281,21 @@ void security_release_secctx(struct lsmcontext *cp)
 {
 	struct security_hook_list *hp;
 
+	if (cp->slot == LSMBLOB_INVALID)
+		return;
+
+	if (cp->slot == LSMBLOB_COMPOUND) {
+		kfree(cp->context);
+		goto clear_out;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
 		if (cp->slot == hp->lsmid->slot) {
 			hp->hook.release_secctx(cp->context, cp->len);
 			break;
 		}
 
+clear_out:
 	memset(cp, 0, sizeof(*cp));
 }
 EXPORT_SYMBOL(security_release_secctx);
@@ -2383,17 +2428,67 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
index cd4743331800..c3e6fd3f8c56 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5056,10 +5056,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5079,18 +5077,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
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
index 9ce67e03ac49..316c5faf9053 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3957,28 +3957,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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

