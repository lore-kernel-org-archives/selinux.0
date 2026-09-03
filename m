Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FE4189DD
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435400; cv=none; b=C1A3e+S46ehJt4fp8y2d5qJWma+k6LgTF1YzkuBl79Hs74aMmh1OFrUhtxocsPxg53BmADWBLj0AN6sBFVc0LfSfZ/59LB+BiJSNuE9PKG7Yi2YvffMWtNbD3AU7jJusX+l/u/hQ8Ssy0V289T2RHddiSsglr1MNYqLAOOAruwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435400; c=relaxed/simple;
	bh=N8jHIY0jQMkilWOz/PCtM98xukvqRAfgwQPT4EUp2GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCEIGTKSVto9izrLFFjg3A6V0iKnJwgiQUVUFQ6Y7u+gHyr3mKUgJ2XARBW78UIC5rLQkKL+LPaa1MvYSNxk8kSXdVZWmKKRRtD6/oXXqRK/tvNwq15gQ82YNBKL4/kaS0pVEp3UiC/YSG4EIZlHYZ1aa20W/N7MS9rlTsPi6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tLVvFDS/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tLVvFDS/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435382;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEAfMA/2z+CtutzMnpOAHVU4x5qhQEKanIypfGCziQ0=;
	b=tLVvFDS/cvT7OFvAlSxOII+DFJgCf+cr4jPoIZQcpENiNkPGXkpsX6emedJzu7aaKp5qMx
	C2Ic0F4pYRHiGbt3IgFaJ+zi3KxV2WF7aaEm1PUh5niCNfQvOY7gS/+6x0OGsjh5962FF4
	Tkt73lIvOL2VR+AJzGozTW3f2eMryQzSBwebdiBJlvDLS5eER167wBILvDnZu6t4mD2lbc
	n2c+oDBGmAY7djB5SfraPTX5pqcUtt90+T6lICy4PrO8X4/McNusdOrRwEvEHOPxvo5ynr
	NjDHRDFvaNlkFLK+GSn9Hs8I+bq0iwsSjXCQHBWHgFPlXbHULcLGbBH5b6i7DA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/5] selinux: validate permissive and neveraudit map types at load
Date: Thu,  3 Sep 2026 13:35:37 +0200
Message-ID: <20260903113538.72942-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
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

The permissive and neveraudit maps are read as ebitmaps and indexed by
type value, but their set bits are never checked. A bit that is not a
defined, non-attribute type is silently accepted. Validate every set bit
of both maps in policydb_index() with policydb_simpletype_isvalid().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index efa8df26791d..c901a0148034 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -892,6 +892,28 @@ static int policydb_index(struct policydb *p)
 	if (rc)
 		goto out;
 
+	{
+		struct ebitmap_node *node;
+		u32 bit;
+
+		ebitmap_for_each_positive_bit(&p->permissive_map, node, bit) {
+			if (!policydb_simpletype_isvalid(p, bit)) {
+				pr_err("SELinux: permissive map refers to invalid type %u\n",
+				       bit);
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+		ebitmap_for_each_positive_bit(&p->neveraudit_map, node, bit) {
+			if (!policydb_simpletype_isvalid(p, bit)) {
+				pr_err("SELinux: neveraudit map refers to invalid type %u\n",
+				       bit);
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;
-- 
2.55.0

