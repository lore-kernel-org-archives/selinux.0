Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A980155398
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836355; cv=none; b=FfwJds1WIqabixFej1o+iA8BNUfcTLkFdpMMPID5X5AH/l39sbYQJRCk5vgb0sqNck583AIX83HPnwmCH48tRIi3VQHu0mYYKA1Y2oD0gSGGn1gJXaA3XCaE0I8bg+an5YXXcl/7+u4h6L3pK0/SpG0A2NHp4mQnBtjqNDrAfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836355; c=relaxed/simple;
	bh=Gr6+LLWTf0EU+XQO2/lQPI8CJYWw1H5moDSgjj++l0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaUln0eTul7vnVx+4k71Trqldmy/+QOJWKKRvg3t38BsTWQkhqLQxgdY5gnZ8EKVx2s7WTBkQPBIgPKsVVIo+gnB4ZYR+Orxtd4kspRKD7VOLmC4TESGuPYyGbRCcJL3y08rj6f1ZNreo6MOrImkAAfvZ7z8Fm/GX32HnMJPq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKmssddP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKmssddP"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-468f6b3a439so99973961cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836351; x=1736441151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbFXOwGTguM08dszQds876fBrzafoT6GF/aDBJs00es=;
        b=OKmssddP2/c7/88GF1FlQ9lPj9gNgFl9zAZJ8CvGwzAnBaVY1brCsNVBbVPC8QheGz
         izO8wNdaWEm41dxjL0UvQ7D7t/fOlGVy7lppQMBCNvZ4sDWCAsQjYQtp5/zkhCRyVMJJ
         JYkbwvDpKgtsMiMw18P3oBNkUcQvGeIxeqLoKAjAA9OBmcjjfixyuJwoN+Ry2FxyeH4z
         OxJlkai7rHp58pJJnvoH+aRutJyiIhyz+vdcupU4uNruobtbAGuHKPdpc7z/RpRqrLvN
         ZNEy90ZIY/oVgbxd4x7grygDYoQcnkDG9HASJA+S9A9orU1kWtHVYeJ8B3wLWevHe6Su
         wmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836351; x=1736441151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbFXOwGTguM08dszQds876fBrzafoT6GF/aDBJs00es=;
        b=jAxlZpbOvFtApkoxvngxP3ffgEDwV3ksmXx35ftlw3MOw7SSyumiIv9vgDH0QTSZb9
         1mK+AWf1lqFXRJGYb7S97YiJBR7ToehimKzMTQFagmO5RUD/teB/m66oTz0Bmu2H+2xg
         E2FcRQWnI81AbzP6icQEJunzzeG624x5viJWyURwiVbc5Ny3B7b8Ry39PAOBvyEMbA37
         BUCjvbVrfg/EjY4k0xh6bNmLJ9RQk62Pi+CY9inee5bt+jl2jjEFqy9VaFOV2/qjBiKb
         RN9waUoKSQPGhfLC3QpJrNOhY137IeUJoDle9ZT0G4RamN3t9rgz8nVTe0hRBU2PM+YV
         628g==
X-Gm-Message-State: AOJu0YxgLdjab51Ep2R5OPWx+IT77BGHNm9qNws7gcQBVuwb5LILwmKH
	Q82nNKpN+Nk8hoqrdhixnktThAqdd/WNmkNPDEsj2Xc0+6NfFUUENKv0Tw==
X-Gm-Gg: ASbGncsTnK+JqC1gu4Gq9tJeXTCkFm0PHb6csrPih1rJoHZv8187v/B5Jp1Y2psWwog
	tGkX8Hqi01sC7mjWYydYB87+05eJ9KzVsuAYcy7ll3nAWuk43w5tV7MJXwz02BEm4efgnrEfNoG
	Zre6zcvMvH1h0qK4eMo5INtl3dImADLzYJy2RUl+yvqi+Gue3WdbefLVzdsmytv0vubCKZ2WkOp
	nlm9GSNCqof3Pl9mV4R5lhvHm9VO53peaoSymsyGCVFJAtws3T7xSJN6Y3amm1IuiA0E0RW0lzY
	yu3lDvDqlEQoARrly3VkcoDcJ/dlGho9mMqzrJMBJ9cciXkd/hKXD9/W9T8iDxkqEijS5w==
X-Google-Smtp-Source: AGHT+IEfgvg1E+AskkvPQ8T0qgoGTyrjQWgqP9DUqmEaGGAm0Mddua0X7tJjOL7D2vI8XJgw9F3svQ==
X-Received: by 2002:ac8:5a48:0:b0:467:6692:c189 with SMTP id d75a77b69052e-46a4a8cdda7mr788919351cf.13.1735836351473;
        Thu, 02 Jan 2025 08:45:51 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:51 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 24/44] selinux: convert additional checks to cred_ssid_has_perm()
Date: Thu,  2 Jan 2025 11:44:49 -0500
Message-Id: <20250102164509.25606-25-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index 1619d5c2c187..9e09bfff8392 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4778,6 +4778,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -4859,10 +4860,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -4900,9 +4901,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -4921,6 +4921,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -4999,8 +5000,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
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
@@ -5101,6 +5102,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5110,10 +5112,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
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
 
@@ -5133,6 +5134,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5140,9 +5142,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6256,6 +6257,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6268,13 +6270,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
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
2.47.1

