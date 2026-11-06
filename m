Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=MBeEC1F1c8rZiEo4zsSXH2ALdAA71pUpjMk2iT3ZG/iFg1mw30TWsJEoND57yeEwo6wP
	 qvwsi3VzHEXPyvlg4T0b168d/TL82pEDhevFjmgrMFkIOZAq4QcyU0WJAyXltro6XYSmG
	 5BEw7OoBDPQe1Az9JuNxkbByiM4b03TZfN8rO2xM4s5QI72F+BbjGULd5DfqQaBray8CL
	 /jp55J+ZS2dMS4F9aVaJzwA67NHJywsTZ7vrUsH+gdkJxangfb0z9pnHbBaugWxcsKDLr
	 yffvqQenI4eCj4pseH5eD78T4Uv26+Tfk+8U1tuPFJ1mJ0/U8C1nZ/RegODGeDuTZnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jyqM+WDGp2d1Pv/UWqhC7S6VSO7DLPlc4vArLJlYB64=;
	b=PuoLz2COn646AnGceCz5mwim9+rmYSfqMm8FI2ionvZ4uuSuuVCZY5w/7XwG+L3fDOPS
	 7E7fhB0na+eubdKWtKLezW7nsk4yDvdON+y8pVLxjiZzAMH/WMeRwy5TsGbxY0FeFTScT
	 rJIrg6+LVvVBGsWrI85RiDNvZTTKOkeY+b736uI+GN7QWtEDUN2CUM51/jm2Chd10Uw1F
	 mtO2aMH5S5G3PYwZBuzNPD24lBgRXpfT+CM8Hzobmv74Fi6ngv+QT9GXT+TvNigkNSzFU
	 yA5h/qS3qSq2H92kxer9pK4i29/C4ejn/Wm1Q2KMvbmjR4MViNXyCI59vbF22+GEhAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=R9mM5LDB;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4F606A33B
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C4F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=R9mM5LDB
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968527;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyqM+WDGp2d1Pv/UWqhC7S6VSO7DLPlc4vArLJlYB64=;
	b=R9mM5LDBhFrZrIotvWqMwn1XmsJOeiSyxG4ItsiTHLX3Eii8NszkqZtTSxeYaI++F8AjIL
	XfwK02RVMeecdvJ72AFnqAaa00z1fLI2cQuTxHX3iU4LQH8rZffeQdfr/PYK6xk0AkvWfD
	5+nM05ndFE4UOvyDQOWHWdrcza9ZTFRhRkoHceqyFg76lajCDQIB+mF/pckkK+YxQ/ghuu
	fTy1LGnBzlNMBZb4qfbkdqewJyhbmK4KOYkP2yeVJ7oiB6pN4rEF+XgAKE3c41E6miwBa0
	aHjlGjE7/OpW+KwbpkZV+RmJIUY6VGlkx0SeI2ye0ZgTi27wn77WvA1i/wlIbA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 16/16] libsepol/cil: name the members of expanded attributes in constraints
Date: Fri,  6 Nov 2026 13:35:09 +0100
Message-ID: <20261106123510.76727-15-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Since policy version 29 a constraint expression stores the types it
names in type_names alongside the expanded set in names. When a
constraint names a type attribute that is not kept in the binary
policy, e.g. one marked "(expandtypeattribute (ax) true)", secilc leaves
type_names empty. The access decisions are unaffected, but every
decompiler renders the operand as an empty name: checkpolicy -C writes

    (constrain (CLASS (PERM)) (eq t1 NO_IDENTIFIER))

which secilc refuses, and seinfo prints "t1 == ".

Record the attribute's member types in type_names when the attribute
itself is not written.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ab221d2c..db25d409 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3188,12 +3188,16 @@ static int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb,
 		ebitmap_t type_bitmap;
 		ebitmap_node_t *tnode;
 		unsigned int i;
+		int members_as_names = 0;
 
 		rc = __cil_get_sepol_type_datum(pdb, item->data, &sepol_type);
 		if (rc != SEPOL_OK) {
 			if (FLAVOR(item->data) == CIL_TYPEATTRIBUTE) {
 				struct cil_typeattribute *attr = item->data;
 				if (!attr->keep) {
+					/* not in the binary policy, so name
+					 * its member types instead */
+					members_as_names = 1;
 					rc = 0;
 				}
 			}
@@ -3225,6 +3229,13 @@ static int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb,
 				ebitmap_destroy(&type_bitmap);
 				goto exit;
 			}
+
+			if (members_as_names &&
+			    ebitmap_set_bit(&expr->type_names->types,
+					    sepol_type->s.value - 1, 1)) {
+				ebitmap_destroy(&type_bitmap);
+				goto exit;
+			}
 		}
 		ebitmap_destroy(&type_bitmap);
 	} else {
-- 
2.55.0

