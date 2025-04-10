Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E113D893;
	Thu, 10 Apr 2025 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252777; cv=none; b=YBXecza8cjcSyGTFCM2Pj0ktYNkkYShESf+2Zd/uSFzNcU2UomXrrPq52LppZRESdZfIVekpwe6B4F3IJbbBjOzHFkhFGNXIi2bEIIA95eC6aQ1rC5bf+EEsVB6VdqzyQWHWj8Sbh30BShLlxmjLN85LIBJPZ34duNlC09ocoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252777; c=relaxed/simple;
	bh=ZX9V4mtFaUKvC4nYI8o1KOnuFMhsBGoeo6qVGgd2aZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUg8t6BILa2L1HOJGBmUZNfdyovo1fSNw9fPHCQ/CLK6ZwvAEB7+G/7llvnrCJPMwDUlQJ+GXiFSCg/HNuZkUSZsEe3QDLZDhoNjL+mTXPG2c/p2mWZbvUcSBfQUuel68D42ozunxhRgyu+vZ+g1wyJLeie3VS1aO2fK8KmglP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZRimtl9z; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZRimtl9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744252776; x=1775788776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xglbg1VLF0CCvJHLP95t4oo8cq09RJz6JBkY/MuhcsU=;
  b=ZRimtl9zgU4DH4iOHuZqzc7LkV6R4E9nCT+a1TVNGkGO7Ir6nIDcXOLA
   9qC8IeJot4ticdTxosOR4kKl2FMgZVjegv9zrK0Edi5bAg6O8Dj1IthJT
   Pd+1c6CmQNGO4L6nxhyd0Q6EQkhsPadbLgp5wftiSb3PzdgRdwjf8BOAg
   k=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="39351639"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:39:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:26040]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 19e0e864-d961-4c79-b4e6-2fffe3a3ab85; Thu, 10 Apr 2025 02:39:34 +0000 (UTC)
