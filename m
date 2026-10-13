Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785250C2B4
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906402; cv=none; b=c3Hvl1GF3xxtJGt8t4nQY25+LnsS2kv1sbBZGsLiglGpyBmIutGhqvNY1FM4RJTTD7tTFhuvz55cJt1sN5qoWGth/DxMPcHObDTwgBeSUrZmeOrAWPfy1ohzyJw2RIXnWqYLf1WYSIDMshwxhVghx0J1AU2IgeSD+NoObfy0LYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906402; c=relaxed/simple;
	bh=aQegBctWLNtnIkYhlp28ItX0+vwvmuvY/6JZxoGT8+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncBHSsiIT8BvlG1xoZZLvUiocAhZ3+rYQJIQNIyeQ6u6EOHawei80LAVqTnC7FehHIa2Fpma8ieAh8DzVuyooRoIYZepEwk1jGA7ISer1hxgvE09UoEmHg8xmTnFerrvd7BfTpegbFn+T1MnbZC9RZt4kGcK2/zKZAYvBiSq534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6ROp5sX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6ROp5sX"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e6fb35f91so308524085a.2
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906399; x=1792511199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8upGx0VIxlAd9XUcpv+jbhKi72IYqJgPwC4hS6/1MI=;
        b=U6ROp5sXwTvo0CUespsLKzT3AAR6ib1qa6ULIOPAxqWSOQH0gXV5RnfNDsH23hHeAP
         UPe6udDp6+wZnGkJa/MraX1xIp6QA94zDP5UcreYW/F0wd0ACs/qhkbe7fZEXtGQT8D9
         ksH1ILrU2NQ3B0cuCuw7bTXR6Nkbyt+4nFMQj/GGAZk+cDX93lW91hxWb5u+Z2XYDmj1
         zc06ndOjLiAr28tip10WCkKbbjHrT4kkcTiNQ3WiP8o1cwX5cS0vv/Mx/TvCziY5PccA
         jUOCta0RFK1/ssQ5wLqnoZs5RuB0aK5lgdLbxTWBS8JIkQwqp/CdEFbzZDUmCDJd9b1t
         QxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906399; x=1792511199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8upGx0VIxlAd9XUcpv+jbhKi72IYqJgPwC4hS6/1MI=;
        b=ZzF0BRfzfIfE79DTvyeNx3Yfkxto/12sxW3GvA+qlDoVo1hFrU8dsev70GK4jNX8fc
         Les5bWPisuaSgCA11xhDeSM9zFk0tqr14fDpB1LQ0AYqaobbtzbzXY8Glrvm6chn5m1z
         FUbm6MS20FJExhfCUDi84YAKS0z3WyREUrsYnVbvbrF5YgYE+QxpbIg8GRDlGSgGU8oG
         RXyJNPyyNWqpBZlGU29rp8Ow/cYLpBsYyp7dCDDPtirX3mtbhPL6HGl+UVGWQmUirI2o
         9k0cavvSBUt9iE+iUHDlBZELJAf5Cka2qxcwv8agz/ah/CnOIkUL0UtmhGf9tVZzj8ee
         gXNQ==
X-Gm-Message-State: AFq9FYL4HQob7DWI6M/knTOES596+hOE+IMbaXSg2kxI2P0PhCGGeL8+
	DXXlcp1dAcKuchVb8mfvBqAac6naA7J/F5cck53dKM5kXrnvk5DruU0OxA4NqlO/
X-Gm-Gg: AYBFou0oQxrnbDROZiLWonzz7VI8voqQV/EU1G3vM+EKEhAZ0MxVfVxxesXS5DDGVtP
	0qnPEHt+D1qV2KGzpAPdr/XRGJSZ/qou9dws9t9c6Pxn9BgnvVIH+lB+wgYk0YQjvTKQpFKypV5
	y611s1AqIv+ixoP/MbPxqUxoeZV0wD8j8B3Kmz4K3lDqiA2ZoAQ9+69oGiiIQ/6RyYCNiz7LyRU
	C+wgJaOrArYZOkvzMmEOx2+cLr1nZGoPU+MkvbMI3JSrcCHl60rTnbvmhlb7muRbUACYIVvSstb
	FGd/bsAXXU0JdGPbjS0Tu7HjI3IIa/Y+Ebuhi6wRSGE606B/jBIYu0mjhR3xpiSekolymTL9KQ1
	U1k0T8l9IgvodvGI8oHkDZTAECTIQe8w8LnxWxDa6EfMvOwb5wLpr88kDlR++AYrPzANmDT61V/
	uIjg2YFGmzBma7rikBYTm0DyuTI+xdvGav6NtLP8GVaFSAIqKuURJFaFBJ+T+S5Ufp1W1LpVMIK
	T9okg8nXDxHB5WOkXm+0m0DpUMhX3I87d1JpJ9kwmfCMWZbop1IUy9gflTZA3O4eq3hEKm+VRNS
	g+KO2m0oUg==
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9dce with SMTP id af79cd13be357-93ec12ca060mr1426898585a.78.1791906399259;
        Tue, 13 Oct 2026 08:46:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93efcf1bd9fsm116607085a.46.2026.10.13.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:46:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: compare policy_type, not policyvers, with POLICY_KERN
Date: Tue, 13 Oct 2026 11:46:25 -0400
Message-ID: <20261013154625.218930-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RULE_SELF checks in validate_avrules() and
validate_filename_trans_rules() guard the SELF_TYPETRANS version test
with p->policyvers != POLICY_KERN, but POLICY_KERN is a policy_type
value, not a version. Since POLICY_KERN is zero and policyvers is
never zero, the current incorrect guard is always true.

No functional change: both callers walk avrule_t lists that only carry
RULE_SELF with AVRULE_TYPE / filename_trans on BASE/MOD policies,
where either expression is true.

Fixes: 1c91bc84 ("libsepol: reject self flag in type rules in old policies")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 0a106d18..7a7c613b 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1307,7 +1307,7 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 		case 0:
 			break;
 		case RULE_SELF:
-			if (p->policyvers != POLICY_KERN &&
+			if (p->policy_type != POLICY_KERN &&
 			    p->policyvers <
 				    MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
 			    (avrule->specified & AVRULE_TYPE))
@@ -1885,7 +1885,7 @@ validate_filename_trans_rules(sepol_handle_t *handle,
 		case 0:
 			break;
 		case RULE_SELF:
-			if (p->policyvers != POLICY_KERN &&
+			if (p->policy_type != POLICY_KERN &&
 			    p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS)
 				goto bad;
 			break;
-- 
2.55.0

