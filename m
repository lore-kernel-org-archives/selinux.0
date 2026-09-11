Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AC43DEB3
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130012; cv=none; b=pzPq2YxR4XmHYwWsRoOVz/Dvwy5WGtC0rbv+wQIvX8jRrFJae0VNJK+VfLijuHylqJ0fw1whc00njoDFr9leP/1E9bSeQ19KnjrSrOeaIuANXkDIc72W34YIGzAf6A/lDe6urHKU3Wl342WQpnOucTlb1GJHugf0ehS0c61UQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130012; c=relaxed/simple;
	bh=r6qkHCLoAfjQdrB5Fr0+AbbfWFePPjBXt+9S/Y1BxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsD49dIAjl/Y8ZEp50R0a09rTXiWAc2nEYqi7iHVzdCGQdF/8gmShlN4mByHYj3uI64mLc28QWY5taNjTy5KU8gkFwWdm/zMI/MnlrKpKT2Uki17ZsNQLcrSHRoCK3MSRokeb70u9GW9gBJWW7jlIcwNtSJarB8kpnfVkkD3dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2y3qM13; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2y3qM13"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-939f4f694d1so30303185a.1
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789130005; x=1789734805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vq2fy3RvootsmOwnoOtlkkb6arb+NlBEA12iUo+pYI=;
        b=D2y3qM13JdO7esitUUIfhxNNDvSmsRd3Aw2DN0Qz+XdrFCVT8FoRht/CL+G/lPKBGV
         j0EfPBf2eHGefxm2lGmWEA+Z8mx0eGJexyPZm2oQya3HoKYI+cx3alZoDDFo9SiKzzHc
         MJKWR5aooq7LTjaza7NwFrB8EBrDQ9jS4YWmtEsI+SGBbOT/DVKBVhLnFlL+oXLKePjc
         JIE0V1ZSohF+J/wJl2LEtFKLaKV19y2cm3/caeWPaohhp0xuVwSwjtKfLZK07tFomDHy
         J2HQmII4MpRwg6GLu8agM2If5W6OnOdreUZWEOwdZ1jABdBImB8K+omPmFhjMCIkWJsd
         AADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130005; x=1789734805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vq2fy3RvootsmOwnoOtlkkb6arb+NlBEA12iUo+pYI=;
        b=ROciK1RDfaBiiCYRFXnu0mBdnNRxfPhrZ2sL1t/hEA7v15ipPCuRJ+JkfprPE6GwZ8
         3ZwIGenChqt4IMnyVX1PbV5YmHJ/xSwqzIDkJupt38LpoZ2oCq4DQ10yWiAQjHpkz58b
         Tf/fOkoLskxm58HU869K0bzhg454NNlujBFE8F6ZFeUWgvR86UX0NNhSBnnttxaee4h0
         KIYY9n/wUH61P7L2U0WVLWXgvhd/0WAAkKaAfk0wXFILaoeW8UnVRXQDwXzzf/+4RdC8
         DRlQW47Ug1VYrmYdN6eefEAVsatHPfFMl2TbnhoiZMoc0IvIbQV+dPBgcgZdB7SSaM96
         p++w==
X-Gm-Message-State: AFuF++mGyST98ftPPIJtgaQjyZO6MkCGpOGxcReHpVOoOII1t07NNbuZ
	dIE19afnr43jXPJQjQ/9gieBF03QZnibt5aLMh3yLae5AytwJSlj+jMu9vfMUYdx
