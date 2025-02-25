Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C42690EA
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494012; cv=none; b=F1Nu7arS9NSFtscHzuiQvV4X1qEcti6LdPnc+JSEyiNG279Cld8yn5Y6eXyc4rVaIO+8/59CfYOiNuVHghyOqyMNcIY9qsA76nHb0GurINvxCbo1GP/H804krW2sPPq9DXHoCr4bNDwtNHYuWpBwVefJhm8zyysoNIAapz5VOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494012; c=relaxed/simple;
	bh=E7Q/uJa/AI0itNEzLc7hZdIWbFJ/JKO+yCFpUGjO1P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqPCOeHaxemYtYp/5UqXkOGvVBXJ73rc4/2raKWNZ4yx0TppfabQG0+5lWJr/mbOD1OI4sb/4HKeigDR8Lq7YQbzW7Wt2HxEQ0L7i53yYkagVpX5ti4LySzKjwym9wGmO+OPsOiiGTACLkHzyC5AEERkGsy76pc2Q9GHNtEgLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bLPRZ0zp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bLPRZ0zp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740494001;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hi7rCc2JcUsU02PJdARws73BCBAvp4iCn9M3Svjns+c=;
	b=bLPRZ0zpkpPoWNdWUtO+bjhyUKAZNLi05fZ0tq0uIkcUAiNzKhemBOzvcIPl+S+nLSbfGi
	u9wdH8/jb4V/yupZa40q0wPeMnH6aB8j5EAVDF2t9OIPvVZRhLUofOwqeP30St2tISiUYF
	abfduIj3ow257QwQ804S++z6HiLCJoPaNX52o4zJw7pXadPJPy2v2PcyBdW5IreTD844s2
	EsSyNNd6r36JsR3w01rOzrwQncLI7Pg2wqP7MW8NvjffurzvUdF+nmYqKLRewOxnkeLvU0
	kst+Oi0cYFBzqT9OnFMWfhlOLgluJs8H/RUmv/jWxSK1R3q1xbuEizU1O0/Pvg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/3] checkpolicy: free left hand conditional expression on error
Date: Tue, 25 Feb 2025 15:33:12 +0100
Message-ID: <20250225143312.47755-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250225143312.47755-1-cgoettsche@seltendoof.de>
References: <20250225143312.47755-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

On a failure during a binray conditional expression free the left hand
side expression.

Reported-by: oss-fuzz (issue 398356455)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f19e9f6d..18654d00 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4202,6 +4202,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
 		if (!e1 || e1->next) {
 			yyerror
 			    ("illegal right side of conditional binary op expression");
+			cond_expr_destroy(arg1);
 			free(expr);
 			return NULL;
 		}
-- 
2.47.2

