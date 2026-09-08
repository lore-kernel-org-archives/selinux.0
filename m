Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2543499D
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895683; cv=none; b=g7zfyNWJf8XCMaBjIqBrwejEOrARtVWW/BJ5CpMyfmOz0VBM/H5HMd90zdrwsSikzRensBt88EUslKIkOxBLXysPLRYQ8s72Thim5SKSVmg28EKO7rPCczWNlQgyyXyr9+hnmXCa59Ugoc25zT8a4/DmSkGsGZ4myv6A0rqZKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895683; c=relaxed/simple;
	bh=8kipusWOK5eg9NI0VkXzZg3xWFZfwp7gXQYmeKBr7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOI+dVNpoMgObDsVqlmK92xyJUtB+819zMIPlHN867bl2TsBwFyt6AOwmDEqR+s9mw/QP/KxviBsZ565ABq0BfDpFmVaUJ0pYtvSzKgSDPYNEug69t6u4bYem0sJgNyk5/s1eJea9gsWkEPp5sJsSt63p08fYclOX+xubTKgFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5LRalf6; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5LRalf6"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309a20a55bso2898591cf.1
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895680; x=1789500480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBfRVBQAoVP+5Y07d7nK7YlgZc1VWzMo2VnLPfURj40=;
        b=M5LRalf6Wr/GxZEfXWzeer7AI8cAjIyuZ6YoHsmXk4KytGC0KkPq648pTxz8pfL5s8
         suGhFa+SRen0gTKhqj2y4NC2H615FfiqXPoOx6BGiWFrWxKQeaZRlvkCa0TCif19OVo6
         TYS5/j0HUlUy9QBWbK7saNyNZA0rW3fuFoCg+PO595/mjPGAHisfVcIWjGOABJkr0meA
         7jypknjiGfIwZdEAkCmncVFtE9kRMu9Cn5j9NupCv8dMxUSVq79TEsYRE0SMMLCZJoac
         Tg98HBMND4+xBmbyxPvArfOqp3mKAdh33WapMA6/RgVli7znaDDKEt3L1x2JhIgxlUxc
         l+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895680; x=1789500480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBfRVBQAoVP+5Y07d7nK7YlgZc1VWzMo2VnLPfURj40=;
        b=dBlqRTRVjlBXrU6zICmoBNxtUEvZDlUVIJw2jPKyscFXJa8EZNmznm8KAnnWT37Dy6
         /yFDqCmxI3yUHdEMlHUAtI+TBuX46CMANPcCDnQzPKKxDNA5Mt76FjhM35LGobmj+wBd
         mdSrBX92EoTCzSPPbI1tBVQQ4hx28a66LzTdXkuRpznrgeJl7FyW/IVHo/CVBcawUMp+
         MdVNyiuYvUCvWzFuRobcvyxwbYxXmP03VsqIGT5e+A9qp3sPfmdF67kAGEO5gN0rEP/t
         EzWGegsyNTVJSPR3L76Is1QBja5YfZuZT75qtfOShwplzVz3wplMdjNPo8Fw9NxGp90R
         AbmQ==
X-Gm-Message-State: AFuF++n01bxX2Urb0A8o/TZFT745h3vTUqLLBHJJSjuQEt6hqkDx8+Wm
	DC6twYs3liKcJ4lerMup69tbw6i4q2fB1cfURJ3MD2FZm1krGWE9C5QaLohPjA==
