Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AB20E6;
	Wed,  9 Apr 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158727; cv=none; b=Wr3nFEUT9cqbkD1iJochY2Ba/Qr9Tgt7xcEqYvC6wklOhGmoHj3HbpP4LbpaHEsrLrG70069LyHKatV9kZZRK52ngzGpJUJ5mwMaiJkrClpBXbX8TWFpm9V33B9Jv3SDYNPESvurF1cy7pwThDaMX30gQBTLTFs6P/9veT8dRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158727; c=relaxed/simple;
	bh=K4Wev6WVpweyFX5RVrP6j1AiMpfisrHmLp8AIkhj9e4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBrO66ac2LsrD97WEBQb7ezTRcJZMKv14M/6Mm8w0SoNY7MIUwlb0zfNjrdJmQMa48Z00yafiE643+VburYyIkMUsiYBfU/DexqPOpHv93zaqCgLO7HjC87pIX6y6DtrPBN0ArvnIGyPJZhz8aigqZEw6ZuwR5T9iHYSn2LSsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SQSyPMmw; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SQSyPMmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744158726; x=1775694726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mejN2QOFOWfufFNt7SXUJBfkOQB4YUp48reBJbT1Av8=;
  b=SQSyPMmwrzp1NDk6L58I94dwg+/lohOWHesP8Rx0C0jHphVeKVtvdcOh
   vP3VzthNHx5HLkvVcvlRCMEEmt2ADtE5VgnFKteTD4B9BYoCkra13NqsI
   DU4Kpr4zkpuIgH4ez9kB2nei8nMWFBJBw/TtHEpBPUObemy/VF1u9JrRG
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="509956622"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:32:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19278]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id d2f972b7-fc0e-4183-aa12-7ab2c118ac39; Wed, 9 Apr 2025 00:32:00 +0000 (UTC)
X-Farcaster-Flow-ID: d2f972b7-fc0e-4183-aa12-7ab2c118ac39
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:31:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:31:55 +0000
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
Subject: [PATCH v2 net-next 3/4] net: Unexport shared functions for DCCP.
Date: Tue, 8 Apr 2025 17:29:10 -0700
Message-ID: <20250409003014.19697-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

DCCP was removed, so many inet functions no longer need to
be exported.

Let's unexport or use EXPORT_IPV6_MOD() for such functions.

sk_free_unlock_clone() is inlined in sk_clone_lock() as it's
the only caller.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: Leave inet_twsk_put as is for nf_tproxy
---
 include/net/sock.h               |  1 -
 net/core/sock.c                  | 24 ++++++++----------------
 net/ipv4/inet_connection_sock.c  | 12 +-----------
 net/ipv4/inet_hashtables.c       | 16 +++++-----------
 net/ipv4/inet_timewait_sock.c    |  4 ----
 net/ipv6/af_inet6.c              |  1 -
 net/ipv6/inet6_connection_sock.c |  2 --
 7 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..0d13d021ef5e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1745,7 +1745,6 @@ void sk_free(struct sock *sk);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
-void sk_free_unlock_clone(struct sock *sk);
 
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int force,
 			     gfp_t priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..e76b2bcec33d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2489,17 +2489,14 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		 */
 		if (!is_charged)
 			RCU_INIT_POINTER(newsk->sk_filter, NULL);
-		sk_free_unlock_clone(newsk);
-		newsk = NULL;
+
 		goto out;
 	}
+
 	RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
 
-	if (bpf_sk_storage_clone(sk, newsk)) {
-		sk_free_unlock_clone(newsk);
-		newsk = NULL;
+	if (bpf_sk_storage_clone(sk, newsk))
 		goto out;
-	}
 
 	/* Clear sk_user_data if parent had the pointer tagged
 	 * as not suitable for copying when cloning.
@@ -2528,19 +2525,14 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
 		net_enable_timestamp();
 out:
-	return newsk;
-}
-EXPORT_SYMBOL_GPL(sk_clone_lock);
-
-void sk_free_unlock_clone(struct sock *sk)
-{
 	/* It is still raw copy of parent, so invalidate
 	 * destructor and make plain sk_free() */
