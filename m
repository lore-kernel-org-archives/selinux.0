Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92013ACA41
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132160; cv=none; b=hK/N4Tn68sH5uj0vOjEcHxnEm1y3Fk9xGd6iU8jhtWm7r0geZaCu2wRz/fLmRtg2ca/tPOb7VOF9ftz/tikb3pwAWOy1GKAACAv38Job98oxdpq61ueC7cCgc0nPSWIjSHuYDm/8Vu/V4K76bqTjxVrXjS0z9jSa510A1dN2XPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132160; c=relaxed/simple;
	bh=+88GMaeK+dSQYmBlg3mzTbM9Dj8VZgOJvR6HgJnNsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osh0RRrPydJb/89kX05UW4/KL82xUops4N1eR15RzJ7OIPTrPnz3/fo03PUcNsavqdt5CpLnPzVtEdrDhmGkE/lhmFRd+WSI4OtH6I+HUjU7Xyqj4iqpWyy2PsqPLpH60EIj50hkkqwd/HSlQfhfz+Q4xv0HkrizBN9r6vT3VaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw3hHPyl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw3hHPyl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8dcc3f14b93so52699766d6.2
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132158; x=1782736958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL+lX/dKK3eeol420BQf+BOmWequRgMIgAqabs+tNZ4=;
        b=Tw3hHPyli2KRFh1+Qgw6XQkMazSIjWSqxEV6I2zLEuqGcm8/T1g4ohhJbeGTcaBguC
         /AY6NJXkV7pZAVkjuMvmPsF9IUoiRtnuc1RAUPqyTqr4j00rNrTdIJ6aHD5j7C8eRLDE
         oGuKxtBPT+yKlA4pyPn9YbmiYDuYVQC7isaTAbpoWOjH4ValqoOEHqXRmLWfU88TPpHL
         9uPDLcXhebQWeYajNxkckw357NUUwlK9iKvOaYLGQAW5Ejwab7edubE6BGOW2TxYOz+F
         dlDN5vNh0USuNel1O5oF3aOPD3L2Lcg9ezAGjdh+QjgupyGaYpYUPjhHCh64y2AcM16e
         9QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132158; x=1782736958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL+lX/dKK3eeol420BQf+BOmWequRgMIgAqabs+tNZ4=;
        b=exUmU01RDP05g0WzVK0w/Pq7xaA8zzjTUH/8tSeii3ngd+JX6fE//t4sogsNApC0xH
         t9YRi0290jGYQBJ2yGWU7NWGxAXnj6FbYHXr8/QfxRTtO1xoInDuTouE7Je6S+U/K13p
         5U/C6iXPoS7AJKTSR6uM8KrIg13MOHccsRvm2W2nRfFXR+UJRQ3EZ7yyrwSWWZMin5UN
         bY80QPk4dtKAwWl1DZOIYNrRcW1snVV5YgivPa079NtwTE/OKuJYgOf+H70k5B1+TB7e
         eSZ7ftUuB8FYFZXNMTCPO7k0YCuXoOEIhh0G/YlHLYJmojYuptFil2QzSjIreOkjRa5F
         9d1g==
X-Gm-Message-State: AOJu0YwYiaXQJNQ7mvZS7LHMboVxgNu5qwSmKj7Os/1SQxUdtH1QPZgs
	Rj+UfczRV2mJNcHJvnF8+S0eO2/w3KbeUQSKMQUHgnRMMiIDN7rV8C6qfmRd+A==
X-Gm-Gg: AfdE7cl7K1ZWqOj3PwW1WHc3tGnuxm3HgWjhxNupXQQ6wZBjxjKsGyBPQQdm7tfRSrN
	AnnJbWBaQnNb7sAaeEmTxwdb37jzvcgrImFmy8rQXyByDQHdfXQAtu2vgca+8b5aoYb20niYcfn
	4MH9PLlzYsq9vGPGQNRLCv8n8youPACLHtH/llHxnR0yXiL9mkiesiza1nu4s5JB/Jf8rDPGyJO
	LGewHfFVtcVtgJmbne1HQBYgQ5RGVRnFQXOhbztMDGjCrp/rGrKrdfKBLy6uNZlsOQ8jIfK3TVB
	r/SeJiLLbia5Sxf2El8VzkjJqaKJC9gJDDIxFTHVOz5rLrP4bUH+pbq6+C0cTHUU5w9w8WsIXJz
	uuw8jiGHJGYyU2Se2ZKyMvlBnQRbGf9nHtmY9RTGbl9uQkQ19qkVntI2bTz6RW1SEKN/t8oZ9n5
	Hqsw8/gj4zrrarj8kllgu/Ssx/H4L05VLIvk27fq3fKRQb3KSCfHG8EhhausiomzzOmIQhCli9A
	RncRxED5/hZWBWAEG7KBqptO4o=
