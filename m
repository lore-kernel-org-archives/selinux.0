Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66729A310
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314641; cv=none; b=P1YsQTK8AtcuBq9PLlV8GUddaIPKpTELp4dpGx9a5V57P6T6dR/WA3eqyGDdxUZBXFueLmkCETa2KO4HbVXdpOyMFXqhYpLTRWfuRMzR9XW3WeeifeodL40UcNj0OaNxqVfRj3lfR5EB1+lyZjcBgF2uuSR3TyA5l+dDrsQMLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314641; c=relaxed/simple;
	bh=+ecaELaZ47pteWkMRbUbtYlO7wkcVyEOvXfdKskR4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf3X0PqdTSaijSsCBf+grvIpdlo6zp5AkNOP4Iuk8TA1SWckp44Si1YufYSY8fOzUhSCFGIoaWe6uRC/ini4m4EGit8II6/L/6lQoazd2jHQg13O4tSw84xGcqw46kf/373OnB20wb/mBle+mb5TjQFh70fJndW8Ed45jfyVgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFVXByht; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFVXByht"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4774d68c670so15284891cf.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314637; x=1747919437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COC8h3k279LTx6grzipl5YJGi3UcnInyDaMLzilXQjg=;
        b=hFVXByhtKV7/WkJyuA9yplnhMcLnz28x45fzi7y9zpdXoCFjI9AM0kIhMor4UXjfAq
         jGWz9beYi0EnV9icHtV9cfrCLvozx+Y08cWAtOIKxZdX4W54vqCiWPGGLqyrmu8tJ/7a
         RYTK4QdmeCcLUmVf7LAKMFotY3PLwr3W3cEaCusVlYqzX+fqy9Z+In6cPPsKWZ9TnPZ7
         d8j5Hnu4JQ9ZryTe5/za8Xx6U3pZeDd9is501D/rQU1pZsSYRI3gG+jKtmxQ6nj31OtX
         YbPAW2owDBUJ9fnMwtlqnhcfpGDnQ0He/KZATLS49uNec+qkz1eZdze+zeVJPv6RdGux
         KmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314637; x=1747919437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COC8h3k279LTx6grzipl5YJGi3UcnInyDaMLzilXQjg=;
        b=a8aaWAlWmYG8RWQ3zedj679NsaLsnR8OVNU6Ij0NuHx+3iV9BMqeXSFEROLYpiVvkk
         861b/9BVxZtBtOdSt3rm87y0W5f8S8RG0w/PnJmvl3fuGrm9tM3UrD2WBbobFi5IpZg2
         3pCpaQ0FAkiAPJnDMCCA21tjKUXd+HmokWaz1ZbnBDjuMJ9DL7krpEK05i621dl56lHE
         zu6RD2xw2e+rOZIRnAMKo/FlybcLnZvT/yWAatjGgr47H4cm7uOT7MNLXQQohwXCpbwG
         QDBrCOIsL3yUuWG0I67QTT79uJ+bh8VyCAjlik8oZMkMv3np8b/Tlg1LZBBbnNux7xIL
         I0og==
X-Gm-Message-State: AOJu0YyOcKn4uuRJ0Kz5KhbEgRaPfZ7xOXyMDot7jTT3aByqSvJWjkX5
	bg+R0LiigQComRtiqMwaPe1RUXcOMkc71mC0lzY+NhHzsJxJ6OVu8k+hjw==
X-Gm-Gg: ASbGncuOj8vggxxY9YJkXD3RZiuVw1P2qivgKVF/quJJcN/h7lt+eDTaqF/jVzuSYDh
	05euerQB9BUY5zI7rmcqx4ZfAtRBApiDs9N2N3HyAUzOZiDUa2afqxgdvvfgQsu2G0xW+DZddHT
	8tIo3V/ejn/ZtoDqUmLBZj2G6Bg5esipg/ySNRWdBfcbQksqxLE4N7tWickBGTNTA3TckercT/S
	r5eUZRDhkjefkt+FSa74EACBcIGQepPSL0m0yggDyoRlpMGMDA+DZ4qr+5qGn7Fk1Sd3dkWHr8+
	wC6FXZqWUHOz/6F3CQxVIZFn4t1JELsLoeIMCJPS8puqVBXeEFjj2YZa9m2brS3MaxlZOBZAmhz
	vsUGTTa3Ct59/exaWzGP+N9dJI18n9E03MyGimD3nu3T9rA+32SkKCDg1cTystw6m