-	sk->sk_destruct = NULL;
-	bh_unlock_sock(sk);
-	sk_free(sk);
+	newsk->sk_destruct = NULL;
+	bh_unlock_sock(newsk);
+	sk_free(newsk);
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(sk_free_unlock_clone);
+EXPORT_SYMBOL_GPL(sk_clone_lock);
 
 static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 9a20b84dc022..a195203e7eef 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -767,7 +767,6 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 	timer_setup(&sk->sk_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
 }
-EXPORT_SYMBOL(inet_csk_init_xmit_timers);
 
 void inet_csk_clear_xmit_timers(struct sock *sk)
 {
@@ -780,7 +779,6 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 }
-EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
 void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 {
@@ -831,7 +829,6 @@ struct dst_entry *inet_csk_route_req(const struct sock *sk,
 	__IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(inet_csk_route_req);
 
 struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 					    struct sock *newsk,
@@ -898,7 +895,6 @@ int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 		req->num_retrans++;
 	return err;
 }
-EXPORT_SYMBOL(inet_rtx_syn_ack);
 
 static struct request_sock *
 reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
@@ -1058,14 +1054,13 @@ bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
 {
 	return __inet_csk_reqsk_queue_drop(sk, req, false);
 }
-EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
 {
 	inet_csk_reqsk_queue_drop(sk, req);
 	reqsk_put(req);
 }
-EXPORT_SYMBOL(inet_csk_reqsk_queue_drop_and_put);
+EXPORT_IPV6_MOD(inet_csk_reqsk_queue_drop_and_put);
 
 static void reqsk_timer_handler(struct timer_list *t)
 {
@@ -1209,7 +1204,6 @@ bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
 	inet_csk_reqsk_queue_added(sk);
 	return true;
 }
-EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
 
 static void inet_clone_ulp(const struct request_sock *req, struct sock *newsk,
 			   const gfp_t priority)
@@ -1290,7 +1284,6 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 
 	return newsk;
 }
