Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F632470E
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400316; cv=none; b=fj97NuzgzKglwoHktFa1l1UBbP4cYTDrPwgKq0bP7TSPxp0kwea9BTQWUIRKLDabWbw72Ipij9TJ3UkVeNmFAxN23mDQ+XzHoQIXLproSvZ74pEgp6rm6DChXL0/nmcFQGWI3mJ74CU0iaxJFI+pqE6NT/l3T0FajAEcGRp2pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400316; c=relaxed/simple;
	bh=ZgY//+8aSBCyNVEik5WeebiryBc7uBmTAmM4e0czpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/xSSsz3mzsmNd/BzITakbHIz46+ZsMRgeDsUEE4YhJzMF6OBr2/55GE0jvfnwCx8YPge7hZ+/PV9MQMvPT/WpZ6w1f0usLZTkc06nxT1SerDKyyFeeak0VUu0AbF/C171elZYhVCC9jCErGlVDp3iewFMFkSOuzM4uA4U9cydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rv9XVg5B; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rv9XVg5B"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso188690185a.0
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789400314; x=1790005114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+WnAHZ8tgdllHG1P3vk2MGI5UsVuSEnmf2RdMTRZCno=;
        b=rv9XVg5BJZ7uvEPGiK3SKG9kFD5A7T5iDdhN2nDDcRQE71GESR4wqCwv56g+sWLG5g
         NJruJZBy59YD84e8w6fD8RfFzb1mmYei11g54o1C7Kxl4MgpRsyFicoR8lluIxb+7et1
         wC0B0ow4FivJYsjJUFldadJzRE6q28uAgApyPcFBk+jCgn24O2Q/DcnGB8EZGUdUPI3e
         Gsef1Sjkeuwvv099UUp/Dnjhbo125xH2w2OnqNyl3iV+sbFQC1noMTI98GzuPukNQZ09
         GQ/MKnrNVUyMpPDx6yBPlmZmxBBBjZjA1ill8JUZlamb/KlkyylSqU0ZhwJ6/qFgWwHr
         q98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789400314; x=1790005114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WnAHZ8tgdllHG1P3vk2MGI5UsVuSEnmf2RdMTRZCno=;
        b=BtLlfeExejP2/y3pbI8vTs5EjfhmiTwGuXDM+41uafknTUjM1ykOTn5qeBCSYBVxAf
         dyPwC1bkEAk5qQtw3BmoaXmfO1KAS7TvfLjC1puD65wHoJ2Aw9TXbXPnV75Lh2nQU/oN
         nqsu3Yfl5HYSgtL7wLbppYOHyRk+oNqcvM32qeGxxxR/PBHS/MTnx8ajqzZsNo2OOtsY
         2RoMemKd2I3osQACKihYv8UO39Av/WPntOb2SYUi1TmNDZGjXwXYaT0zpOEZkgbPcRlA
         fWYui4cSurqj1+JgUJ/bBsMDwk366q2EAZT3tp5wx2t2UWipZOo6+AGlpESADhVRDSBC
         oAwQ==
X-Gm-Message-State: AFuF++lJt2iGqaboBA5H8FqmWxQsDHcOVtrnQ3iglFJ8et29phHT75Yw
	0K6BifVMUMre079qGKDztrz90CSKPfhavgy5jM98uGG5PnuIxVXbQK5cmKlS0Q==
X-Gm-Gg: AYBFou16DMEW3jjznf9iyPguQbDQPVqKsVf+ffnAVtPJuz9e7QJDU+uiqFnZc/Azk7D
	zn2LjWDI5/ScwGrBwf6M+OaVlQSDM5PyaEiIvZz+PqgKGLdwNQdy9l7x5/3mdK97cxvGIDt8LCu
	8Dt9iks7Xa17YynzenAA3962EHemJJaK5wXDLhfruPseo4zI0VE5VANbpUJ/DboVrhhyUX+O2aj
	HmQSCsxNFxdBgIMbrxPJdl8f1Uuxd1n22+xNzzPiLbJ3s5RkeTnoGm04JZMRGittLD6f3nyHMpV
	8Oe6URzfvDnzjeiUUL51I3NCc46xYOWUQ4C1EFBfwzWWOiJ/VyWdG6AiuPAgtlbu4plUg7mqJJZ
	gYQBN445zuN/58yS9AD2SZYQq9kYrm8/aYBvPPprSyuxZKiVPa0JNgnIzTjXreP61xima9iHFCx
	xsDFOyFdHmH7HTlGgoTS6I1ceM+ADlRn0NZQzsmyAhNQXHuurQF8aymUOwzdIj4uWq35hzlKaSs
	HgBlN4VkUoFqyuvVyyr7PnCBYYSi0gDNwy8n23FL3Z1zUjwG69W6lSA6cCEob47HlH3S0LTA/s=
X-Received: by 2002:a05:620a:40cc:b0:93a:48a:171 with SMTP id af79cd13be357-93a29c28966mr457553285a.51.1789400313648;
        Mon, 14 Sep 2026 08:38:33 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a2d4514c7sm153240185a.28.2026.09.14.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:38:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: use the correct value in validate_type_datum() for TYPE_ALIAS
Date: Mon, 14 Sep 2026 11:38:22 -0400
Message-ID: <20260914153822.26027-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alias-chain walk in validate_type_datum() picks the aliased type
value with

    v = (t->primary) ? t->primary : t->s.value;

which falls back to s.value whenever primary is zero. For a compat
alias (flavor==TYPE_TYPE, primary==0) that is correct: the alias
shares the value of its primary type and s.value is that value. For a
TYPE_ALIAS (which owns its own s.value) it is not: primary is the only
field that names the aliased type, and every consumer reads it
unconditionally in {link.c,expand.c}:alias_copy_callback(), and
module_to_cil.c:typealiases_to_cil().

A crafted module with {flavor=TYPE_ALIAS,primary=0} whose s.value
resolves to a real primary type therefore validates, and then any of
those consumers indexes p_type_val_to_name[-1]. No compiler emits such
a datum: checkmodule (policy_define.c) and link.c both set primary=
target->s.value >= 1 whenever they set flavor=TYPE_ALIAS.

Match the walk to the consumers: for TYPE_ALIAS follow primary (which
validate_value() then rejects when zero); for a compat alias follow
s.value.

Reported-by: oss-fuzz
Fixes: 7ddf99ae ("libsepol: validate alias chains resolve to a primary type")
Fixes: https://issues.oss-fuzz.com/issues/560970829
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5b14b244..8fb8e4de 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -736,7 +736,8 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 			while ((t->flavor == TYPE_ALIAS) || (t->primary == 0)) {
 				if (repeats >= MAX_ALIAS_REPEATS)
 					break;
-				v = (t->primary) ? t->primary : t->s.value;
+				v = (t->flavor == TYPE_ALIAS) ? t->primary :
+								t->s.value;
 				if (validate_value(v, &flavors[SYM_TYPES]))
 					break;
 				t = p->type_val_to_struct[v - 1];
-- 
2.55.0

