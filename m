Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AB20ADC4;
	Mon, 16 Dec 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367316; cv=none; b=Imhoa/e2oN28z1ifaT1NlVrh+T0E62kFdXsII0+hUg7OvqdTGtnMGSn5zw/7bbWBwAIG9Lak0Gwo3vCZb2XD16T/8Nu503YZhyBhysa32DnIXcdTdrycRXxzpLyZluZxLGZdd40/S+nM+zFajR8of1cJaGCaKmqdsikaywHYmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367316; c=relaxed/simple;
	bh=hwcN29obroXhrm5aJt/8aR4DfYxwb15fzF13yoPBSHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcgy0W3ckleZneRjLfKX5SvTzQ9alOj84BuJCynvRqV0CovxmynGpEKNARygyOj7lKdvZHkHQtAQ5Owx29wAUd7Z/lNcXDoYWijJObcr4Gqn6RgDcINkilG8U7m19Jumeq7c1I5MH+epGSrLXq8Tu+hOgQMJumS+1gaghETG1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BAwBzQjB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BAwBzQjB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367313;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0TYDu/9cDjTVlwHEhIn455hbVIKkcj246nhArRZl4U=;
	b=BAwBzQjBAhUBwMwBSHmIR9zQZr8nNxf5aCgwg2SWRPW5eLu0bnKmT+2aR8QnpW/R/1DJ4c
	wYyM5yHiYTVHEOoLCi8WxwXYDUPfkDjHhHxw4QDCtPF/sC74DV+lMyZ5LF4pJm2TkgYnnb
	iOyJDJr9as9L9lX3Niu46pqS0Xqa7J8OwfReG8meGXlO9HO6c0wy6kdhy26z1mWC4FnXjA
	++Qrchu9J+zOP72ZefByrnOovt/pfAYtCrA9v2tEq6qTBN0X8WcFe593ZaiDb4MN74aDil
	Z0d6IuKMGvk/Ote0ZdXdp5+4+/20JslSMzwvjhXgrLmCVVjsS9fGyXOSRQWkvg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 16/22] selinux: check type attr map overflows
Date: Mon, 16 Dec 2024 17:40:14 +0100
Message-ID: <20241216164055.96267-16-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Validate that no types with an invalid too high ID are present in the
attribute map.  Gaps are still not checked.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3f85bb63cb5e..b4381a0b93f6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2946,6 +2946,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto bad;
 		}
+
+		rc = -EINVAL;
+		if (ebitmap_highest_set_bit(e) >= p->p_types.nprim)
+			goto bad;
+
 		/* add the type itself as the degenerate case */
 		rc = ebitmap_set_bit(e, i, 1);
 		if (rc)
-- 
2.45.2

