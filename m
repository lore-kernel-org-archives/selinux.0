Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DE19FA9D
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334636; cv=none; b=Cg+zkBt2ZqobFfP244Im+DVPWAzwWjXhh43vVZniGatb0+uo3OOjhrhqrIRIynu6a6TGaegMRSs/r06Ar7ReGDbACcXuc6rnHXpkdrs2ybB11UwiXrh3iLlwmuLKtYpZI3AiqMdlkxPzUOUeVJpJg3vayJ0cK99RWqhHJpyqsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334636; c=relaxed/simple;
	bh=mhrw0jndIUEpPz9wLkgvkiTI32yS3VzD4SA66ghCyas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIfEwBUoSTvc5xLv1+UxpqnHlhisBzqP9kOqqqTEQMf7Ln88pxlh041qYIccAVjQPsLMcE//A9EAoSBqZybd9AZZEo+2O8lQcXhBGpUbfhVB54oFyq2lqKmZmILNy9N1+v+2OLCpBvuNPKTSfzrjuVEHk5codWzL94fYMxQIyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t8SI6/Oo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t8SI6/Oo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334633;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OvbGTL76osaDfJHN1S/oqoYdhgMkuYnWF77H0QMPBs=;
	b=t8SI6/OoEw2s1NRu4+7Fy2Skz5/b1qCL5ZlN9EYSPs98blhFUMMCxLcuBK2Awy4UyEHnzC
	zAFx6ecyN72dpDIxEVS0Dsore2nnnDqyroyjqPWzBNwJ9Nqzvsqwonl4A4iMD9qjNr2D9b
	1lCnCpfbwdkxI5Pp9DEJSNSXOlXTEd08kTmk1dBhW2weOQHiCur6buk0N46fQ1uarWuyxG
	JLjj3m6BGElU9IHU//W1TsR6mIlM6+3z9DNSL/0CvklHjGJYH44JOjVy/EFWGPl3OAv8fe
	OPdc4CDn21bhmiXD3F5gV5wvBzjzyHhOV7/N09YmID+GBAqQVRhp/DEJh0tgMA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/47] libsemanage: drop unused macro
Date: Mon, 11 Nov 2024 15:16:22 +0100
Message-ID: <20241111141706.38039-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Reported by clang-analyzer:

    semanage_store.c:68:9: warning: macro is not used [-Wunused-macros]
    #define TRUE 1
            ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index b0b7aa5d..df994297 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -66,8 +66,6 @@ typedef struct dbase_policydb dbase_t;
 /* relative path names to enum semanage_paths to special files and
  * directories for the module store */
 
-#define TRUE 1
-
 enum semanage_file_defs {
 	SEMANAGE_ROOT,
 	SEMANAGE_TRANS_LOCK,
-- 
2.45.2

