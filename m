Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9126AF6;
	Wed,  9 Apr 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158751; cv=none; b=YVc78N47N43PliUF4lDWqphMml9kQbdCTJnI2g1xsffX1HwEsITKnjDOD66u9q9JZPd+SpjGBJAzFV5wQpzC4uKZ4ke5tTX2SWY+LWeyVnBHjM/RsMFZnRoUQ1M69iNLa8thUDncLdGsvXClUYuK/kD3kX80H6VZX5Xn4TmfSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158751; c=relaxed/simple;
	bh=Wjo7zaf/2eJQlNtPQf299lx7i2pW1ib1d6Jua15gID0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olTJ4a0bmvB4aBQgH700JJQoh2S2P0YQrOur6EdS8PVihzDdwROrcJLGf6/24j+r0by4jqHB6PiIpO5R14wh+SOjH5dDjaJ75XYuhPmiNi0HCIQJzbHvA1EWktgyIaIeooCg74v0dAg6h0ymRc7xQ5WgrpxnxjQauQTV8SlXS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e7IbFliP; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e7IbFliP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744158750; x=1775694750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBEMm5OooTEDmVd7oh39SDGI97foq73Nnmjcv8TLzPw=;
  b=e7IbFliPFKWQpU69pLTd66teVcpCVXDx1g8b3WnkqvxeKfrtKt/R2a06
   Q7eqWNKd0MZahLyGuF8tnaQ+MUfEmaLu75jUNF+knt5GVHAg2L2eH+bnt
   ZwFWJvFyDAz0joJe11P8WgUQLUswiscvGcckVbiM9wzqKDJPGt3BaryJU
   g=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="814495650"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:32:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:11950]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id a0e848c7-fe84-4151-88d1-f988161098c3; Wed, 9 Apr 2025 00:32:28 +0000 (UTC)
X-Farcaster-Flow-ID: a0e848c7-fe84-4151-88d1-f988161098c3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:32:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:32:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Neal
 Cardwell" <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
	"Pablo Neira Ayuso" <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] tcp: Rename tcp_or_dccp_get_hashinfo().
Date: Tue, 8 Apr 2025 17:29:11 -0700
Message-ID: <20250409003014.19697-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409003014.19697-1-kuniyu@amazon.com>
References: <20250409003014.19697-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

DCCP was removed, so tcp_or_dccp_get_hashinfo() should be renamed.

Let's rename it to tcp_get_hashinfo().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_hashtables.h   |  3 +--
 net/ipv4/inet_connection_sock.c |  9 +++++----
 net/ipv4/inet_hashtables.c      | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index d172b64a6320..4564b5d348b1 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -175,9 +175,8 @@ struct inet_hashinfo {
 	bool				pernet;
 } ____cacheline_aligned_in_smp;
 
-static inline struct inet_hashinfo *tcp_or_dccp_get_hashinfo(const struct sock *sk)
+static inline struct inet_hashinfo *tcp_get_hashinfo(const struct sock *sk)
 {
-	/* TODO: rename function */
 	return sock_net(sk)->ipv4.tcp_death_row.hashinfo;
 }
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a195203e7eef..20915895bdaa 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -330,7 +330,7 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			struct inet_bind2_bucket **tb2_ret,
 			struct inet_bind_hashbucket **head2_ret, int *port_ret)
 {
-	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hinfo = tcp_get_hashinfo(sk);
 	int i, low, high, attempt_half, port, l3mdev;
 	struct inet_bind_hashbucket *head, *head2;
 	struct net *net = sock_net(sk);
@@ -512,10 +512,10 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
  */
 int inet_csk_get_port(struct sock *sk, unsigned short snum)
 {
-	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 	bool found_port = false, check_bind_conflict = true;
 	bool bhash_created = false, bhash2_created = false;
+	struct inet_hashinfo *hinfo = tcp_get_hashinfo(sk);
 	int ret = -EADDRINUSE, port = snum, l3mdev;
 	struct inet_bind_hashbucket *head, *head2;
 	struct inet_bind2_bucket *tb2 = NULL;
@@ -1022,9 +1022,10 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 	bool found = false;
 
 	if (sk_hashed(sk)) {
-		struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
-		spinlock_t *lock = inet_ehash_lockp(hashinfo, req->rsk_hash);
+		struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
+		spinlock_t *lock;
 
+		lock = inet_ehash_lockp(hashinfo, req->rsk_hash);
 		spin_lock(lock);
 		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index d1960701a3b4..da85cc30e382 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -176,7 +176,7 @@ void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
  */
 static void __inet_put_port(struct sock *sk)
 {
-	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_bind_hashbucket *head, *head2;
 	struct net *net = sock_net(sk);
 	struct inet_bind_bucket *tb;
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(inet_put_port);
 
 int __inet_inherit_port(const struct sock *sk, struct sock *child)
 {
-	struct inet_hashinfo *table = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *table = tcp_get_hashinfo(sk);
 	unsigned short port = inet_sk(child)->inet_num;
 	struct inet_bind_hashbucket *head, *head2;
 	bool created_inet_bind_bucket = false;
@@ -668,7 +668,7 @@ static bool inet_ehash_lookup_by_sk(struct sock *sk,
  */
 bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 {
-	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_ehash_bucket *head;
 	struct hlist_nulls_head *list;
 	spinlock_t *lock;
@@ -740,7 +740,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
 
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
-	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_listen_hashbucket *ilb2;
 	int err = 0;
 
@@ -785,7 +785,7 @@ int inet_hash(struct sock *sk)
 
 void inet_unhash(struct sock *sk)
 {
-	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 
 	if (sk_unhashed(sk))
 		return;
@@ -873,7 +873,7 @@ inet_bind2_bucket_find(const struct inet_bind_hashbucket *head, const struct net
 struct inet_bind_hashbucket *
 inet_bhash2_addr_any_hashbucket(const struct sock *sk, const struct net *net, int port)
 {
-	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hinfo = tcp_get_hashinfo(sk);
 	u32 hash;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -901,7 +901,7 @@ static void inet_update_saddr(struct sock *sk, void *saddr, int family)
 
 static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family, bool reset)
 {
-	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
+	struct inet_hashinfo *hinfo = tcp_get_hashinfo(sk);
 	struct inet_bind_hashbucket *head, *head2;
 	struct inet_bind2_bucket *tb2, *new_tb2;
 	int l3mdev = inet_sk_bound_l3mdev(sk);
-- 
2.49.0

