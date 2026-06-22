Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C330F95C
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162216; cv=none; b=NxCi/Hy1h3E9Kcb71qFRG+82lkRhXjHi5JxzVhonB14F2eRiuTOB33kXWdySOtfoPxDjwU3oAACFF9p9pWDR4Qr03B8XrsP4TQsvf8KR6sSfR2XIuTpEKVU9QXVfSlpab5EozfdfyPOmNjRzOVn8My7N6aGhzrQ9sSVHbEpIjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162216; c=relaxed/simple;
	bh=JqC3pq7NIWbTtr2/fYT4t/8plFRvdglrTV+xjsQtjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyKJ/BUnEuf0wvNyImkEUu6n20ZFmaLh1m9O5N6K3vbLqoHYbAnOJQdP7Jr6WiNX98ujnRF5DnyGAahoabDInU/6AD8szZE7GnbVjMNIvGNvVuTspZxrErG3Gk8ZaUwl4+LBO1BvzvVcUl47Q6BxGvZS3xpIT/X5DkK4446Eupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYZmUNfW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYZmUNfW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-463f1165e16so4807101f8f.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782162213; x=1782767013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+hBnMxhJkO6FDQAL0eqBCFsfSLziGXalyqU7rpqVDw=;
        b=iYZmUNfWGkDg81+a6uErbhY/9LOBD1YpkxGR/QJTIPUghu8pBwdDDyYu3M6p+sJTe3
         rM437Vl30ieukUqUF5kC7XD3oj9Ic2GXwUeSO9eCBy2HdPjmj2d6W8IRil49BufCYslJ
         Yu09PfEW4gXCd5wy68DCOoO998vcybgRJoud56vf5DNTLnZwWPH6bpmKbeE0dq3LlATS
         kRQERQ4LLi85sWi9OZ1I+kZZl96WMyiZzqWGEbMctpWTeW5cI+IMJCWCb6kgsiGIQxas
         cmIfXBXkYxptO2PHPo95jAjN0ZmQFZY5wfFt5VNOs5aTYUQZeVB2el42d6HLGK/Ls47K
         a3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162213; x=1782767013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+hBnMxhJkO6FDQAL0eqBCFsfSLziGXalyqU7rpqVDw=;
        b=iHOpM+c1GtDlAynEPf6R7EBrebypYuanCl5Aa1tFwAhC0qtIJTeuLNTML70MYinPko
         RdLb5y3cGKqBUeLw7M53vSRO6GjKuwVtsFNIBTl74bomBcYLimzZNhHXG5S4syeNHhnO
         jUU28E82/DMwa6aM5jkANH2d39A19sc7XEBc+pnkboS7GoL/CJ4XdQmnrv5hmP6etRSX
         eLhU70mmUSRyzT7INISaf70TW+wMG28fj6mIWAncfMS9HpUAdHxOvwKu9Ff50tBtNZLd
         Ovlo2CpDvH0RDVnrFkIRjnfVqFIh1/fdIvIuHnex1vIdbcqgpWZB7STrnaxMa7lify/u
         tVIw==
X-Forwarded-Encrypted: i=1; AFNElJ+PhOiH4rv2yB6F8vjm2LzPeW3ArYbRXVL6itv7hHzy9/e8ROkcEC4xCrG6cj55CMArv9yMcTk9@vger.kernel.org
X-Gm-Message-State: AOJu0YxXv5kZOzlE0OMSu9yZctdswI6oEZwDAcGgq3JJMveOZMYWcoN2
	HoNrINOjLYWgb+jEkiIQNVJHUeOklc3KIhrFmxZ1wkpGRaJ0YHhe2QI=
X-Gm-Gg: AfdE7clEY9VcKOgDMTgi/pKeJfXyRft3Xah0zDW5hk3m7q1tOoZl2cGuhBOLMt08YGv
	6NokQZRMQCr7xfD8jS5yIhPrULQp9fOrszX6a/L5uvAib3F9rYldzr7nSowoVFieD7UluMYmJyL
	rUy6I/8kaVH7E+9dkLd3J12PLqR4EVmt1HPX3cn+DtQ1SyvYwoRSlIctdL/j+3cBup9EtpcHFZ8
	jkeSg9yGmLDTT//gLOLchvO7/60M1eHbDdrzVrYeSv8GwBNZwXjY2UsMxWzqu4mSvd+G3/+uAl9
	u2GAPGw5L3xo09Dbn4I4kmaijWceuGgK/Qiqlr2uFKVZtRDJ9UOVY7WzpyxLPA225uBJ/VosIhZ
	Nc1HcqFf4JU+2WB5PJ48t0kHiW7oTZRP7YJSpIoRNFh6MgH4abLo+avveug==
X-Received: by 2002:a05:600c:e548:20b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-49240df7dafmr179983725e9.1.1782162213270;
        Mon, 22 Jun 2026 14:03:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245bba787sm198208495e9.1.2026.06.22.14.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:03:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v2] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Mon, 22 Jun 2026 21:03:30 +0000
Message-ID: <20260622210330.3187099-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618232149.1780219-1-tristmd@gmail.com>
References: <20260618232149.1780219-1-tristmd@gmail.com>
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
Changes in v2:
- Refactor selinux_socket_bind() and selinux_socket_connect_helper()
  into sk-based inner helpers instead of adding a NULL check on
  sk->sk_socket (Stephen Smalley)

 security/selinux/hooks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..aa58a17da219 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4994,9 +4994,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -5126,13 +5125,17 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
 
@@ -5221,7 +5224,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5706,13 +5709,10 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
-	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5741,14 +5741,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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

