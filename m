Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B50394788
	for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714643; cv=none; b=CMn6Pfz+BJEWNBU2T+nXFR98g3+Ixz2v0iVHF0NxZsNUseI4/ZrxwyxH3YScne7gfwPT06qy50o4SoWXgIZGoHv0nf17Cc6bKHC9Th4gl8KptXfmH4ysHrUi5pqvZxaOKq8jk8bgRqrE0zI0agsxd6tkmQPqzpI4CcqTq3cvjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714643; c=relaxed/simple;
	bh=qjCjqEktVLfcbUua5ODyxqgJQw/XU8MgxvYQHlogHs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ulsb/GBZsGax7QFjyZt+QsiB87KpLpU+V4Z2pnJM/9rd/ofBdpkPhSdLrCSjXKgsouW0S8lOROeNr6/R05Qg+TdEZGTQtovcgZxgy/iVrl0PQ0gUQAor7VmfwqkKTNpr+qpZ5gf5KhMDDJU2VNkYZdcc6M/0Be6X6Js2BmJjkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiINDONz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiINDONz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8424b00710aso2075316b3a.0
        for <selinux@vger.kernel.org>; Sun, 28 Jun 2026 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782714640; x=1783319440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QWfDOkWF4RIDvgKQHG4dgK7tSt5MmULFX9Wy98yIYE=;
        b=eiINDONzA1XIcfr3J3r18nn9/prd4NaSs4mMxfrTTWdaNu42+tYYV44/5g2b5LhM7k
         zsv7VyHDXUbNCDQj9hHLGfZyVX2drh5ooyMqa6ll6GhwIeyfkqYcNS7XYXjAmoKBAYty
         9JqsV1z5Fr2RKsYY3udZsx1djXGA2eva4hju5StdbJ11DrhyV7xmSO8Xesbh4ARoGS2C
         JFdqR5zmMQzjrxqOiACWvoxpfliX2V0DQHCPyLTD6W0/f3FWuxQmCd7/m4ZDuFuEWOBz
         IHl/ng/ZGXcXP2wHHk730vKfLNM3CSFXHyaXd38GHErQeawdtJBx4RSU1BqlEpuk72Ml
         8p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714640; x=1783319440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QWfDOkWF4RIDvgKQHG4dgK7tSt5MmULFX9Wy98yIYE=;
        b=c2o1hTGQWpUH/xPJN3bHQ0GdtU5liSAj8KBLeorg3YBVRQKgB9B92+kvpprLHlybmw
         4kRGcRYtWqRYTQjGVNF8afYU1tEtoVwN4ln729ltdDYx2IZY+2HxETSUWamRlDgAwnwu
         vlAfMWuJrqoKhc+BtQ3GhQz00KnEeyeSxu/msEXHER4dR54lQwQ8jrx7CaKTNtnrCRXu
         4nrrOsQyfkRqCBObIdzSGP7ZUXQyDeGPOqQmNr1kV0O7i47oYg3zoyQMfy9GYRcS7lBj
         F7E/yfYStQdNbaohGpH6uRZAAW1GP40PtS6R/DMcPklcmOYLH54uwWOcV4UyOoTyfshN
         80vw==
X-Gm-Message-State: AOJu0YxdlGuXzHdkWW/LG49lBUc3CjGK/nwrcLcxJDsqSOQV2XBrVe8K
	gFsJ+aLF82D1GDtKxJDEY1JXJaESagDWdWHU+KSiznQvpbOeCzZWP7gd
X-Gm-Gg: AfdE7cnZcVRBcNgkvUTywTuV13snoVdheWngI8UH+Mo2oHdD07h7DTqYN9bIl+9iGLT
	iHgLUp+6D9YUHwMy9imhVOifIovUHCGg9LSRdSe9DsWXIA2fXijNdVU0te7tJmfGO9FGdGmYOkp
	12vdSfyy7YIGKiCBzONfzcRArzlcj4fLB7P3wiNb15001q5AyTH3lG9TGbtBpoWwqlG9xJUqk2N
	++4dKPAeIa/sxEWDY/xdyT+NU/XCo7d4nNW3yQV9QJfzhj7YPU1+AazAWp549Pwa7puopi1gG7I
	SL7IAlFdMIzrFkD7KI5SXJraicQy4l34z62i1UOOKqPQpmABDtF3VVkFU417RTYnuvzyJL+FC90
	/Wi+hxzEKm11w1fDSOhHXRPMBLUnvpjbQur01B6uwf2SFgiZb+tb3Ju8W/xC1AU+lcVOTkx1rr5
	p++ApY7VlZw3wYQs6fSOu2SQa4D8sN6xlqfj680ndG0NT4cug1UvaK4rulXAmjBwhgVYd9
X-Received: by 2002:a05:6a00:430c:b0:847:8d56:1f71 with SMTP id d2e1a72fcca58-8478d5630cdmr1060958b3a.21.1782714639589;
        Sun, 28 Jun 2026 23:30:39 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2300:50e:3153:a360:ee7b:9a6f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4002c75sm11135026b3a.26.2026.06.28.23.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 23:30:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kuba@kernel.org,
	kuniyu@google.com
Cc: selinux@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH] selinux: suppress warning flood for retired DCCP netlink messages
Date: Mon, 29 Jun 2026 14:30:05 +0800
Message-ID: <20260629063005.64700-1-laoar.shao@gmail.com>
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

Since this is a retired feature rather than an invalid operation, return
-ENOENT instead of -EINVAL. This suppresses the warning flood while maintaining
correct error semantics for user space.

Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 security/selinux/nlmsgtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 655d2616c9d2..812961a847bc 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -192,6 +192,9 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 				  sizeof(nlmsg_route_perms));
 		break;
 	case SECCLASS_NETLINK_TCPDIAG_SOCKET:
+		/* DCCPDIAG_GETSOCK has already been deprecated */
+		if (nlmsg_type == DCCPDIAG_GETSOCK)
+			return -ENOENT;
 		if (selinux_policycap_netlink_xperm()) {
 			*perm = NETLINK_TCPDIAG_SOCKET__NLMSG;
 			return 0;
-- 
2.52.0