-EXPORT_SYMBOL_GPL(inet_csk_clone_lock);
 
 /*
  * At this point, there should be no process reference to this
@@ -1380,7 +1373,6 @@ int inet_csk_listen_start(struct sock *sk)
 	inet_sk_set_state(sk, TCP_CLOSE);
 	return err;
 }
-EXPORT_SYMBOL_GPL(inet_csk_listen_start);
 
 static void inet_child_forget(struct sock *sk, struct request_sock *req,
 			      struct sock *child)
@@ -1475,7 +1467,6 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 	sock_put(child);
 	return NULL;
 }
-EXPORT_SYMBOL(inet_csk_complete_hashdance);
 
 /*
  *	This routine closes sockets which have been at least partially
@@ -1590,4 +1581,3 @@ struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu)
 out:
 	return dst;
 }
-EXPORT_SYMBOL_GPL(inet_csk_update_pmtu);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 5bf163f756e9..d1960701a3b4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -713,7 +713,7 @@ bool inet_ehash_nolisten(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	}
 	return ok;
 }
-EXPORT_SYMBOL_GPL(inet_ehash_nolisten);
+EXPORT_IPV6_MOD(inet_ehash_nolisten);
 
 static int inet_reuseport_add_sock(struct sock *sk,
 				   struct inet_listen_hashbucket *ilb)
@@ -771,7 +771,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 
 	return err;
 }
-EXPORT_SYMBOL(__inet_hash);
+EXPORT_IPV6_MOD(__inet_hash);
 
 int inet_hash(struct sock *sk)
 {
@@ -782,7 +782,6 @@ int inet_hash(struct sock *sk)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(inet_hash);
 
 void inet_unhash(struct sock *sk)
 {
@@ -823,7 +822,7 @@ void inet_unhash(struct sock *sk)
 		spin_unlock_bh(lock);
 	}
 }
-EXPORT_SYMBOL_GPL(inet_unhash);
+EXPORT_IPV6_MOD(inet_unhash);
 
 static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 				    const struct net *net, unsigned short port,
@@ -982,14 +981,14 @@ int inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family)
 {
 	return __inet_bhash2_update_saddr(sk, saddr, family, false);
 }
-EXPORT_SYMBOL_GPL(inet_bhash2_update_saddr);
+EXPORT_IPV6_MOD(inet_bhash2_update_saddr);
 
 void inet_bhash2_reset_saddr(struct sock *sk)
 {
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		__inet_bhash2_update_saddr(sk, NULL, 0, true);
 }
-EXPORT_SYMBOL_GPL(inet_bhash2_reset_saddr);
+EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
 
 /* RFC 6056 3.3.4.  Algorithm 4: Double-Hash Port Selection Algorithm
  * Note that we use 32bit integers (vs RFC 'short integers')
@@ -1214,7 +1213,6 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 	return __inet_hash_connect(death_row, sk, port_offset, hash_port0,
 				   __inet_check_established);
 }
-EXPORT_SYMBOL_GPL(inet_hash_connect);
 
 static void init_hashinfo_lhash2(struct inet_hashinfo *h)
 {
@@ -1265,7 +1263,6 @@ int inet_hashinfo2_init_mod(struct inet_hashinfo *h)
 	init_hashinfo_lhash2(h);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(inet_hashinfo2_init_mod);
 
 int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
@@ -1305,7 +1302,6 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 	hashinfo->ehash_locks_mask = nblocks - 1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(inet_ehash_locks_alloc);
 
 struct inet_hashinfo *inet_pernet_hashinfo_alloc(struct inet_hashinfo *hashinfo,
 						 unsigned int ehash_entries)
@@ -1341,7 +1337,6 @@ struct inet_hashinfo *inet_pernet_hashinfo_alloc(struct inet_hashinfo *hashinfo,
 err:
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(inet_pernet_hashinfo_alloc);
 
 void inet_pernet_hashinfo_free(struct inet_hashinfo *hashinfo)
 {
@@ -1352,4 +1347,3 @@ void inet_pernet_hashinfo_free(struct inet_hashinfo *hashinfo)
 	vfree(hashinfo->ehash);
 	kfree(hashinfo);
 }
-EXPORT_SYMBOL_GPL(inet_pernet_hashinfo_free);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index aded4bf1bc16..67efe9501581 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -166,7 +166,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	spin_unlock(lock);
 	local_bh_enable();
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
 static void tw_timer_handler(struct timer_list *t)
 {
@@ -223,7 +222,6 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 
 	return tw;
 }
-EXPORT_SYMBOL_GPL(inet_twsk_alloc);
 
 /* These are always called from BH context.  See callers in
  * tcp_input.c to verify this.
@@ -306,7 +304,6 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
 	}
 }
-EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
 /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo)
@@ -365,4 +362,3 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 		rcu_read_unlock();
 	}
 }
-EXPORT_SYMBOL_GPL(inet_twsk_purge);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea..85bf681d427b 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -881,7 +881,6 @@ bool ipv6_opt_accepted(const struct sock *sk, const struct sk_buff *skb,
 	}
 	return false;
 }
-EXPORT_SYMBOL_GPL(ipv6_opt_accepted);
 
 static struct packet_type ipv6_packet_type __read_mostly = {
 	.type = cpu_to_be16(ETH_P_IPV6),
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index dbcf556a35bb..8f500eaf33cf 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -54,7 +54,6 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 
 	return dst;
 }
-EXPORT_SYMBOL(inet6_csk_route_req);
 
 static inline
 struct dst_entry *__inet6_csk_dst_check(struct sock *sk, u32 cookie)
@@ -137,4 +136,3 @@ struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu)
 	dst = inet6_csk_route_socket(sk, &fl6);
 	return IS_ERR(dst) ? NULL : dst;
 }
-EXPORT_SYMBOL_GPL(inet6_csk_update_pmtu);
-- 
2.49.0

