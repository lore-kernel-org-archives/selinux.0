Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C471FE457
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353924; cv=none; b=WYiPLL/6oHninwM6yKnq6dMg4Cdjmg5K1LQPFUX5GuKqBxmBGPyrUTdSGnuezr5BP/HUZeZ3jYSl4gXrOhG4WNgUjKU8zUclYTyynTZ+yM/VpwjcoM4Y4GHPuNX9XMQauCAXxL9Tu3Rcw/2MugJ0Xo56Ij5GQcxOban821fyOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353924; c=relaxed/simple;
	bh=P15Foa6JHzzaOFhVewob59AP8AxxKcDCKSpolOV0ScM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME9t8VINi18Fr7NA2NtOJ4/5jjDB70HQVLZOaeLAtb0E/ks7giZTaOVRvWrZvzF0llImeKDF96YBXtBCcumCUfXsTA6/x7XjnbmNkGbnihzZMRVeCcsgiuypJape9GS8txeUgBSAXiCrmZ3lFHKHWlrgct1/kWIf42SnrxgKGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ugFZeIyt; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ugFZeIyt"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736353914;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYapd+49nVDxjKqRC7Ig3ItyuHoI8pVvAG8U9IdoW8g=;
	b=ugFZeIytcTc7K6p5bP9GiL+YB+hGCkdAUZGA6cWxKXQ75P4X/SkWC6VN3XTP0QtNr2FN/y
	AMNxysnomY8H/C2iZKsFjs+RRMMUp7geM2i4ezz1ryeHG4SUxoAyFFO5HSElPvSq1Lzlwa
	Vk5BaYuaDVATnepRJR7TfxREafk9Gtlm8rB91CCLANNQEXnHTxlZe79kApcWS/fbPXHT22
	rUL93Vy6baG/cUgyaKf05YwhkbzsLSESj7eRc1x0Wz4W8/JdzONl9PhvK74bME+dE4GtK6
	se/MSmkU+U+4xlAnP4pQ2EHfE92qmlcVB1bSqc+FwcfwJ8OW7e0H0Ly9uDwqCA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libsepol/cil: free nlmsg hashtable on error
Date: Wed,  8 Jan 2025 17:31:49 +0100
Message-ID: <20250108163149.104958-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250108163149.104958-1-cgoettsche@seltendoof.de>
References: <20250108163149.104958-1-cgoettsche@seltendoof.de>
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

Free the hashtable for nlmsg xperm rules similar to the ioctl hashtable.

Fixes: 1fd41f48 ("libsepol/cil: add support for xperms in conditional policies")
Reported-by: oss-fuzz (issue 388376332)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 070bf525..e84188a0 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2616,6 +2616,8 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	return SEPOL_OK;
 
 exit:
+	hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_destroy, NULL);
+	hashtab_destroy(avrulex_nlmsg_table);
 	hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_destroy, NULL);
 	hashtab_destroy(avrulex_ioctl_table);
 	if (tmp_cond) {
-- 
2.47.1

