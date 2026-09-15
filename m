Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C642376C
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488490; cv=none; b=c0bQ8qIRS8NKbO2XS291SU8xnLW45YHaOl2uhklWaJI1TpBA3aGHGd+q1FaIxEVo17s0UWQkmoDpznhWByfWl7UwYy6iX5V3MjmcI2DmJicY+Axo69mRiFFAcaVdzuGi1Vgf9wpONvDn/wOjWvTSkj/vF8lV01oSfiqg45zXEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488490; c=relaxed/simple;
	bh=lfWjdh+1ItId8Lk/4uV9fazA95+uLVsGa4uUDWhw5ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESNQjwRo7a580Km2QTwHpCucy39kxXyubBFsqwgWG5UBrEs7XCz/5j50ASs1GwzjnkKIVq/FYnh7dwr3RJHTOqo/RJZ4GOUR9ri0advJrWr7AEeekN8cZCHSAUheXYGiHG0qwKP5qvLrMS14P3UVMIuQWr5FtySvgOCDlVdAZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNV34QlN; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNV34QlN"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-670fee39d73so3246548d50.3
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488488; x=1790093288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Eoczd14ZBV5sZ0cdBKh0kKLOR1BwA/ExYwwU9iLPBc=;
        b=SNV34QlNcp8uN/9KuM/LCp1KB/4Y7VJGa7JWVO7xv6V3gX+dGfERmingFh80J6HTL0
         RCtyGIolBbfWoSwSK+uu6aqnFGRUGHt+/R77GqrnYO7Db942vnqVvUeEClG0pNYdxzDa
         UqINg/fmlQLz5ycmvRAwGoZsk22TwyJYWMfV6JFwUemjn/w+zYxxWzfhL80OAgkUgATg
         otiibAvJ1x9K1P9a0rN/fsh7fatdMTasSzjPabMg7vqWTlGVYYsCUaKrgDTB3m6XszVl
         M6z8O8c96Dum2U090bO+xCcI5rDKpiD39a2/mP8KGL6k6hNN37083cEipSQ1R0vxQabZ
         dKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488488; x=1790093288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Eoczd14ZBV5sZ0cdBKh0kKLOR1BwA/ExYwwU9iLPBc=;
        b=HI7+EHu5FCe5U6PzLEgXGvZciQNDRPG/BQpQ1J6fBkptMdhJvfFGkGR/qwx7SVmucc
         u7LCZA+ot6qNViepKEyaRS/y01EV9aysGnl/ZoK9vO4wOMQ05UB4Ia0CNUAnxsufCQye
         +39Il+A8EMeFyELztHC+cAhDs6PGBhVJpTdqZEi4MoIPphJQr1Mgk4RQDVoNJc1Y4v+H
         Cr0uT1rxGXEYOt3jcZ2gwaPGJQBMzNcs3xuwvzTxpoKhte4pcUdHnev9jArfYsFAHI2j
         XgunTlGOUWHDJhRqB8nZm4hbfo2W4WpeoSaZ/2L7tiXIdd63Yj57dnm2SqjZDFPEIez5
         rc+A==
X-Gm-Message-State: AFuF++nicyKlESi/U5CGLCu2PnB5YrkALPkSsbWzl0dKE3ZXifmo/YwM
	sbqhi8C3ujQOF9holicxzX23DDdTX6xwmiYaut+vwq9ZXBKiyGmWT4WTYRdQzQ==
X-Gm-Gg: AYBFou1FYDL1samG1oBe0/Nbo4mlUANP+4O7zflitFEocXZkC6SS8v8/UXfEtAjF0S6
	ZL5hbU06takWkVyUtrzX+q9mABLMZLiMJrhiYABSZwwypNIBWYCPuDyVsfcJSTyxVh/5QCqE8vh
	Lel3ev0aXhawfJQfBfFLClySzdYsPMhXR6BR0wy5E6QhxH0XtZAS/mzAr3rd8SWB1X1tQ9j1/78
	YUL+gOA9YaKPcPAAFgoRCsA6NmdyBramqqzaMYmSdhuGNcZIcNQmELasdW1ROvphHAE8DEKGjRZ
	fxYbyWlofZn+Akb6oKW2qWRTmy/alBsFa7f97ln/EtsMkXmko+e1RtBgdBBhahNgvAeih50nZVb
	Lqv6fCXujlDkU4f5CGXbLo4JhvUpYJQ7HDMgqoCWLw8V4QdLHje+GFzrsf/2YEkz6xubL/IezQ8
	zYiTF7KiMtZTM81Q19VW8MWFcetGosjtYd4d79qDyOBSYWUDoZ1iGE3cr+cfTrvq4LosJmEYwE1
	rPR0HzowDvhl8sMvyzgLPMLZaYVD53gZ/9IgoPzLdRNSJ788saL05A4VDWRPzvAY68D55U7RiU=
X-Received: by 2002:a05:690e:bcc:b0:671:5653:8564 with SMTP id 956f58d0204a3-6715653866dmr1589471d50.91.1789488488113;
        Tue, 15 Sep 2026 09:08:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c885sm1961696d6.21.2026.09.15.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:08:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/4] libsepol: validate port range in port_from_record()
Date: Tue, 15 Sep 2026 12:07:39 -0400
Message-ID: <20260915160738.46723-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
References: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sepol_port_t stores the low/high port as int, but ocontext_t.u.port
uses uint16_t. port_from_record() copied the record values into the
ocontext without a range check and then compared low > high on the
already-truncated 16-bit fields, so a record with low=65537 high=65538
was silently stored as ports 1-2. A low port of 0 or a negative value
was likewise accepted.

Apply the same port validation used for portcon ranges in libsepol,
checkpolicy, and python/semanage to cover sepol_port_modify() callers
and libsemanage local-port merges.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/ports.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
index 28e5a44d..5bbeb3c5 100644
--- a/libsepol/src/ports.c
+++ b/libsepol/src/ports.c
@@ -75,13 +75,12 @@ static int port_from_record(sepol_handle_t *handle, const policydb_t *policydb,
 	tmp_port->u.port.protocol = tmp_proto;
 
 	/* Port range */
-	tmp_port->u.port.low_port = low;
-	tmp_port->u.port.high_port = high;
-	if (tmp_port->u.port.low_port > tmp_port->u.port.high_port) {
-		ERR(handle, "low port %d exceeds high port %d",
-		    tmp_port->u.port.low_port, tmp_port->u.port.high_port);
+	if (low < 1 || low > high || high > 0xffff) {
+		ERR(handle, "invalid port range %d-%d", low, high);
 		goto err;
 	}
+	tmp_port->u.port.low_port = low;
+	tmp_port->u.port.high_port = high;
 
 	/* Context */
 	if (context_from_record(handle, policydb, &tmp_con,
-- 
2.55.0

