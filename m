Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FE43498E
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895682; cv=none; b=kHUL3CnkTfNtXmwrYLH6Joy7DgNiCtVHPL+ydt/5xNK+VkUPGzBTkKKzXHIPK/NC18Xj/OaXlZedmkapiDoOYQjtH6xjq2U08eoXb3vch7kFTgWtp8frN4zAsY73+MjRu6XP1zK74OkXv7sKjOo6LrY9ssGUSQBvUF8Okxab1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895682; c=relaxed/simple;
	bh=jUs83jxevluwHWPU3rDWklei36QeCVERA9EwdwoN3pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQXmQFXGQs/YII/S1X92A+Wq9nWEknyoDZ/+rTjT1P97ujb3blzGBKSmcs9wWx66zVl7/a2+vzuM4U5xOIU4GTKNzhd+1yOzApLOD3o3iSvlChXaRcAflToS7GVihmymcnB4jd9m9BsbFRl6yxeRlhRG+X5lcELPI0+7c2nDVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT09FoGF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT09FoGF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53069ec6e61so37397991cf.2
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895679; x=1789500479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTLZ05PY7+QkBMAs9Uy5gCF0UudnIvZHC8n3xv0EwVI=;
        b=VT09FoGFhB4oZ0QQPs1Jq80gJzN+JHvEuw/A5IOfBLaSoIayRfHM21WK9IP+btGvyL
         xqb8LMbmPr/7rUF/lf4J32ULiaS4m7a3TdjIbDCRMMoVf6EhQepIKWRt+Xw38GJDo2dT
         HzuhCdM3xGBebSdVG7+7Y/vshOyZFrPMhXaYEHgmGRumvuFLXFXNdVjca0r466sX96oK
         J+O0s64JYcufR34afLf19WNq5c64heU49Jo5UPt1K5fdwvipP6FqB2mY4qIM9Wq16shE
         Pm0aFazcmpjL3n8NbC6ywVBxGBddfUfebWfKzu6rlNLkVROPN5NDf2fxXx0H4qs/bInw
         EWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895679; x=1789500479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTLZ05PY7+QkBMAs9Uy5gCF0UudnIvZHC8n3xv0EwVI=;
        b=qgMD/koj7T6r5puWob8YMD2DpM611Ythu92MUdGmb1Q3JhhkEJo470/DibFGu//E2m
         f0TeGJFOZhegw2fJ43CPLfbd+OI1acbarkTdrtUybdQCsni7dPaP8lCBqbK0f/Pr1Avo
         MbPMkHvkAdzQeR9ZnPk+7Qp1we6McbX63isroitegFKPY/SQuAmn70m+ZJ/67Pycpe7D
         YmSXyxDUkUS1D9itTaryAvMV53VpHv1MzOYa6odWhuMWaUqgKWqmZQ77hOZFJPezTJSe
         A9cmaItez+wPTTTvlP42cxci8SAbsd36EcTF52pcoFMZRjGno+43Bk4qvXnagYOG9hbO
         SFfw==
X-Gm-Message-State: AFuF++k4oJFQ0uRa3NOvc/B8hsOVU6gXU07a3gdbGJOBlHca1IgiJ9h0
	9SCqXGa8PBFkthiZYlUJ7jYZckeR5fg3hA53rtM+BoXBJQKJ2zVwBeZhW2YvZw==
X-Gm-Gg: AYBFou2CyNyakOza//3iFJiH3ftYylfPl62uhhKHKSpezYaiRAWPWtJyuFYN5maquJS
	NZotViz0pLjsDUdJJBE7kkJ0TAXhhTiyesJBVnUXtzpIF/HK1bomojtgjPWakpIjkvEBvnzZ1pg
	l7m23YvtIPv2PWRIfD9zbruRlFycq2xWPTZv/YaJNNbqGsnQFdBTJwDyih7DMMKzSdSkO6XMHL6
	C398FENkH4VJ6KiwHUTfFhlNarHhV+eoo6W5otYHfl6qgfKXLejLMIGgzTziFYACKQZuhn7vAKu
	2PhSoNFD5vWxXX+2d0WLxRXZRGuQ0oEAIHi+bpuvLOo2cHCkk2pcCsigY8wphZSE4jsmmCygkin
	22zEMLwIJF2GCv4xbLHVhIPVN6M9j9355O2aIMsQ0qxqWWzsNeWGAKe1ge8GIYBQXZda5/VmM48
	9LDYVaSFubkAfPVFMPwhWi5Yx9W1OGTLlTfJSsAWVb4EaqPMhVBmPZohujGKzE3ttaJARA3b/d/
	LVcKED7MRpraiRyvXXHW4UQLKVm1HiJXRO5CsI8JFT6oMlq5xUODJE+1Fup2LxA
X-Received: by 2002:a05:622a:30f:b0:52f:64c4:8094 with SMTP id d75a77b69052e-530549ef48emr345308611cf.39.1788895679188;
        Tue, 08 Sep 2026 12:27:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5308a706823sm47606551cf.24.2026.09.08.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:27:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/4] libsepol: validate genfs_seclabel_wildcard paths
Date: Tue,  8 Sep 2026 15:27:41 -0400
Message-ID: <20260908192743.21663-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
References: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the genfs_seclabel_wildcard policy capability is enabled in a
policy, kernel_to_conf, kernel_to_cil, and module_to_cil all require
every genfscon path to end in '*' and reject it otherwise. Check and
reject such genfscon paths up front during policydb_validate() so that
no validated policy can reach the decompilers with an invalid path and
fail there. While we are here, also validate that genfscon paths are
non-empty since that was dropped when I removed the prior string field
validation since paths can contain ctrl characters.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index ae879d5a..b5b18dda 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1680,6 +1680,9 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 {
 	const genfs_t *genfs;
 	const ocontext_t *octx;
+	size_t len;
+	int wildcard = ebitmap_get_bit(&p->policycaps,
+				       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 
 	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		for (octx = genfs->head; octx; octx = octx->next) {
@@ -1693,6 +1696,13 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 				if (validate_genfs_class(octx->v.sclass, p))
 					goto bad;
 			}
+			if (!octx->u.name || !octx->u.name[0])
+				goto bad;
+			if (wildcard) {
+				len = strlen(octx->u.name);
+				if (octx->u.name[len - 1] != '*')
+					goto bad;
+			}
 		}
 
 		if (validate_string_field(genfs->fstype))
-- 
2.55.0

