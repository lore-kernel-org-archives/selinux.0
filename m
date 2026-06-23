Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575937BE6E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222154; cv=none; b=pBZJiz8QV2rvnW2CByf+MIybpe0kBszg5EfgfSx+Xb9414jcdD9km5m/WGLbOyUtbBJ0SwsCBRY1nZwOPdXqtCfjDnBtLor9r3vJmF/I6dXiv4Vd3Ee9rEPIQ30cLLuo8sPe4qlWGrDj53rxRAqw8KOgcMI+6P/cDlEG91cxbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222154; c=relaxed/simple;
	bh=dyjPBD4Ro1a3LdX8PnKyT3d5vBeP1ICLKtZ9Bhawgb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnULcnGxmvO5m9sdNrDMzSwKm1CYjKJNH64XTkAWEfnsjixYt67UZoXnCj4u5OHkopKSoMZhSraeIppywgsn1UtdEUm/D8hhrZEm/S6/zY5hgPspqbyVcTCqjAzXEihVHRtwpWUQw/nmIx8JjoW/dtaJxlK0tb804N4ofjJfJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XNL3757q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XNL3757q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222150;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1KXnGf8gMqjX/NLrSrcFufgfOeviTZLZZTNh2WpznA=;
	b=XNL3757qxCBZUxKqbg6I81+sSVdarv6k6Tani9uCJ0w4cjJ/KLaZXj9/Pa+qlJKHCZxMOJ
	eNhriXy52Jw4zWmrS76Ck0mPiGWQnOqNS3UFAN8IeJ2H4faSvjbf64Wflc8iHI3V4/v84u
	haiWLbdSHyAkhhh84j1hZskVs1xd3dX75AVHbAdwD8mPlitIJr+J9OQvzJe4epyX1Qz3CD
	jIF3MiLE9GPveP9shQKue1M9O+XMd0ayQzrv9KoGhNHfd2R1OogfPovE7Zp5K5Um9wfue8
	BkXnXLhpCOcmXez19oDjDMtVXb6XYMhRzD9LStD+bqkFRB/IyzBP6IljDlY6oA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/24] libselinux: drop undefined fflush(stdin) calls
Date: Tue, 23 Jun 2026 15:41:53 +0200
Message-ID: <20260623134215.98273-3-cgoettsche@seltendoof.de>
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

fflush() on an input-only stream is undefined behavior. The six calls
around the interactive prompts in query_user_context.c served no
portable purpose; remove them.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/query_user_context.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_user_context.c
index c2196de2..0267e49f 100644
--- a/libselinux/src/query_user_context.c
+++ b/libselinux/src/query_user_context.c
@@ -21,10 +21,8 @@ static int context_menu(char **list)
 
 	while ((choice < 1) || (choice > i)) {
 		printf("Enter number of choice: ");
-		fflush(stdin);
 		if (fgets(response, sizeof(response), stdin) == NULL)
 			continue;
-		fflush(stdin);
 		choice = strtol(response, NULL, 10);
 	}
 
@@ -47,10 +45,8 @@ int query_user_context(char **list, char **usercon)
 	printf("\nYour default context is %s.\n", list[0]);
 	if (list[1]) {
 		printf("Do you want to choose a different one? [n]");
-		fflush(stdin);
 		if (fgets(response, sizeof(response), stdin) == NULL)
 			return -1;
-		fflush(stdin);
 
 		if ((response[0] == 'y') || (response[0] == 'Y')) {
 			choice = context_menu(list);
@@ -81,10 +77,8 @@ static void get_field(const char *fieldstr, char *newfield, int newfieldlen)
 
 	while (!done) { /* Keep going until we get a value for the field */
 		printf("\tEnter %s ", fieldstr);
-		fflush(stdin);
 		if (fgets(newfield, newfieldlen, stdin) == NULL)
 			continue;
-		fflush(stdin);
 		if (newfield[0] && newfield[strlen(newfield) - 1] == '\n')
 			newfield[strlen(newfield) - 1] = '\0';
 
-- 
2.53.0

