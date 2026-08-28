Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AE396579
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939616; cv=none; b=lQDmutaGL+cBLWRKxuP66yVCuoiNdZY1/J41E5iAYwDqI5LdKj05pQivoA6EgKwywFTdv7NmDTf9AQo1fDkMNFTBWOAXhwzyj5HtlApVznw/VDHs4U5KYWIKnYo5anIYM8YrxcfEae8KO4Zg/qJCqm6NKPU6bNc3YNNyyTtFw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939616; c=relaxed/simple;
	bh=ITY6UQPQ7bLgs0r+akkFipVpdVJAKXFhsTAqK+4UY9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epiZLo3swyLD9XOaT7EQSAzLZ/vRd+cMLMiamvcT7LUUH7Bx0ekaQy2FLbMCXpEl6I9sqIE19se62dVhCPtjwPAP2a7wmcH22sTuIoWihu7HGXm+D1t0Lj06hwNA54jkB37UWgMDNVmMS5pZGeVuK29eywggpFSaa3txm6/rZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOEZ/usn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOEZ/usn"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93900ed2925so101559685a.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787939613; x=1788544413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrDSw6jkMlFQNimd+2a6dVQdluzsUQS7uZ0wC6EZO8I=;
        b=UOEZ/usnjkFGALwAnP5lIqyt0gPIdheZR/nm/JtHNl/2zVkQTVnR69QMR0+A+uDtki
         O04fHMa5flecwIH4kdSFnB+wxVWWk/+9RS38QwxU5a1herDKXXVn9N/8Oc2tH/EEdeMf
         bCp1kHBFbehTMW4JhkmPeMX4Rf5S5+JhKkezsf73sbwB9LWu9GLmb8j7DcgqdsBQiUXk
         3H+rafUEgF4/ONQ3r+zGLbt2hX2T4tf0LAiXmOTTTZvKxSuqa/lyjuLDCcmjKwaty5+9
         xwrNwNgE0mHBLu8/e198KlB9KdbVJuxrh5gCKMz/+aPTzkPdU1YyT6eanXBXe2j8um0d
         wdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939613; x=1788544413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrDSw6jkMlFQNimd+2a6dVQdluzsUQS7uZ0wC6EZO8I=;
        b=HY1vbakuqPX0qZsML0lWu2HXyM8BduarFQk5pO/FYFvaK6Ep8//Eu943UEjw3oL78q
         cSkGSr9UCJQfuf3xgBSMEsmbD5X6v5zAZ1ZkwBgfeEbjCUfHdFXTnQpinkh1YtdCPuLI
         Yzg7cFcvPIYxg/Mezeic6X37Vpkms1pOMnp914w2U5CL2MQ29MdrFiCPjiA0KepDNDd8
         3/O7lO7P5+r4Z+mqZaQOmvYBDv4H/ZcRSpQ9+efWHHuiOk+Dy28m4cXTYAeEVo5TwrMK
         qunwyRPbMkwZXcAqaM+dxfL51fw6glkv4QnK16x8bDr0OiTida4s407uWi5gPSPeguUS
         hbjA==
X-Gm-Message-State: AFuF++kuRCus5JFhSslSnjYq6/6xLtiobM4MYre04PPIe4eU8E84mf8R
	bePDatp28huagrfO6LQGLgsN2uag8wVLlqPzwE5CKe89V7HVUsR4uQDt9006UA==
X-Gm-Gg: AR+sD13uEvKebRqed308yywoGbCdNms/iT6ECadUuZAbjIIkrfXxfp320Wyd13B1Qd/
	SrDwZp5KprB1xY2rVAC+G+T3Ijd6TTyLMW5KFNQS06qmTAS1VnO3V5HVpuqTA9vzl9TW+oI82Wx
	yLHPAkX55cKclV4/WwCKf00YfeoSrgSgtNp7cIRG6VUSjviGSNXLCEzwxRJqzLhTTMpRMKXrPnO
	MxTqx3IxO8vBwS84h6VvZt4tOdSC7FYOTSuwgmxx4u51vqAXD/SshvX5NNRbZcuspPS/qMxKHBY
	MLZITVICHZLiCLB/OZlIL4Q+mTiAf0H8o+LJuQZz2Ys50EdamiJcDbICLU/Ozrfr2NtsUVcF/Wj
	FmKiCQYMjl8EbD2SU8Qj2HTpF3j6CQpckzy5lrk8IcggRoiQ8bYysw7l/NX6sFWBU5OSQHyN2lU
	kGGn9xYJNZ2J5Br0czcsfVBKLeNmuPAc0VJ+1PQothFUhZjTZ0vWUwjxwUHbr1OuRXap3eD1S3a
	feWMWtbq54UZXLgybsBHtaKQQjLpzBfJ3WpBBKY9yupqb5ao2gb79Z3eYroFDgjuAduOnRMEhY=
X-Received: by 2002:a05:620a:2985:b0:939:1976:8309 with SMTP id af79cd13be357-93919769636mr597103385a.4.1787939613547;
        Fri, 28 Aug 2026 10:53:33 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93916eb3d01sm198126085a.0.2026.08.28.10.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:53:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: add include/sepol/cil symlink for in-tree builds
Date: Fri, 28 Aug 2026 13:53:14 -0400
Message-ID: <20260828175314.38256-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

secilc-fuzzer, secilc, libsemanage, and policycoreutils/semodule all
include <sepol/cil/cil.h>, which only exists in the installed header
layout. The source tree has libsepol/include/sepol and
libsepol/cil/include/cil, and the libsepol/include/Makefile installs
the latter to include/sepol/cil.

Add an include/sepol/cil symlink so that -Ilibsepol/include resolves
<sepol/cil/cil.h> against the source tree. This lets the standalone
libsepol/fuzz/Makefile build secilc-fuzzer without a system
libsepol-devel and against the source tree's header rather than the
system one, and more generally lets any in-tree consume of the CIL API
compile without a DESTDIR install first.

The install target is unaffected; it globs sepol/*.h which does not
match the symlink and copies cil/include/cil/*.h into $(INCDIR)/cil as
before.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/include/sepol/cil | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 libsepol/include/sepol/cil

diff --git a/libsepol/include/sepol/cil b/libsepol/include/sepol/cil
new file mode 120000
index 00000000..a1b89f59
--- /dev/null
+++ b/libsepol/include/sepol/cil
@@ -0,0 +1 @@
+../../cil/include/cil
\ No newline at end of file
-- 
2.55.0

