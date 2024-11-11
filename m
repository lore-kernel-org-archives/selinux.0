Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E21A0AFA
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=DvmAKBrM9mb6tP2s81AXa558xa4MZFJo3//wb5f1n7qe7/CUEF+XWMQV4mUTL7Ygm4pR/GQBpmXbxYDoK1YihLkkt+qTyhBS/tJwcTF0O6mre8TgcODlLDuK0HWIuhBUHmkSdVhby3LwxD6bmex0uDFvfNNgVJiJJSpS4PgJTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=U4G+mP2sCgHQb1JFYaCWdEf/uSv7HUjJY6PU+8KIjg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF7fxYHyO1CssN6mFSpRwpgRfH84MTRJUTwdpqFvvir4wL5KdqWFdhuGnSWubNplEam3cRnLoAL1335CsBNzETdndKFsA9dfj9d909Ooh7g/TUgbwA+CxnNQcJHAvsuSJnvOqyG0w+zxCqh+d+fR/o/skaNPCS1R44Yk5jLTZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CW30iPxQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CW30iPxQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334640;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjl50UKi5rhHt01L3BdcEnxDOBWRdPK/I3dGhkS4keE=;
	b=CW30iPxQsDdkMN5p/w2+BEsN8XIJFMbRKKnqvJbrNE69JAsC1zWq+h1DeEV5lqW/v0gDxI
	x+tszJakY/45NNPKgU8H3cuBjRPm3Bv68s+u/wUhxzmewMZa3uOJGiKv6XfJ1KjX6t4vFj
	/8dkUEwo1Uw47yHulvA+t7naUZTz3okvdmW806DBZnGlUsOFbUxHQjJYi40N9JDAoAY/Te
	wmiKPLeJMH6UkI30foCSsvbJOJBld9UYDzG7UrufenAzsbWFqOhdJf78LcpEjxyTw8ULLC
	tWp+GAZqUdbfrT21Vv/Ih4E4F47Z1IKutNs2seeZRt4tmlcjmhMvr4o5uTFgcA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 38/47] libsemanage: avoid strerror(3)
Date: Mon, 11 Nov 2024 15:16:57 +0100
Message-ID: <20241111141706.38039-38-cgoettsche@seltendoof.de>
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

Use the %m printf modifier to format errno in a thread safe way.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/debug.c          | 6 ++++--
 libsemanage/src/semanage_store.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index 1e375694..a2708279 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -79,8 +79,10 @@ void semanage_msg_default_handler(void *varg __attribute__ ((unused)),
 	vfprintf(stream, fmt, ap);
 	va_end(ap);
 
-	if (errsv && errsv != ENOMEM)
-		fprintf(stream, " (%s).", strerror(errsv));
+	if (errsv && errsv != ENOMEM) {
+		errno = errsv;
+		fprintf(stream, " (%m).");
+	}
 
 	fprintf(stream, "\n");
 }
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 98ef2524..68bc8c41 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -739,8 +739,8 @@ static int semanage_rename(semanage_handle_t * sh, const char *src, const char *
 		return retval;
 
 	/* we can't use rename() due to filesystem limitation, lets try to copy files manually */
-	WARN(sh, "WARNING: rename(%s, %s) failed: %s, fall back to non-atomic semanage_copy_dir_flags()",
-		 src, dst, strerror(errno));
+	WARN(sh, "WARNING: rename(%s, %s) failed: %m, fall back to non-atomic semanage_copy_dir_flags()",
+		 src, dst);
 	if (semanage_copy_dir_flags(src, dst, 1) == -1) {
 		return -1;
 	}
-- 
2.45.2

