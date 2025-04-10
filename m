Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062731E5B66;
	Thu, 10 Apr 2025 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252881; cv=none; b=cAkJoGyoaxVOq4UfiFFvKbpCoUXO6BjJbrdq4f4m1lcbgSmiP00qBcRbz4eYT63tGbwxrr6XibtiHGPqLWrFZF+KGo11tWBxo+OlGPNTDCJVJtmZvTwhpH2HDdVi9GftIE91Qtn3HB7odQXzW8AVRp1BaaQBkeSXWc2B7GuK8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252881; c=relaxed/simple;
	bh=Wjo7zaf/2eJQlNtPQf299lx7i2pW1ib1d6Jua15gID0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMV+jh9yZ2OcD0Dy1zMdE6qIc3vh76tK1TeP/Fkx8FX53Ii+lOe041KEXYSAABcJiim4E2qQYOupr2TvjegzoBBiajr30YjGdVWAhH098ZMv3sofuSmdqZnWdJAsysQ7lJv48w09a7W6Ex5L6hQYZCXkYnNhO5ICewnLce/h9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NPtOwwEU; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NPtOwwEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744252880; x=1775788880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBEMm5OooTEDmVd7oh39SDGI97foq73Nnmjcv8TLzPw=;
  b=NPtOwwEUieLX67BTZraf4n3eqhHtY6AUeY1TYNvXHAcC8NIEVBq/Q3LK
   DC6qJhAM8GaahOrz1UqVxA5kmGoLdH+OpxeB3eesab4MM/10IXTwK01V9
   POOb4GX1hqRTRfeUUngMkYgz69br23F4eRCsy1HMj5YfChRVzIAXd3024
   g=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="510312527"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:41:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:16071]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 3d3aebe2-8aa0-4119-8ed4-686d8467639b; Thu, 10 Apr 2025 02:41:19 +0000 (UTC)
X-Farcaster-Flow-ID: 3d3aebe2-8aa0-4119-8ed4-686d8467639b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:41:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:41:12 +0000
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
Subject: [PATCH v3 net-next 4/4] tcp: Rename tcp_or_dccp_get_hashinfo().
Date: Wed, 9 Apr 2025 19:36:47 -0700
Message-ID: <20250410023921.11307-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410023921.11307-1-kuniyu@amazon.com>
References: <20250410023921.11307-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
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

