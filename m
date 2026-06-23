Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5337A49D
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222156; cv=none; b=Xw96av1BVDF6f/snfD+js8/ABo9DaK4fESBEiB0C1vy6af0oHm/bLxD/Tsvh4dgoCDyoyqJVOw2XSmR/eDCM/Zf+9NH1l9KMj14CwAA0EKJe/5p/mgGMyAl6xA/r8+kkbQgefO57qSVkqTWb8Pzj1zfuXt+H7QBlZeeTadOioA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222156; c=relaxed/simple;
	bh=ygB9uLkv4HMEkerBEHX38ccD4Hyi+wckl9MHhCKEXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXBcxa6jf5IBVfpAY1VUQVhEwzQVebpAobWUtQuLA1mviPBn2gkPdMtUAEihaT4/piWoLHixGtp0Iv3C50cpDhnArgajk43Ry327xAm/Li1YxTjYo19+grd/L/wX2+C7FW2F4apYTUXjShbDRxqlvd89eUuBN6kCv/TZYxBxweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=RiavRWsC; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="RiavRWsC"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222152;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbYpAyRll18eAq2E6n1xA0cVutuwGhxEjQznj2dmKQI=;
	b=RiavRWsCEkq1SgeH/+nu/3vvq8Tys1vaV0R1R/yovHSPLJnSWInkc7a+U9m6zlbr9Sc9Rt
	zV+WweLPYkvxye6tmHIKK974+lybWdAq3+jGLy2Hc0w3EhCc7jjybdYRWciYvDlhEZD5LE
	/JbcJR8YLvZDQG1qqGXNzKzoJXDWhIKbodzjRYKWI99kbhRmrxtFL101120+5UQp3/PHcX
	UoNjxE5pNUTpvzUNVJ/a+6H53xuIYD7MMbEZU67a2IBIN2/fHlUELxzhnCwUG/DIwUSubV
	1kYcRY4Gr9pn4fA2JIpLbynZaFXlQX20hUjxS/0PXjLLMFF5CyFyoVHAt5GyyA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 12/24] libselinux: simplify type extraction in find_default_type
Date: Tue, 23 Jun 2026 15:42:01 +0200
Message-ID: <20260623134215.98273-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

ptr already points at the NUL-terminated type after the matched
"role:" prefix, so strdup copies exactly the type. The previous
strndup length over-counted any leading whitespace on the line
(harmless only because strndup stops at the NUL).

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_default_type.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index f689b4dd..2f8e4781 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -62,7 +62,7 @@ static int find_default_type(FILE *fp, const char *role, char **type)
 		return -1;
 	}
 
-	t = strndup(ptr, strlen(buf) - len - 1);
+	t = strdup(ptr);
 	if (!t)
 		return -1;
 	*type = t;
-- 
2.53.0

