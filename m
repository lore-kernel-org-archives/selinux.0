Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663A4968E6
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137526; cv=none; b=jb8OlPJxjZXbDJQ15M582z9T9uq9/ekc9pUlLruSmY7PdQ7QkYKgU+qW8se0VHG00eqSt92uMG0MfRppORrEk0JO5lwfKzr7WYa3GOFteVScAdHJbJHDA9Df26YZDpaMOcaa8R51LbCEHxKzpkPcU3RR0WLyIc/6eypevyv+T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137526; c=relaxed/simple;
	bh=2ed4UEKbEmopItTfSh8SaOCg5r2awRhH8sd4+ztqMNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7D2kTGtJJg2IablPGDV6OR///nwHSyV40vUDgvhpwKq3V9JD9nvu3RzyIuPXemO9d9mmXcrFJp3oBE1R2H+9sbXtYr4+keTMNfMh7fn/fFa4zyHgYOUN2940K1qi70DzeAUizrFn9PxscEuYyBRApEnKJJWtKUQbHeYNcTitrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejJX5bfT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejJX5bfT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso42748975e9.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137523; x=1784742323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yexqJ2VzOPF3xR+A+TR1+g93dNh6FG8INE34gePW2HY=;
        b=ejJX5bfTWEuTCXmXMFYt3Znj6dS209YsAPmETnvkZ7reuYEsorqaRP+S6te3S01FU6
         MGDwKxVd/M791OtyVbABfwLHS9bzs79dRHhKAYtAXfRBRsSnoOVjmzsmra0rC0S2QSvs
         1WYfLYcS3cdjSnnSqDCeU/vcAfbMPf/5DObsOlA5yCIaYB5dLXKXze6nJE2G4ueousCd
         6TodzHdtrS1QnVTF09evrv/Apx5ImMVHQO2cn/qT9sRggRmAGXqZ35ZefbPUZIotc/sy
         oC4VytrqjHH7Xv3+YphGv2gekERTMFg409y5fFF/7NrXNGxScaZF1PMEJ+OL8irUsYMs
         /ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137523; x=1784742323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yexqJ2VzOPF3xR+A+TR1+g93dNh6FG8INE34gePW2HY=;
        b=HC0caWqwhU8HiKqwMKgpjDBhe62M44lq2jXpZzKpIVpNifdyfoVP/keZtaoljKH8IB
         4lyU1qzaizUNTrD87RAQL7TuZtvPOnHZ5DCbEhJ1m9c1CMZnOA7gdEO7LKP6mCfIQ1OV
         29GtszeLTV/cjDgDDyVG5WZ5u+Vnj4BsDEWMa7hWW73XmDd9lUlNsg0cCH7xBv91FRUM
         1E1cjfS+xt97Aif6bMihqFoGEHT/Bdcq3THWT44HPEKk94oy68lzjOIeUsvzAoyb5CM8
         gtlcY2z3HeGkUaPk7tYBi8qT6fdSRUL8E+T1BJNnriSiGkwnv0lorxKu1UArbE896ZwI
         YbBA==
X-Forwarded-Encrypted: i=1; AHgh+RrG6xuiqokqVtNXq/ybhpCoDgNlOUoj53mXsvxGcqMkfh3xVMWRl0jaU3Fy+bNnv0VH8TBxaxVc@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcl0TONBd3O1SEqqDtFl6k64a3oeo1deI2Z9J++35T+Z9Z74x
	7wpBXPz6is0QEh33gDIqf0oO6rz8ImYdQi0CrUc/zNo45ImSh+GvaPs=
