Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CFDC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5237821EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GJPkEYLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfHGTrG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:47:06 -0400
Received: from sonic309-43.consmr.mail.bf2.yahoo.com ([74.6.129.217]:42280
        "EHLO sonic309-43.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729712AbfHGTrF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207222; bh=F2MkUs+7cOBQjgIea++26FgMqbcVuuyt0xdHfo57WZU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GJPkEYLQVFeHxWSDFYNYrfpARo/aUNwABjklHJuoTO68Brzow+GY4qTyilGEg6CfhGXUTi4OIFMkkp3E68deLHOgKrjvuhLnnYVlES5Ff1Dz1f/2BZ0hCAEEgbHFAXYpGFP5MWf4ZhIY4557HZC7YHBaQz92zU5tNqkH1dX5voAEb+FqqTOBNJuiXJ4gC8g0lsZCGLkuE2o3NqKpj86ul9AZPQealcaQDwn6/kl77M1CLH3KwkGqEFxPizm9ydjU2okj4szZumOLIVp2+EgCu4wxGXI56K75kfBsIdR4X+iUqb8mA9YQPSeYy9EGnXlXSUvpbW6GlWfbNd3XGJaKiw==
X-YMail-OSG: Ho_J96oVM1nNn4DI.sKUy5Hzosr_S7E.7niFyUM1wcufBzdo2Q6ey_abY0ryiue
 WSF4_J19or7jkeb2ExDpTlbG8Ldm3YdRLAqA9R7rXaJU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:47:02 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 47b71907c10558f94678ade4ae66d1b7;
          Wed, 07 Aug 2019 19:45:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 26/28] NET: Add SO_PEERCONTEXT for multiple LSMs
Date:   Wed,  7 Aug 2019 12:44:08 -0700
Message-Id: <20190807194410.9762-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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
uasable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  1 +
 arch/mips/include/uapi/asm/socket.h   |  1 +
 arch/parisc/include/uapi/asm/socket.h |  1 +
 arch/sparc/include/uapi/asm/socket.h  |  1 +
 include/linux/lsm_hooks.h             |  9 ++-
 include/linux/security.h              | 10 ++-
 include/uapi/asm-generic/socket.h     |  1 +
 net/core/sock.c                       |  7 +-
 security/apparmor/lsm.c               | 20 ++----
 security/security.c                   | 94 ++++++++++++++++++++++++---
 security/selinux/hooks.c              | 20 ++----
 security/smack/smack_lsm.c            | 31 ++++-----
 12 files changed, 134 insertions(+), 62 deletions(-)

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
index 33e5ab4af9f8..b0f788bf82b6 100644
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
index 12f6d5fcbf6a..0665a27a2891 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -130,6 +130,7 @@ struct lsmblob {
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
 #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
 #define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
+#define LSMBLOB_COMPOUND	-6	/* A compound "display" */
 
 /**
  * lsmblob_init - initialize an lsmblob structure.
@@ -1324,7 +1325,8 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+				      int __user *optlen, unsigned len,
+				      int display);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
@@ -1458,8 +1460,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
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
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ec2e39aa9a84..5d25959610f9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1037,10 +1037,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
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
@@ -1060,17 +1058,11 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
index 2f4a430a1126..0ea7ee27e331 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2117,8 +2117,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
@@ -2342,17 +2342,91 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
+	char *tp;
+	int rc = 0;
+	unsigned finallen = 0;
+	unsigned llen;
+	unsigned clen = 0;
+	unsigned tlen;
+
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
+			/*
+			 * Don't propogate trailing nul bytes.
+			 */
+			clen = strnlen(cp, clen) + 1;
+			llen = strlen(hp->lsmid->lsm) + 1;
+			tlen = llen + clen;
+			if (final)
+				tlen += finallen;
+			tp = kzalloc(tlen, GFP_KERNEL);
+			if (tp == NULL) {
+				kfree(cp);
+				kfree(final);
+				return -ENOMEM;
+			}
+			if (final)
+				memcpy(tp, final, finallen);
+			memcpy(tp + finallen, hp->lsmid->lsm, llen);
+			memcpy(tp + finallen + llen, cp, clen);
+			kfree(cp);
+			if (final)
+				kfree(final);
+			final = tp;
+			finallen = tlen;
+		}
+		if (final == NULL)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
-			     list)
-		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
-			return hp->hook.socket_getpeersec_stream(sock, optval,
-								 optlen, len);
-	return -ENOPROTOOPT;
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
index fcad2e3432d2..5e7d61754798 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4923,10 +4923,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -4946,18 +4944,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
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
index 7a30b8692b1e..40c75205a914 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3919,28 +3919,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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

