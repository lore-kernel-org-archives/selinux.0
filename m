Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E2495515
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406016; cv=none; b=j9urIYYgxKR9FEjyQzy8kWJI2XjvZmGaTrdBT7F2yIQGvTyVtmQB2sXkcEuZ38BvK0p/EpKouYgmVg832LF+dhecN1M0GkSvbT568gs0lhYkjv1HRCwZsCFBhYrpwoKsRE0u76csN3VxLX0uVcztIBzyGvIKzgu/mXMEdAkJ+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406016; c=relaxed/simple;
	bh=pM/2ZHRRTQP3t5EMGyZiSKSVse6j2XeoH5q+D7OE4yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZ2ETZiI7MG+0I916j7YE4liVQ24alfCu/MQEtevq01ubhUzULOa0rzSTHB4LsGYFE656YWROcmYbOgTYpZBGgg8ZdsHI7h6Wp6NTfHylNT+PrxrNlJplwU8UVa+rIMVwB+fvgoqKQJ6BapkcyMukjFTLBY+wc3c+lbOkUKl7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppnaQ3w5; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppnaQ3w5"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe207so29735566d6.3
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789406012; x=1790010812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Juqex+ydrKMq7zlCcJuUz3rRfNH7kgi3YUPXSJORck0=;
        b=ppnaQ3w5SBT8oV4MD5UG2T04s+NPzN/1BRkrpq/8u/j8aF+zlFZTjv5lvukycFuL8p
         HJ68r/rTqB5yL5yPFJ4TL4gbcOxFA1XrQamYI179/wr1Di77jwTqPHm/B1FQ6dCpZBpy
         e7q+MyX1bxOvWbbXjzjHSgKxgnZ93qS2Mr4NtSccgE+U9kEegjL7lrVUq+SYQdUK8f3G
         LAgSVeAvSZj8L2GSgEVUJxbVdPaR3JF27yQXe/mQwu4ueAlqAYqZCHfLFpRa+QqirWHM
         OWXVwhjRKvQ3LQyvehAjHsbCr/KV9IOnBC3IaFsOKDhAr9QR9Q+FpMAGZbZXWolefa1X
         9PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789406012; x=1790010812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Juqex+ydrKMq7zlCcJuUz3rRfNH7kgi3YUPXSJORck0=;
        b=pkinwzQfhC9m2pQc1OQ2t1Il8BE7KiujUyhpd0eMW7GBZIdOsYowjijTydW7rtErsJ
         lbi2Fbh0uM3bYstP9QRPC/0mhGywI3DNlmeFXVRUxeUimbizGmQ3/qe+CTwF8DYb1xrQ
         ivF3FCpKxxgJcGZy5iM0JOX+fTdXRFEntLjkeOUdTgw96fx4uIlZYC8k+ZPEv8U/iGGc
         PoTd38mt0ajn2vJfWMVbLVtJvTBJxAUUY1PQHAwBqGmG3firycfUf4FTcUiGJzpuOnPh
         LTn5G5k76J+mO7n31gmqrTHPvYQ5m7OoHgCf1x10QFL/6NLpEldtovDlYio0Z8XAyISl
         QJVg==
X-Gm-Message-State: AFuF++mHurxAIX+yAFkXuizXJhI/FlWFCvEk5Y/8oGTYLikv0/F0oNW5
	6jgKiTK9um+uR8HiLrtaPBV7S18Pqu5YoVKZSGMy555PNiUDjr2WlMvjUJkM9w==
