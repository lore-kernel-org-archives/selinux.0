Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583E8624B
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408749; cv=none; b=kcDnBrhua2BqAbeUmxFt1f7SIy8zP7u+ylFyQT+VviHBOMsl4rI5m19ajtCUgAewrdZUJPxf6sp/cKTuJA5wGCGDxlScJv6CSvbqgBPlNmMcxT36ldgtz0EzERczFPWjqCr9qBUHs7H8IsxFLIoNoD1C2PfCDKWH3tWOL0omLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408749; c=relaxed/simple;
	bh=Gvxur05Brx5t9q8HIfbC6Da2pahDKpHlTA8npQoM7Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZKyn9byZiknb+TA1BI8lTcvYS7velEDyR1qrDSu+brhNY5PP25bGTIxoiHO5D5v4mzVUZjgqICsSA9ppA/HCvtccFkBbnVQYkmiUl87ZXCpZAzpZlqfPwRYolE4bA4m0EutRv22ngoxp9XflV6w5VbUK+ZaGnUIqjorNPA+5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FXpN8sUD; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FXpN8sUD"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408746;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVQpZpsJpw8vxez0LS2SQbCW39B8iShTaTkMHVEviWE=;
	b=FXpN8sUDYXQTbgbCf8ouYixx/t+VKApwUU/iMdwmiFud3APttxp/Rjv9PuctGzB3ApKx4a
	MmCmkgLUtuqLgqh2jrqQ4De3zjHanzZqaVcQ/rW16L8Ps+28lSRLm2fVxgXWwJfbqAiEHi
	ecTTOhfu5XEcNRP47QwYseaexmGN3qDVU8XPQHlKX4n6XltwlWhYqk48zRsP8Cvkjiyd+E
	JyArMv12H23+gGoF2UrV67tKDaoRyDBjyy29yGgxYPHaLxUQxIwnIOIhQfCpDkZW/9NEdE
	96EH7GinQXVdKJTTEO4rFczkNcQz5ebZ7HoLYeoE2HT+zC8UrwR518UlUgwUuA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/3] libselinux: avoid pointer dereference before check
Date: Mon, 29 Apr 2024 18:39:00 +0200
Message-ID: <20240429163901.65239-2-cgoettsche@seltendoof.de>
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

Since commit 5876aca0 ("libselinux: free data on selabel open failure")
the close handler of label backends must support partial initialized
state, e.g. ->data being NULL.  Thus checks for NULL were added, but in
two cases the pointers in question were already dereferenced before.

Reorder the dereference after the NULL-checks.

Fixes: 5876aca0 ("libselinux: free data on selabel open failure")
Reported-by: Cppcheck
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_media.c | 4 +++-
 libselinux/src/label_x.c     | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 94a58062..852aeada 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -164,12 +164,14 @@ finish:
 static void close(struct selabel_handle *rec)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec, *spec_arr = data->spec_arr;
+	struct spec *spec, *spec_arr;
 	unsigned int i;
 
 	if (!data)
 		return;
 
+	spec_arr = data->spec_arr;
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &spec_arr[i];
 		free(spec->key);
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index f994eefa..a8decc7a 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -191,12 +191,14 @@ finish:
 static void close(struct selabel_handle *rec)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec, *spec_arr = data->spec_arr;
+	struct spec *spec, *spec_arr;
 	unsigned int i;
 
 	if (!data)
 		return;
 
+	spec_arr = data->spec_arr;
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &spec_arr[i];
 		free(spec->key);
-- 
2.43.0

