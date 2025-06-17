Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436A2ECEAB;
	Tue, 17 Jun 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169209; cv=none; b=UzvI0haslKDPJ2EoR/uLN6B8L0Dvo0gESzxVoddt0KZZ7/ycdSBfYWajYsWRDcEoVamll/z+wUEEtUeOHY41CfGPskh3KUggjSAnylBuZ+F1/IER/HOBHak9NoaQoMgJCVd8i5OUUvpUqatDViWZPebuZ1zfkoCMfLoaZqHNYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169209; c=relaxed/simple;
	bh=qBj/obOoRVAUiPQJvUSUywmm4kNmRvpfSBEUaXVkCkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3sKaksTYmYH9mwHwF6LaZZdkF7tLXJWopBh5c1WSLZ9wY/buyh7pe6fzjQv8lEeQ0FuGy1yqxzk4MDAbojn6zLHunnqQA0x9eoAWmh/ageEJ+gISHYo4J7YptQyQDa9zTEjn63+DTM4+SIR41hiNj8L2cdBs1kitOPa9B0qREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtFqkbh5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtFqkbh5"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7cad6a4fae4so1130513485a.2;
        Tue, 17 Jun 2025 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169206; x=1750774006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlEW2ofIl9T169JsWt/h/1Ej2Iw69gcklETM/hbfFZk=;
        b=NtFqkbh5U9z2YG+qePkFN9jkKRoTHvpZRdKpfBg9LbHvAr3BqqA7no8+3OTzj1J427
         7BtEe8BNghmviCpICIAKpdFX1DTtOpXAoFzAGBQTi5aBxif0h+xdWqsD+aqNe3E/O2DL
         GEfIQh2UeGRajndDy5yVO+cOMp0REDTlYr2IySs34VqFkFWhtPwxaLreLrpsPtD3cNfN
         3FC+YfVVDJIutmyJMeybXnvcWVPmI3tLyBj6WtozZ4At3RRKYKkmP0ITiT4bMsPmlxcC
         rKm0ubsW+e4mLTGTe8st7Wa93wvKBqWH8yN70cDeXsnQMOyclts6Dn7gwoocYfk/zZnC
         kTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169206; x=1750774006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlEW2ofIl9T169JsWt/h/1Ej2Iw69gcklETM/hbfFZk=;
        b=F6WmKtXGwqQHUQTXIrvC9eQnAenfL51vdx852hb+UDETmD8Z351rTAIHLf4QdMYifj
         RyMMFker6Zx7lRxGakFsxltdVSPYwPi5m06XoDupQ2QTI+Y3dHUK/wO9nm5ZJpHbrfM6
         dreInsNillg6kGSxuF4Xun/7MndhZbuoNHg0SfPui9uMUx10+W6w2GT9IeKoBqP6KUVN
         nNnWbobeePzR1/jyxjp7MRi6yceS2IzfuiWV8P7+z5pJxxiS6kOqHgguNQaf9u4rit/Y
         s6MQWAcEDlBCMNbwqIwlN81Wh+OqTcEHg0W8ECk7oB5D9CFfmkkvaiKc6zWXh3VQJiej
         MGHg==
X-Forwarded-Encrypted: i=1; AJvYcCU/mkUNQWs+NqKkwr7sPCFTvmpg3KBst0FmqOt2MoQAnuE7oHhnzvkUgReTfXnVMlqnPGTEuK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Zky0rWlKHLzWtUO4zMB4r99jVaMIJEjLy4cbBw/Bx11LUm0I
	OBWrhsuzbZePcCGySq/Tze4uJhIwUVqO8AyyU+s14grb6CcK5hEdRm/rxVfSxg==
X-Gm-Gg: ASbGnctGBcOLT6j+J6JiKNH4CiTq3q7YTsJJrpnyC7tr+UdDtVt7R+A9+JRjs9Ib7pS
	bNwbTV5D/mbBELC3wiiG1xRsB6SsQLZo4DabFeltf3ktSaM5FGSTjTZjokBahX+XJXnW9UXnE0i
	zJI5Eas+acbu2zZfYPDCC4co5covrb45Ot2L9GybcMZ7ENuAeUBqegQKz3gv7G1aG17J5j26FT/
	uzVqvgPNgPiiervHZHbJWERPIHQ7IVw1agQggDDig3oPGfrE7tQeQ9WejxA8TQk7T8lBIINIb5B
	JMxFIFq8lD6HCvEMSW+jof7IxiIwMMv2ZmuAGxzAGhlguNnZ1a1K25ePlzCri+SYRUdbQIblrLS
	p/8USfwDpBz9aWs1i5y0wxoGCWfN95dYEYwHf1ClmHTXYVQZWj8ndohviZiJSGIXVwuSmFAeZSQ
	t5
X-Google-Smtp-Source: AGHT+IHFRBAKGVs9TR6OG8Xp50o/dAvr6VDq59OHHTH/X043jZT0Xdh0muU7Xsz6RZmpMUWIzRkrPQ==
X-Received: by 2002:a05:620a:f05:b0:7ca:e971:8335 with SMTP id af79cd13be357-7d3c6c043c7mr2623051585a.8.1750169206246;
        Tue, 17 Jun 2025 07:06:46 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 33/42] selinux: convert additional checks to cred_ssid_has_perm()
Date: Tue, 17 Jun 2025 10:05:20 -0400
Message-ID: <20250617140531.2036-34-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 40d76586343d..8ea1402bd84f 100644
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

