Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787A39EB59
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594984; cv=none; b=JzvVITjKSwf1ibTs4R19xJgk7nppUU/2WFAVmCAPl+YYjCtOiV7dHlwNrdV0hwo1fmRE/YJGOPEsug6s8djlsTLSIx/juCeg+MwdX/SAuvID0ZiCtjaMlISfsHzwV+kNgxpVeAdDvhKbOYXosZwyFcHRuyhcsJOG0T4KFoWallA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594984; c=relaxed/simple;
	bh=hsU1WzD3x8yqBDdWjrztwhzHqkldWhtF9S8XU8rjZao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNJH+fN2XYmVmYMBpA4jPN2Crd2uy880mHolaRIymJgoWShhle5t0Bwzo95HaxRqt7HAT+phzjuZ86JQTlddTA9Iu+02poth4/DIjTQeJHYJZPL51p47jHVF65m5HXaeXgDKX8oELgZirfKMpuWAepBzxy8IY6No4pFDhXMfgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrz3Se9B; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrz3Se9B"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157f7c1c0eso97364185a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594982; x=1781199782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6pOuelzVPBQF7PQN36W0D+VHwMgiiTCfPv88wxcMrk=;
        b=Rrz3Se9BfdWpDHDfYaGlZnZii0L8opa6aQqHysM2/UO0EaFcLUc6ordxvN2kgJttJi
         repijQTI/HzyrsXCHy04Uak2SDl0OT3piBeNc9p8hh5ZgKvILIAp+O/DHV6hD5OLqF41
         B/urrltiWKWALkVhOXBCM5NdHflgPyhjTMj4TlPMlaL7PYkXaZB95kdeM0BSm7xtRSzO
         /0/dbQ3kJ354NNLpQSZPdTOj+3nAwyiujCKYfbyMi75EgkpjsghqaI8xOfY3IEjtrr7B
         7zls6vRhQLrgcIcs1+5zDtxrp8MfaBR1XYtNRp0LcDM8jDwcFzeds3AJuSkk1gI1TGcQ
         FLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594982; x=1781199782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6pOuelzVPBQF7PQN36W0D+VHwMgiiTCfPv88wxcMrk=;
        b=r5C40yK6tWLHXeP+a7PAHC4h+p3Jzu6wQVblG4TBnJmWC9SIEZA2SncnGJZuzLF7o3
         EoEyifA3Z3PAkuCucFXNDEG195VWj1Y6CdQx9G5AHrarI6rYQeeRAAU3sia1QJYjszAq
         p50dJHkKjwa8os5EnIAFfyzDGbstiU3K/eve/y+UeA8yh2+LeTPvEoPuhHnE31I/GVyp
         MBw18e9eTT4JG2v0oz3OF/8SD2rJt0+NZM3uiTBkFOBMpXz4Cto0oZxPL+vtf19kFjVZ
         ETsc95dXRqDa4qT318KCOkgnRvEwZKZgwZAXCYSlXUAwTIwhBsClyLho1Ebo2FHpHOVi
         53GQ==
X-Gm-Message-State: AOJu0YyAF9Y7o84vKpVrpQy+bpmF/xWKil3nAPcZTydLAkAtoQDDb0nf
	lEKMgCRY1eF2MnbcPoTnOWgi0ZM68/8kRwHeY8XEPSRFXhYcBSFITCFpPBtUvQ==
X-Gm-Gg: Acq92OHDzfXZQLm4dCWEu9vuYRsje8mfoS4AzdkPNdl8YMS1p4q/DBMKbdMXeapCJH5
	k2QtgqSaszRNvlSJ5WGkerL+8b70iWzutohvPsY4nQzfhKRn1hNcclNhbvGfKhbQ8PhB4L6obSz
	LSxFC2WWtpq+zJSziAEMnOYED78TstqpXjHRp4z2/IO8Yx25r9MIgF3Js0FzbATbWjhHtjPIqM5
	Dv1uEjBm+Av1f6QCit9fAODxOhtmt7/1GFKwh0I7KUnIHENX1+yrOCk8lSyupSZM5/PsWxb71p1
	29eQMkAxmIkNu7HVHR+lYsnKyGosNsnzvMzKSfeep/QEXf/UWYv+191fS0zjIfBU2y54/jygxrz
	cGbfdVNMBqybyXvMvDWwcPa7eBH4wq9ik8P22FlaV7gRO0NqcQq7sslqkutf2QHdfE18ZQhDgHK
	oHqEewwsoYmNykdo/h6F93IrznjgwsuVSRMRY9BgDE6KEU4Mq7ca3QpZTc6XJHFMU6DzDNmQl/3
	7b5p3L4X4FBZZ0JRrsDsjDnfp6q02Xr3AefRQ==
X-Received: by 2002:a05:620a:6ccc:b0:915:75ba:17a9 with SMTP id af79cd13be357-915a9da95eemr19723485a.31.1780594982034;
        Thu, 04 Jun 2026 10:43:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c4e6sm635334485a.26.2026.06.04.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:43:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: label: ensure specfile_list is NULL-terminated
Date: Thu,  4 Jun 2026 13:42:47 -0400
Message-ID: <20260604174247.263844-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selabel_digest_fini() walks the specfile_list until it reaches
a NULL; we therefore need to ensure that there is always
an extra NULL slot at the end.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index dcbd60ab..1ccd1abe 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -70,7 +70,7 @@ selabel_is_digest_set(const struct selinux_opt *opts, unsigned n)
 				goto err;
 
 			digest->specfile_list =
-				calloc(DIGEST_FILES_MAX, sizeof(char *));
+				calloc(DIGEST_FILES_MAX + 1, sizeof(char *));
 			if (!digest->specfile_list)
 				goto err;
 
-- 
2.54.0

