Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E4DC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE721D7D
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V54vxbXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfLPWi2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:28 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:38154
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbfLPWi1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535904; bh=MzhgwfGoe8mx2emDrYG5Bp5l3ssUaRF0vCPHkk43PjU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V54vxbXpK8HrFHVyGS4OeZjiTYeiryQikwOZKUgb8otuhOUB3rShgePP77YuzQvgFkSiHQbaX8L81rHMwFmx3PUqJufgSgjybKUDN6I32PeqJf75zPkoOWhpztNGQOAofk5cVSqvDl+D6qQgYzH51i1RXm1YA9Qb0NNo7cjoeHbi65sPvpwPvKwVIYy2TW1IbKkUoPVbKmrwLn2NoZ6D6HFZQXp9ZrWHg6NIniffDGcIIDDGXzbD68iOzXfhcFokAf3AtjFFBs3hOTbucjwFEVTDbz1Vak00Mj5aDR78f+4o/Av/W/ATfImB9di7EQ/ME+tNqGhURtWhW5E8X3QnWw==
X-YMail-OSG: kkhjG10VM1kPYxBuh5BLPtvr6mT9g_0Y9T0R.6_tbalAVkfdeFPLfmg6cyLWUiM
 VRlajXy1QtdgRqJCAOM7xfQNtVISlurD8X8CmAr046s.75S6TxS_s6yUVeKbDyGhytgUWdMgw1XE
 bzJG4VV_8u7hCFCKbhJ7Rn4cePMVvbZuqHJxJkYHjtVXHTgQvlcMOzKifAGChuOc3eDwUBClL9Cd
 LirhABswm_bw9nP1.PQCvzRzFyukdyrhpRPXEfHI0qnIftcs8dB5LhskclSNdryPZQb4_EKwnZmH
 7MheeUOd26XvSNuP_l9kK8r06MzgL.wSwIntHboxxOQU5nLmoG4ws5VwWE22JK3cl562CHAliIOi
 V6dYMaNqjmRH_87PvnWZ77j07mBbvtqbQ5dDZSwWkIeKlMa61hgVUZX1nAHJDO5_jOFT_pfPQH1.
 7jX78FHKrXCc8dEjbRoa4V8fxr8L0NraMdfx6azkvS0cBdaMgKUblqza7KTyxGVHEuUbxsuFuU2L
 YBynOkroRY8SwpKS60P.otHRwmDN5fozFzA1tWiXzHGpCiay0PrCpX2d38is_Z090G1zy6oVnKWL
 J5PvG.0CJCiGa__gSAcawXkdzYF24TvLe81LQj455tLuH3oUQT9F7WSsU58ezHNBz58OXqtQpFEP
 jRmf9piS6vCYsUArBklbZbnNlv1IOfcSv36D6F9I_eu6ufsLDw2I_QXtTay0naPYtviRIdtMZfiB
 knDUqtWDEw0C56Z41JWGkLDaHQ7wdrDMP2DhANwoxMOBBVxRAUkxRrCjvRi_u008OP9jubHwy9yZ
 HoXBUwbhsaCik8NRJT_3O7LcRdbXSnKds3YVd3Al2RUYkRSP3HnF34ozk9zy3.CsLviE8thJ7m2_
 eP8ufM8_mrhh.DzpNMfQVD6R5wUhoIhxFGKmg5fiizOp6BBo1zmpNfud8iDl5sHcFX1.o7lTnx.i
 q4q0v6v4bVQD5yHrhnlMwxTh3tKvDrAA32i5Vl7xOaDY3terWQKKgOHVFFBjCRTrQ_ljcl931_JC
 .CP.WiQtqRlIyafzg1PcFEpQH1Sy.HC8gOToCXxTa6W30qS2ChAIDLjOh1zGkRRlcfhDqEDZfH55
 aVO0Ec1MWNf5xsli_8gzLJvO5BpWgI9F9cnu42KEaL0Dhsrn0Q6F.R4bGsZOutsLOWoidWLVSrlR
 hDOfc32AtsSrve90AJOfuk3yZqnTzYDhGpjz0exQBuPUHclI5WM7mM3sRLgFz3x1A30TJscXdHrL
 IO7qsv.SWusoa.3ZBkFev_16jAL7nhlDy_SZ4nRZ1a_EQ.O2L4ESITm2bcenvAvBIODnR9XLz2x5
 fGyhlJceALxHNRp1X5Qe_rL1jJjU.nPGxy3WFWJzniLO_7avUFbwIAnOUXCJS2rbWm2NbW6XkPTR
 Ihd6.di6GYvDG2sDCEn3MBUQGIV_gBPTu2I1uwqB9gnSnQn_1mm2K_UrhukTAT99cCgWJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:24 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 93195002d59abd5bf2e6730fba371f7f;
          Mon, 16 Dec 2019 22:38:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Date:   Mon, 16 Dec 2019 14:36:19 -0800
Message-Id: <20191216223621.5127-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index 536db4dbfcbb..b72bb90b1903 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -181,7 +181,7 @@ struct lsmblob {
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
 #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
-#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
+#define LSMBLOB_COMPOUND	-5	/* A compound "display" */
 
 /**
  * lsmblob_init - initialize an lsmblob structure.
@@ -1400,7 +1400,8 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+				      int __user *optlen, unsigned len,
+				      int display);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
@@ -1534,8 +1535,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
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
 
diff --git a/kernel/audit.c b/kernel/audit.c
index d40f64a47c4b..71151ba2a6c2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1424,7 +1424,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		len = 0;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context, LSMBLOB_FIRST);
+						       &context, 0);
 			if (err)
 				return err;
 		}
@@ -2099,7 +2099,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
+	error = security_secid_to_secctx(&blob, &context, 0);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
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
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 60a7665de0e3..fefd1f2d26f8 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -436,8 +436,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context, 0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -493,7 +492,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+					     0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -554,7 +553,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->lsmblob, &context,
-					     LSMBLOB_FIRST) == 0) {
+					     0) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -1125,7 +1124,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
+	ret_val = security_secid_to_secctx(lsmb, &context, 0);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 1941877fd16f..537c0bf25e3c 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
+	    security_secid_to_secctx(&blob, &context, 0) == 0) {
 		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
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
index d0b57a7c3b31..1afe245f3246 100644
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
@@ -2196,7 +2232,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
 	 */
 	if (display == LSMBLOB_DISPLAY)
 		display = lsm_task_display(current);
-	else if (display == LSMBLOB_FIRST)
+	else if (display == 0)
 		display = LSMBLOB_INVALID;
 	else if (display < 0) {
 		WARN_ONCE(true,
@@ -2246,6 +2282,15 @@ void security_release_secctx(struct lsmcontext *cp)
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
@@ -2253,6 +2298,7 @@ void security_release_secctx(struct lsmcontext *cp)
 			break;
 		}
 
+clear_out:
 	memset(cp, 0, sizeof(*cp));
 
 	if (!found)
@@ -2389,17 +2435,67 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
index 7349ce263759..7d449188ca16 100644
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

