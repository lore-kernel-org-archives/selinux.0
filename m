Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589961E25F2;
	Thu, 10 Apr 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252808; cv=none; b=cqGl4+QnuMWi2na/jIfGyC/5EuEU6S0HbdmHTwmXoiBqmwPW5SV9USCjZN4KwmAU93HhsS9u9O+FXSEjYQUkjOWkXjevArPS8Oxc8YV3sgpExZSEimeVk2UCT+CEp/yslizIEtw5AIbikxB5VvzkJgRnmgaC/zTwxuHC8bUJ5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252808; c=relaxed/simple;
	bh=bEWGK5P4YQz95vX7AoQGlfaMHxq3D2mWzsHRG9wcBG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOjFloI/00WsyDSLLZtg9GQzuMbdKpLb6GEYIepcAukfvvbbgGVrqcajfgtuKevOYYZfxG8bJo7PSPz52aK/QsUVgHIXHApvsbX0eXX5eprAa+34Io9aiAQROgiR3pj0/J98tUsDmryXVv6wOn0xmp51vPPazkl3pE106wkIWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dr6otVxP; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dr6otVxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744252806; x=1775788806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJMHaKMJAQ79N46BBPYPRkB0Djr/kL1pa5NBC9LuzZM=;
  b=dr6otVxPt2X7BmC9Itwbp3TNivrvTUvDd/1gQ1qk40yGPjJK93rHhMl+
   /C6QH9C9nr6wH2SiCJlErbtSxAPSic1QNi2wRVmxWB7ZOTxvsS8maDAdf
   ACqlncXsxpOO9QrIYgYylVqt2zwVk2MnD7f+a58bRC90LPSkoLoolkKcp
   c=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="287191780"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:40:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 200848f1-8117-4b6e-96d1-5deba887df3d; Thu, 10 Apr 2025 02:40:00 +0000 (UTC)
X-Farcaster-Flow-ID: 200848f1-8117-4b6e-96d1-5deba887df3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:39:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:39:56 +0000
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
Subject: [PATCH v3 net-next 1/4] selftest: net: Remove DCCP bits.
Date: Wed, 9 Apr 2025 19:36:44 -0700
Message-ID: <20250410023921.11307-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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