X-Farcaster-Flow-ID: 19e0e864-d961-4c79-b4e6-2fffe3a3ab85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:39:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:39:30 +0000
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
Subject: [PATCH v3 net-next 0/4] net: Retire DCCP socket.
Date: Wed, 9 Apr 2025 19:36:43 -0700
Message-ID: <20250410023921.11307-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As announced by commit b144fcaf46d4 ("dccp: Print deprecation
notice."), it's time to remove DCCP socket.

The patch 2 removes net/dccp, LSM code, doc, and etc, leaving
DCCP netfilter modules.

The patch 3 unexports shared functions for DCCP, and the patch 4
renames tcp_or_dccp_get_hashinfo() to tcp_get_hashinfo().

We can do more cleanup; for example, remove IPPROTO_TCP checks in
__inet6?_check_established(), remove __module_get() for twsk,
remove timewait_sock_ops.twsk_destructor(), etc, but it will be
more of TCP stuff, so I'll defer to a later series.


Changes:
  v3:
    * Patch 3
      * Fix wrong inlining sk_free_unlock_clone()

  v2: https://lore.kernel.org/all/20250409003014.19697-1-kuniyu@amazon.com/
    * Patch 2
      * Drop netfilter changes
    * Patch 3
      * Leave inet_twsk_put() as is

  v1: https://lore.kernel.org/netdev/20250407231823.95927-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  selftest: net: Remove DCCP bits.
  net: Retire DCCP socket.
  net: Unexport shared functions for DCCP.
  tcp: Rename tcp_or_dccp_get_hashinfo().

 Documentation/admin-guide/bug-hunting.rst     |    2 +-
 Documentation/networking/dccp.rst             |  219 ---
 Documentation/networking/index.rst            |    1 -
 Documentation/networking/ip-sysctl.rst        |    4 +-
 .../zh_CN/admin-guide/bug-hunting.rst         |    2 +-
 .../zh_TW/admin-guide/bug-hunting.rst         |    2 +-
 MAINTAINERS                                   |    9 -
 arch/m68k/configs/amiga_defconfig             |    2 -
 arch/m68k/configs/apollo_defconfig            |    2 -
 arch/m68k/configs/atari_defconfig             |    2 -
 arch/m68k/configs/bvme6000_defconfig          |    2 -
 arch/m68k/configs/hp300_defconfig             |    2 -
 arch/m68k/configs/mac_defconfig               |    2 -
 arch/m68k/configs/multi_defconfig             |    2 -
 arch/m68k/configs/mvme147_defconfig           |    2 -
 arch/m68k/configs/mvme16x_defconfig           |    2 -
 arch/m68k/configs/q40_defconfig               |    2 -
 arch/m68k/configs/sun3_defconfig              |    2 -
 arch/m68k/configs/sun3x_defconfig             |    2 -
 arch/mips/configs/bigsur_defconfig            |    1 -
 arch/mips/configs/gpr_defconfig               |    1 -
 arch/mips/configs/mtx1_defconfig              |    1 -
 arch/powerpc/configs/pmac32_defconfig         |    1 -
 arch/powerpc/configs/ppc6xx_defconfig         |    1 -
 include/linux/dccp.h                          |  289 ---
 include/linux/tfrc.h                          |   51 -
 include/net/inet_hashtables.h                 |    7 +-
 include/net/rstreason.h                       |    2 +-
 include/net/secure_seq.h                      |    4 -
 include/net/sock.h                            |    1 -
 include/trace/events/sock.h                   |    1 -
 include/trace/events/sunrpc.h                 |    2 -
 net/Kconfig                                   |    1 -
 net/Makefile                                  |    1 -
 net/core/secure_seq.c                         |   42 -
 net/core/sock.c                               |   32 +-
 net/core/sock_diag.c                          |    2 -
 net/dccp/Kconfig                              |   46 -
 net/dccp/Makefile                             |   30 -
 net/dccp/ackvec.c                             |  403 -----
 net/dccp/ackvec.h                             |  136 --
 net/dccp/ccid.c                               |  219 ---
 net/dccp/ccid.h                               |  262 ---
 net/dccp/ccids/Kconfig                        |   55 -
 net/dccp/ccids/ccid2.c                        |  794 ---------
 net/dccp/ccids/ccid2.h                        |  121 --
 net/dccp/ccids/ccid3.c                        |  866 ---------
 net/dccp/ccids/ccid3.h                        |  148 --
 net/dccp/ccids/lib/loss_interval.c            |  184 --
 net/dccp/ccids/lib/loss_interval.h            |   69 -
 net/dccp/ccids/lib/packet_history.c           |  439 -----
 net/dccp/ccids/lib/packet_history.h           |  142 --
 net/dccp/ccids/lib/tfrc.c                     |   46 -
 net/dccp/ccids/lib/tfrc.h                     |   73 -
 net/dccp/ccids/lib/tfrc_equation.c            |  702 --------
 net/dccp/dccp.h                               |  483 -----
 net/dccp/diag.c                               |   85 -
 net/dccp/feat.c                               | 1581 -----------------
 net/dccp/feat.h                               |  133 --
 net/dccp/input.c                              |  739 --------
 net/dccp/ipv4.c                               | 1101 ------------
 net/dccp/ipv6.c                               | 1174 ------------
 net/dccp/ipv6.h                               |   27 -
 net/dccp/minisocks.c                          |  266 ---
 net/dccp/options.c                            |  609 -------
 net/dccp/output.c                             |  708 --------
 net/dccp/proto.c                              | 1293 --------------
 net/dccp/qpolicy.c                            |  136 --
 net/dccp/sysctl.c                             |  107 --
 net/dccp/timer.c                              |  272 ---
 net/dccp/trace.h                              |   82 -
 net/ipv4/Kconfig                              |    2 +-
 net/ipv4/af_inet.c                            |    5 +-
 net/ipv4/inet_connection_sock.c               |   23 +-
 net/ipv4/inet_diag.c                          |    2 -
 net/ipv4/inet_hashtables.c                    |   30 +-
 net/ipv4/inet_timewait_sock.c                 |    4 -
 net/ipv6/af_inet6.c                           |    1 -
 net/ipv6/inet6_connection_sock.c              |    2 -
 net/ipv6/ip6_output.c                         |    2 +-
 samples/bpf/sockex2_kern.c                    |    1 -
 scripts/checkpatch.pl                         |    2 +-
 security/lsm_audit.c                          |   19 -
 security/selinux/hooks.c                      |   41 +-
 security/selinux/include/classmap.h           |    2 -
 security/selinux/nlmsgtab.c                   |    1 -
 security/smack/smack_lsm.c                    |    9 +-
 tools/testing/selftests/net/config            |    1 -
 .../selftests/net/reuseport_addr_any.c        |   36 +-
 89 files changed, 47 insertions(+), 14370 deletions(-)
 delete mode 100644 Documentation/networking/dccp.rst
 delete mode 100644 include/linux/tfrc.h
 delete mode 100644 net/dccp/Kconfig
 delete mode 100644 net/dccp/Makefile
 delete mode 100644 net/dccp/ackvec.c
 delete mode 100644 net/dccp/ackvec.h
 delete mode 100644 net/dccp/ccid.c
 delete mode 100644 net/dccp/ccid.h
 delete mode 100644 net/dccp/ccids/Kconfig
 delete mode 100644 net/dccp/ccids/ccid2.c
 delete mode 100644 net/dccp/ccids/ccid2.h
 delete mode 100644 net/dccp/ccids/ccid3.c
 delete mode 100644 net/dccp/ccids/ccid3.h
 delete mode 100644 net/dccp/ccids/lib/loss_interval.c
 delete mode 100644 net/dccp/ccids/lib/loss_interval.h
 delete mode 100644 net/dccp/ccids/lib/packet_history.c
 delete mode 100644 net/dccp/ccids/lib/packet_history.h
 delete mode 100644 net/dccp/ccids/lib/tfrc.c
 delete mode 100644 net/dccp/ccids/lib/tfrc.h
 delete mode 100644 net/dccp/ccids/lib/tfrc_equation.c
 delete mode 100644 net/dccp/dccp.h
 delete mode 100644 net/dccp/diag.c
 delete mode 100644 net/dccp/feat.c
 delete mode 100644 net/dccp/feat.h
 delete mode 100644 net/dccp/input.c
 delete mode 100644 net/dccp/ipv4.c
 delete mode 100644 net/dccp/ipv6.c
 delete mode 100644 net/dccp/ipv6.h
 delete mode 100644 net/dccp/minisocks.c
 delete mode 100644 net/dccp/options.c
 delete mode 100644 net/dccp/output.c
 delete mode 100644 net/dccp/proto.c
 delete mode 100644 net/dccp/qpolicy.c
 delete mode 100644 net/dccp/sysctl.c
 delete mode 100644 net/dccp/timer.c
 delete mode 100644 net/dccp/trace.h

-- 
2.49.0

