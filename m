Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC1434981
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895681; cv=none; b=Wuzm2SqYI1c49/Ud5YUl0bxK67UfvzAr7Rr84ZGJXg7Nyam+rxQoIBUEnA4uXFRw/gu4GyRGuQglUtOhSuAkLRBWKV+ivPk3fT+Ww+Gz6QQ2lzZwHF9HA1hCfqIOGO2VfwCgQPXHW2MBre9O8Hi3Ak+K4i8c0qe4nzebEAWZyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895681; c=relaxed/simple;
	bh=xG52z2xYx45Himw1sM7r7RQfGp5DhDF2PsQB4tvAYGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VG6k/i3CN8BB78s/QQgtQDJS40j9EIChy+2HUKVwWl1i8Jx3VWxZESmCim3eM52/jUOx8c8/lB8loHMJq5G9U/7W7R1Pb+BvrCNb+6AJ+t986JfUA66LfCIM266rD06jP9Zwt90ufS6xo99l654C59qui1iXQKgGQjcznkjIoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtNAeWqC; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtNAeWqC"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca2eso3296501cf.3
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895679; x=1789500479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wYJh9pafaiw73rBdTtuCXTxYggOCGYC9tcvVEPUk9jI=;
        b=YtNAeWqCSSDzUBAWMthCbsPQJYxg8EwELKeHGHyLl47P/l1aGVkVQvWBGqO/kT3TYB
         525YFoq7sDmHhWZ8Hq35pdQdiDsQjITP3sK6phCKrsgBIbb/Hjp3N9e77EETKo0dloOT
         Uz7W8bNC6CSyR50Xa0rvz5VVuMTZYrIUec/SwTAts/zGCyiHd69TdyD6RXXE0JVRcIGX
         yujckxldSCJQAr3vv9vhqRsd0w60fezd/x3gTLHkkxnm/BlYPxA3YpvWwAIlNDegJFzC
         ZWtCPESScYYp5vA0Hmeh2uEwkKxZ3MWyQwcxyzPv5xUIcdYcvh0dyTI9OGUx/wHkiD9G
         DrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895679; x=1789500479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYJh9pafaiw73rBdTtuCXTxYggOCGYC9tcvVEPUk9jI=;
        b=pT1oCUX3DAaHGTNXPhcqshnXyZaKwBFmXy0MckVDUvQfO5U+5ng93peIekc9d6wqnv
         g8qmlbUvKhkN2wsQZA5q/WRyx9tZozVqD1ubE3YBHveK/zK5Frjy9J5GqtYsNSaGpRzC
         pb9ju7cao2zuVFmauKlpW3Eeatw4EK75b9NnRQe0JgeFb4qN/M7z3YIp13SnKLB2AYm4
         ymHWtoMdsLuK/NQSgdTM7NzAMm+ghcH16ULhUBua4TIYcLco00q0iKv0pbZNMISn+7L/
         tSWLi1e4myQ49sUySr2FddNyYvcf7SblcoDNbxFtRV0jYqm++RGu0+04zrsQljgJy0rN
         yopg==
X-Gm-Message-State: AFuF++lTgQ09xOJm+esjyM1iCXKH/9cijkJejAOZe5AXmSZ61Prg1F2r
	q8WJ1WWE1PSg4NE3EP2lMaFxHszf+teWTQT7IypuTsomYtnPqe9j73elD8aMCA==
X-Gm-Gg: AYBFou2c399e+IpHwikcGBEpId9KHD9AnIt4FI+UIOYs6Is7GCkBGMENCnUHlWohUyD
	/LhAetHi4jhKnx6vgzjLqfY0Qx6mhiJVh5jOETN9NWthrAACZ/P7r9Xb0dstpkxh3VSSgMxZjH2
	ULkTkOL5mxulc5muuDgI0cYyuJdm3Lg6FSGw1yYLglOBGwT87V1q4ZjtPeREfjQrKYWSrJWqe0b
	yDbkxmwn0+4rlrykjsB4Y7hrpG4jS6XjWgtXNICtwMuL95kXmeSkeeI8KIOuAXcbl2ZQ6EwJ3Ue
	2IROtq1w6ezhO9mXlJNiHzs83IJFUDicwaNVQA2/u9og+KhJOH478lk0qXPXzSEvXpX/MHfSafv
	gWcO3uvhYs8oNBynw7dn5KzFCg8dYoq3JDeopBRuP8f3gJDSxNGJioA/g2a6HIUuBpj1DJN87nU
	OUWoM5Tm2YXygxQDmai72XmSdVqPIh39CfXzVOA5dXt9scsWsJrYU8zNM/ol4RdBcc1lCbjwPaf
	fyBD4ej5V8ZQB9rNTu68S1o5CybYnMm7bu4apUHMj0viDBxYZrle7wLvAWZMmS3
X-Received: by 2002:a05:622a:2591:b0:52d:2e0a:8ca1 with SMTP id d75a77b69052e-530a2d78e29mr30637201cf.39.1788895678613;
        Tue, 08 Sep 2026 12:27:58 -0700 (PDT)
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
Subject: [PATCH 1/4] libsepol: validate portcon protocol values
Date: Tue,  8 Sep 2026 15:27:40 -0400
Message-ID: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_ocontexts() sanity checks the port range but does not check
the protocol field. kernel_to_conf, kernel_to_cil, and module_to_cil
all reject a portcon whose protocol is not one of tcp, udp, dccp, or
sctp, so a binary policy with any other value passes read+validate but
cannot be decompiled.

checkpolicy and secilc only ever emit these four protocols and there
is no source syntax for a numeric protocol, so bound the protocol at
validate time to the same set. The kernel additionally bounds protocol
to U8_MAX at load time, which this covers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 98ad7ed4..ae879d5a 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1,5 +1,13 @@
 
 #include <ctype.h>
+#include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
+
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/polcaps.h>
@@ -1586,6 +1594,15 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					if (octx->u.port.low_port >
 					    octx->u.port.high_port)
 						goto bad;
+					switch (octx->u.port.protocol) {
+					case IPPROTO_TCP:
+					case IPPROTO_UDP:
+					case IPPROTO_DCCP:
+					case IPPROTO_SCTP:
+						break;
+					default:
+						goto bad;
+					}
 					break;
 				case OCON_FSUSE:
 					switch (octx->v.behavior) {
-- 
2.55.0

