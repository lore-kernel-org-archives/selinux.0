Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F91A071E
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=mFI6w3d+r4h0ZwQFQ566Ecbi9I++4gnyGlU4dFKWN85ZbzphCcb7JrjLYooNUwcd7QC/MkXtTrqHxKhVhGDu7l/rSIfgchw3TarnhGNzuEFGJyk5c1IiL/nFIuvKXndzCIvUNJxMTBv5f2nD43WUSBuxfZpz/vmVgW0J02VJinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=NgIXJRoCJBeWazQ9Uh7zYzHT2DHr15wc3S/jQwU6+nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyhoD8bIYBRFic71D+3m6bUyW/Xr+C8FXXv3+4t/mQ/bpsN2fW8DlMABc+Q5D9fUoTc3z+zKqkM7mwSi3kO6oFK9k3y9J2ScatqHmWG2fJzdHwNt6xcSYcTlY3wUwP5khMIJIZ8qeU5f3qfpKJBZPEjzVnKGjmCB0FPW+gGhOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PYkW9HFL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PYkW9HFL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZqOO2qEkP9MzUnFTSK/Pw60wAPzqnFLJtvJueEXL+4=;
	b=PYkW9HFLFrgwn3+mzD+bqu9IZzRAybrAhLmmCaG40YijH28Bfivr9g1Y875AhLiLzup1ph
	UBI532O4fCpXzZQGtGqukvvIFvkEh6V7FklAiB+GUa6chhaBHHpFjRZsjFt62YKecNQYIc
	+4zqSOdP2GZzjeRBYoWCN4mlb8uu456WmaA4F0rDAY2Xb0x9Dhhnf2alhYH0UAfzr9VNbD
	BwkDUxv+Kn9j2XIE523WqJzPZKYISn9zs3yyb5WwdhaV31umqVLbMCALnGU+dXXmQmbtFH
	K+A+w3KQtnvf9+bO1/U9epQRGUHHBlERzbN4MWBQRrMXPlVkippJWkq81xe2ew==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 21/47] libsemanage: handle cil_set_handle_unknown() failure
Date: Mon, 11 Nov 2024 15:16:40 +0100
Message-ID: <20241111141706.38039-21-cgoettsche@seltendoof.de>
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
 libsemanage/src/direct_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 66a6fa66..a262fe09 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1353,7 +1353,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		cil_set_policy_version(cildb, sh->conf->policyvers);
 
 		if (sh->conf->handle_unknown != -1) {
-			cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
+			retval = cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
+			if (retval < 0)
+				goto cleanup;
 		}
 
 		retval = semanage_load_files(sh, cildb, mod_filenames, num_modinfos);
-- 
2.45.2

