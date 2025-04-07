Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92217BA3
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993486; cv=none; b=cvADK9zPS4G4HYlWiHLDDyojkVY+/9kJ9ZbWQa4dm6hp/h4CjavlZhWXsn5bqTytvPvX0SwuvBEYrxAKbaYZh7YKlD/Bb2qEPX4JVmsQHtxQSuOof0LjzUqnC36ntMle+I98GQwfFCliYnNjyDXGfPbVpVJTySpyh7fLm6ph/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993486; c=relaxed/simple;
	bh=GaYVXI7T5NGqHbyoaqdpv1VODnvQbaPCRg8fTZWykq4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z2j1RBoU6CtLUXubiXaPk7EWCudBl4B7OgcKzHc+EtdIZX21mQix2QpVxQPzawK8jl5E0gZlAGUrIIuckHUlsadYK7XwmN58utyDS2380fDYdHeSiZQQCojXNkYK19HtzOAKLqjdHkZSmM/DrOir+JYJS9RiQu9M0FiHzGYNOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEBYE/9r; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEBYE/9r"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso46782505ad.0
        for <selinux@vger.kernel.org>; Sun, 06 Apr 2025 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743993485; x=1744598285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9IuEBHomlTiUCj0xcbQg0sTgMinGk5iatHq5VpGiZfM=;
        b=qEBYE/9rKX1F5T2TCUEsSB0YVvP/6V11eW1iEiZYp8uC7roiOoc+R/AM2kOrlXi9JJ
         NwuQ51eJ4P/QjTtrauTgMfpVd5CK969ds7AOXO5bQ0S3BghvWWM/MnUTn1UfY3YxMLnQ
         XIppNh+HHcIQAUXDK4vbMiWJGNQpqhd6AScYc65J34BNk/XUitxy5PwOhtcsXYpRDWsP
         e5GuIb8SQLNEUZFvJ+swmNqChjoWkDJfpkIic62xBduOgkhppdJEREgK9D1iCJpvK79F
         +b64MbG7cylvY4ley1H8AjpcJcyRBtpgMrHXCeg+bR5LO4NuGjQPb2kKcAtwYlj/ESEN
         GFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743993485; x=1744598285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IuEBHomlTiUCj0xcbQg0sTgMinGk5iatHq5VpGiZfM=;
        b=k0fYu1qUklycNnfSwtMos5GX55Wzd78GIgKDdNfpf4JLqLAN8+a7IK5HGt9xIPiolx
         K4kpAZj969gyLmwUZz1Ui+DMQDmQ5Enca8kVLDcd7IiCUsJVNxWnYBifIkHvRWxQE/4j
         xSnwqo6r04SCTD4ftq5zdqj5CcNQTWKSFpyHXpyLydUsoyL2CMbvFQPeaYXjesMNj8d8
         GU4jTvh+kUhM+J39fp92SR6C42CKZaLGSvhZVq+5gPA4oqHTxiO0SLYrTAyJhhcmsmOe
         nA1MSpqTdCHOiO7PXmTZGRonhxEUpCAlTIzkG5I0Nn4NU0mcfXYHWuofKp7ULY70lweI
         Va/A==
X-Gm-Message-State: AOJu0YxJ5vV2yFt3Ge3P7pywlQDCc8HvZ3fRSQ9QbGc4fRjssdRLQqSd
	LSQA2D/E8Jb/Vx39KG+yVowoEcBiFKOGjKYa9w4KWjcyGPt6gQQ6aXGK9Q+95iHRzPsEGdGBfl4
	gyzWOVLgoKqoxTk1Zv9P1Zh/d/QarXjZzOHalZRzbM1j4Dy4HDVBPP3Xj8afziNOyHPCdZWycdz
	fft0EvvQ+2Aiyh26VD9YD2mYtApaKfy12FOQ==
X-Google-Smtp-Source: AGHT+IGiqpYbgr6qDnYomlzlyjAGYyJcPZrIZAP4VkNt8xS+8zZUP26PFavSuaSRhyedLfm7CoxqnhNHDlM=
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:732:51fc:618f])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c4:b0:223:5379:5e4e
 with SMTP id d9443c01a7336-22a8a0431b9mr152674485ad.10.1743993484641; Sun, 06
 Apr 2025 19:38:04 -0700 (PDT)
Date: Mon,  7 Apr 2025 11:37:57 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407023757.2183935-1-inseob@google.com>
Subject: [PATCH] libsepol: Fix markers for info nodes w/o children
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

cil_write_src_info_node has been called with
__write_cil_ast_node_helper, but that may break the result CIL file in
case there are no children for the info node, because the "lme" marker
is printed with __write_cil_ast_last_child_helper.

This change manually prints the "lme" marker in
__write_cil_ast_node_helper in case there are no children, so opening
markers and closing markers always match regardless of children.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/cil/src/cil_write_ast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 15d8bbaf..f9edadba 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1624,6 +1624,10 @@ static int __write_cil_ast_node_helper(struct cil_tree_node *node, uint32_t *fin
 
 	if (node->flavor == CIL_SRC_INFO) {
 		cil_write_src_info_node(args->out, node);
+
+		if (node->cl_head == NULL) {
+			fprintf(args->out, ";;* lme\n");
+		}
 		return SEPOL_OK;
 	}
 
-- 
2.49.0.504.g3bcea36a83-goog

