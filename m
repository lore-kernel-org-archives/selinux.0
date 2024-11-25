Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96082196DB1
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533528; cv=none; b=PBl3jnVyLy40N5s7NDWd6hYH0KJtMosVjCz57k65VBYMgQqYtkODKO2hUklzQef5Clvyi9M45Y45jPhCpe0+KKTHaAa1EOL9s8qF91D3oLTuzOGs8gefGEwzkfj+NKd1Ga8CymbkEXtDPDSJnCFc1V8iy0N4JYSLYHXDGaeZ8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533528; c=relaxed/simple;
	bh=uCsnvZ84bGSW1jvXFgFM8yuB2slcKn6VOZshtGeibJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua+wA3eOA71NzjXxYLC5Ldn7wTnIxbIcep11qTVR3liR9ZakqgZkbrSNFzEOYvgyQi0/F3gdKnf6SAMISec2U4Vo6w9MmYC0b9grpU8Q8w/z1KLZwQLISEX1QBx7chHLyqI0CUYN/ww/MG3pSLiaqNAw+VDKVKM8CiH6KU8AgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iXSaPlsk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iXSaPlsk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533524;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVu6fqqXlO3/e9l8ZL6MMnLXQovESjSF8gOKzosyS74=;
	b=iXSaPlskalXsYJWY731ecdaLlURQbmI9rnuNv9cdo35y3QCresWkIjMwAEAL7/6ni5HOSa
	Oil84kRQmExcPDR90G6ZzbAHDqVJHj2d6PDpwVQXzOaK1qWeZ+PgpYJyLuUOsh5eFcwlQP
	6Bqa0zU2PzzLefm5nIAhCOC62palJDiLG29rZOw8vcM/5FdS9tE8+aAP5KBgIT9q0BSfO1
	IM8OdX9LA/MZ4ArSDeqsVWbZW4u5peQ2U2xbxHpKgh4c7386CHTJgJMxhegY9eUQ/vQAMu
	du4obTDPI9onVsm8nZihVU/PDdL9XfT3fR60GTR0bCL5KugLo/mbt32SyR67aQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/9] libsemanage: handle cil_set_handle_unknown() failure
Date: Mon, 25 Nov 2024 12:18:33 +0100
Message-ID: <20241125111840.63845-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 85876676..a271a576 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1354,7 +1354,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		cil_set_multiple_decls(cildb, sh->conf->multiple_decls);
 
 		if (sh->conf->handle_unknown != -1) {
-			cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
+			retval = cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
+			if (retval < 0)
+				goto cleanup;
 		}
 
 		retval = semanage_load_files(sh, cildb, mod_filenames, num_modinfos);
-- 
2.45.2

