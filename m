Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E03D1CC6
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578701; cv=none; b=eD5/ejEwMObO0WyvWlGuEYsX0uEihfpUAPk402U6gWtJUkMLs0BJbxopt9aNrx+tieQUWDnCvYRitU5n9csIT4l/LDjNHb4uH5WRyxEyDXhQroKzzVDxgTHPusSYja5WvYykN86NM8AYvQ5xQ6cse/kX3t5wIfd80IXjCy8QdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578701; c=relaxed/simple;
	bh=vHaU50FxXwZE7MOOJFl7g9tfRAs8d4zIYLZw4ChpBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVt6lnChY/JARketwC6ll6ChvVu/bOyiK78w1WoR58v9fTiJ2PLgj9rp+uFNXXB7wiPef/mi7W232WlHeJk0pPJyRQaZF9rIxzhZSrdBd58kCgYClWKD0lKVeCBNSCLRwFkXxZP4OFyu0ITrob+1yN4nwzKg3469rXIyv4b3O/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4elhW3F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4elhW3F"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso12613245ad.0
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2026 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783578700; x=1784183500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Dl8ZQwGcObXRhhgmS9bgcpluOnG9hQBFZQKTKc6z3A=;
        b=l4elhW3FCdmx+dj6/7ktmq+LixH67xo0lsKbMdL00kMPRonferjt4eH9P25bX6lmXJ
         WcrlMCbrs/2ImEEDs8mOgJEEF9VFtrZSlRT7D+gnRIRv9M2wULi+IwiDWCOsCbU5n8g3
         hLoGgZSkmKejmVxHFOAmQsDDDdaB4xdLDpOf1ee1Og+xgPXaWeRAEHK1dJME8n3ip81a
         jSLaMXjvm07Qk1HJFV/T0r18MI34oal4LzODmNWQ0geTuz5EfSaHTXXkFrLAfPtlclK1
         ByLnHRSjwQavF4+NW+lAxOtfnC2b/BCkRoGFGlOMbfcM9jSHhetdckxxquvm9txeTzE9
         X+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578700; x=1784183500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Dl8ZQwGcObXRhhgmS9bgcpluOnG9hQBFZQKTKc6z3A=;
        b=P2q56IjnM94/8DnkF9JhEtGb6cQuWSOozm/dOCEaaO97g00URGcY35890RDPX1Lhbb
         bHTV4EwAjfXO1PBDEUpstzU5bT//18NfMwZWyOzNvefKu1rjEDNzEIQW/bWJIOaydh6D
         OS/1qSW59k1/RSKGj0jR7LMB/qqduuwN5kqyA/LoHDJpCNKlmG+Np0qhP6dx0p0hcpuT
         9rDTWbJtsjBs20uYORsG1gTGBV2S9tkg66Su3mzrTT/7iJmbVl8Jn88NolPhZY6TwFHN
         bzLYzPHbEbexm+wrr4IcCrGie+t87WzkQWWJQdkEOuXr7dnMl091eCglUJWWxJoHTwGa
         OUmw==
X-Gm-Message-State: AOJu0YzB+8ZT8rAilfjBQhnJlJDtRWMeEFu+NgwAD9MmaeQKiMcw6g4G
	h6BleXRlajLneNqFApy+lD/r6vKqXYivv/0i3Mnu9zEcL4g8l+y0fWJf
X-Gm-Gg: AfdE7cnYtTcVYSc/wNyUavYFuGcItisqZBYucyAKpQf1iO0B+iiUHgq8yUboi7rhf+e
	kRDp9e7dbmC9+5H870bYB6JlLIY1329pyzMVHRMc0C0qlbG/jHvqBXfoGDiblbNiHBnLhMcf1X3
	gL0viObgOqlZT4/Eij5llIywHvIba8QtuFoqjUvIijmSkCs/hqRN6PDNyVjPVG7AAPXUqPpz4Xx
	1oAu4X957kBKcdZIdv3flZRNY0spGeh7byE7+WAWI1Oid3uBpyp3w3GSSICq0+8W53rWCnK0sUQ
	OfSiFjM4EacFg/+4rPhJqu/rBGpM2YAldXNWwokvWplOt3nEQrRaj7W2g40xIV39hfd3fJyhlUf
	zk6bLf165o67Dw/GTa51dxjUQN8VI6tvBP50dzFPyS7xx0nziXbDnCVXwGorbrCBOQZ7T4E48qb
	n7eS/+5Ol1BfHkvfVkM4jrFLUBXG2AmpWnSujsEFzonc5djBLL6zVDMj8SVZ71bSk9DYGQc0ovw
	2w0kw==
X-Received: by 2002:a17:903:2307:b0:2ca:6d2a:871 with SMTP id d9443c01a7336-2ccea47c7a5mr60388305ad.37.1783578699790;
        Wed, 08 Jul 2026 23:31:39 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2377:8568:3784:b66f:5b5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd5bsm38394095ad.72.2026.07.08.23.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 23:31:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kuba@kernel.org,
	kuniyu@google.com
Cc: selinux@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3] selinux: suppress warning flood for retired DCCP netlink messages
Date: Thu,  9 Jul 2026 14:31:28 +0800
Message-ID: <20260709063128.75873-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deploying linux-6.18.y stable kernel to production servers, we
observed kernel dmesg being flooded with SELinux warnings when running
`ss -l`:

  SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
    sclass=netlink_tcpdiag_socket pid=188945 comm=ss

The root cause is that DCCP support was retired in
commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
`ss -l` invocation [0].

Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
flooding.

Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

v2->v3: check also the sclass (sashiko-bot, Stephen)
v1->v2: use pr_warn_once for the removed DCCPDIAG_GETSOCK (Paul)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..8a9ec06e40ab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <uapi/linux/inet_diag.h>
 
 #include "initcalls.h"
 #include "avc.h"
@@ -6272,12 +6273,17 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 				return rc;
 		} else if (rc == -EINVAL) {
 			/* -EINVAL is a missing msg/perm mapping */
-			pr_warn_ratelimited("SELinux: unrecognized netlink"
-				" message: protocol=%hu nlmsg_type=%hu sclass=%s"
-				" pid=%d comm=%s\n",
-				sk->sk_protocol, nlh->nlmsg_type,
-				secclass_map[sclass - 1].name,
-				task_pid_nr(current), current->comm);
+			if (sclass == SECCLASS_NETLINK_TCPDIAG_SOCKET &&
+			    nlh->nlmsg_type == DCCPDIAG_GETSOCK)
+				pr_warn_once("SELinux: DCCP has been removed, pid=%d comm=%s\n",
+					     task_pid_nr(current), current->comm);
+			else
+				pr_warn_ratelimited("SELinux: unrecognized netlink"
+					" message: protocol=%hu nlmsg_type=%hu sclass=%s"
+					" pid=%d comm=%s\n",
+					sk->sk_protocol, nlh->nlmsg_type,
+					secclass_map[sclass - 1].name,
+					task_pid_nr(current), current->comm);
 			if (enforcing_enabled() &&
 			    !security_get_allow_unknown())
 				return rc;
-- 
2.52.0

