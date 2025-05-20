Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D975280015;
	Tue, 20 May 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742502; cv=none; b=tTUMglOABpPtYfhaluJIpJwZi8YAQKyxsodUmFp0l3wTzzXcYyCNJwmImRtUwr4txQWY3RPExexlgOHr/rKlg/FFvPnDiDZ44OjuGs+WvmSh52KDykC7TGyBgzFBUy6637ytNbaFbkBilwNMSHWxdkgkEYkqfkI3Su9BPAuG214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742502; c=relaxed/simple;
	bh=THQNAQUp3F0mGkqcxdaNkmAnyTcEK6OgOU9sPnukggs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvhRyiJPPoSga7txJZERJ6Rj5QrBq5Q3YeVYJRl8GLbhmpxKXYqOkeFv6QantLceve+3l2qJDWLFLgi9z2xFwGc/pYaLPT5czqlyglGpyEsxC0Ehu/Omz+PL8rfS4+J7/NjprwY5idBUg9dw2JXrlBY5gRhJgeQwFLs9T31sqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmcz8N/i; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmcz8N/i"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7cad6a4fae4so914349185a.2;
        Tue, 20 May 2025 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742500; x=1748347300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFePcpPZpX+foP5kExlCINCXv66KNof8YoP8aee+dko=;
        b=Mmcz8N/iEpyC5tuL0xLOPI4Ux9/Cz0gqWVz7ILZskDnW3UVffBk+FbqoWxj0+wtvV0
         Ja8q0hBd1cEZ9MCG/a142Omcu7p2ZFzLu+p2/FY+X6KsZYaZ8CydEyPlliEACt26kE1L
         RA1xEKb6qC4aQuDTiwd3iniCtQphUGecgqxRZSGcSpb2Ap9GgHqzvjFWKWuE+xVGkJUO
         A2TVo2KidIPou4suCnDhM7YcWEEqlX8rRONeATS3hjlBN+YVaq+rsO0cSn2Ek3RD+wVK
         hcj4FPnYUXgJiZKmI2xreBozEsWK+rnsmk/DwN3p4b3WLsDOL8ji8357B/Ff/AtABxrT
         PYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742500; x=1748347300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFePcpPZpX+foP5kExlCINCXv66KNof8YoP8aee+dko=;
        b=e0BQqLKur3xLUrPyVaIuQoEctL2Dmy6H+6eZR5rXsyQqwFsJ/6/mfoTGW0kYH83K5s
         2X5FSOI5ZchCFAGHWgqfecxYd3WI71Jhe86iF6TidLT1NIRsriGznmVaCGtYhSCgttzg
         CKShbViklayc1Vg8EOCEJt7sAU+XvZkK34YVTIxeRseIudu5Jr/XUd/avvMhnw+LWTEI
         vX3DfeS+9Zo1VxAVqJqLkTrsNMtfDXv1Be2oNsR1TnFAJjcLsvKyv7NUq4isgMXQyLX3
         oZWJsHnW2QD1g5juim2EyGys/04+Ijf3cYNwj+kCWCeVPKnZ/5gtBFw15Da5dJOv/wCg
         vwog==
X-Forwarded-Encrypted: i=1; AJvYcCXi6eUcT+5zRswzDWy7USrFYjxcU12TsWbhFrtjCMMkd41O4iZ+/9Vy4pdDxjzY3ivTahFM+UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkNRkcGqlvpIZRP4qBO9bFsJLEvGyKsbnjQ2PIE7Nr46RbDlo
	i0FOJJl0OK4ibDzlr8pVgGJvaA5mpThAqozAI8tVgp2uhkB8IksbsHrg8j+NHQ==
X-Gm-Gg: ASbGnct2SAkR1eK0iuvFTa5XI9Z8NeS1n5fzGQ0MlaO0DevpwcROKrgYwa/9Ca/BLp/
	sq8ttj4fLGOi0fKR23kYSkulUdEQeSbiSZeWHAIGeQQV5Sx90bfygGMFSIcrihAcfXJvG8dzk9J
	yzfqYi4evnqISPTbLUSCAuCTZ8J2/xpKR0Z4PWjf0NkaOMGQyujqNmv6J5rLu17oM3Dmj2Widvy
	UZwIW162/YAcp2LdeaUrnfuDWDgk4oB3nJpyueqpbwHPwqLeFKAFUt4SL1XZ20DeMclrSxUJVzl
	bUNL7sTfMLcWix7YfuHPIAze2UzYx1dzB6bZ5DiMu2LsPmmbRc1e9dXg1cfAUNMXl6sUao3vpVp
	wLvF7FV4vAXksoF8M27BwejT3qdVxVv3fGTogY0Gj5RqY1wdRwBZqHw==
X-Google-Smtp-Source: AGHT+IGBPtU7xKagQZMSHoZsxvdZpWjsoJc5/XKMU00DsqMfOCFNRyd+mIPRapWvvC0BhPpJFLfQfg==
X-Received: by 2002:a05:620a:4443:b0:7ca:f021:4d3a with SMTP id af79cd13be357-7cd47fb274emr1931204885a.39.1747742499743;
        Tue, 20 May 2025 05:01:39 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 32/42] selinux: convert additional checks to cred_ssid_has_perm()
Date: Tue, 20 May 2025 07:59:30 -0400
Message-ID: <20250520120000.25501-34-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 40fdcc3c7f4d..ea07fa492e3b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4936,6 +4936,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -5017,10 +5018,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5058,9 +5059,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5079,6 +5079,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -5157,8 +5158,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
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
@@ -5259,6 +5260,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5268,10 +5270,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
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
 
@@ -5291,6 +5292,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5298,9 +5300,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6423,6 +6424,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6435,13 +6437,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
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

