Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89725A55
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510798; cv=none; b=tJnCZYVb/y8NvYdbwgKTwKZyvdiEbedVfPMSPeMJho1ymCv/aQSqrmPkElep9X8OHKG5kEwgHd297TD0Rkr3l+ndWAsX57fIqx035GAt7OUjUOXFOYEQhjpH/rj6Ne3jwylpSQy/kT/2BZq8b15EHuWrLOh3Fs2aw038aTrD9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510798; c=relaxed/simple;
	bh=h+KI4XQ0whfMWtExR300QDpxYfmWJXuBgCoBMZPsgy8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lx3HjitTgDNFe8R6J41J/xO6LFYMVuNNf6pHY5rjCCBO5x2SQGZoFukiibIB4eU8NN9iH6mLHlLJ004CVhgHpLnIdrWdTi4XXX7vm1jZZ/bnGBJ3VcxykFLbKstiZuSnJITaWlDzCXOXzzBOrMMZ05ZhCOBhOWDe2y7XosByZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJzA/gf0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJzA/gf0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so599014a91.3
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748510797; x=1749115597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4sHKooJjFNQPf8ygP8epyp/nLhni+9fQ75CNJLYIdw=;
        b=yJzA/gf0gLMAvKGe3Xs5l6bxyld+ESJkM/eF4YW8uQrEuB0ycUlPXSeLLCdIk8fDrX
         ZJqp/Qyg30qqZhEH1EFc4mIPrSZYAiIL68kugADP0WuDWcgbjh6oJ7OFNF/wQedxbtgH
         AVlkefKPTCqraHqea/VXFCOhbU9JdjbmP+rrmFTKV2kLX3UiJMmAwEL4VbjWrG2uce+J
         qRNFbnBA9adHNnnobaiqQH7tUhmmSXTeukeXLUKxSyyVFphwHeMCz28kv5sFg/bsFbFI
         42FBs/YlmuKQpjoWRwiLrUpgply7zxoBZ9+Ic8VSpLkBkPDGhBdnGouXro8z/MwsDNZm
         bZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510797; x=1749115597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4sHKooJjFNQPf8ygP8epyp/nLhni+9fQ75CNJLYIdw=;
        b=Hh/AdlG73F7NNxVlZfzzJ1u+0mAdJzIhJjK46w1zMuwLV+cpsbbsuQDnkaeb+3IL6+
         BmqY9hpU22+/P4WvnG0X0mmmQmlKukxcLjEE+31+NFycBOprtZwfdFnmg5LZ/fwuOZ1x
         cP2f/415F/XbLJfmnnztqZ5NIAHnElochAdIwmvJXX9wMRn2dAHz8hhUkHlAs0KCZZvh
         0ODxJKFyPch+B5mXCIkP4a83lu9oTVzX9PN45EHM4INOahs7O5oScwDfoCs159FcBskS
         fKPzJFfU+nHRZtb6QKITliHpE2vy/01jqk4JXWqjxhedQFQbvfiwU3k1GzOqSxHuz9uF
         oNkQ==
X-Gm-Message-State: AOJu0Yz3dz4qVv0Y/7mrzEIL4qMjs6EQIfJDEvY95+llZVyMhDgxP3MS
	giD20zjsuR0tNB+qUG8Zrc40W6Jc5n00aGKM16l48IH+Jp8tBBO4vPNRry5EhwBFislsv/TCq/S
	sZa8r+ThNHqp8qRpR738jHplV3jn67nzXU112fRvevu7dC3C87VLVTRYTGh7Z6UWxUPAVhd+eDO
	lBmXmZwa6ggaBlO9Y1j08PAqC5u+V7THWMn7K9qA==
X-Google-Smtp-Source: AGHT+IEyf3xJSun5ZgCFsHsjOu8Q/woNn7KiP7LrGK9N+0J0aF9a+bPAPLBPlrdj9V4LxHpTovTIhXA3vA4=
X-Received: from pjl4.prod.google.com ([2002:a17:90b:2f84:b0:312:18d4:6d5e])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f50:b0:312:1508:fb4d
 with SMTP id 98e67ed59e1d1-3121dccd0ffmr2919162a91.33.1748510796733; Thu, 29
 May 2025 02:26:36 -0700 (PDT)
Date: Thu, 29 May 2025 09:26:32 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250529092633.1057963-1-inseob@google.com>
Subject: [PATCH 1/2] libsepol: Allow multiple policycap statements
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	Inseob Kim <inseob@google.com>
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

