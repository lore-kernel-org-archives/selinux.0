Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E91E572F
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582015; cv=none; b=ji0dmxqCNZJ3KSzsEr9/0MzgPJjdxmC+3D+iLbnhGcP0f/wLrAATgf5SB4lAabE997lX5ocbY20DF1Bbkh0mT7TeKXAZGSmrvwF/9m4T1EtMTnQ2SnWUCoJE7YgpXyTXLvE+4DMzYlOCbAkvG2Lig6H61cxio2HeNun2G3wed0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582015; c=relaxed/simple;
	bh=h+KI4XQ0whfMWtExR300QDpxYfmWJXuBgCoBMZPsgy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5+0AHE2+ikZIBJpTfvaYkprG4d5sHn4JCa+ALDZzhzNogOCvLZT7CasIE31+DioUMumoWMjkZxHFdhRtYhYoCKhgFw1UCNd9BQSflJpB96zKhrtkraGVjswV1PooqsYAtsla4NPGrkNGrZ/wbyGBZiaRmx+sWpy/2pzTRofdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSGgJlW8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSGgJlW8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23494a515e3so13883345ad.2
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748582013; x=1749186813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4sHKooJjFNQPf8ygP8epyp/nLhni+9fQ75CNJLYIdw=;
        b=nSGgJlW8+XozKiheP7I3/U+sopCkziKOxYl965KNetEPbQBPwXPlV9236CPNc1QD4Z
         dy58paZlwiG57R5EYVkEut+Tu0aboq3IA/WDs0sTU4coFkbkIHFANU6hahSrvBNIsE0g
         cY5s/F/stZjZnIzxK/ryKtvXz+HZJnBS/m3xJ0OiJeS+1DJXyryf7Vmm1fzOQc2k0Jrs
         zz8TwHR9ExIWEKkLpin6eB631ozXMgsLAmzqrL+yYshJADxnsA4QeBIpUryc1LjhRH5I
         gDEGJTcODxEGiSXo52jExsA6CtE5dCF3z8gMkr0eI9T+tupfww6VzzlMcD5csHbNZjQQ
         2itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748582013; x=1749186813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4sHKooJjFNQPf8ygP8epyp/nLhni+9fQ75CNJLYIdw=;
        b=DkF+TiIZ7jh6HjdlQKIYkxWpb0LG+zrcHsiIqxloRdb1sGp381Eb7gjFNVMMpl0Cnh
         k5FebHyFtQqfowPm2Vr4j/cMu+UDhEtOO2pxIlsAjPYp+SizIxAgV0JGzmtJ1K05qqv2
         RV3PIG7j/FOvrr34678WxEO8kdtwxBa0KEF/zJD8FxvPkpSeyvreCLJIk6cxNe+BLEUn
         NujXHsjvyX3z0MJfF0jITQJuo0I4iSdzEPvLenOh/Fq1IRWtvpMyA3q7bZXLOtllYuMW
         BrGmznosWOehyVlfOPyD1OyRpsSGmBLmMp9eXGnExiAF7C8NWyhkfLc1yHLhIYGWE4U0
         EkYg==
X-Gm-Message-State: AOJu0Yzr7iLqXh1M/SaN38qTGPc4I2VmfrmzKypxmvBQ3LYXzXaJHBb9
	Jdc5PcvzozIRl5WjQJ/liyVGpdX1kSdhtIs5wbm2gdC3L1McRstqNbJYSgPlfsAZO85PLT2k5vV
	lZaWQuX5DHDW7L1GbUFNvAtJgahIikofMHQZJ6kEDYze6mOS8DAn9xM9BnW4+ofTEoE1WSl7t2g
	YDf9aEZ6ZVhBzAOeOeilxgZGo9Tc3/I8xseyMoew==
X-Google-Smtp-Source: AGHT+IFpZmF8jz+YPrikXLu/0ae5p++RAlFlsvAgmfRklI49JG9LwSiuHA3iZhDAavvzw8gABOJZ+F+cVaQ=
X-Received: from pjbsx4.prod.google.com ([2002:a17:90b:2cc4:b0:311:9ce0:8215])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc5:b0:30c:4b1d:330
 with SMTP id 98e67ed59e1d1-31241b88a06mr3368937a91.27.1748582013443; Thu, 29
 May 2025 22:13:33 -0700 (PDT)
Date: Fri, 30 May 2025 05:13:21 +0000
In-Reply-To: <20250530051322.1678251-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250530051322.1678251-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250530051322.1678251-2-inseob@google.com>
Subject: [PATCH v2 2/3] libsepol: Allow multiple policycap statements
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Same policycap statements don't conflict each other, so it's fine to
allow multiple policycap statements to exist.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/cil/src/cil_build_ast.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index fc11758d..4e9ecbd8 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -145,6 +145,9 @@ static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, en
 	case CIL_OPTIONAL:
 		return CIL_TRUE;
 		break;
+	case CIL_POLICYCAP:
+		return CIL_TRUE;
+		break;
 	default:
 		break;
 	}
@@ -205,7 +208,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	ast_node->flavor = nflavor;
 
 	rc = cil_add_decl_to_symtab(db, symtab, key, datum, ast_node);
-	if (rc != SEPOL_OK) {
+	if (rc != SEPOL_OK && rc != SEPOL_EEXIST) {
 		goto exit;
 	}
 
-- 
2.49.0.1238.gf8c92423fb-goog

