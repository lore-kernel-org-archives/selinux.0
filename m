Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523E3382C5
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231872; cv=none; b=XzzTshtBlxhzhFjKIsglrP7vj0pF8zIJVxEPjEg4m+G8HtTf1UR8+rU5yQF+sl6Q0YRgFLrmsyEigQY8Q0GWD+S3GZnz+Nqy2HMxvVA6YlBTmj91W9BJrDPXeq8UhxJ/j5hGxEgLIJpYUAkMyykkK2lSa33Z3yj1jI3VfJGvOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231872; c=relaxed/simple;
	bh=8JHKvKh039XR+YamyWNlBfu9Bs4og7xZA4HCUwBTuMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJifhB5L7b3O6o/9DWRVBhWmx5FWxm5EjZma9k2tBvzgDE6ChNyUhAVYWaMXZXI+GY0d0YejJ24S3uMluDMsZ6FmpA21vguqvy+YGs22SGCll78vyfWw11KSStzjXQtwTHNs8/XFxPGGEzPwjFSBjPzVo7UDg3Sm6VISkZCo7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpOAR0ir; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpOAR0ir"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so64202726d6.2
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784231869; x=1784836669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCPdtnsBvsAN4EJCJRBUEHD/EQeFUucSfhA9iwsODYY=;
        b=kpOAR0irnRcMkbOHJu+++KUVYnWJZ7n7b11C/nfzqMg44us0Igtp5PbIe+KpF04UWa
         D4U2ad3+PZEbs7Zq7AL900aMmpR7UQOxRqyC3x1OxJLKb6aZkybzjsgxEhWcZHrVtcHJ
         uv1XOrdyeuGZ027CumPgm8xx/WP7yATHQhQy0ran+2XjfD6BrbZbypKSmhBuBGrVCLhG
         4+zlYhcTlKeyoQYxeIpepSQxgiaz+LM+WmMOwvLlzQ8vC6ECg5wCmtacg9TbdDYWpxE9
         83/6bCPs1KFivAmSYhnFkL/4X9fQdOuGtKp4UO2pmWP7cRy4ENqItuBsijTmJ0k1zAyX
         GEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784231869; x=1784836669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCPdtnsBvsAN4EJCJRBUEHD/EQeFUucSfhA9iwsODYY=;
        b=KDVEd7kwDB0K88gUFfMbAFXENogwnuJZB+Etb3YlU/jagRukiZp3quzScqrIeNBEmq
         SZzsbdCr3AWqNN6d2DpOS4ku4BrQZsI7tUkXBPesBqoXnSYsznfH8osWZ5tRMlz6LQO3
         cXGsp35leGFdLRtdffXKvX3zWK3mnjNoBr+WRgXw45AdKXwyZCLWYqBx6TDLOMDNUfZj
         v/MFHft28cOBpvrh30CZuun61Qz8gCZJytIq20WqVsKZi9qr7dwQSI33TLEWB3+KONsV
         fe8VfCdLU3Eha2/QXCCD8gWetB9GaGu237UqyMczUpLnvLWR+qMzM8dP7Pf3oF/vFQ4r
         voYQ==
X-Gm-Message-State: AOJu0YwiXgSJBPQRuE8Xj4GEBhTAv5yTL24QdBGdfP+3NzRS0arkRQ4u
	qUzL/Dc47GQtXF5frVLqSspNxacee8Ijn2cM4b3XDmW30MvDRVSOqMAyRGM5WQ==
X-Gm-Gg: AfdE7cmZPbZ4fr5gkWr6hdUs603yU1mOQCQfxBadAyOQaRhUuNeQh086gUt11qK+F3b
	64JYMN1WzlDIBpMiSSUTFnWgk1Hw3hJvyPWVQEPwZ7jGwRT7ncKM6AiCXOsR4CgUKwjC8e8LEha
	0fJ4msPALmiIJYiiHIod9ozssjPClqAWNMPGamWSCbsld0wRxEIoj1Lh4rFTjcKejpcXSg5uOyV
	yEQlN+PhxTXlci+sCgh03SuKoLXNZw4XrxA+DdgNuJnoOix5W5odZFMUTeOr2W6PVRlAeKes/31
	2gPcdJfNx99T+kUvSne8jnS4gox9P7LWZCkQiHw/keXrrfuzisx7s42tXjx7C97oYOsTQnpvfou
	zSHjBT4ai1D+lA+kpv4Hnn2MrQPrIpqd7es7gOSW+oYMSkE7lq00S7iYe6rdr6aLuf0/uQSoH/H
	QDOXP1/HQJYECZcbA2s+brPrig1Gv8Z31b4ffq6tTIudx4CUwyLbNWru4A6V13INdteY2iEEw8q
	Dgwrw==
X-Received: by 2002:a05:6214:428c:b0:8eb:326f:9515 with SMTP id 6a1803df08f44-90758cd66e0mr117764606d6.8.1784231869191;
        Thu, 16 Jul 2026 12:57:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10e9sm223300616d6.7.2026.07.16.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:57:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: match base classification and word text case-insensitively
Date: Thu, 16 Jul 2026 15:57:31 -0400
Message-ID: <20260716195732.11660-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The base classification and word regexes are compiled with
PCRE2_CASELESS so a differently cased input matches the regex, but the
extracted substring is then compared against the configured text with
strcmp/strncmp() and fails.

Use strcasecmp()/strncasecmp() so the follow-up lookup is consistent
with the caseless regex.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 8ed1aa95..89235269 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1285,7 +1285,7 @@ static char *compute_raw_from_trans(const char *level, domain_t *domain)
 			  match, strlen(match));
 		base_classification_t *bc;
 		for (bc = domain->base_classifications; bc; bc = bc->next) {
-			if (!strcmp(bc->trans, match)) {
+			if (!strcasecmp(bc->trans, match)) {
 				log_debug(
 					" compute_raw_from_trans base classification %s matched %s\n",
 					level, bc->trans);
@@ -1443,7 +1443,7 @@ static char *compute_raw_from_trans(const char *level, domain_t *domain)
 								int wlen = strlen(
 									w->text);
 								if (plen >= wlen &&
-								    !strncmp(
+								    !strncasecmp(
 									    w->text,
 									    p,
 									    strlen(w->text))) {
-- 
2.55.0

