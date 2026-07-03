Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F341DDC3F
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045843; cv=none; b=ZlVXmqOVeOz8RSyRFwGJRviga/ATsL+NwNM4VvG/hPGekDxQwTFPKKzO7FS4kKViB8v6SzCDmJobaTAbATKzvKN7IlmlDOIzrljGyUmOdRoVBmiPrwXmqspsYNOcdcfZmhtUFiINEOueatwOYqiOMRz+CiLtXZ2yxBIMxA1wViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045843; c=relaxed/simple;
	bh=1bpjoPApbqLa35uKjTSPzBKpp+pWZ1KYq1R6ywDv7kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ei9pyCFXyCD7lnYDJl5rl9SzNV4E2bekFw1aLjGqdYGFEMF2ZsKeuNnDwrYzCMWBuyRR5EdUYyVfJKmXoVJ3sn/y3RRNA3orw08ndIojOCcwzXbtRbOCcFBdKXgX2XtMRbRfEBZd2BEyOF8vcC09UFG7bubk/0Iv+Eiu92EIOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAT1I4wW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAT1I4wW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso50367a12.2
        for <selinux@vger.kernel.org>; Thu, 02 Jul 2026 19:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783045841; x=1783650641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpiwXtNSHF15I7xCLJ9APaGGQYykifM+whbvHDSmq/w=;
        b=kAT1I4wWAiT0ML8qaIKHkFylvwdpusx5OQWgxtXG3YIDugNn0aeVBNi0FV4+7UpcAO
         qSnLWGWin9FCe8chVhjbeDCsNB0pFaKq5Qbl3Z/anK6es9pDtgpYtPOlPczR4DpDwghs
         jngvPSzTtOoxSCfbDSjwmi84cg0J2TYermPm6lFowwtExl8cOly+J6aNgCXZ+cbxzqeX
         FRTxZHOd3EUqURXPYD9LXLVtSSeVsdCGLNkN7hepUToemRyz1AqZ7U0C+dMvai4+0emo
         LTEtpW35MOyfWv0Ch2RsKcfMFJF4xAsZJW/5YI12AdZ/dqbQHWhoNZSaA8I7wIZAoVDP
         i8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783045841; x=1783650641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpiwXtNSHF15I7xCLJ9APaGGQYykifM+whbvHDSmq/w=;
        b=DvACJ9ByF73kbGOuxZWEwcQPnTAJN3Pppcw+tPt8+uvZosx2MYfSV/HX+FoEdr3w/7
         30rIcbvcngclClw+JushJwPzSDLz/SnKPcESzTqIgllI7eKk0zSvPn7jYVdPMzj/6sXv
         3uwg/eZq6/PyrdnlL4ljVUESWAx5xjk8eeCer4zcvGE1PwE3AS9cR/Ooz/AYBCZ4m65B
         /EikQ+3jV+Ce+WhGrIIlMJMX3MZkpDjLwSFWqWW3bEDHPeaYK7PxOP11ZGdQ0JZfntCV
         Rn6qUDTdvtI8++LQUvYiJiMuj8puhZ7djGtwiaA9e0++RuPuAv7OQpumDyDCOZsj6Ayc
         Akiw==
X-Gm-Message-State: AOJu0Yy+KMRZO6uPjLsCxk5bfwVCc2/wfK0Fp1UrAdhzL/7bEwAlWXFh
	LD+wgplkIpmUEdS4Z9gjl+tZ6hrOfnCHBYrrAfHpfkaKhmsUTXStbZco
X-Gm-Gg: AfdE7cnAuBvyjU0ZhgcppH8bB6e0WZvdCY1EbvHnXxWt13NEsa70/3j3wXSVeI4Usj3
	Wh44vTxTw/R4ALvFuJMy31FNIOkl8Bup8VU39o6evs0MvOZAF51GjuhVbb34ucr0krg0rrtIVSh
	oWwlkOqO4vQt+uJr79AhgLTnzCBuOYVlAaC4fNx1EmwuLsvVGpsa1ncBP4kzJL1PQdZtP8WtJ/k
	5lduJyr2otGBL2TNUSvh4xHFLihAYFljtnqNQRFDMuIkKBsUa5tBt4FG6tD5zcpkkEDtpmchuis
	8J1KFrWIOOXBbXSbeTUSaKatVTWExGHUkWH6BLsgQhHH0BJZZDjMTrvq93BVHFLntPUjReVd4EU
	GI6wGpWsmYD5BXTVmGNMEdrz0MVWxe4c5Gf7ZxbrEJc189qmcQ95qoEoeipzQKC5Vob/n+GMQhl
	ClJtWHLSLNK8G3dICcQ0yCP+ELWQ7rSbNhhtamKU8nCXfWt9rIySAFVhYhDlaesz8T6V9q/09Q
X-Received: by 2002:a05:6a21:1b84:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3bfed3b19b0mr10503085637.39.1783045841102;
        Thu, 02 Jul 2026 19:30:41 -0700 (PDT)
Received: from localhost.localdomain ([101.90.60.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b0785csm1940291a12.18.2026.07.02.19.30.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 19:30:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kuba@kernel.org,
	kuniyu@google.com
Cc: selinux@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] selinux: suppress warning flood for retired DCCP netlink messages
Date: Fri,  3 Jul 2026 10:30:30 +0800
Message-ID: <20260703023030.94417-1-laoar.shao@gmail.com>
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
`ss`:

  SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
    sclass=netlink_tcpdiag_socket pid=188945 comm=ss

The root cause is that DCCP support was retired in
commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
`ss -d` invocation [0].

Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
flooding.

Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 security/selinux/hooks.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..9541cb674d61 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <uapi/linux/inet_diag.h>
 
 #include "initcalls.h"
 #include "avc.h"
@@ -6272,12 +6273,16 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 				return rc;
 		} else if (rc == -EINVAL) {
 			/* -EINVAL is a missing msg/perm mapping */
-			pr_warn_ratelimited("SELinux: unrecognized netlink"
-				" message: protocol=%hu nlmsg_type=%hu sclass=%s"
-				" pid=%d comm=%s\n",
-				sk->sk_protocol, nlh->nlmsg_type,
-				secclass_map[sclass - 1].name,
-				task_pid_nr(current), current->comm);
+			if (nlh->nlmsg_type == DCCPDIAG_GETSOCK)
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

