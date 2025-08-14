Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A563090D3;
	Thu, 14 Aug 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178059; cv=none; b=a8EIwIKrKRj4/CatGkVYycz/2RNqwNNdibvGhv1CbBuO/NUEDkMIg1/bjADCtejkmMHN4s8jgosA79iBZ1vDg5WZp92d5+6Af38xD2WfVUPyOW1O77CqxZZB5p+WAWfVo9+PnCPoNG3Mp5HLA641tPA/hQmSWumqd6h5p7IFaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178059; c=relaxed/simple;
	bh=3440CsceTeUvLVpBpxbzPrhQR2AnlizhRtBeFfEtneg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHCqB5fWJLpJIV/SBWyZUPMOJhe1kOqgYndGlKllH2sErIIaZvDM0yT96OE+9kS45EQr/qYazSwHqtcNH9qY/10o4XMKAUKh8Jh3CxQYYT269sm2RbZCk7m0ytXYHmAmrqH5Lm/Lf5Jkwb2tIwiYznIGcg34Z6tLodioP7zK0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K38Upp3l; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K38Upp3l"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109add472so11103751cf.1;
        Thu, 14 Aug 2025 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178056; x=1755782856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnTqC002fXILQNw4QFwFX3/1itpx+ZO48R1RVZNqhxw=;
        b=K38Upp3lgNU63wWY6vs5bUg56SqZyygbZbwluFK9j1RUj6uTpPh95Zlu9ggoMr+wuq
         tiavpMstxLFsvDtIE3hc6LIECy1llIpPYaDw/k+dOiP0GD5jtHBdGEZEExbD5QYz0vOM
         DHFSkVoRUBVHvL7W7ay8oLP5QjnGKWT/26IAud2Sw8bB3nOjiWK8yKhWyW6+JDVZ02C1
         9hBh+/UP5h7JdAuTlkAn4i2aKuIdbegFLtMr+OH+PdeR+sqPvQzjh6zajbcxm1Z24Zte
         hx/CLHiuOJYMeWWbaFdZHkXJ+OWWeym1DZtTyyR0sTgIZrFYLCkdRTf1M2Q5kdthxZY8
         60HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178056; x=1755782856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnTqC002fXILQNw4QFwFX3/1itpx+ZO48R1RVZNqhxw=;
        b=JO5UxWSden/hasHJRQ8wFfFg/YOyQcN6Hvwpr/4fMmNoLSMBvDbaBPxGDB/aKz/9zS
         CvmodNrwJC7s44K/EwafEl+Ey8T1Z3pSxA+vS4K0DdFPXBJjU1Y31+m+OYKr8UNftvcM
         UZaLxZUwRkaCpKApLV/5YfFtrgENfsDbM6X6Fcwny65RCTzZ5VUmKWKFBuDPidNzsMNA
         GsvgAV29O08VIaXC3WhEMfSlGKQ0mq9sekQZPG6UvjkhlsUliQd/QUhy47nXCpW0JlC/
         yjEPljGmBf1A2htuAmvfs6FoKlN/Zlu1vc4xJfEsDYeyj+U6fDEuCtFW3HwNqayG8/qc
         GQnw==
X-Forwarded-Encrypted: i=1; AJvYcCWlEp2u1j6gsDQGcl1BICnfZfOpRr1TpEGc07bzBGonqkJyKHCkiG1gOmdpDGPLCgCqtCioceA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ENEN2Ul6VmpmoojUvV10xqjLZfsvb0xhBDmKQMG/Uud7lr9L
	zwdEikPbNQQ0GYs3TjG6WeYwlxUznezAKQbb7syfFfzmiozmpe0X6qMyocso1A==
X-Gm-Gg: ASbGncsFFFaUIhnkscYAcb+zygirCcS6iiQZtEvUKvys/Sj4TCrMvoSSeGykgQy7nIQ
	slXxEvfMcvnJIqhyBAMudJRkkm0hCveyXBinOQVL47fXHWrzyaci0Ne0fLXaFipUDv7Pdy/LfiW
	Xi8Xb2iJTo2cQ6Q2hXyx/V4SLFxxFlbG8JwMZ81H5FRMGoM9alTLMHeVxRckga82R5dJpEN9GWU
	Foz8ObBm9wuC3HvY7KLCtUsH+3UIHvcfrTQkNz8jw1Uh4wzKi/tflHoUYlOq1Pr6Jge80aLNJ4N
	UhLo7iK31w1NrowTrCo/SBY3GYKgTx/4r/3effKKkc0oEUx1Mqy7nhNiQ/U5UxYlVC1txKoLuUT
	y30xbmysATsxB2Bh/Zf7CBDNkDs/s4cXeEvYJOg8H0Ez0bZOeRCc+jWtFjqNmplIMbwHNZNTek3
	4GnnP0n37p0QgMPW4WjVEg+36fpQ==
X-Google-Smtp-Source: AGHT+IEF73CJTRHwENv0cTVdsm7CY2aIBX8uYRtimlrVJYHtITKgF5+tHhxCoQCznEcO4NdhPnupLQ==
X-Received: by 2002:ac8:594f:0:b0:4b0:6b76:723d with SMTP id d75a77b69052e-4b10c394137mr33914491cf.7.1755178055774;
        Thu, 14 Aug 2025 06:27:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 33/42] selinux: convert additional checks to cred_ssid_has_perm()
Date: Thu, 14 Aug 2025 09:26:24 -0400
Message-ID: <20250814132637.1659-34-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index f229a8099167..71ccd86c5303 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4938,6 +4938,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -5019,10 +5020,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5056,9 +5057,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5077,6 +5077,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -5151,8 +5152,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
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
@@ -5253,6 +5254,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5262,10 +5264,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
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
 
@@ -5285,6 +5286,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5292,9 +5294,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6417,6 +6418,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6429,13 +6431,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
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
2.50.1

