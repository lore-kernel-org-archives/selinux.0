Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710184D0B
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408298; cv=none; b=tqpnrmp9wnSeXqwIPrwEoIEmes9wSP9irCiRD5vutqx+YKqtUtObkMIqXllSYFRS+a37Io6qGV0boJEkGCviRqnFGkcflRwNjrWlSaDvfpdzXvBiYEJvCm/3Y2UkxxdWqP6iZUFf/tlAKpR1ipFc3MBqY2jxbTx2c2JfBjI872Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408298; c=relaxed/simple;
	bh=2Ksz3HFsz8lv9fCcQGfjGu2bxdrckywQ2xdnE4tFWuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq/+WdUD9j8aEMT92HkwTpXHwRaxOgvClRqhpoFC5r+rwarW8+fu69tXiof5KnSZhiQR0n3s1x3vgCkv8TgRC09uKd7xBPfDvEvORE4xJfvhk0cJpulMWY8HwKfyX/QWfXplE1oNyMSL4VvCtj8todzTP4aDi++AvEuGOqtlt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nOA4GVMx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nOA4GVMx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408287;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hacdkDRiPTOZCSK+irBshyhb+T7/7yQsg34/4JXp39c=;
	b=nOA4GVMx85aX8T7vVjHavfqXXRlOi587IZ80vfu17konbGxcOH+rLqScW7/unWxt9mvfY5
	JARW+p6vm+XE3VkAByKIARIUc+UhnNciWuXRWj/02fwaBSCTKFJLxT+S7Iv/JevUJJ3+mI
	/eA/18qOXxB/1EuQJhgl3DzbjzdQLDD/HNUIRoJtz1catT0ZJQgei+KANBtCre2Wrh0n33
	Y/Lh9IShEs624QfM8KLbm9H+0qz3RWGGdN/xyFbl7/8Tn8NlFczhAFsRnqW88VJyUCltCZ
	S1C7vTc38t3oNRCGEuCgqLjA/Y8M01M7VLyyVb99asByLrGrzNldy2RDfOFY/A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/5] libselinux/man: add format attribute for set_matchpathcon_printf(3)
Date: Mon, 29 Apr 2024 18:31:20 +0200
Message-ID: <20240429163122.63181-4-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163122.63181-1-cgoettsche@seltendoof.de>
References: <20240429163122.63181-1-cgoettsche@seltendoof.de>
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

The parameter for set_matchpathcon_printf(3) is a function pointer that
takes a format string with variable arguments.  Add a GNU printf
function attribute, if supported, to enable compilers checking for
format string inconsistencies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index a0948853..83ea871c 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -443,7 +443,11 @@ extern void selinux_flush_class_cache(void);
 /* Set the function used by matchpathcon_init when displaying
    errors about the file_contexts configuration.  If not set,
    then this defaults to fprintf(stderr, fmt, ...). */
-extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...));
+extern void set_matchpathcon_printf(void
+#ifdef __GNUC__
+   __attribute__ ((format(printf, 1, 2)))
+#endif
+   (*f) (const char *fmt, ...));
 
 /* Set the function used by matchpathcon_init when checking the
    validity of a context in the file contexts configuration.  If not set,
-- 
2.43.0

