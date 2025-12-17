Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A335C1A9
	for <selinux@vger.kernel.org>; Wed, 17 Dec 2025 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993779; cv=none; b=NCpBQS8VcrRk/OEEeqf7iKly7IgkCzgFaAE5Z2dH+i7XTf0TGdhOJPxpCbaX74y3o4qfnJRGAQokb6dG30grbglf+YilxttIiGl3ni+zJpjuIw5DkRKnZa810vlHY2ck/PCWc8dHLD3K9yjIguJsgRRPtUhCFpm7qMd+OMJR3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993779; c=relaxed/simple;
	bh=fMBq638nPscM5PKDnGAPfJwd9i6DUVibrg2uIi8QUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5jpGUyP6cIbdjHDFhv2Gl+FVVXA4on4CIO4zAJ31+foNC0NRnd309E8dC1PsGTLucQ4LsJ8hWNn9P6Tk0DlCcyjnn4OT3QjMTh6gDJkuQe3PY/RHzyNp+/9w370z9HGHxZVJkArjDj4JnyGIIOioSHycIrgNP7sctWFi9GBTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NloVgll8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NloVgll8"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a22eb38edso31696676d6.2
        for <selinux@vger.kernel.org>; Wed, 17 Dec 2025 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765993774; x=1766598574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPlV8NJ3zbXR1oxxsfMXmZhGyMwV3aK7aZbDHsL44p4=;
        b=NloVgll8sOmJrzd5+9fzTSKrQF49fVTA/W70yOarylX8/KxOu1OfCcSOBKAxZq/xN4
         kWI32QK0pFU3w4hw459vvHBKUNVIvQNitJZxO1mbDUAB9IYP8TcbPTN2fgnz22wgPmB0
         OW7ElvseJC/sjtsTHCbkBgD5RwyhtdfBKXegVpnO2lj3YbnRTc1RJjlIiD3fmIYs/y9v
         v2nNSeXy0GZZvlzAQbzvCAf4xB/QI2YW782Xgn83ZGtr1ZZrEbayC9APRrp1SaJONSsP
         wFkmGb5n+jLcJPk8bacTQ4BpB67Ppe617aneE0mip95Cu2fgGkG54+STV+wB/Ybt9442
         47Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765993774; x=1766598574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPlV8NJ3zbXR1oxxsfMXmZhGyMwV3aK7aZbDHsL44p4=;
        b=d2eYSHNl/K7lchTrRHYKSIvZuIymrJx+FmvNLvxe5u6qA6d1Cqm6FxBliQny3HYJ+Z
         95pw91YRSUUGTsNUpgGesIj3fLbnds/BANKOhs9MYZHWeW69KSNBUtL47e6YA09uBiT+
         h6lPcz7Wh0i3uWoWh+KQ5vFPCrqJdQ/QgdzeNGbjv2TWDY0GADayXiRXkwHWv5z5x5Cz
         7aqDQMDhR3niKkW4/vOvdiWSVr3MmfKwYSH5b0GF+JBUxd+bii+rUCZNal/eGymKuMKD
         3um7AmLFQwj7vtAGnkJemjj6jTbAU1NlsXBDcFq7UIgJKrHgRQ4uedZx0xT8QJNq7nkI
         MxbQ==
X-Gm-Message-State: AOJu0YynH7U2xSfgFTHyGd4ngmtHUfTVvqTSQPzvs7jAulLg1MAGn6DG
	N8fUgSOKQLsjjdzEfhy5xYJI49qDF1we4Wg7iNrxlIedUEGPCKl/0razP4zq4Q==
X-Gm-Gg: AY/fxX7oiw2ozLcHwgAT2BveGrn2m31xc/88u6+mdbtcfS03PxjsO6kc56Zy9K0phol
	XpZfvsoNLZuXCfwqPhC0f+ih9nKclbIHhVac3sZIvgqkfC4s31vhhSjFjDvqmixKdRhCnX/3wtY
	tBXHjjbzN36jgs5YA9lqEVbCVKzPrvE/KOQM7OnI5hDsgFbg0PnKXomZ58WPtkVgW5Cwf8cR3HU
	2x747H6r6bVy35FjgQzT+rq/q1yty4SHXV+5RRl/ssbL470b09etJ6j9vLjDCM4wXiPd6C7rHUZ
	AP9ILpBOxp/eVZlrVcfS3g11bjGbZHD4GvBpl1f/G/yjuJlkcwQjJ/dYEJnIhz9wy7pwFZRDKlo
	7Uyz/WEeWNY8tCxBbBFyzcmBr+dN6pYdxYm5FV+oRflgg5mJo3KAQUUveglcycDCS1fXMeE2Pi/
	+rDnSpjz13I4QG0mZyiBI=
X-Google-Smtp-Source: AGHT+IG0gSj589uhnl3aj8Cfr4nxz82LIK3acTTIOraEGw8za7TcvT0GRgeehdMoZS/ACoe0L4kuwA==
X-Received: by 2002:a05:6214:2dc4:b0:888:87ea:c7db with SMTP id 6a1803df08f44-88887eacc37mr296031526d6.39.1765993774001;
        Wed, 17 Dec 2025 09:49:34 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089aeb8sm186146d6.28.2025.12.17.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:49:33 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix expand_role_attributes_in_attributes()
Date: Wed, 17 Dec 2025 12:49:14 -0500
Message-ID: <20251217174914.189853-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential NULL dereference when there are gaps in the roles in
the role_val_to_struct array.

Remove debugging messages and provide a better error message.

Checking "!done" is clearer than checking "reps < p->p_roles.nprim"
for determining that there was a problem expanding role attributes.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 04b5e5e4..74f03c87 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -875,7 +875,7 @@ static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb
 	ebitmap_init(&attrs);
 	for (i=0; i < p->p_roles.nprim; i++) {
 		rd = p->role_val_to_struct[i];
-		if (rd->flavor == ROLE_ATTRIB) {
+		if (rd && rd->flavor == ROLE_ATTRIB) {
 			ebitmap_set_bit(&attrs, i, 1);
 		}
 	}
@@ -887,9 +887,6 @@ static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb
 			rd = p->role_val_to_struct[i];
 			if (ebitmap_match_any(&rd->roles, &attrs)) {
 				done = 0;
-				if (ebitmap_get_bit(&rd->roles, i)) {
-					ERR(handle, "Before: attr has own bit set: %d\n", i);
-				}
 				ebitmap_init(&roles);
 				ebitmap_for_each_positive_bit(&rd->roles, nj, j) {
 					if (ebitmap_get_bit(&attrs, j)) {
@@ -901,19 +898,21 @@ static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb
 				ebitmap_union(&rd->roles, &roles);
 				ebitmap_destroy(&roles);
 				if (ebitmap_get_bit(&rd->roles, i)) {
-					ERR(handle, "After: attr has own bit set: %d\n", i);
-					done = 1; /* Just end early */
+					ERR(handle, "Found loop in role attributes involving: %s", p->p_role_val_to_name[i]);
+					ebitmap_destroy(&attrs);
+					return -1;
 				}
 			}
 		}
 	}
 
-	if (reps >= p->p_roles.nprim) {
-		ERR(handle, "Had to bail: reps = %u\n", reps);
-	}
-
 	ebitmap_destroy(&attrs);
 
+	if (!done) {
+		ERR(handle, "Failed to expand role attributes");
+		return -1;
+	}
+
 	return 0;
 }
 
-- 
2.50.0

