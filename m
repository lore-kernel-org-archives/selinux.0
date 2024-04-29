Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3C86253
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408749; cv=none; b=XFSuk6MFSwnLOiKCLandYepHhWXb3/CJqDKKoWIEyHf5+tuzvV6j1iDk7hgZgGRVPGtXt3gZXNczTF3iu1w9g8+vE6h46qjKqyN0tOLDtQaORGTGoZoDX11pRvkT2ER0OPKx3t8MoOFzLXWRmYHjph3NY8fSUihIL5ADPMBzd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408749; c=relaxed/simple;
	bh=NST67LlzPZnAQLjVXfKodS9MVsie87ZwpF116Pc3cfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf9JJpL5Z03m1siUz7O4eE6k29QzqBPed7b2Tpy9gCVLO9pWNhBgDi2OOQ8vFZuauBYCT6QjMhsHlqKVZMVVJItMFTVSsyrmMJieNcxZfP65kHT6dpuigAQwMBL5FRlffiW16TEy2S50hZV7Yz+hdk7VcexH7xmNJC6yrkf28wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=djALUZUI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="djALUZUI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408746;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQxGRhXdR6GuGqeqbedKm9FeI/RNaxGHCREQGZDBmXs=;
	b=djALUZUIbTp3RoRF66VWviqd9XSZ5msGg6JqhX0NyqRY+R+CNa030wnYqzYduODPhqf2Y0
	r+FLJhjvNcDKlbwqHh2268e0B29L06d5G62hOtUHYc4YeFdAISYAMyHKPjmXGcPYsPbqE7
	EFviP4xmRjLz1xaK3aFcUqg6flRB3FKKWUlA5YtrSiXRyiPtWYd9TjSNFP6mUV6c5IsQ4F
	TQ4nu9TyzPSnnd1S24OEdsW8TaF8y9BjEnQBoU5++qB0nUq49Np8fKxVYK8rEucWvwPmzM
	QKtQBj68+NPlnpi9TpPoElbTP63g7YiEKYW404xfluJOhbNJAwMP/3+zYlvlSQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/3] mcstrans: free constraint in error branch
Date: Mon, 29 Apr 2024 18:39:01 +0200
Message-ID: <20240429163901.65239-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163901.65239-1-cgoettsche@seltendoof.de>
References: <20240429163901.65239-1-cgoettsche@seltendoof.de>
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

Free constraint, like in all other error branches.

Reported-by: Cppcheck
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcstrans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index fded3235..7667e131 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -477,6 +477,7 @@ add_constraint(char op, char *raw, char *tok) {
 		}
 		if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) < 0) {
 			log_error("asprintf failed %s", strerror(errno));
+			free(constraint);
 			return -1;
 		}
 		constraint->op = op;
-- 
2.43.0

