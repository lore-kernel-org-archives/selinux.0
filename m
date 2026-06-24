Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB243C8719
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311776; cv=none; b=TCx9JTAEDby7pz+vO+tqJqSVtnFo4tsNMx+DDhVDwUm++WCvw1pVSwBEhow3McZxieNS34Ut8caHcLWEp3CiYZIIC7Kk/THTcWpwOAF+wS5Tm8X+kNC2guPLNtkRi6Y5GZD25f5d9ilxmjhP/8ZjJNUriAtk0QWowTbuJuFXjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311776; c=relaxed/simple;
	bh=48D/ZE6ADOhuQ8NT1XZRq7UExQL/Mjb3HuzThRb4cv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpmYQ5tVKocFWz/GUlZ6tfjgGMNSvc3pcUr6xITOHj3OVfBa+0IcpJL6Mih+PyeoxUxVwtU18P1cA9fEMX0jw6R//kF5S6rbYR2b2gof2gmCLNxNa2/XYBNxerca8O8LLRM/Li0qRhYFLtv1aXipnasv0C6AtxUSRgVieEb8HIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYNAuqsY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYNAuqsY"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51788280e71so11406561cf.0
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311773; x=1782916573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnV6LfspmUJQA3Jhzgw+X3MwJ+8LwnG9XdAkkf24L4Y=;
        b=UYNAuqsYblR7sOlo3W7a3Fk8XP5SQCxA6vdqh6viKoNf5abTJLeNN4INqf0npbLiAy
         ty5Ri1Y0qsjx3ZJGWM+w1tuqGW+eWJO7dAA4Qif869jkemTHE/Ck4KXZlPYaeQZD6Isv
         BcBil2IeIwAUE5jnxCSGFYbUGbl1KIcPDrVk792cdKfUgYYmKSAWYkkr8yOEY3Vjs1OY
         Ka91aZ8Y9bJ+6dDM7U9If1GY9M0YWMUGUg76+EP4mE0xetlQOfGysnCk8A73h4OyCMNS
         xlL8zAYzPQJclipU1q0Tg4bKcP+xTvUjukKTeuIA6i3m2J56dtqe4uJsH5EAMHI1FTUC
         zrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311773; x=1782916573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lnV6LfspmUJQA3Jhzgw+X3MwJ+8LwnG9XdAkkf24L4Y=;
        b=n30rg9PahFfdeuINlzMPypMUBr5Fw7abggP8A2wCLTEN2ltbHnymsfB3XKBkBZvc6C
         rsU/GshDvhG1KIH+obbtuKmCEC8/04q3yzzYGenfNadp3rwRa+iiPt+OJhlZmcLAa1zd
         dF6mI2ezRjL2pO5NCxYNZkLi151ocdvmT56CY6y7PJtOJ4J/zAd4SLrn2EoV0JlOXPCE
         GpIvJiZYQRpojcoJ7qqxm3dxfWTq4RClPs+YQIyZZZXEtzEJ3OMNSiWDo+Ik3q/YS3Fo
         C9EQmrW4XdH1JnM9eCUwt9lrqPc7GgTNhfG+ejwDRcX58OHSX27NRDp7ClslPfIvHpJF
         26Zw==
X-Gm-Message-State: AOJu0Yx87qi29j39teWFevTa4mgowIRpIMGhuVj2KQCwRMkbaqo/jb19
	Fa61QA5hnsjOyzu3tPheyCbZsJnD4Ae+nP1s3U++vh9PesYlE+2RYcsAEYkw1g==
X-Gm-Gg: AfdE7clsXlcoHrlA4NfVg0gs9p5GbmgWt2c3VnMhQnDyykQ5wjzy0Obs0yyRR/Gw3+n
	92LjzY7gRyuP6vlfyqa+b7jJriqDFQhb5S0oLoWcwfuBRt2v5YQW/mdKPZUoj93aIRe9S1V7Si3
	wnQsF0Drf60n4XrH6XbFqtjAXd5s0IZ/IyfPwgD5DHO3B2zOha8DwXhRxWxcqFRbYgnWAQ72lVL
	343NVsiB5v1T+sIzNoaUNnx8lPDwQgvOemKQ3xFTWDYTFR/ztZ9Sf6SZDDUFnX+hKWw2gMJxo4Y
	vGUPzhUNFKmnZCA/QLuRD04q7PJI7Q92Tt2GU5Wl5GhmVd/RIqSsw62T3sdrmsdwAQICpL2XU58
	MRfo1Ju6xVYXjpUOTErLykU2NI1tPgJSAkdakDZWDgogOiRuz/5cuIkdTMB5QjpBFjPrtdof+wg
	5Bt6MWxdXjKAcxUOGf2qr9ryD6VErmx/0flDE=
X-Received: by 2002:ac8:5a52:0:b0:519:f420:d775 with SMTP id d75a77b69052e-51a069347f8mr295559751cf.28.1782311772648;
        Wed, 24 Jun 2026 07:36:12 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:12 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6 v6] libsemanage: Add overflow checks
Date: Wed, 24 Jun 2026 10:35:56 -0400
Message-ID: <20260624143600.11282-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624143600.11282-1-jwcart2@gmail.com>
References: <20260624143600.11282-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow a buffer, but it is
possible for this multiplication to overflow.

Use the __builtin_mul_overflow() family of functions that will
do the multiplication while checking for overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v6: No changes

 libsemanage/src/direct_api.c    |  7 +++++--
 libsemanage/src/genhomedircon.c | 11 +++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9572dbf0..b87b87e7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -588,8 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
 			char *tmp;
-
-			max_len *= 2;
+			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
+				ERR(sh, "Overflow");
+				free(data_read);
+				return -1;
+			}
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
 				ERR(sh, "Failed to realloc, out of memory.");
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ce7ea167..f04fc127 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1090,9 +1090,9 @@ retry:
 		goto cleanup;
 
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+	if (retval == ERANGE &&
+	    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 		free(rbuf);
-		rbuflen *= 2;
 		goto retry;
 	}
 	if (retval != 0 || pwent == NULL) {
@@ -1171,11 +1171,10 @@ static int get_group_users(genhomedircon_settings_t *s,
 				    &group)) != 0 &&
 	       errno == ERANGE) {
 		char *new_grbuf;
-		grbuflen *= 2;
-		if (grbuflen < 0)
-			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
-			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+		if (__builtin_smull_overflow(grbuflen, 2, &grbuflen)) {
+			ERR(s->h_semanage, "Overflow");
 			goto cleanup;
+		}
 		new_grbuf = realloc(grbuf, grbuflen);
 		if (new_grbuf == NULL)
 			goto cleanup;
-- 
2.54.0

