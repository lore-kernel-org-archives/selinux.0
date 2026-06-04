Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756F47ECC5
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583999; cv=none; b=uKYW5n6lqmQ1BURf1zadbDwxweXj/IhVr8HALrRPnKFd7tgNd/iQwCVSoN7/4dl8LsBIa0O3LfmmbEmdfT44QiVBEHwrcP1jvag/FbgaFEP5YwRtQFz8K31Nst18+ImrU+xEP/0wS0HvOTRumrzA/ejBNCaAPB5FKb6IYKACBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583999; c=relaxed/simple;
	bh=iZWsGSkPCmWmBb4yTls3l3v+MhYhroO6FujgTj0Nz7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ1Rhlld6ebUq2tVjK7YjLFtq6RgRuA7EYVq2Ns8ZF2JG1rOzFotaXEn1gULnnw5/LurSetYFJfm4/AclIRjyHC6ral+NkP3o4SazTAqdkvGn/0SzfkoMATKra3YjqIl/KblnHqZyFUEMledVueWHRT1YmDGU2UvNAuVVjI4yeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azk/0Nsm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azk/0Nsm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9157b895c57so79634785a.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780583997; x=1781188797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KP6dty7pKHhbHYuO0IgpmVzqk0qRkskJO2yUEdIKRBk=;
        b=azk/0Nsmmj9Frnuo52L8uC73w6RXGWAEqxgm4jCybDodYCg4XviyYG7lT9cfcR7uxo
         P4DgWtNICmCN2zvIr6t5OId7OfJWQCIHcQan0mFbHjxU3uurwe7PSJv3xz0XUpd5CJj7
         IfBQsKTfUSLRXHtGNGBV/N1liARKoKY4xb4igm606INT8l+6IVeZ+DCLNuhYVyYp3aDZ
         vwDIinmgoGZqru27NISt/U/WmLN4GQQafLnCP7HQ/6fYFSq15y8W/Wf41qB7EcI6N8Pu
         /LLCu3zwnnrTd49iCz/W2CpnUu6ALXqbZGmKkuXNsmI46xr5i0ia7gGRZAFRL1WuDqos
         nTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583997; x=1781188797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP6dty7pKHhbHYuO0IgpmVzqk0qRkskJO2yUEdIKRBk=;
        b=p/AXnhpUsJc/C+Dwqu1aPcWx0juIuxOiueY8ljCJi7u3cF6SZMN/pjQPlTMEWQnhqn
         5buRRZsAg5A5t/1zfOHnnLkriccaQm3B7iBbi/FBEpO3+PJCwoFxigEuVo/uZdcQ32jJ
         iQ6pJCT4oltjzSO20S37c4FB+FAY7X/JbQzBk3ACdRwHmZjY7k+J9MeE727Q8naDio4G
         eD1tXluPfu5L1TkVEr9hGUL4aUkJCSh96JhBmUCGFxlYd7ecpVdtx7CR+BulochPZ9Yz
         SQ5jtxd95cUnCFDWZQHFq/O/5MrLWsAKLBb0oI+JzHiulm0kej6Pi7UYEJ8DgryfL+k1
         Ww3Q==
X-Gm-Message-State: AOJu0YxMfaUYF4cBlii+JzUDTGEKgP6/bOvIm5Qf00Gv0P/BAG6L7zWT
	iWYvI0x78T6TgOza9dcMzs5P7P1lArpen1kpnMPkMeZ6kpnusFqavUrfx2tudA==
X-Gm-Gg: Acq92OEP5E+jyMgb8nFLBKaZAh8zmGd/Zc8YF+48PzbQr9/aF8pYmRT2f8nx3Fsc2EH
	LYw2t4Vz1ZyYmOJhcqKbrmSesbob69LiOZJ8SeY3RgilUTvwPSJpl/iZyfzcme7rxEHgqvInk5t
	NmvZkvy2cKmFR2YkmHWpvCQZ5S5+qYUWtmdveQiUisO27AnKX2BobQPV42VZLdE5mkTwItFyADQ
	W8aYBG3wpQyGW8039xMEWQY+rI1o+VX8GHDSPxdbFnMmYm4ZcHJQCruXfLUx5u4eJc/6zDUBRHo
	ecG1FnwDHMsDl5PoTq+M4XSVv1VH13PFiC40g2vLuev8oRUAKj2Owt3NRT/FlFPFnzqKuScaS9J
	hG5KPJ6DP1bJCsux2N+hWz4my7VW2zB8gP3+QpyRlbzLP7MbgrXuwJJO8P3mIajl8pONmrE+0bQ
	5kYIErCNB+TBixnovj7WATJpEriRnE2M7z5lSvUgLkU4K1xSaymJdcaWWF
X-Received: by 2002:a05:620a:2b43:b0:915:9273:923a with SMTP id af79cd13be357-9159273a874mr1014303785a.2.1780583997300;
        Thu, 04 Jun 2026 07:39:57 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053210sm52970556d6.26.2026.06.04.07.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:39:56 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] Have clang-format ignore auto-generated files
Date: Thu,  4 Jun 2026 10:39:44 -0400
Message-ID: <20260604143944.11282-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added .clang-format-ignore with auto-generated files to ignore
pulled from the .gitignore files.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 .clang-format-ignore | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 .clang-format-ignore

diff --git a/.clang-format-ignore b/.clang-format-ignore
new file mode 100644
index 00000000..8c32d922
--- /dev/null
+++ b/.clang-format-ignore
@@ -0,0 +1,13 @@
+checkpolicy/lex.yy.c
+checkpolicy/y.tab.c
+checkpolicy/y.tab.h
+libselinux/src/selinux.py
+libselinux/src/selinuxswig_python_wrap.c
+libselinux/src/selinuxswig_ruby_wrap.c
+libsemanage/src/conf-parse.c
+libsemanage/src/conf-parse.h
+libsemanage/src/conf-scan.c
+libsemanage/src/semanageswig_wrap.c
+libsemanage/src/semanage.py
+libsemanage/src/semanageswig_ruby_wrap.c
+libsepol/cil/src/cil_lexer.c
\ No newline at end of file
-- 
2.54.0

