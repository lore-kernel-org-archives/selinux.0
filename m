Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB751FDE3A
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958279; cv=none; b=rJyiw6zpokLe5e3Q/j481zW07BIOP0z/exgliFkBqaYebiLolOP1jmIeFInTa8R2WsWAh2EKMnLwI/8fwoXr+lF2q8YKyK1h6/YnLMvtzcqGV6PhiFUr0HuVsx6EOpke4f8RShosXwq38mtDDG1O6eRt7JN1uIfwUmuSvgrUIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958279; c=relaxed/simple;
	bh=WTSpHsHwq0U8lrbK8pBiEXnUWMqR1OPpzcMABcfh44s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkowqgOq23zf0o3r1LvKdtqaO89lVLgtre/nwENEsXRlG7oUGvJ1PgS0uZoVBGzk5+2Pb7nDsGpamrtVFc6qOzONh+zf3Lytr+nxEeMZyThUf5XYQOyJDQRqKVbn2P+iA21J6xIf2NT5HP+sbmSjyVvakoVYFE4z0a2yaz/2jvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ib5+hjPU; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ib5+hjPU"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741958276;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UogqeOpLKixeY+Le536mRgOEghwgJLh/9gxL7hK4CI=;
	b=ib5+hjPU+FBJfSmPxfR/U6hUzeJz5XeBeet7ifQY51naQdjSjwERRXGbRvZHL8VX3zSNvr
	imaEN1EMx6qFsw4bhiQhiEmak56D/OecvwCt+nvUGKhVl3X/8NHTItbT87h7ArZpRKqUkj
	wCNOx+9NyZ5Du55U9jEp6gtp47T7CyoemwE68g23W9epf7wQqJL9nbufvTg4GPabrvKlkv
	uVvM2gnVk9h5r5AgtOl3rnmVG6Equ5oIb9GDtcjGnLrg478qN4MC7/nglsQZpJuus4DhD4
	XWTeodYL6cXGdTJ9pFirJHKebB1kbl42j3/4IpukqnH2VhOeCl2UZSm6K0wT3A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 4/4] libselinux: limit fcontext regex path length
Date: Fri, 14 Mar 2025 14:17:50 +0100
Message-ID: <20250314131751.28289-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131751.28289-1-cgoettsche@seltendoof.de>
References: <20250314131751.28289-1-cgoettsche@seltendoof.de>
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

Limit the length of regular expression paths in fcontext source
definitions to reduce the worst case regex compilation time for abnormal
inputs.

Reported-by: oss-fuzz (issue 393203212)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: add in-line comment
---
 libselinux/src/label_file.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 470e2385..67db78e5 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -439,6 +439,14 @@ static inline int compile_regex(struct regex_spec *spec, char *errbuf, size_t er
 	reg_buf = spec->regex_str;
 	/* Anchor the regular expression. */
 	len = strlen(reg_buf);
+	/* Use a sufficient large upper bound for regular expression lengths
+	 * to limit the compilation time on malformed inputs. */
+	if (len >= 4096) {
+		__pthread_mutex_unlock(&spec->regex_lock);
+		snprintf(errbuf, errbuf_size, "regex of length %zu too long", len);
+		errno = EINVAL;
+		return -1;
+	}
 	cp = anchored_regex = malloc(len + 3);
 	if (!anchored_regex) {
 		__pthread_mutex_unlock(&spec->regex_lock);
-- 
2.47.2