X-Google-Smtp-Source: AGHT+IGfUVf/sflq6VBhAIcJQwpWhGtUNiBFH2kaQobMdA7orOLmeeAFp5HMuQU+BFm9/AngDzRBAg==
X-Received: by 2002:a05:622a:a08:b0:47a:eade:95eb with SMTP id d75a77b69052e-494a3435e88mr36697361cf.40.1747314636724;
        Thu, 15 May 2025 06:10:36 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 24/49] selinux: convert additional checks to cred_ssid_has_perm()
Date: Thu, 15 May 2025 09:09:22 -0400
Message-ID: <20250515130947.52806-25-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert additional permission checks in the hook functions to
use the namespace-aware cred_ssid_has_perm() helper function.

In particular, the following hook functions are updated:
selinux_socket_bind()
selinux_socket_connect_helper()
selinux_socket_unix_stream_connect()
selinux_socket_unix_may_send()
selinux_msg_queue_msgrcv()

In each of these cases, the check is between two object SIDs
and does not use the current cred SID.

selinux_msg_queue_msgrcv() may bear revisiting since the
source SID is the SID of the receiving task (not current).
An alternative would be to use the receiving task's cred
and the cred_tsid_has_perm() helper for these checks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03a61e511309..c70c228095b9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4949,6 +4949,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -5030,10 +5031,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 						      snum, &sid);
 				if (err)
 					goto out;
-				err = avc_has_perm(current_selinux_state,
-						   sksec->sid, sid,
-						   sksec->sclass,
-						   SOCKET__NAME_BIND, &ad);
+				err = cred_ssid_has_perm(cred, sksec->sid,
+							 sid, sksec->sclass,
+							 SOCKET__NAME_BIND,
+							 &ad);
 				if (err)
 					goto out;
 			}
@@ -5071,9 +5072,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		else
 			ad.u.net->v6info.saddr = addr6->sin6_addr;
 
-		err = avc_has_perm(current_selinux_state,
-				   sksec->sid, sid,
-				   sksec->sclass, node_perm, &ad);
+		err = cred_ssid_has_perm(cred, sksec->sid, sid,
+					 sksec->sclass, node_perm, &ad);
 		if (err)
 			goto out;
 	}
@@ -5092,6 +5092,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -5170,8 +5171,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
 		ad.u.net->family = address->sa_family;
-		err = avc_has_perm(current_selinux_state,
-				   sksec->sid, sid, sksec->sclass, perm, &ad);
+		err = cred_ssid_has_perm(cred, sksec->sid, sid,
+					 sksec->sclass, perm, &ad);
 		if (err)
 			return err;
 	}
@@ -5272,6 +5273,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5281,10 +5283,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
 	ad_net_init_from_sk(&ad, &net, other);
 
-	err = avc_has_perm(current_selinux_state,
-			   sksec_sock->sid, sksec_other->sid,
-			   sksec_other->sclass,
-			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
+	err = cred_ssid_has_perm(cred, sksec_sock->sid, sksec_other->sid,
+				 sksec_other->sclass,
+				 UNIX_STREAM_SOCKET__CONNECTTO, &ad);
 	if (err)
 		return err;
 
@@ -5304,6 +5305,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5311,9 +5313,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6427,6 +6428,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6439,13 +6441,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid,
-			  SECCLASS_MSGQ, MSGQ__READ, &ad);
+	rc = cred_ssid_has_perm(cred, sid, isec->sid, SECCLASS_MSGQ,
+				MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(current_selinux_state,
-				  sid, msec->sid,
-				  SECCLASS_MSG, MSG__RECEIVE, &ad);
+		rc = cred_ssid_has_perm(cred, sid, msec->sid,
+					SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
 }
 
-- 
2.49.0