X-Received: by 2002:a0c:f8c3:0:b0:8cc:f882:2564 with SMTP id 6a1803df08f44-8de40ff0b60mr181681506d6.40.1782132157628;
        Mon, 22 Jun 2026 05:42:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f8f1464sm104568756d6.19.2026.06.22.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:42:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
Date: Mon, 22 Jun 2026 08:42:22 -0400
Message-ID: <20260622124222.31518-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

parse_raw() advanced the cursor with raw += numdigits(sens) + 1 after
sscanf(raw, "s%u", &sens), assuming the consumed length equals the digit
count of the parsed value. sscanf %u accepts a leading minus, so a level
like "s-1" stores UINT_MAX and numdigits() returns 10 while only two
characters were read; raw jumps 11 bytes past a 4-byte buffer and the
following *raw == ':' test reads out of bounds. The range reaches
parse_raw from trans_context()/untrans_context() -> extract_range() ->
compute_trans_from_raw() for any context sent to the mcstransd socket;
trans_context splits the range on its first dash, so a high level such
as "s0-s-1" arrives here as "s-1". parse_category() uses the same
numdigits-based advance at two sites, shielded today only by the
MAX_CATS checks. Use sscanf %n to advance by the characters actually
consumed at all three sites and drop numdigits().

Fixes: https://github.com/SELinuxProject/selinux/pull/533
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 mcstrans/src/mcstrans.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index c494e76e..b5c8d54a 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -173,41 +173,35 @@ err:
 	return -1;
 }
 
-static int numdigits(unsigned int n)
-{
-	int count = 1;
-	while ((n = n / 10))
-		count++;
-	return count;
-}
-
 static int parse_category(ebitmap_t *e, const char *raw, bool allowinverse,
 			  bool fromconfig)
 {
 	int inverse = 0;
 	unsigned int low, high;
 	while (*raw) {
+		int n = 0;
 		if (allowinverse && *raw == '~') {
 			inverse = !inverse;
 			raw++;
 			continue;
 		}
-		if (sscanf(raw, "c%u", &low) != 1)
+		if (sscanf(raw, "c%u%n", &low, &n) != 1)
 			return -1;
 		if (low >= MAX_CATS)
 			return -1;
 		if (!fromconfig && low >= maxbit)
 			return -1;
-		raw += numdigits(low) + 1;
+		raw += n;
 		if (*raw == '.') {
 			raw++;
-			if (sscanf(raw, "c%u", &high) != 1)
+			n = 0;
+			if (sscanf(raw, "c%u%n", &high, &n) != 1)
 				return -1;
 			if (high >= MAX_CATS)
 				return -1;
 			if (!fromconfig && high >= maxbit)
 				return -1;
-			raw += numdigits(high) + 1;
+			raw += n;
 		} else {
 			high = low;
 		}
@@ -242,11 +236,12 @@ static int parse_ebitmap(ebitmap_t *e, ebitmap_t *def, const char *raw)
 static mls_level_t *parse_raw(const char *raw, bool fromconfig)
 {
 	mls_level_t *mls = calloc(1, sizeof(mls_level_t));
+	int n = 0;
 	if (!mls)
 		return NULL;
-	if (sscanf(raw, "s%u", &mls->sens) != 1)
+	if (sscanf(raw, "s%u%n", &mls->sens, &n) != 1)
 		goto err;
-	raw += numdigits(mls->sens) + 1;
+	raw += n;
 	if (*raw == ':') {
 		raw++;
 		if (parse_category(&mls->cat, raw, false, fromconfig) < 0)
-- 
2.54.0

