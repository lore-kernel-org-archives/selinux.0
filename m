Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97401369992
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042255; cv=none; b=OacY1oe0azn6zsQj0USZ8CHd+C9ElqPxJJym6lFh2Tze+6A8gCmGJPlDBL4idkEz8f/Emt8QhTGixoeGF3lyLm2KkRoeCwMwMyKyur5TImbXRkpHT4AjWEFfY/dpfQ/lPEd9jnlixGnjCzo+ArwzP3ESM2leZrWnCvab7nk8dZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042255; c=relaxed/simple;
	bh=HhvyIHH1nTXFMXcWDv4wibQDTnVksTP3+NQXL+c/cm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0TGw4IiQSdRsYuyiR2CVoyLXJd5KbSFrpgjntkZz1xGadiyjFxiDT+fonYUX/tXL00Zm3buypokwD1TgiEvZGEWS6MVBLrc0zxnHqvyCNOgn+dUQ/Tsya4u3FL6PlA5JNvtWTYCHtGCF/GN4J0E4eMkh3Y7LjbEkJfrmMF9cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NNPCjlgv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NNPCjlgv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042253;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1P6IO/rc4/oL1n95gySojUzoyRiOe5mrTns2AIf7eg=;
	b=NNPCjlgvsSf62jVrBFCQHBG8iCCi7QvZBwbj2TuzB9/lI0pHqac0cU2uNtBjBCz62EOOYK
	MNarHvgx4qsGrBTauDNY/L0wB0mtr4nFUwQLc3WxmT8ZlXP4D/WXPwW1dDPKhCKrhcZC3T
	wa0vjaVOFap3751Eca38QpUmV+HXHgbOrePkdEMZS2OIS9GA5XYku1todHAL2QMpKPp14b
	X9FrmdQBffhfRsS/pD0iR/Bcm0EaICr2ksZ8lgExkitRPCRHWcEaIv0asu2/08KjRDgfKi
	ljphq/LNP6ZQlklAWkVyiHPXq6LF7keCIYYNfrSV9wcGqHTCmgtXOJ7jG23omw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/8] libselinux: constify regex interfaces
Date: Mon,  2 Feb 2026 15:23:59 +0100
Message-ID: <20260202142404.92347-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
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

Declare the read-only arguments for comparison and writing const.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 12 ++++++------
 libselinux/src/regex.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 976f00d4..df087367 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -172,7 +172,7 @@ err:
 	return -1;
 }
 
-int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
+int regex_writef(const struct regex_data *regex, FILE *fp, int do_write_precompregex)
 {
 	int rc = 0;
 	size_t len;
@@ -278,7 +278,7 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
  * Preferably, this function would be replaced with an algorithm that computes
  * the equivalence of the automatons systematically.
  */
-int regex_cmp(struct regex_data *regex1, struct regex_data *regex2)
+int regex_cmp(const struct regex_data *regex1, const struct regex_data *regex2)
 {
 	int rc;
 	size_t len1, len2;
@@ -422,7 +422,7 @@ err:
 	return -1;
 }
 
-static inline pcre_extra *get_pcre_extra(struct regex_data *regex)
+static inline const pcre_extra *get_pcre_extra(const struct regex_data *regex)
 {
 	if (!regex) return NULL;
 	if (regex->owned) {
@@ -434,14 +434,14 @@ static inline pcre_extra *get_pcre_extra(struct regex_data *regex)
 	}
 }
 
-int regex_writef(struct regex_data *regex, FILE *fp,
+int regex_writef(const struct regex_data *regex, FILE *fp,
 		 int do_write_precompregex __attribute__((unused)))
 {
 	int rc;
 	size_t len;
 	uint32_t data_u32;
 	size_t size;
-	pcre_extra *sd = get_pcre_extra(regex);
+	const pcre_extra *sd = get_pcre_extra(regex);
 
 	/* determine the size of the pcre data in bytes */
 	rc = pcre_fullinfo(regex->regex, NULL, PCRE_INFO_SIZE, &size);
@@ -525,7 +525,7 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
  * Preferably, this function would be replaced with an algorithm that computes
  * the equivalence of the automatons systematically.
  */
-int regex_cmp(struct regex_data *regex1, struct regex_data *regex2)
+int regex_cmp(const struct regex_data *regex1, const struct regex_data *regex2)
 {
 	int rc;
 	size_t len1, len2;
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 2dfa2534..d449b1e7 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -120,7 +120,7 @@ int regex_load_mmap(struct mmap_area *map_area,
  * @arg do_write_precompregex If non-zero precompiled patterns are written to
  *			      the output file (ignored by PCRE1 back-end).
  */
-int regex_writef(struct regex_data *regex, FILE *fp,
+int regex_writef(const struct regex_data *regex, FILE *fp,
 		 int do_write_precompregex) ;
 /**
  * This function applies a precompiled pattern to a subject string and
@@ -149,7 +149,7 @@ int regex_match(struct regex_data *regex, char const *subject,
  *                       the same
  * @retval SELABEL_INCOMPARABLE otherwise
  */
-int regex_cmp(struct regex_data *regex1, struct regex_data *regex2) ;
+int regex_cmp(const struct regex_data *regex1, const struct regex_data *regex2) ;
 /**
  * This function takes the error data returned by regex_prepare_data and turns
  * it in to a human readable error message.
-- 
2.51.0

