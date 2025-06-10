Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8354254845;
	Tue, 10 Jun 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576210; cv=none; b=A+UYFN2VzQzbSi2kJglLSgPTYyJXxeycCoDjgS3e/2FUdt7Ejw9dniY23zbGyNguZnQd2pV25GIZvxiONg2MJbp7R0RK4ayrpGR4YVKCgrqf+A7JwP3ZSWND9h7IKNBRHmlK7OhqCHFBbaD1sM2HfMDIbvceb0A9NwyooIb8tro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576210; c=relaxed/simple;
	bh=Q+8TZdZGz3e03taZT2fXnNlsH8epPWmtT7WesxljjtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6lc9/z6VXnWMGzoCgLJZ/X2ZVYdFFRt1owRDk+NYTHFvsr2urnVlw1NauQBtv1fRvfSq+Udf1j+gjzcouAhF5k70U2clf/00/0Mgf9E/UhFFMWxnEfaaWCuDQDU3p1gFeCV2897IRB1YMTp4tbgO2CBoA70tY6OF0XIZnj/kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL0cZ4Yk; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL0cZ4Yk"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fad8b4c927so51436626d6.0;
        Tue, 10 Jun 2025 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576207; x=1750181007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcgHPEooEzTXlWBJfSnPZFIEp+kcCx0GP5p7v8V9b28=;
        b=GL0cZ4Yk/ILgMruexppiiA7f0XBhFoqo1Yyv2CkjFPwdH3eJ52lSuYcMvCcyS/SYAj
         2faAopL68aKtMNlVqL/mcpO/bgwt4AT54e+HP6ScwKgoadil9rSPX3DsREBWUIh/Zivz
         XRCmPzO1dEvZANfBORu5xgLDIVmGzXlJgfjGPc9lVjybDKRnDb8Os7W8k6mTA73uSWf9
         rduWCaiYgZE3MgkPORsTTyb290Da2tqMXACSnymhrM3zhBDJ3FAvjRCi3Rf0M14kR8q6
         ueBDoWcKIixp9ko4cgLhcXT1A+S77o4pZJjVgcIy5S+zKNvIF7UgzUYR84SmM2LU8Uak
         vt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576207; x=1750181007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcgHPEooEzTXlWBJfSnPZFIEp+kcCx0GP5p7v8V9b28=;
        b=LXgf40liNaRPaeYNqh4LFeily0bJh2eFPWuG1VaLpYyCKOr0/QrJEsWUhvtzuJAn1z
         Bd/BbG4YyWKMExkTy6xCqzeBV91vsi3zLUFiCTSlQVeU3pIAAxv1PVu1b4bqBZWnQSK5
         e0Rxva1FAPEw9Sr6kOtsEBmHO1bmXdXcU5jvo05YnYyM7xoFQCAvgsQCu9BAkROOdTiN
         j86GJawBbKcKTBMzCtf26L9EFK5x+qQ9YoBm+rY3vLMbqLLHm6konfUKrQlg9YopKnoV
         hy8xxrNeZWyCbUc6ubFaIzlG7xVLD1uSynL3iptn1PxynLiutaqnV80Sbwxa1yGk15JC
         j5OA==
X-Forwarded-Encrypted: i=1; AJvYcCWyzLeaRAvqUv/zCkLvw+QYa3Dlk6G3VSovU28Q3JlhT/bO73Kt82E+VDMreO0rKCoyxUXB3ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aAiNjh48lHznC9wDrwOIvdO37n/wJQcBSWbg+AlvXVXvTqq6
	mrgLLSwCfYlIwGwBrbP6hbHvbw3jkcfqBD0AnnzuX0jNZhTOFYMpRXwidaaMKg==
X-Gm-Gg: ASbGncuMyUi86D1A33uWp9F3dfPeykGgpnUAgIwrD1keMuSvBO+6qKFEOYvMgHTLF8e
	m5hfCkC5o+wTLwsfLi/ZwLutFNg8TA89Nxr8rmkI27ocwz/CUEuZf2AeDrDm0n1Skcqvn1Sm5ra
	WrSxwJidd6E4jJwXMQmyJD6ESgvFa8vW/HQaJZyxt+WL3IBNr0YdShZauV6M0obU2Fq1BCanZP7
	jpGbu3JDG+9l5qtg5EFvkEGE3jpeziWpAiReWQm/VvhGFaOyFIF4xHiLW39EfadtHFLyJ13/ABS
	N6L1JEWUsPcSHi0Ncu0JihpQfvfyAgrGm05OrUYzxhLmPoRsdtprgNdiGReox5WfWFIm1KIUXNq
	GbltEc/gOThl4a0fz/zlpUB3wTIdtnJho9lw9CzB0nsWzTG/bmpckwUmPXaNfWkmTog==
X-Google-Smtp-Source: AGHT+IEI/y6ggN56msepJJ3npnWqHobniVC17oJhdX9fO0kCLgtfnBoBmKEwuGq759GwluTymY1NaQ==
X-Received: by 2002:a05:6214:d0b:b0:6fa:c6c0:47d8 with SMTP id 6a1803df08f44-6fb2c3878admr3810296d6.43.1749576207242;
        Tue, 10 Jun 2025 10:23:27 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 33/42] selinux: convert additional checks to cred_ssid_has_perm()
Date: Tue, 10 Jun 2025 13:22:04 -0400
Message-ID: <20250610172226.1470741-34-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index c04eda2f18fc..d13749aa5f24 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4914,6 +4914,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -4995,10 +4996,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5032,9 +5033,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5053,6 +5053,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -5127,8 +5128,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
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
@@ -5229,6 +5230,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5238,10 +5240,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
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
 
@@ -5261,6 +5262,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5268,9 +5270,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6393,6 +6394,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6405,13 +6407,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
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