X-Gm-Gg: AYBFou3bf1GUyDS2vT5CQZx+/i6cO8bz1EWktgcxpMgQcGXTYzMAGsFAcdQSBI6eIaa
	hikdMCWXtayFERKEaFjB2PZzoycK4yavgwtJHvbWO0XcRk3efEWncvlNUQRffi1M/TCTM3VTyyN
	TH1DTWIwOjRT3usx908BsSViYbRbq6lMJ6UEx2p6QDIP8eXuaB3n6wqBJQlheeJYiUDRbXWNyhS
	8u9B0EQbKgc2wl1OLV0eMMjphZESVi/QPrmW0+WsLAWHzBRP73bUd0G6aVBge7g8XUlSPfjninr
	XQNJrdmtkgnNHJEFMwPj7YKSE9yOWuATOxW1ZX6bDlrzRVRMCPMG4JnHso6v+dDJ11iUQbz46Bh
	Gba/a1nhfSmh0ExxB3t4pOjDW5tdatr8eOzCUpKwLAWoEjDYFYW7A0/mc54Wa36eYrTBjnwi2Qz
	2uT4k/j7gki4/t7iddmjixFj78aGTMMIOtgNhjRaR/VUb2J8NRVPrfhwRsw972RAaGCGIZOwM5E
	ElW6vu0TcczmHe6xHWUuZfbh5kMSj5Fk7XVNFBPSX+6UttOk4+yiVKxFfwsmYKT
X-Received: by 2002:a05:622a:4d8a:b0:52f:ba92:1121 with SMTP id d75a77b69052e-530a2d0cfccmr33885821cf.30.1788895680352;
        Tue, 08 Sep 2026 12:28:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5308a706823sm47606551cf.24.2026.09.08.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:28:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/4] libsepol,checkpolicy,python/semanage: validate portcon ranges
Date: Tue,  8 Sep 2026 15:27:43 -0400
Message-ID: <20260908192743.21663-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
References: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel policydb reader rejects an OCON_PORT entry with low_port 0,
low_port > high-port, or a port above U16_MAX. Apply the same checking
in the policy compilers and semanage front-end.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/policy_define.c      | 10 +++++-----
 libsepol/cil/src/cil_build_ast.c |  8 ++++++++
 libsepol/src/policydb_validate.c |  5 +++--
 python/semanage/seobject.py      |  2 +-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c0f546a1..726060c7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5241,15 +5241,15 @@ int define_port_context(unsigned int low, unsigned int high)
 		goto bad;
 	}
 
+	if (low == 0 || low > high || high > 0xffff) {
+		yyerror2("Invalid port range %u-%u", low, high);
+		goto bad;
+	}
+
 	newc->u.port.protocol = protocol;
 	newc->u.port.low_port = low;
 	newc->u.port.high_port = high;
 
-	if (low > high) {
-		yyerror2("low port %d exceeds high port %d", low, high);
-		goto bad;
-	}
-
 	if (parse_security_context(&newc->context[0])) {
 		goto bad;
 	}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 3a6b1631..e4f6af7b 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4438,6 +4438,14 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current,
 		portcon->port_high = portcon->port_low;
 	}
 
+	if (portcon->port_low == 0 || portcon->port_low > portcon->port_high ||
+	    portcon->port_high > 0xffff) {
+		cil_log(CIL_ERR, "Invalid port range %u-%u\n",
+			portcon->port_low, portcon->port_high);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	if (parse_current->next->next->next->cl_head == NULL) {
 		portcon->context_str = parse_current->next->next->next->data;
 	} else {
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index b2144dfd..be2cab05 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1594,8 +1594,9 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 						goto bad;
 					break;
 				case OCON_PORT:
-					if (octx->u.port.low_port >
-					    octx->u.port.high_port)
+					if (octx->u.port.low_port == 0 ||
+					    octx->u.port.low_port >
+						    octx->u.port.high_port)
 						goto bad;
 					switch (octx->u.port.protocol) {
 					case IPPROTO_TCP:
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 5914ef7e..b790597d 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1103,7 +1103,7 @@ class portRecords(semanageRecords):
             low = int(ports[0])
             high = int(ports[1])
 
-        if high > 65535:
+        if low < 1 or low > high or high > 65535:
             raise ValueError(_("Invalid Port"))
 
         (rc, k) = semanage_port_key_create(self.sh, low, high, proto_d)
-- 
2.55.0

