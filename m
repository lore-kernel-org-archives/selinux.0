Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27717D2
	for <selinux@vger.kernel.org>; Wed,  2 Apr 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555680; cv=none; b=fiVh/6VHLaMceYzrm8m2Jem9QTOqCz2dRIVlkX1MdIXCH7wtEG+0mHYI9MLeFdiNRpdKnqiOQvyzni+p4/fhggIggtNtAoqJI+z00DpS7HfwCtbZNfP7wIlMFLbzpVSVcINgZalDw1EOG3T74Ue++i8Xtwm0shxQzRpGaUIpA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555680; c=relaxed/simple;
	bh=fXQiYr5zv2T9vsb76ZOjgj191oax88X4ylOzvCdFHx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fuAOLh+fAFd1MHWhwixYk5Sov/MC3OV9gE7EqrseBDEsZ9SRUuFzS1203K+Ib5iPHAHLPowwp6o04WHLoaMPb4UsagnEMbKKSAjsNS4Kq6jz23A7qstdfarEAG+wR3ZYUjLM74KCB7mBppw5vS5W6aA9n09TnEAQR80zTZvDyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k3LayGG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k3LayGG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4eacd8so10102614a91.3
        for <selinux@vger.kernel.org>; Tue, 01 Apr 2025 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743555679; x=1744160479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYrnmWeFkr52qE7LVeBqeQhvC/cqs4plJ1vAkslUG4s=;
        b=3k3LayGGv+tnOhnIeJnXlVxuGONcUWaCKr9drmriJCaHRzNuBEL+F6EEMDd9HIZifU
         jcxNxR399l/BcviL48e2DWwgvITW9X2YDnQeJ8xwHtfKSFo1hw9Evao+ZeyobdIYbaXu
         aNsbi40dWAjsuKQGT2PtpsrTeSlhIInPmCOglo21cIULxJOyICCb1ZgXCCE6QJHGhjbp
         ml0sBzoV1p7BO250+0p+zxIUp7aH7TKq+JjpXUJ143H0WPXNLOyJEqVZNtsx0jpVZQ0h
         g9XZfkoNE8IwfCWJnA3iEedEzKYA0V7TzCEhQVA+gNBrDPt6tXlfuxWoNducm3wCzcBm
         z9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743555679; x=1744160479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYrnmWeFkr52qE7LVeBqeQhvC/cqs4plJ1vAkslUG4s=;
        b=YdAiiWYUiAfPVJC4N5hmrzPaMtEtAGNXaiB1GaIBhQ1cbcB/9lC0cVxg242ZylPJD3
         g0c6NMBlLA2wx68vu1yYOLoW9pMXdzGIm+AoAXf8ZM4U6BJde2dIGXt0ToELWoRMPM4U
         0nI6l5L+0QEglht+MgRc6ya0YvCLgE5KwTL1GrHND9dSiHyrxbGzvOYzhYKYYBQurdsq
         PjbjCmcz97/XxqscioEvFnw4vjL7sN2Ua8kcGIYjxDrDtOuP98mxVbNUHTCTcVbWdjmd
         DLCM7pxQ4qOb7RSLtJareralQvQLQ9ayaa+2KXtvjTjmqjGIVQu5ZUHdn1i4aqOU2XEg
         Utzg==
X-Gm-Message-State: AOJu0YwkNs2O+A0HIkYEzeD5jpfslhvpSKesIk9wEPohR0iQUsqvZdZ9
	H66hodjtUGA1J6DKdggXESDRFEWF19m4unRiljBPoIoJ63AYvf8JtMDwSsLPQHdhr6gi83dDtg/
	HYUhSG7GIpHFIR+7ZncgTvxJ+MgMRSIZ+XOubVMa0RnA1C/IicEVRwSzzQ8n5/yI9Skn83dlLlG
	yRNtz4h5S7lqAyUq4WMuAJcwEGsARfRCn/RQ==
X-Google-Smtp-Source: AGHT+IEAi+QPuJuo2HuqwDrEqibHIw2jl/DIzRlb5IkDhuhkB+8ZvghGTYeQLORc0DudETB7TVwrDZDdHtg=
X-Received: from pjbee12.prod.google.com ([2002:a17:90a:fc4c:b0:2ff:4be0:c675])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51cb:b0:305:2d28:e435
 with SMTP id 98e67ed59e1d1-30531f7c7dbmr26991213a91.7.1743555678630; Tue, 01
 Apr 2025 18:01:18 -0700 (PDT)
Date: Wed,  2 Apr 2025 10:00:58 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402010058.898417-1-inseob@google.com>
Subject: [PATCH RESEND] libsepol: Print info nodes at the first child
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

