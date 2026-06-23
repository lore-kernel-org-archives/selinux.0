Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC82BEC2A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222156; cv=none; b=E/EUPsIYf9uGoO/0eeomCr9LUlSE4q3+xmYylKw7cEGpizCHZgIfNJqryB5CANLyPc3jHznpGzCDV6+rPbq16Jhyb34sUhYjVaMxtC/gqfRRnb2dSfn6Auwi2Y1dgnZ/5Pa7T8KAlMI+kK8n0+CQUW4g0r7A0cQTprS6ZcfD6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222156; c=relaxed/simple;
	bh=w8n/kNFAuQY2Cfu1UmBkBS08MCAgM9SV0uUzYvyjwrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAWk6we/asHBNZeVcd4yspUlhMbpn+E2GnvvrwaNfhKRGLaURgdNFQdFdUkkyf1C0fd6m4Mnts/1E5WwncONE5DvsoGm4U9byppuau5t0wnhlYeR3TMSOaW6/CIZiIW6pkS0TGceVf7C23k2mKi4/Z7+exaIb3YG3JUubRomMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rFyvBLWU; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rFyvBLWU"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222151;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q87oMUOy54S7LKmbM2x0UawpYzKEfkT3TH7KcYnPpBk=;
	b=rFyvBLWU5UaExd94dtj6vvFXch6qjU1K3X7JppQMRVx5ZE4qFTJYaDwaspFeZg6BsPUJvY
	k3fWB130HCysaJkXU1fKzymnECHbMeOZaMaulJj35EtzDzFHBKvgOw1wojJLE19H+S8tSR
	m4dHXAJgLBUDy3EajSwPsd/gevJrtBhWgareYA/IdNuDkh/E0L7TmzmEf9+0HYboKV7++B
	grHzuJ7MEW7brHMFdIsLYGpDnU32dIbgxC5NjOAAMcyeUdfZlXI3QrbvVdrWgNpfeJX16I
	tnyAgN458zV2cgQYMl1u+4mH702pFeHEEQkoovYh+KktH3AA2bv6fY0bM75HAg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 11/24] libselinux: bound permission loop in selinux_set_mapping()
Date: Tue, 23 Jun 2026 15:42:00 +0200
Message-ID: <20260623134215.98273-10-cgoettsche@seltendoof.de>
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

The per-class loop indexed both the caller-supplied p_in->perms[] and the
fixed-size p_out->perms[] (sizeof(access_vector_t) * 8 entries) with the same
k, stopping only at the caller's NULL terminator.  A mapping table with more
permissions than the output array holds would write out of bounds.  Cap k at
the output array size.

Also drop a double space in the log message; the neighbouring "SELinux:"
diagnostics use a single space.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/mapping.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index 6b9071ba..ddc11dae 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -13,6 +13,8 @@
 #include "mapping.h"
 #include "selinux_internal.h"
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 /*
  * Class and permission mappings
  */
@@ -79,25 +81,22 @@ int selinux_set_mapping(const struct security_class_mapping *map)
 			continue;
 		}
 
-		k = 0;
-		while (p_in->perms[k]) {
+		for (k = 0; k < ARRAY_SIZE(p_out->perms) && p_in->perms[k];
+		     k++) {
 			/* An empty permission string skips ahead */
-			if (!*p_in->perms[k]) {
-				k++;
+			if (!*p_in->perms[k])
 				continue;
-			}
 			p_out->perms[k] =
 				string_to_av_perm(p_out->value, p_in->perms[k]);
 			if (!p_out->perms[k]) {
 				selinux_log(
 					SELINUX_INFO,
-					"SELinux:  Permission %s in class %s not defined in policy.\n",
+					"SELinux: Permission %s in class %s not defined in policy.\n",
 					p_in->perms[k], p_in->name);
 				if (reject)
 					goto err2;
 				print_unknown_handle = true;
 			}
-			k++;
 		}
 		p_out->num_perms = k;
 	}
-- 
2.53.0