X-Gm-Gg: AYBFou09NgBoHsMOhRx8Vd0c3pd71awPVHuHXOoBUubCYPQqtXB520s3Q0g3Xo3jh+5
	j5krnoiRggGVDlzWdnfaX/szL7LNBGFInllN1A3TwXUmQNRus0oh/hacNo88CJvjsaKTxr8Ibyh
	MhTcqc2t27oqx3gC7HNWgvQ5wbLXR034PnZbr1gOoKsA1upuoduPfp7E7vfxBb2kcedZnR9Pjih
	w+e5YlLgQ44dKqdfd+oeNBeRqTP1+AnQNk5LyWqywtWLG7Uf3X4F1PQM9pXH2jgsY7R7C/r8jFE
	HYFT7a+ekLBp+mHIWAg4JsSNrdvZvdrCHaabG4YV9++eq2Llz9ss883R1ZVRbcbJ7nUiy9mzDvj
	KSwNKf0COSqPKulX+LX416HE+5eG84rh4OiMjlYvFmt0HlUu+JvoRmUIhTJEK1b4nnjU59izU6s
	bWx8a3NrhOe+VvGQLcO5d2DUZa3StIqU2tmwbF6qhe5wOzaw9kAU02omTBe4eekOO/4A0s+h3W+
	XMMWbWzreXTE4UABkadvn0bBOjXs+2ZDP8zhNgfsoi9sDsZ6A4AE54FeeTkKpODIPO73Ez4bMth
	WMwZm3NPvg==
X-Received: by 2002:a05:620a:2705:b0:939:ad19:c5a4 with SMTP id af79cd13be357-939ea2451camr459716385a.39.1789130004539;
        Fri, 11 Sep 2026 05:33:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f18628sm231391485a.13.2026.09.11.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:33:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] libsepol/fuzz: link a trailing module into a base policy
Date: Fri, 11 Sep 2026 08:33:01 -0400
Message-ID: <20260911123301.69171-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911123301.69171-1-stephen.smalley.work@gmail.com>
References: <20260911123301.69171-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

link_modules() is currently invoked with mods=NULL, so all of link.c's
per-module remapping and copy paths (copy_module, *_copy_callback,
copy_scope_index, ebitmap_convert) are unreachable from the fuzzer.
Two of the recent link.c hardening fixes (d7a298a7) sit exactly in
that dead subtree.

If a POLICY_BASE input carries a second concatenated policydb and it
reads/validates as a matching-MLS POLICY_MOD, hand it to link_modules()
as a single-element module array.  Existing single-policy corpus
entries have pf.len == 0 after the first read and behave exactly as
before; a trailing blob that fails to parse as a module is discarded
and the base is still linked and expanded on its own.

Ship a base+module concatenation (the test-deps pair from 34610ea2,
which link together by design) as a seed so the new path is covered
from the first iteration.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index c75d0106..977fcfb4 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -28,7 +28,9 @@ static int write_binary_policy(policydb_t *p, FILE *outfp)
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
-	policydb_t policydb = {}, out = {};
+	policydb_t policydb = {}, out = {}, modpol = {};
+	policydb_t *mods[] = { &modpol };
+	int nmods = 0;
 	sidtab_t sidtab = {};
 	struct policy_file pf;
 	FILE *devnull = NULL;
@@ -80,7 +82,26 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 			abort();
 
 		if (policydb.policy_type == POLICY_BASE) {
-			if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
+			/*
+			 * If the input carries a second concatenated policydb after
+			 * the base and it is a POLICY_MOD, feed it to link_modules()
+			 * so that link.c's per-module remapping and copy paths are
+			 * exercised (with mods=NULL that whole subtree is dead).
+			 * Trailing junk that fails to read/validate is ignored.
+			 */
+			if (pf.len > 0 && policydb_init(&modpol) == 0) {
+				if (policydb_read(&modpol, &pf, VERBOSE) == 0 &&
+				    modpol.policy_type == POLICY_MOD &&
+				    modpol.mls == policydb.mls) {
+					nmods = 1;
+				} else {
+					policydb_destroy(&modpol);
+					memset(&modpol, 0, sizeof(modpol));
+				}
+			}
+
+			if (link_modules(NULL, &policydb, nmods ? mods : NULL,
+					 nmods, VERBOSE))
 				goto exit;
 
 			if (policydb_init(&out))
@@ -113,6 +134,7 @@ exit:
 		fclose(devnull);
 
 	policydb_destroy(&out);
+	policydb_destroy(&modpol);
 	policydb_destroy(&policydb);
 	sepol_sidtab_destroy(&sidtab);
 
-- 
2.55.0

