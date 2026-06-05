Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D004279E0
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688737; cv=none; b=V1e8WRVzxYAUCAs6BcTWzyMQ79zP+1r34rBf4WdEGcfj45MwvoyeJEAEV1nHQuIioEeTdt2SvQ9DWvyjET2WGEXy8I12Kilg1vTNsQ4OOM3/yQvPETCEU4n1rhfWQIqX7PgSVHrunD0/loW8rcSunPLVh5jIOauEH1pw4WwqywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688737; c=relaxed/simple;
	bh=n4r96JJtBO/G0wt+57xtI7iX9VkYdbaePFjCdAAkk+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngVwFRAbMAZsi2PaYLvAhp1bkTV02aRhnBWDtid7GeW309ZqRMTLjeAzZzERB9HreLovUfDblFf9Vt9vpeJRJifCVL/Hj4uxyMSTqr9EP/6Eh0lNzmpvb6FFEd2nl+3Cx/jV+IcQWOx2xBiplJ/H2tFlOx1Z8xpseADhHBKZZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iugf1fvM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iugf1fvM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so26594576d6.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780688735; x=1781293535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPA33BSxaI3W4gbi5M7hb7s3wa/vTEdRQFsoiwzI2Tw=;
        b=Iugf1fvMzWHkbdSNOOwCIJNov9uEAe7B7rg/1O7OVuuyNVMA+sq06JREe9QPevoIDt
         FJq/yLEYvTY5ZgBJtyffMf+zt94ZfaQmqMjKM0bZeEI7Uc7xGFYgaHOXvN11o00ocw50
         aP81RC4FppoLOLJ/86amLjQab6v7yZvjDWc6msk/DWcuURuL9PhKZgK6fh/Gl+eCRrJp
         NO16l+HusJdRTAm/yfXsYp6cmIs/oKDtxtRrMJPgVwHUtISB0N069/S7RTe3iD1B7xCy
         dEvEgECdOS+Su4luDQFZ/h2BsE5QeiTzucwy31InpkdQF9h0sRptNDl/9dvdTJ/QR5/2
         dP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688735; x=1781293535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPA33BSxaI3W4gbi5M7hb7s3wa/vTEdRQFsoiwzI2Tw=;
        b=Dc2672KhubxxJheXHrGbgJL5si8p8tUbd3qLUqZdbr9kB0H5v99jfOcdQyLDIuPmS2
         6GrYFqgV+8j0mgbY1X2ATbACLWxgVZYkch30xwyJrSZsaerfPASlILLibAVzxd6GTAOs
         UWkyNy7ZgPV3kuwITiZINoobU7HZxJxBtnOuAcmT/od5fltitrE4hcO0zEpyZcaH3TNu
         Yb+i9HnBdPHKTZivQMb7Vd4S/VJG6Z1lmaJgoGWzgY6v/OxRHZQ9c7PJhzTuYdUM+scH
         ToE48U8vh6zabVLq+X4u/ZKhh9Nh4jnVUmdkGWJavS4SOR5Y+zw61hHVhndfQsyzQ4Sm
         S/KA==
X-Gm-Message-State: AOJu0YwnhwmtgESSibGeJBkBkWpW7CHNMSSWATF5w57vNWLCArRtFfkO
	FTu4wix3Xxg0BcLhTTxfyuoCiH8RRoBGjv+lqxLwdsXMK4KOJ8h6BlE6wailGg==
X-Gm-Gg: Acq92OHuBAPlssKBYgxT4YMFAY9Py8RWXvlryuH79iY2aUuaINexGuOKn/kNpNKdLAy
	OF0DnpqJBn8qXmO9D5NdUwGc83tBFQwih3Mi4I+1IOaTuxue/VlpwSHbRR2aNW+gHUmI9BSdK3O
	NgRKXw4J2iT+0hQNdGvKDmFEGr7goInK4MOJv590Uz/jTsXhmhgtRDvKQNTsCCEP8U9hgtXf05a
	EcdqSEy9gYCMiocldc4kWrS24C/9hRPWc2lUYv+mB3ZvnvZcGCO/d/6Shu3acALDwysX9SHxbxW
	+LoxLOJySPMv5v+qdo7rmT+8xyJ8vIGTHIqvRNemjfEOc9e2JQNBeaKFJcdDk2m7ApgatTDC24P
	9GAkc6e7hho3A5qvHs1sqS0Wimfk9u+b7AKbKSveD8cmmy1Ast3aJEudx+hzF+f12xV4Xpn6uZI
	/496U7o7eBPLCf41KlXwJgy3aXLhze/uOSxZYv0wPNJHvALuAjFNJ/R4Ktn8yHS8G0H1F3O31/f
	Xxu2lPgL2XY2bUsvhKDydsoC+XuwCXBLUyu5A==
X-Received: by 2002:a05:6214:12a:b0:8cc:3546:260d with SMTP id 6a1803df08f44-8cee5fe4a24mr64692766d6.3.1780688735577;
        Fri, 05 Jun 2026 12:45:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd055181sm90156956d6.30.2026.06.05.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:45:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
Subject: [PATCH v2] secilc/docs: Adjusted correct statement keyword
Date: Fri,  5 Jun 2026 15:45:03 -0400
Message-ID: <20260605194502.282098-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>

Fixes: https://github.com/SELinuxProject/selinux/pull/466
Signed-off-by: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
---
v2 fixes the GH pr link

 secilc/docs/cil_role_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
index 2e1b4047..3e0688db 100644
--- a/secilc/docs/cil_role_statements.md
+++ b/secilc/docs/cil_role_statements.md
@@ -51,7 +51,7 @@ Authorises a [`role`](cil_role_statements.md#role) to access a [`type`](cil_type
 **Statement definition:**
 
 ```secil
-    (role role_id type_id)
+    (roletype role_id type_id)
 ```
 
 **Where:**
-- 
2.54.0

