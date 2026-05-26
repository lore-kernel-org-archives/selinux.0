Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F43B47F5
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827219; cv=none; b=BDgDU3twLXWcdb7YlxNlFupYZlWM+GRSMOyZGCeeafzeBmdgwV6c2T55L60JHPP2NfyJQxMICymaq5ZfUIH4T+jQPXONs/+F/7cBs7lepSrkRqcu+nh4ePLwxfLceeS4Gn6XKKXgNBVb2a1UGUhHtm2uHy3mlbl6yqbgrDVZ1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827219; c=relaxed/simple;
	bh=1ecCMiqOp0v9AURyrgm6M9EolzU6N+b39icOFAzVOhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3Vi06A21PIF+cQY88QffP+S9lbxGnpVea5a6hwius3AxwRhn9hTv6ZyaWdTbztFgxpnfbJ6VFEXpLG2to0xvzhAQsbTy1DMPJmfvvds1uv9UpIhXfAmONHTpNTLO9qpWU8VdCh46f8+vNBhPZCVK098ruIjyuSvAekTyFDw19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6UjTUHl; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6UjTUHl"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914b03e42b2so609602085a.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827217; x=1780432017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNR5cTy3VgELfAsvoi8jLeN0/UZM0NbvoUfMVTVNeHs=;
        b=Z6UjTUHlSe9lhqwM8WKg/e7+ELKbtktAr/Z9iM99KC2ifi0lxCAiodCsGzw+Jr9R5c
         17+Up54j9y8fJG5EByVGelaBuRRruGL1oeA4n/Sn/CdW8BAN71syZlbiaY0vVC9e5sRf
         cWgkCxE8WlYFNlDB6emygulYtKqXS09c1GO9eyBLnKYViPfUe6MsTrjl0wrs100zrC/v
         99Q0MiDnuHXlhW6+bA+udc4x8giWipAr9TMeeUitZsBfT8IzIPvY1PUSzEaaTBQturwe
         LiSew5egYxk4y6uflfGULq3ay3bet/kDXyxvTNNgoIS5wKCXDrnsoVwLojrxTZK/SHw4
         0QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827217; x=1780432017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNR5cTy3VgELfAsvoi8jLeN0/UZM0NbvoUfMVTVNeHs=;
        b=Oll9ZJvVFI/2wiw/obvcqxyfQ+KAgTEsvJHRmNU9r9DC8DgRBk/VkujwTZxlzMmuUB
         HHmIK5cs+GW49RooMSTtLVxyMo9LEbBU4X61kOK/U5Ch/KB78oywjDl+HcqmG1wFA1WU
         4pfNA+t9n5lHM+pnB5eHuMz6YirP8uzf6lZH/L00+BhubM1btB3vsvvGMxk/IO6LF5xW
         YhP5X1eCmZCIzb3COh4pgPJpZRKXCYnZQJRk+M8AA84qW/cr8Ge1Vdom6Ld3QXovf6te
         W8LNLIn6ChGmI2MGzhF9QAOxcFgB26P1xfm6r2QyadaH1XibD6rzn/Vrlc37HKuH+8dq
         0alw==
X-Gm-Message-State: AOJu0YzGYpDfIXFK1w/HQPT4UlMGnvZtgAs4yyNINelwvuqE3B0neTZG
	+bXu2vm4wuLzOkm5VWEXY4BRRXbN/JVKFipnTJXQgCj5sn7u9AMfy3yLCRyDXQ==
X-Gm-Gg: Acq92OFydrMkuikgFBUfs6T12kDkeN07z1KtpM5uFR84xxXzd/V+wlx5z+gaSLULMoA
	FIFRMo/5lukbr/Lsbr/10qx8jYZQLmM/aYx9e494pdiZbSRXWkpaUe21ni13jpN3CTL7OydJzZk
	ftvTc0GOaJd8/TjYhfs33Ie3+necePJLVwXnV+gDIoARjR2xc2JuFWxpZPTOH9XcQcTgscB1cpf
	iqIlHLc1mr6erTkdoLIEyavtcz3X01RrbhEbqbw8DY1SHg0WX7v+HORAn0MfwRp86C1r9qyWYyq
	1vLj0796RILWYrujtFnAkXbf9ar7aWMppspw0tmLaCRpoMSOGYgKKhu8drEB1CKtRJAkm/ewtPb
	LT9gMuP0Hz6FjR13dKQMZb+mbI3STVpdJ+y8rXhn7p0mKM2XYjI7KT9K93JNDCO2RJJe9a+NgKM
	REPYbWJcKbgV+AxKxYer2WkY+0Ke9N8X3fqXwt2eJYx7evyZ1mz0SfZyxY/nwOjUJ5kqBf9sbMP
	Jt//v6Hj2ggRuDgueQ0jhiHzzoROxERhylusA==
X-Received: by 2002:a05:620a:2b89:b0:914:c316:4608 with SMTP id af79cd13be357-914c3164a2dmr1815923285a.62.1779827216693;
        Tue, 26 May 2026 13:26:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f88022e5sm281165085a.37.2026.05.26.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:26:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: avoid size_t underflow
Date: Tue, 26 May 2026 16:26:40 -0400
Message-ID: <20260526202640.19141-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the prefix and suffix regexes are matched independently
and unanchored, the matches may overlap such that end < start.
Prevent size_t underflow in this case.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 002877e4..1baf7ba9 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1280,8 +1280,12 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 			     (g->prefixes && prefix) ||
 			     (g->suffixes && suffix)) &&
 			     g->word_regexp) {
-				char *s = work + prefix_offset + prefix_len;
-				PCRE2_SIZE len = (suffix_len ? suffix_offset : work_len) - prefix_len - prefix_offset;
+				PCRE2_SIZE start = prefix_offset + prefix_len;
+				PCRE2_SIZE end = (suffix_len ? suffix_offset : work_len);
+				if (end < start)
+					goto no_word_match;
+				char *s = work + start;
+				PCRE2_SIZE len = end - start;
 				match_data = pcre2_match_data_create_from_pattern(g->word_regexp, NULL);
 				if (!match_data) {
 					log_error("allocation error %s", strerror(errno));
@@ -1342,6 +1346,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 				pcre2_match_data_free(match_data);
 				match_data = NULL;
 			}
+no_word_match:
 /* YYY */
 			complete=1;
 			char *p = work;
-- 
2.54.0

