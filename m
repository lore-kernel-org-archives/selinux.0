Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96FBE4E;
	Wed,  9 Apr 2025 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158670; cv=none; b=Vzus9NmzdE4v1imDTrX4prSTQ5l9LsCnx4VQCqkl9TzG+2b+EIJKEN0zaKvKcd60Jt4C6st/H3QYOQUtt8B/+NKGRKUvf/gSxpIu32HNXC7UtNeufW+vAFc34N9K19fYCBIznZDI7viq3UB+kXjwxfLs2YFN+y3tbyVoVbo2KLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158670; c=relaxed/simple;
	bh=bEWGK5P4YQz95vX7AoQGlfaMHxq3D2mWzsHRG9wcBG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/cW1C+DYsFoDSsO34shD25t4qbS8rYzSQpniM8jfOwuT5Z5+In5tuaCEHmiS6u4crbrVTJGJBycaNbf0gdUjNnuLTdap1d8NjHl2r2ZwSfn4+AqmL7oDal94WhDNHEbpmOcXt6eGYDhelsyzi/Km6b7P6f82TGaGleqoFJTrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aDsVVVcR; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aDsVVVcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744158670; x=1775694670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJMHaKMJAQ79N46BBPYPRkB0Djr/kL1pa5NBC9LuzZM=;
  b=aDsVVVcRP9L0r29PK/6Xzw1ovya0X7nuOY0cWX4PwjiimGvQlTnSAJ3P
   90B9PeLcxVQ/pWEicyMCEtzHjDj6P5vCHKYlbNWjcIiFqeFvwVn88szRh
   wN0u5jGp4kdEANgiD+5vRsinbqrFbVJO5ofVWxz6Q8Yg+yLrKLHM+mbOP
   w=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="38980325"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:31:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:13252]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 63938e3c-50b3-48a8-ad68-22a6e130dcc1; Wed, 9 Apr 2025 00:31:07 +0000 (UTC)
X-Farcaster-Flow-ID: 63938e3c-50b3-48a8-ad68-22a6e130dcc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:31:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 00:31:00 +0000
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
Subject: [PATCH v2 net-next 1/4] selftest: net: Remove DCCP bits.
Date: Tue, 8 Apr 2025 17:29:08 -0700
Message-ID: <20250409003014.19697-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove DCCP.

Let's remove DCCP bits from selftest.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/config            |  1 -
 .../selftests/net/reuseport_addr_any.c        | 36 +------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 130d532b7e67..3cfef5153823 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -33,7 +33,6 @@ CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_SIT=y
-CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
diff --git a/tools/testing/selftests/net/reuseport_addr_any.c b/tools/testing/selftests/net/reuseport_addr_any.c
index b8475cb29be7..1c43401a1c80 100644
--- a/tools/testing/selftests/net/reuseport_addr_any.c
+++ b/tools/testing/selftests/net/reuseport_addr_any.c
@@ -9,7 +9,6 @@
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
-#include <linux/dccp.h>
 #include <linux/in.h>
 #include <linux/unistd.h>
 #include <stdbool.h>
@@ -21,10 +20,6 @@
 #include <sys/socket.h>
 #include <unistd.h>
 
-#ifndef SOL_DCCP
-#define SOL_DCCP 269
-#endif
-
 static const char *IP4_ADDR = "127.0.0.1";
 static const char *IP6_ADDR = "::1";
 static const char *IP4_MAPPED6 = "::ffff:127.0.0.1";
@@ -86,15 +81,6 @@ static void build_rcv_fd(int family, int proto, int *rcv_fds, int count,
 
 		if (proto == SOCK_STREAM && listen(rcv_fds[i], 10))
 			error(1, errno, "tcp: failed to listen on receive port");
-		else if (proto == SOCK_DCCP) {
-			if (setsockopt(rcv_fds[i], SOL_DCCP,
-					DCCP_SOCKOPT_SERVICE,
-					&(int) {htonl(42)}, sizeof(int)))
-				error(1, errno, "failed to setsockopt");
-
-			if (listen(rcv_fds[i], 10))
-				error(1, errno, "dccp: failed to listen on receive port");
-		}
 	}
 }
 
@@ -148,11 +134,6 @@ static int connect_and_send(int family, int proto)
 	if (fd < 0)
 		error(1, errno, "failed to create send socket");
 
-	if (proto == SOCK_DCCP &&
-		setsockopt(fd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
-				&(int){htonl(42)}, sizeof(int)))
-		error(1, errno, "failed to setsockopt");
-
 	if (bind(fd, saddr, sz))
 		error(1, errno, "failed to bind send socket");
 
@@ -175,7 +156,7 @@ static int receive_once(int epfd, int proto)
 	if (i < 0)
 		error(1, errno, "epoll_wait failed");
 
-	if (proto == SOCK_STREAM || proto == SOCK_DCCP) {
+	if (proto == SOCK_STREAM) {
 		fd = accept(ev.data.fd, NULL, NULL);
 		if (fd < 0)
 			error(1, errno, "failed to accept");
@@ -243,20 +224,6 @@ static void run_one_test(int fam_send, int fam_rcv, int proto,
 
 static void test_proto(int proto, const char *proto_str)
 {
-	if (proto == SOCK_DCCP) {
-		int test_fd;
-
-		test_fd = socket(AF_INET, proto, 0);
-		if (test_fd < 0) {
-			if (errno == ESOCKTNOSUPPORT) {
-				fprintf(stderr, "DCCP not supported: skipping DCCP tests\n");
-				return;
-			} else
-				error(1, errno, "failed to create a DCCP socket");
-		}
-		close(test_fd);
-	}
-
 	fprintf(stderr, "%s IPv4 ... ", proto_str);
 	run_one_test(AF_INET, AF_INET, proto, IP4_ADDR);
 
@@ -271,7 +238,6 @@ int main(void)
 {
 	test_proto(SOCK_DGRAM, "UDP");
 	test_proto(SOCK_STREAM, "TCP");
-	test_proto(SOCK_DCCP, "DCCP");
 
 	fprintf(stderr, "SUCCESS\n");
 	return 0;
-- 
2.49.0