X-Gm-Gg: AfdE7clW9sRYgvqWmU+/ODbcrEU73q9cKAOnHqdf7y8ZP1dSb3Yfw4XcaXMH6QzepJ3
	fkp9PhsxmF8eJOcBicuAmmuUSvqgNwcHignJYhDYQ5aBzDacv2Asb8iOVqjlf9Kp9KYdLeG2oNX
	AOW/fDwPY7+N1KyieIdjkaBjqkKaXI/uEwOYOZKjqxRlJMG8DCmFlhr7Gg/hMRkbC+sqbGPw1sL
	6gxG4TrSCWWW9D9MhOs9qIkTHpxtDGuH/ee2e0gFZoefHIZcGTHBzdE4ZtXgtuUYvFv1PD/wt56
	jd9J+BkW+8wq525k50gCA9u8ffeEuzJXVRZvsmPZM8jHc+BdWxjTL1cap3M+f/38ieYYLdNcUTF
	FZdPjzA/XeTP3R/4w1MaDcPxgwuttHRicmOE9qSw1IQip+6sMVPvjoap+3cZZxkkxWWTNs70=
X-Received: by 2002:a05:600c:6214:b0:494:1cdd:4f9e with SMTP id 5b1f17b1804b1-4953c27eae2mr40121735e9.31.1784137523180;
        Wed, 15 Jul 2026 10:45:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f462e0cb2sm18260323f8f.0.2026.07.15.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:45:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] selinux: use socket SID for SCTP bind/connect permission checks in softirq
Date: Wed, 15 Jul 2026 17:45:21 +0000
Message-ID: <20260715174521.589520-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__selinux_socket_bind() and selinux_socket_connect_helper() call
sock_has_perm() which uses current_sid() as the AVC subject.  When
selinux_sctp_bind_connect() is invoked from the ASCONF softirq path
(sctp_process_asconf), current is whichever process was interrupted,
so the permission check uses an unrelated subject SID.

Thread an explicit caller SID through __selinux_socket_bind() and
selinux_socket_connect_helper().  The process-context wrappers
(selinux_socket_bind, selinux_socket_connect) pass current_sid(), and
selinux_sctp_bind_connect() passes the socket own SID (sksec->sid),
consistent with other softirq-context hooks such as
selinux_socket_sock_rcv_skb() and selinux_sctp_assoc_request().

Factor out __sock_has_perm() with an explicit subject SID parameter
so that sock_has_perm() remains unchanged for all other callers.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/selinux/hooks.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d6945edae7a..1071c304faba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4916,7 +4916,7 @@ static bool sock_skip_has_perm(u32 sid)
 }
 
 
-static int sock_has_perm(struct sock *sk, u32 perms)
+static int __sock_has_perm(struct sock *sk, u32 sid, u32 perms)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
@@ -4927,10 +4927,15 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
+	return avc_has_perm(sid, sksec->sid, sksec->sclass, perms,
 			    &ad);
 }
 
+static int sock_has_perm(struct sock *sk, u32 perms)
+{
+	return __sock_has_perm(sk, current_sid(), perms);
+}
+
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
@@ -5000,13 +5005,14 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, u32 caller_sid,
+				struct sockaddr *address, int addrlen)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
-	err = sock_has_perm(sk, SOCKET__BIND);
+	err = __sock_has_perm(sk, caller_sid, SOCKET__BIND);
 	if (err)
 		goto out;
 
@@ -5133,19 +5139,19 @@ static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return __selinux_socket_bind(sock->sk, address, addrlen);
+	return __selinux_socket_bind(sock->sk, current_sid(), address, addrlen);
 }
 
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct sock *sk,
+static int selinux_socket_connect_helper(struct sock *sk, u32 caller_sid,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
-	err = sock_has_perm(sk, SOCKET__CONNECT);
+	err = __sock_has_perm(sk, caller_sid, SOCKET__CONNECT);
 	if (err)
 		return err;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
@@ -5230,7 +5236,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sk, address, addrlen);
+	err = selinux_socket_connect_helper(sk, current_sid(), address, addrlen);
 	if (err)
 		return err;
 
@@ -5729,6 +5735,7 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 				     struct sockaddr *address,
 				     int addrlen)
 {
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
@@ -5765,14 +5772,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = __selinux_socket_bind(sk, addr, len);
+			err = __selinux_socket_bind(sk, sksec->sid, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sk, addr, len);
+			err = selinux_socket_connect_helper(sk, sksec->sid, addr, len);
 			if (err)
 				return err;
 
-- 
2.47.3

