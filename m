Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D42F005C;
	Fri, 20 Jun 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441548; cv=none; b=KiULUzk5cGg2zhj+O9sSkPk7CJok/kxFc6v7yJsNvyVl6lX4zxJbxtxGaTAy45b0v/nDTXW/AtK3mOoa84mGenePWCf9qV0PfbNHiAxvgrXlTLaRQz8XpGj2oGdzH3QPRbJ4RG3nyVVBRQ/A0TuozooHOi8PH2yGhJ+N9YHcABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441548; c=relaxed/simple;
	bh=WuvshWj+bi7vWYkoFD0GaBUDjMNK8rFs4dQXrU0tT04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGRi4qzRkVJDJ3UI+bUCIMsemWRGmVfH10r5wMRaW87MEw0Qo4kAq6n9tfKAAN1JfCfOdc/SRI/tMxc8zFfbRzdl+GDbs3lXgTLXRLpJEV4Uh2kxvXVOM76j1aWeJ6EhoWuFco6vmQ1Gh6Tf1CE/gKLHr8W4WO+4JGN0OWK6z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhVORebl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhVORebl"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d094ef02e5so215223085a.1;
        Fri, 20 Jun 2025 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441545; x=1751046345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjS3EXYMa9F7RuVH/zbSNQI1VIJQ4LgXqU3PS6ydUJA=;
        b=OhVOReblrAAGphh/D4NzkSuPocbf6AdtEi2MoyicpN8b9yOpFIyLHM0ZLd0DZnMrR0
         Z0HqY0279uO9eDbW7Y3ZDdJUqq3WByPv/0w1y25Ab7WTOLYye9YuxQ0mMt5zhfkZyGdj
         l3vxBu0S4/I9DWQeqRWRW1rRK8+haJbPEuDHcM6j9rBXEvkmppRD4+ckFnhmQNEOn2o2
         B++nksxCkOksgunUz3YqhyMr82z4d2Srq9E0lpnZPwnHYJhnYODgC5THogC/QCOEZuN1
         7IDw9eRbKEVKPOHoYLzVI1swtGoh8hh/fhFzKWE3CWbUY4KBP4qi1Xv/8MnXJY5L9b9y
         0etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441545; x=1751046345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjS3EXYMa9F7RuVH/zbSNQI1VIJQ4LgXqU3PS6ydUJA=;
        b=LEgZQNxQs8h/YV7XmwPIdTVheAUof1Mky8MSL0DbQ6zWByqmFwVwYCgtrTQKb1Hak+
         fZ747yrG1TI7FaKs9o36y28vKiRAVEcwZqLf44TazbzSJxCKJa5H3KN2YYV4Jbs5HbkG
         0ioygHwnMKhpOzT9PqlmgTjNbguU4gL8KX6Eah5Km8vmZOcEnQaNj+2nv0u/UwhxSGmv
         Y3NCHq0nNLwUx+sKoppP5h+wz9/w6wWZJl0pB/yASVVdOAY/DS3jDDzJTtFzyQoCyrzi
         mOtU5RH18a5kOVX1gekipUDPdDkWVwXFGnYj7nEGtQlcGtKX4GmxWAkX4RkxpUW2mITu
         qLWA==
X-Forwarded-Encrypted: i=1; AJvYcCWut024f9G73s2wq7jdwC+HEQaIiGq0rB7R1JsgIuM6HOtj3KmZwB28DsO+IpLCc4327Fs8Oy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk11Vjs9CX98qv5c4iBlBhb4Wj4An+6P/QWe362Cf5WNK5UQvN
	IAijAPQ1yjxhuuIA8pvX5u0tfyQW2F98s1FqINZsu8J7GY8223I2f1elsJL+Pw==
X-Gm-Gg: ASbGnctsfFzzCy+bFKK1IvcYbKza0cZWigrxFPMaztVvmSWI2jghEYB9945almM3UgY
	Mo9fBv+1zAopdK8z9lSPGKQ5NAvZTNW8RqhkiI/wdXZa/jvzB5by/1LnevqYr5G+WqraoNUwi4C
	Q6m2Lo+zv1bmJFpPZpcex+qzB5Xe19uluZWBib1Q3Ek8GIJKFbJFOrKFOivQNyFNePz6wViQFE0
	i0kKlAp561P8zpfGLEqdYotlmirl+3iQDityXpQ7/ojO7ubnrzBei14DQKVtSi7VrWW3mgVQzJu
	h1o0Cr7rYbFv1fUqJ+nnDvV+xrIgpBaiNTYiSUBFOYJ7EiNUvvp3KZ0Rncrq0hF0a7M08Exj53Q
	bZkjvLLttMuPFvcVysPu0S64ygagc9H975D6dHMGZUNB08XG639TIn0rdVqpOe1hAqQ==
X-Google-Smtp-Source: AGHT+IGWvnDpRIecg9wpq7gmGbmc1HuqQxp+4zPzR17DtNEXSkIByUEtmUQJN18LOC38aZFfY7gQnA==
X-Received: by 2002:a05:6214:2247:b0:6fa:9a9d:fe93 with SMTP id 6a1803df08f44-6fd0cb7f3b7mr47680356d6.21.1750441545532;
        Fri, 20 Jun 2025 10:45:45 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 33/42] selinux: convert additional checks to cred_ssid_has_perm()
Date: Fri, 20 Jun 2025 13:44:45 -0400
Message-ID: <20250620174502.1838-34-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 2b83fe093db5..27efe6f05d65 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4926,6 +4926,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
@@ -5007,10 +5008,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5044,9 +5045,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
@@ -5065,6 +5065,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
+	const struct cred *cred = current_cred();
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
@@ -5139,8 +5140,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
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
@@ -5241,6 +5242,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *sksec_sock = selinux_sock(sock);
 	struct sk_security_struct *sksec_other = selinux_sock(other);
 	struct sk_security_struct *sksec_new = selinux_sock(newsk);
@@ -5250,10 +5252,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
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
 
@@ -5273,6 +5274,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
+	const struct cred *cred = current_cred();
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
@@ -5280,9 +5282,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(current_selinux_state,
-			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
-			    &ad);
+	return cred_ssid_has_perm(cred, ssec->sid, osec->sid, osec->sclass,
+				  SOCKET__SENDTO, &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
@@ -6405,6 +6406,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 				    struct task_struct *target,
 				    long type, int mode)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6417,13 +6419,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
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

