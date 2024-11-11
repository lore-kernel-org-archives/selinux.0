Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D119F40B
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=cF3KDxrA2tHlgsVujQsEnOoOhPZh9pgCr5rdw9RlSAt2f0L4Y5+ciajIf1UkpZIwF95dbSHWqjt2liidl3ZRe1b8EyOPSHjVivZiJhuLZupaw6SSB0nYgAlwrep0x7z93Kk9S20HNeVY460sQH2QOki5t/nmzaMboyS1YY5/1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=Ew9T5vXFjGUbOfAcrJKejQe8vq4fj/cuGNmDS+zuZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqiTBS7SRcs7HhzhTYjq2nv0hmO6cpV/n7MQb3jSNnX14RAoHA15rXhSGRsW3ijLpRTaM/Ne1OZ9ci5vnd5wd4ekyYb+R08wQ0Wr9ArwPZuihs5PKRSy1PS8S8cabF2ff8mGiH05e9i0krLDO2oM9KVLw+Cesw1v8iHt4qAU230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=X1lEeh2G; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="X1lEeh2G"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3AzfBnbeSKlt8eXAwPxGIEqw+5cF/4EyhUIt/fuX4k=;
	b=X1lEeh2GFMH0cGRJwbfiKVX6JgXhtiscR5/GTG/gloGUC0ztqbDZFlCb/6Xfizv+8ixjlj
	mrmpt3GvKJr2VuyY7JqGrSBH4A+jbVLJToTZFJ0raiafjVeRiax2yJe4u+0L+nSKtTAKva
	wrcboQaROvDRwmtWR207wZXMrIf9/yatVKwRDF/TidgL1jCvBFWwMwT/4zDA1nAsZlr3HT
	vuaP2gffPpHPzkNEeV8YIytnoZbtagRNcnvoG9Emj+ft6+xwGM71tz91pmGcHh5wxxVohX
	ZH3D/3+Kau1BQh+gM48OS4ZVNzc+aWzA0TZzgpW8It9SCxLlb2JwhdfXqkxOjQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 37/47] libsemanage: preserve errno during internal logging
Date: Mon, 11 Nov 2024 15:16:56 +0100
Message-ID: <20241111141706.38039-37-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/debug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsemanage/src/debug.h b/libsemanage/src/debug.h
index a18a95be..506b9db0 100644
--- a/libsemanage/src/debug.h
+++ b/libsemanage/src/debug.h
@@ -23,6 +23,7 @@
 #ifndef _SEMANAGE_INTERNAL_DEBUG_H_
 #define _SEMANAGE_INTERNAL_DEBUG_H_
 
+#include <errno.h>
 #include <stdio.h>
 #include <semanage/debug.h>
 #include <sepol/debug.h>
@@ -36,6 +37,8 @@
 	          channel_arg, func_arg, ...) do {         \
 	                                                   \
         if ((handle_arg)->msg_callback) {                  \
+                int errsv__ = errno;                       \
+                                                           \
                 (handle_arg)->msg_fname = func_arg;        \
                 (handle_arg)->msg_channel = channel_arg;   \
                 (handle_arg)->msg_level = level_arg;       \
@@ -43,6 +46,8 @@
                 (handle_arg)->msg_callback(                \
                         (handle_arg)->msg_callback_arg,    \
                         handle_arg, __VA_ARGS__);          \
+                                                           \
+                errno = errsv__;                           \
         }                                                  \
 } while(0)
 
-- 
2.45.2

