Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4C37CD27
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222156; cv=none; b=Zdsu9JNj0pR3p1rmpUOqg/2XpjCNBbXvGZrZhj1zIosoNC5LTGMlggZb94Z8/cL/xtL7s+Myzr3AiV0Qw+p+ASxBblYOOl2v8OeFZl9VX8wHUiYXFkeAYq3z4nszDsMne1ZVhiboZDPWhMHU9hBAUi1kl4WGSY+oMYpRJyDsS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222156; c=relaxed/simple;
	bh=NeFIJs7JUt7wFWB1nZ3tiVMi2+u81JtfFifzPP5m4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXDZx/vsxOIRq8C1LzgdPDjA2iE2lsg4VCEQ7x5evsNhz96rg7obpsEj/AgB6oOYNl+Cqj47687NPTvpFR31AORIi+Ci1APnszMZQzAqPKMh/biRzcFS6KGEGVaTP/IprZAbSufvW/m4/zWEiD6pSZLCKYXukd8LeT05lhQnEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EpUBzMxC; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EpUBzMxC"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222152;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7/zn77Es0dSICyEHS3bfkyj9GKeTwolJvvbWQCYg4M=;
	b=EpUBzMxC0PqMr59v/xbKcpbi7667BTTV0asDAVE7rIQWFaLtKoXMAgAMoxw5syJxyhHuVn
	lPc4NP3GQclmH/AcdQJCFoMrG7FS+mB6ZrxosUbgG/gFxPOp+Z+PWta0nFRc3wjSJNpHgF
	mUwy8vgQXwHiZ8wTe7fizL3GepfGsWl/owI2ZiGxNEPFEQqYKPkPqyX7+g9K8I1Q520WIi
	9N25OGrEl5bLnDi/YNTdeW+WkDtltnVPtGByy3IAoRfZwdSeNYlMdK+XyBdOXm85nKUbh+
	ohXIEvOaBy/JVvbGYk81ZTY9QPfaymfvdlO/3mmjwi/doj6+5ZwrWoHsFoacUQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 14/24] libselinux: check strdup() allocations in getseuser()
Date: Tue, 23 Jun 2026 15:42:03 +0200
Message-ID: <20260623134215.98273-13-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

A failed strdup() of the matched line was silently treated as "no
match"; bail out instead so the failure is not conflated with a miss.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/seusers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e4a844df..d33e91fe 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -305,6 +305,8 @@ int getseuser(const char *username, const char *service, char **r_seuser,
 		if (strncmp(buffer, "*:", 2) == 0) {
 			free(rec);
 			rec = strdup(buffer);
+			if (!rec)
+				goto err;
 			continue;
 		}
 		if (!service)
@@ -314,6 +316,8 @@ int getseuser(const char *username, const char *service, char **r_seuser,
 		    (buffer[len] == ':')) {
 			free(rec);
 			rec = strdup(buffer);
+			if (!rec)
+				goto err;
 			break;
 		}
 	}
-- 
2.53.0

