Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E9269B1E;
	Wed,  9 Apr 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224858; cv=none; b=V508WW7oWhpLbdmJUkZd7NV+a4jujoM9XvBI2UqM2WvxxZUCA0zzdRiFaGeM4cA2J9XLLa6oSBPBgwpad9tk0TIzHYPUA4cyHcyQ8QyjZwRpUhfIoLiB469R+pZ1R3RxGuiK1y4bl1tMz2oBz+S0EF5YKsJWWBRJh4tjqxRF9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224858; c=relaxed/simple;
	bh=j75jUcknLX0EvayT68ZtfbolzuFLvZfJ3QkiyLlvBW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IELTW2mYiVuAILW1rYCX2R4s58csu0t46qyM+IT3+qWx+Ek7Abp94SoMQlqJjjl61wrvRnjswvlY00Cvg/E7WS+CdvH4BYZRCXzSnV6YOPuDtf09mNEdYlh1eJ2lc1pLc5xCOmYMvRXOz0EodkQA6QCtX/ZJkG+AztE20RV1hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ariTeyU2; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ariTeyU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744224857; x=1775760857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Y+ZGykNcdvfvWdA+3QWI9sfVzx1jMsXgVbSk8G1+84=;
  b=ariTeyU25iI/1vG7mNz+BP0it08Tejs6LiBMFfxdVhCka2htodchJF52
   txrW6lL/7kbKP48Rcue0cQfCq9MNleOVOSuqlfwaFLO+tOWQz8qRQb3Ny
   I0tXWpnePTQuIKFqbtQkraio7GRnqjEN3ym6j7MC5qQuSaT8a8dKkvdTL
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="9030907"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 18:54:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:27356]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 0e6f7f6b-bdc1-448f-89f4-2d1d29037238; Wed, 9 Apr 2025 18:54:08 +0000 (UTC)
X-Farcaster-Flow-ID: 0e6f7f6b-bdc1-448f-89f4-2d1d29037238
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 18:54:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 18:54:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <casey@schaufler-ca.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <jmorris@namei.org>,
	<kadlec@netfilter.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pablo@netfilter.org>,
	<paul@paul-moore.com>, <selinux@vger.kernel.org>, <serge@hallyn.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 0/4] net: Retire DCCP socket.
Date: Wed, 9 Apr 2025 11:53:41 -0700
Message-ID: <20250409185356.37457-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409064949.6c992d15@kernel.org>
References: <20250409064949.6c992d15@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 9 Apr 2025 06:49:49 -0700
> On Tue, 8 Apr 2025 17:29:07 -0700 Kuniyuki Iwashima wrote:
> > As announced by commit b144fcaf46d4 ("dccp: Print deprecation
> > notice."), it's time to remove DCCP socket.
> > 
> > The patch 2 removes net/dccp, LSM code, doc, and etc, leaving
> > DCCP netfilter modules.
> > 
> > The patch 3 unexports shared functions for DCCP, and the patch 4
> > renames tcp_or_dccp_get_hashinfo() to tcp_get_hashinfo().
> > 
> > We can do more cleanup; for example, remove IPPROTO_TCP checks in
> > __inet6?_check_established(), remove __module_get() for twsk,
> > remove timewait_sock_ops.twsk_destructor(), etc, but it will be
> > more of TCP stuff, so I'll defer to a later series.
> 
> So it builds now but appears to break 1/3rd of the selftests :)

Ahh sorry, I made a mistake while inlining sk_clone_lock()...

Will squash diff below in v3.

Thanks!


---8<---
$ git diff --cached | cat
diff --git a/net/core/sock.c b/net/core/sock.c
index e76b2bcec33d..e053ab6380f5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2490,13 +2490,13 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		if (!is_charged)
 			RCU_INIT_POINTER(newsk->sk_filter, NULL);
 
-		goto out;
+		goto free;
 	}
 
 	RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
 
 	if (bpf_sk_storage_clone(sk, newsk))
-		goto out;
+		goto free;
 
 	/* Clear sk_user_data if parent had the pointer tagged
 	 * as not suitable for copying when cloning.
@@ -2525,12 +2525,16 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
 		net_enable_timestamp();
 out:
+	return newsk;
+free:
 	/* It is still raw copy of parent, so invalidate
-	 * destructor and make plain sk_free() */
+	 * destructor and make plain sk_free()
+	 */
 	newsk->sk_destruct = NULL;
 	bh_unlock_sock(newsk);
 	sk_free(newsk);
-	return NULL;
+	newsk = NULL;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(sk_clone_lock);
 
---8<---
