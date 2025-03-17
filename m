Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EAD21B1A3
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202744; cv=none; b=D8b4XBTMNfyYAIEcIFtXM+wQewHZ5OZI8F79/PtWyMk1GAZbhI3//77VIWomgzYEU90mAMg65iKj9Q9DVMLiZu2reOFNSTUyhx1JsVvhZ5wKwGbCaHoyGGE/eSl7P+Qz2tubICHsD1CeCyMfRo/10GS2aMiAwiJeJjbmoDZgbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202744; c=relaxed/simple;
	bh=fXQiYr5zv2T9vsb76ZOjgj191oax88X4ylOzvCdFHx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N7LFduMrqaecRJ3XA0nwV6PfNQvo+bgq++TpQMYsg06l3YYwhy4qn6sofKvlP7gjP6sewy3hGUZpWnUQ6PgdYszLEtPoyPnMc8uSYe3cVhbg4i2ejds1aRy/z2pd8W9RkUxIXTDhjltI4f9tE/vBP88QM8X0bPx/5UhMMIprgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZw6QKTB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZw6QKTB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so97964395ad.0
        for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742202742; x=1742807542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYrnmWeFkr52qE7LVeBqeQhvC/cqs4plJ1vAkslUG4s=;
        b=FZw6QKTBELm40EAbyMztWMFgiHlLCJQ7ejl0bSxmVG2aAXEKzTFTUP0KtnSctMJxDJ
         /ac1U9z2VeCg8KwUGtZ6s1qYq4gP7193fJ0HHefovJJ38RU/2CxCi7X+SDABTL6NEj+W
         tPYJg7ehYJLzAFbFiwFiu631+stHxw2a8WCdxrj2SscoLIZZm3GSmiTHg17GKsgpO8Tt
         ahWneg3+jm9D3toqXKluS/H0FUBVeZlZGNsfBzC5r613bsCve00BaAYtAiNe0SmseCjv
         ILFRtOCM2aKqKAeMrOi18bAx6Ts6FlbCBdU3fMP5zsfm7pXL3vB59+3ic5XLj5+p8O9Q
         Sf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202742; x=1742807542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYrnmWeFkr52qE7LVeBqeQhvC/cqs4plJ1vAkslUG4s=;
        b=AfDLLs2e7c6qAKNZzxEgIzecZg9vHUlX5A8ezTQ/et3GRneghrMtgbB6+KQu6Zro3g
         Us5hqvFiHHXet1A8ndYBQud4ZP+EDd46BnHw/PAEa+uSMSQkeZnJ2F23tZ/BfKmbjLIn
         lPfwmJURUbqoVAYKyGPbDypVgx02D43lt8/g6xXi9PGLjJZS2c+YYeQ2wmAYz9eUoUud
         u8QEsSPypZohnEEQlAu8mCEXzafiCI/+xJiUdo83U4SwP+4Ev5QunP+RqbiVxeMPmtXa
         fPT6Krljxb8IjGUkGXxaaVMkIalRujSk0Qx4LVY05GE3GKAmhaXYbbKmpIpcUCYSdVyN
         Heig==
X-Gm-Message-State: AOJu0Yy1/A3gjAfWCsg55CMqGnPg4AA3w6TlWQ2o2j3eLEShgaOa96Hg
	9Q5lqPshuV5eKPTC+Z0/x/BiSVv75Xv/gTuXtlJUVthGqOiPQnTHTZOtfFpb4PAfca0mi5nRoWY
	3B9ep3dX3z5I9FMnamdm09C7sjBTqgcn3bSdHcCmP6FX50lbmCOahh5BtnlR0nhTIsF6bVDctvv
	aUYM81fGFic9rLIvgadJIhujYL6C9wKAxNhw==
X-Google-Smtp-Source: AGHT+IFAm6DOa3ePvQTaGml1V8HU/rqqlV4g9iHqRGtcczZM1i0lvXODXn2K6/07baB4q7qLUWx2HWD9DMk=
X-Received: from pfbbd8.prod.google.com ([2002:a05:6a00:2788:b0:736:af6b:e58d])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9c:b0:735:7bc0:dcda
 with SMTP id d2e1a72fcca58-73722310adamr12985315b3a.5.1742202742069; Mon, 17
 Mar 2025 02:12:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:12:14 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317091214.2765104-1-inseob@google.com>
Subject: [PATCH] libsepol: Print info nodes at the first child
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

cil_write_src_info_node has been called with
__write_cil_ast_node_helper, but that may break the result CIL file in
case there are no children for the info node, because the "lme" marker
is printed with __write_cil_ast_last_child_helper.

This change moves the cil_write_src_info_node call to
__write_cil_ast_first_child_helper, so opening markers and closing
markers always match.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/cil/src/cil_write_ast.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 15d8bbaf..7f41387f 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1623,7 +1623,6 @@ static int __write_cil_ast_node_helper(struct cil_tree_node *node, uint32_t *fin
 	struct cil_write_ast_args *args = extra_args;
 
 	if (node->flavor == CIL_SRC_INFO) {
-		cil_write_src_info_node(args->out, node);
 		return SEPOL_OK;
 	}
 
@@ -1643,6 +1642,10 @@ static int __write_cil_ast_first_child_helper(struct cil_tree_node *node, void *
 	struct cil_write_ast_args *args = extra_args;
 	struct cil_tree_node *parent = node->parent;
 
+	if (parent->flavor == CIL_SRC_INFO) {
+		cil_write_src_info_node(args->out, parent);
+	}
+
 	if (parent->flavor != CIL_SRC_INFO && parent->flavor != CIL_ROOT) {
 		args->depth++;
 	}
-- 
2.49.0.rc1.451.g8f38331e32-goog