X-Gm-Gg: AYBFou0H3G84+u4VRE/0/zacjl/fGuySIhWoY46KuU9ALGEw0zmy+U09uWxoAZPatgL
	9C63dIGeQehkCcVPJlp3ePDL8+Gu5flWoIeSR+z1qLMh4TPblZRfoijnvTDNwNK2G04sTho+wXz
	4cONCmsb1Axa8ejA6VhuinSPxq+Hqccx4qRsc5ugOJJdofPpYOlbeqXj6hxYbdEh7y5wVBdmf0g
	/T6E/CcN4DcvPWu2oFR97dXkEOZBTg5uiPXDfdz0u/BfVt3+Wah+8HTP7JEOicFygTY6RXxnRdp
	K+y7qn41SioKYY8H8VGPngCeZHD2pcikkUbzQ+hJsFHiumPLK06jjRaDFnlKomc84ecb2tXh+/l
	ymHcxGcA6p/hxdli8Px23zDHu6RV4XiZmuNgF/6rKewuLdHKREYcGrZ4dQF4UA2PrcCfA3kRfB4
	rEgCrqDwVTnbnV65A2YNfek9sBRTfhYCfo+m5pWLpEPHR29KmhV5UhAW+XfpE+U3wUArwcLA4tf
	tZXHoxHKwx/4sSgBcYw5PtE02bN9jM0RIKR/dxrJALE2LbYl0CVAcdBSfzqv0dZBrfXnx0UlKM=
X-Received: by 2002:a05:6214:2628:b0:910:6ff4:5d31 with SMTP id 6a1803df08f44-9122e4f4c34mr54061486d6.11.1789406012422;
        Mon, 14 Sep 2026 10:13:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d35a9sm99867406d6.41.2026.09.14.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:13:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix incorrect regexp anchoring
Date: Mon, 14 Sep 2026 13:13:17 -0400
Message-ID: <20260914171317.29972-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As identified in #544 libselinux anchors the pathname regexes by
prepending a ^ and appending a $, which will produce the wrong result
for a regexp like /foo|/bar. #544 also notes that we should be using
PCRE2_DOLLAR_ENDONLY/PCRE_DOLLAR_ENDONLY when compiling the regexp to
avoid matching a pathname with a trailing newline.

Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.h | 15 +++++++++------
 libselinux/src/regex.c      |  6 ++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index a42e2aef..ecc16984 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -460,18 +460,21 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 		errno = EINVAL;
 		return -1;
 	}
-	cp = anchored_regex = malloc(len + 3);
+
+#define REPREFIX "\\A(?:"
+#define RESUFFIX ")\\z"
+	cp = anchored_regex =
+		malloc(len + strlen(REPREFIX) + strlen(RESUFFIX) + 1);
 	if (!anchored_regex) {
 		__pthread_mutex_unlock(&spec->regex_lock);
 		snprintf(errbuf, errbuf_size, "out of memory");
 		return -1;
 	}
 
-	/* Create ^...$ regexp.  */
-	*cp++ = '^';
-	memcpy(cp, reg_buf, len);
-	cp += len;
-	*cp++ = '$';
+	/* Create anchored regexp.  */
+	cp = mempcpy(cp, REPREFIX, strlen(REPREFIX));
+	cp = mempcpy(cp, reg_buf, len);
+	cp = mempcpy(cp, RESUFFIX, strlen(RESUFFIX));
 	*cp = '\0';
 
 	/* Compile the regular expression. */
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index d6b5bf02..a76f29ce 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -96,7 +96,8 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		return -1;
 
 	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
-					PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
+					PCRE2_ZERO_TERMINATED,
+					PCRE2_DOTALL | PCRE2_DOLLAR_ENDONLY,
 					&errordata->error_code,
 					&errordata->error_offset, NULL);
 	if (!(*regex)->regex) {
@@ -379,7 +380,8 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	if (!(*regex))
 		return -1;
 
-	(*regex)->regex = pcre_compile(pattern_string, PCRE_DOTALL,
+	(*regex)->regex = pcre_compile(pattern_string,
+				       PCRE_DOTALL | PCRE_DOLLAR_ENDONLY,
 				       &errordata->error_buffer,
 				       &errordata->error_offset, NULL);
 	if (!(*regex)->regex)
-- 
2.55.0

