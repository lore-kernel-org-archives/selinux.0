Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FB38B12F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674796; cv=none; b=KrLhY5h7URxW8NCNjgL1LzYLyaQcVlMwlfWZtHJ9886fs1PB4av6t6XeatRQbRCI9sNF8NLIsDZMew2DT+E0AajAJDskOU+bRusfKTvXciNUB2DPDAYZC/EPbpAOAljZRj/5MBrOJmfz1fQevF4f3gEsed2RsoT1f4cd3u5vHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674796; c=relaxed/simple;
	bh=s8mYWtQy16vboWGgAHI2x3SqG+MsBJ7kRdYXBa5Vsf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCLSXpAFkss0jOjVfRwvAIBHhMx+mrwH+lix4b8iStAJ+KoB9fBA0QzbZrL4gbIAOkmlvGvqREJqOlcyn7uF9zTICsJqyWrBwzz28gemDKmjzHcp8Z7vBB8MWGPfRUTyUXpQ13EU+b3KbgNmVNSp8Df4M5zcwxATUHroB/HPAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBdEo/MR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBdEo/MR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517583cb07aso22915791cf.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674793; x=1781279593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+oMN+wnlU7u58mPV4aJ5HmCABqbEw2RgLpR8Sv+u6Y=;
        b=KBdEo/MR3lRyDLbO+CVFbpu0buZEaJjZpMDGSaJdHtLRG04BBx5AZt3C73paZcQhcv
         gYqH56Cvnnb/i3oI2gVDSEekfiQC0UOmRBRcguFhCJUc3kFkilT3fNgWO3FjGcj0arpJ
         rexDLu5YVDnHndeW1R5f36teP1Ubl7NEBnS8lRlYq7pXj8zGgdZgMeJ2PvO/fFeZWASg
         Pkr6eOR4+N038svugXPLEXvehdu1cLMDfiQwYw1kCpgXTFhIDoMwKMwYZlIVia9lzh3b
         HfthcrisP9l4xmExw/25TmTh3+/BNtRApUSOMt9dGaza91eYcridbfAb6s2ALtK1xKwq
         noJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674793; x=1781279593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+oMN+wnlU7u58mPV4aJ5HmCABqbEw2RgLpR8Sv+u6Y=;
        b=nhG/raJUq1bbX++uNEkWZCkd7mWxrSf6XgjDXqBMPweM8VJj4V3uqMCoPsG74q9Aj8
         O78bx5w8bYA/3WeT/fytDr3DbNQXQzTABvcn3jMldtR/LPPnC5217D13PisCPGOeOacg
         H30fJmImXMPL3VoCUxa72/CQtuceX5fnyVQYH1cRHj27j79pthoAmcKCzpuWYSEWDfIk
         WaoKDpqtdz0y/IY9X8P8esx1dhlPD30eMYfgbvk/ssS44wCCTMZijGhSXJdZNPggaqOq
         CQys5u6Bf29Ccs4KRifev6+MJ79rfdYfhCxdpjSm08A7PFcdBtM7BI8HievVfMrHVJ5w
         4ljA==
X-Gm-Message-State: AOJu0YzRoRrmrMhEG59Y5fS41rLF8ocAzDTI9Vr+6El7Crg2KhSmpn7S
	4wmHwoJTAbmpw27pDgZjLK5DLVweIQkT0oFbeCDdxQcdKOUAwepzEsHZPHm6Pw==
X-Gm-Gg: Acq92OHGBI5NLfTHydaWYOGyGP38whVAxcbiNuwQG5jilVArB9kl5zSXgC8w7z9naNz
	C3F74xuZWRgPeQXGTZqMF9tr8BUYwP63IvKTutbnJpkBE+lry4KjMFcnsdBBAvh8MzFzcVy3sLM
	UtU21auYVfIt45vqK9dYWFzuS41Un+cKBYqO+qLD7S5w+ecW9uy13BjxMNSbzXQgkuwKNiG0Wgv
	H+BnqCz65xASlzad5Dfea7nnjdz3hSPuVAsWe94OSRLZdrR0r1TrpUcImGv9BxY6un4Geg5tHC2
	0RiFrGupyUmYhzCCHhTl7AJlnfxz9poYAOo8q5klRp90elxUpAYhrZN5a1tG16AK9sYd7uerx6J
	KCorapJm+1d8V1JcwRF0SBv/mOradq8T6+9w8ujxZwZnjmV0o5WIDJSSiyHhbTZd+La/xcjbGFU
	rWhpC9TfZjw9jWjEOzUPsDqtVOvr3xtavGInvfFxOz7K7TUFNqxuK/f7gs
X-Received: by 2002:a05:622a:181e:b0:50f:b904:454 with SMTP id d75a77b69052e-51795b4ebbbmr62903941cf.11.1780674792435;
        Fri, 05 Jun 2026 08:53:12 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm83331951cf.4.2026.06.05.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:53:12 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Need to add to the length rather assigning it
Date: Fri,  5 Jun 2026 11:52:59 -0400
Message-ID: <20260605155259.112585-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing a policy.conf constrain expression from a CIL policy
all user attributes need to be expanded. This includes lists
containing users and user attributes. When trying to determine the
length of such a list the calculated length of the users in an
attribute was being assigned as the length rather than added to the
length.

Add to the length in this case instead of merely assigning it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 7f20b7b7..85c01050 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -384,7 +384,7 @@ static size_t __cil_cons_leaf_operand_len(struct cil_db *db,
 		cil_list_for_each(i1, (struct cil_list *)operand->data) {
 			struct cil_tree_node *node = NODE(i1->data);
 			if (node->flavor == CIL_USERATTRIBUTE) {
-				len = __cil_userattribute_len(db, node->data);
+				len += __cil_userattribute_len(db, node->data);
 			} else {
 				len += strlen(DATUM(node->data)->fqn);
 				len++; /* " " or "}" */
-- 
2.54.0

