Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A631C862D
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972443; cv=none; b=uS40kMyFCU/kBvQM8EU47wdhEpVXE3/Y54xjfFqlQfSp2JikLg4saLwUbp+wld0Ch3iyuLNzTTfFYVfCT8/Zl+EU7p5qAKAy87dVizxn4PsAJCibQCP+G40/1LZy9Hpr2D5mBA8EYyyz3qQEI8nxxzmBak/6vgQOrgTeE84vUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972443; c=relaxed/simple;
	bh=vj7aT5sq+wN9BxXg1Ro/aHRjSgbxaxc5Rw0L+v94Wuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXuewa4xYFli3gjLZaX1c7WzI4FEuDhwRyOXa31TN0d+Wo4yhsCbsp62pX27A6dR6+ZTX0QhQqCRvIdXkafhLvhiokvMv4rcBl6gqfEFahaT4hcAtden+QAhaIPHWbeka26nwL2GUh5e8JxyD2OfXPcGWJuaBU4+/9S6EeRn9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=RDKpcl00; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="RDKpcl00"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741972439;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XncgkVqF2agWXBjre0fAYHB2o8IArRmURNCtZAu83OI=;
	b=RDKpcl00ShK99U1zFZ6Yb/3NueZ/ar5Ah6De8kQarYD+cUCveUCvoZDj8qOygvUjIZJGmd
	Ou5LoUlU6d7kms/ttzkCrXpHxRWsFieakH2Br2KQvG564ldcCwa66TblzjbEWgmzdb3OXM
	iJ8ssxkU+BWsRZvpm+REfZRuKQMzsdmKPCx5DZO+ri8HCcpFMZyoBww6hhth3uzccXb5Ks
	ZS9MlyG3NrCH0nhTmqucoXBgz6VQ7c+X9O5ScrPDU0rqVGjODKVAQ6pbNzLoNYmshS4Etd
	WcQL77D/7ceqUafh1ZXbyne0H14o53+VyQkJEgWVWmDsAda2txUEra1G7kiUcQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy: free ebitmap on error in define_compute_type_helper()
Date: Fri, 14 Mar 2025 18:13:55 +0100
Message-ID: <20250314171355.27185-1-cgoettsche@seltendoof.de>
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

Free the local ebitmap for classes in define_compute_type_helper() on
error.

Reported-by: oss-fuzz (issue 403364352)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f19e9f6d..cdd98cdb 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1699,6 +1699,8 @@ static int define_compute_type_helper(int which, avrule_t ** rule)
 		return -1;
 	}
 
+	ebitmap_init(&tclasses);
+
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&avrule->stypes, id, &add, 0))
 			goto bad;
@@ -1718,7 +1720,6 @@ static int define_compute_type_helper(int which, avrule_t ** rule)
 			goto bad;
 	}
 
-	ebitmap_init(&tclasses);
 	if (read_classes(&tclasses))
 		goto bad;
 
@@ -1759,6 +1760,7 @@ static int define_compute_type_helper(int which, avrule_t ** rule)
 	return 0;
 
       bad:
+	ebitmap_destroy(&tclasses);
 	avrule_destroy(avrule);
 	free(avrule);
 	return -1;
-- 
2.47.2

