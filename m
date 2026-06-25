Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711633688C
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431624; cv=none; b=dwWUqjQHQjmCurno0TgjhCe/XycJG26Fl/bDhsrZnhjZ+fertnmnXOTYvT8pHRIfJ4qx0hL5oB065ppSFew19Njv6BqldvGw4tuXlxDheb7+UugpTKq87zeVIvr2AFaipm+1ZdQFFM89zIH1An7X2cbkVYagzoMdHW0zILmnT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431624; c=relaxed/simple;
	bh=SZxuankCvUX6ApChHtho3Rt2t5QOrvDbrJtuqI4WIho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=driIl8mehpGKgMhjge/n6ItxcGcBgD2/31KlvDWw9BlRHeUStQtALLAGM85fIWvGdONFzB2LECno1tokh5hAjveRhzf7JaNKIC0P85Ny8BunMgliF6Ttke9r5+6osGabFv2oQ5myfow2h3jKUwSTX0ae7WmUpiyqLaMtBzT8Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3CmUnRq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3CmUnRq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so4340595e9.1
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782431620; x=1783036420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCBP2ycGuS7vhe9+Yccf8aICwkrlxSyd4hD3m1eGqSo=;
        b=k3CmUnRq5EPbTlePoForv5ISjmqe4GFdHdu7LiVNvnPe2GiMtclqQZc+guqUOH1/HY
         llpefpu8NXidsPrY+8Xu8mp0KmIL5ykNozJlrz+iE6H9Jox+fODR1PuvMgDzX5+whUvG
         me4uDtz9PUYpVwbBqoUVq3FMDhOq1B7HPy32lqxZwa4q+SD2ZB1qz+dlXk4a/ukvjJp1
         xiTWqzbCF+cLqBck6v/1OQF/80x4ml7iGNhSRyDqJ6do1goAUsTi9glW3auaQZqXGfVL
         SATwjloPt37S30amez+luikjiOjzMov9rftS7EE3yj0VGJbh6P5v/vu86ojDwEzzU3zP
         CJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431620; x=1783036420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCBP2ycGuS7vhe9+Yccf8aICwkrlxSyd4hD3m1eGqSo=;
        b=nSrck0+ESvykmtFIJ5G5MEttimkkzilmfs8pVqiiVRtFpmo5xQXw9K1VAHr4x792xb
         q/PtSbtEFrtIiHq08AGx95AVln1Np7+1vjuKOvr7xC/5D37dQZW8F5k1NLdm8LlcterZ
         nqTlwA7teo2FprLY1k8hJskR54WpvKwBk44WMp3ssV+O7D//06TOqRtmFpnXq3Jkhox/
         DoHUDYN4j03otOBBg34v3YUUD/OKoXqBXxCite0d1dy32UIY9c6xFbTY3n21bUFqILP+
         Jbw6eb6VQilZKMiYeyGaxvHVDQNIGJG7MyQKNiISWGPQElwYxdZnPoX4SOH+gbCszK1S
         Pflw==
X-Forwarded-Encrypted: i=1; AFNElJ/ocOc8iMH40PqfCx/KlxHw+zOwmQAy/AgwwyAKi3TY+n1M3eHAUg818H4AIpI4UcHfLT+N7Mt/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqg/lMlSvqCueKgdx4+QQeILYXDwqXJhxeJGuanD1Ns0SJ/lQl
	mTD+aw1Rz/4sVKnaQswpFXLJBV1UeUApwGVv+4WsftV6XA9Y2+fg4CI=
X-Gm-Gg: AfdE7clBk+3GP+2K4G5tK//BtPFJw2geisVew3t6LiLdy3+pvd16ge1heSiKuutXVRu
	4piP3msYVTmtWChC9jjmL2OMirw8pqz3bCeF/6bkfmB7EfWu1VgrYsK1cm1vd9cki4UxvODPe6t
	iRyntYJO2k/ZLoyM9SZ6STrbM4dAMJVNmNUv8ingez+T3GV3UcGfrlK6hT7Kb/JR+cY/3iXztH7
	BYfK/uGzOi5mKTcnlixZYqAKcvRIWO9OEJiGKKme7EIkB/9uuIm0Z6EamzlEdHpjEiTrrDaI54W
	b4oD+XM0TMgmij/2eSvsAWcH3/MeE4qpQsm7hsvnCL4EyD5gLMcWH6WjXcdUC0DB04RFPWxj+mx
	dno6B0QqGsoT5sYj2So95m+3vmyKQ1fFsImXogdkEqNSDRYhdNm2YkOWtGg==
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr50677105e9.37.1782431620004;
        Thu, 25 Jun 2026 16:53:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279bc77sm18979840f8f.32.2026.06.25.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 16:53:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Thu, 25 Jun 2026 23:53:36 +0000
Message-ID: <20260625235336.3641828-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
struct socket * to selinux_socket_bind() and
selinux_socket_connect_helper().  However, when the hook is invoked
from the ASCONF softirq path (sctp_process_asconf), there is no file
reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
callers (bindx, connectx, set_primary, sendmsg connect) hold a file
reference and are not affected.

Both selinux_socket_bind() and selinux_socket_connect_helper()
immediately resolve sock->sk, never using the struct socket * for
anything else.  Refactor the inner logic into helpers that take a
struct sock * directly so that selinux_sctp_bind_connect() never needs
to touch sk->sk_socket at all.

Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Keep comment describing IPv4/IPv6 address processing loop
    (Stephen Smalley).

Changes in v2:
  - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
    into sk-based inner helpers instead of adding a NULL check on
    sk->sk_socket (Stephen Smalley).

 security/selinux/hooks.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3..1f202f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4689,9 +4689,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -4825,13 +4824,17 @@ err_af:
 	return -EAFNOSUPPORT;
 }
 
+static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+{
+	return __selinux_socket_bind(sock->sk, address, addrlen);
+}
+
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
@@ -4924,7 +4927,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5409,13 +5412,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5444,14 +5445,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = selinux_socket_bind(sock, addr, len);
+			err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
 
-- 
2.47.3

