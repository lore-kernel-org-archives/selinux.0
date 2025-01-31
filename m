Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3B42AA1
	for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346588; cv=none; b=mCXHnymPPlXPcOQoPLYFF1BwwSC3xsrIygIOpmDeYkDrjeg+CsEfQh8nhUVXto7DEtcKUI8NU4rubUh87SmhC34jNEEljwg3/We7u90zlqUlWQJ5i0s+m5Z6KWNQbImzZkhg3iLiI5d+b1scoI0B93HdyXKJ+S41RYSIccii0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346588; c=relaxed/simple;
	bh=Gsp+eWv/ooh2BV906VmWbsjfRLcHq8Km69BBI341dmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvbWrfEC6NwT5/H7G5o7SYXjjvzDmidZjQwG7giUQ8VWFwaXX1KSMVkg33vdecsDr11u6dcNoJmOIFJlqpZOsvFWpmoO8NyjY7byftLYt683CTHTqDR1+sqkNSnhNRC0GVxhbSOwX8h+4s1vXA8Z8M94XpDknRymBvjn8EzYK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=j79eEqkj; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="j79eEqkj"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1738346162;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eitghxm1A7gw8QF8qRkdLkAOEKgmS93NACVjLyz0NA=;
	b=j79eEqkjCIrbesN3Au7G37kLErYE7R6+G50ZNSdSCDZpA2gC6xNqLZhDV8V6yq7bRJqjb7
	xuaqdD9hsKtdhcY77hmtz8cUxHCcr+LedDDvbgG490go5QXgbo/RXTBfv3WWjBuO/BCG7I
	3WAor4SKhkuHmFovccqiRu95XPGIOV3YL4tdAqd0eiWgL/XUnxZhbDkM6MbuPISB4t2Ug7
	Od7M1em9flEz5+bodl94lMrwNqYgt/ex9b5/4gwNrZ9gvD5D0ob6SGx9YC8gNL6pjo74sM
	r9TRRuaRTBVIEeT3bhGGb0q0pDzXISqFEeolrr72oHNo6ujxihzVkcwWkyNbiA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] libselinux: limit fcontext regex path length
Date: Fri, 31 Jan 2025 18:55:56 +0100
Message-ID: <20250131175556.21836-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250131175556.21836-1-cgoettsche@seltendoof.de>
References: <20250131175556.21836-1-cgoettsche@seltendoof.de>
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

Limit the length of regular expression paths in fcontext source
definitions to reduce the worst case regex compilation time for abnormal
inputs.

Reported-by: oss-fuzz (issue 393203212)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index ad7699e6..7a9834a0 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -434,6 +434,12 @@ static inline int compile_regex(struct regex_spec *spec, char *errbuf, size_t er
 	reg_buf = spec->regex_str;
 	/* Anchor the regular expression. */
 	len = strlen(reg_buf);
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
2.45.2

