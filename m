Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4C41F7E3
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298827; cv=none; b=FkycVAo8jcihe+BCLtjSPAdOa1Dvn1lQfG0nCoKLFsktyOAjCOFUH3tA+Zo/g+SC7tndoihtnBBErz6rKTshZg/k6zZgL2VgQF5ZvRM4lIoggQA8IxGdAsj87ZXnqdqHuwarG+s8fkbth2LLQeIkkbyFB8Wu+aU1SQbGrAzPYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298827; c=relaxed/simple;
	bh=CtOfRWsHFl1A1AgToBKSMS7pY1QXVqUXV6bzy9/mlcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1vkJgQ1DCVgWtq1rspjg5iZZXpyr8cuBR0VuE+cKy00q4++3PVwoxM5l+Oh2UvRGD5UMh2aqrGNH4Y0cPM2WsVKkt/Baq3e9AwJwcW69u33SYkLFJxB7t+sW9z3tSDUX4XQEoRf+8/n0z1L4IilOBHI0+wkJqcbUcLskFRXKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXcwC3ws; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXcwC3ws"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so75183411cf.1
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298825; x=1784903625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsSy4H5l8OV/3LCrHz8YP2gYorZCtl9nzhnzFU9QphU=;
        b=oXcwC3wsskD1NHXZcqMN5ken77jqxm2g9WgfKBodjR+l0yQpA4jV7WlsN2TDRQVxxZ
         LEfIS10Hxc9+O6hTlCnYuMzR8yyaKag7nltvLqloOghPsxlSU+gUzsPkeix57VU6SqU7
         kmlWp16k0koSiPp+xu6H+dh0R5C+dS7vEzSih85c1H3hm77snqMaJ+YxykXpvAYqqbFZ
         Ju/1mn8/JId8JpLSBo50b3qBA+z/OxQUOZmJUd6+tSpg49e+X0chstP2kwhgCdIp+31L
         Dx3nfPvqcUSe2Up3Akz1/T9JC9wR8spTVqmCArOZttLvTATmTlQWFFopRjp7EdQdKNp0
         P7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298825; x=1784903625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsSy4H5l8OV/3LCrHz8YP2gYorZCtl9nzhnzFU9QphU=;
        b=NFkNAiLWdvNcTiuWB76JCNsDdkpRK6IVFohsgjOgM7PdooCsK/b17dLv/scuF4Rx7j
         aKcDCpvgdvMiD86mL1Sq4iEhcqK55HhzWW+IyagKWatCGSAnD1IWofJRq31wPaRfq7qM
         sV4Er3iBZWo/fl67LU3bTfsDodLP0PBEasiwz88dhE5t5PvMv/g02auhUGEpzfePPdNX
         h/E+Zpfm0Y0IeIzK9uV8nIFpN6tumOABhJW6RC/u5z7mZWaBBb90OXF6YOcsbi/X4tgD
         HBj3rLP8J9wkitaFg16TroTRPb6zhTN5mdcshk4eAjkBk0ZSisVRv43TbNtDyYz/HGg8
         wuqA==
X-Gm-Message-State: AOJu0YzpkhsjnTHn6IPCI/MX05jQkly0ia7brPuhL8D0ZfEA/PlIhjuP
	uU/x2Y/K90SFLrfvM1NFrMEEtgM8P25CETdWnmUSDGn/+oMnCdei7PpBZqqezg==
X-Gm-Gg: AfdE7cli2t5ixmy6BDLZP+wG0nXCC60OaZtffxcEMqzi5iqJi5dOmShmZeiRf+fA5sC
	Fn/tk6uMIVbdQD8HsuUJAWUUtdOgjjiOhp6d/ZRdw4EPekVdFM74Uw1p+rjCx9WO9/U2Qk4HA8f
	n3pE3uZzo3badbx3GZM0ionyMmOu9g6dKVG/hz3RIoDFf6s7N7vzv/3qJIO7J8SwmNCE5Gn8jgY
	LcS+t1sQNxDkGX1ALj/ZNdBFuOk6ea3K9FKYue7JbEg79xfBqVdV978Kv/KllWGRlBh4kepks7Q
	0OgcVLthCLD6cZyvXSGGDwiZM7uY8swVQfW/q1PYQ4h7tRTIfx0ih0Gk6UwHdR/nkLRN6WQTxkw
	go4Scyx7GSJWuK7hLEZsnzVNQVq+DndMJAGlrcOHP4GH7QLAwCZwyNkTWL7OAvhdzIXUwjTAtnM
	R1JpOrsPD9LZDKnlLJru+Xc6Ghb03Mjw7frFFdpKBoZLpzMeTkfuwUAINZv4cZxEK6AZOSPgVIF
	aRi4mrhXYtjiDYG
X-Received: by 2002:a05:622a:87:b0:517:8011:3a4d with SMTP id d75a77b69052e-5213c7e4fc7mr25534861cf.20.1784298825332;
        Fri, 17 Jul 2026 07:33:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b92acsm13852051cf.30.2026.07.17.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:33:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux: do not call close(fd) when fd < 0
Date: Fri, 17 Jul 2026 10:33:29 -0400
Message-ID: <20260717143330.18119-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path was incorrectly calling close(fd) when fd < 0.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/utils/sefcontext_compile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index ab73180d..f8115026 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -707,7 +707,6 @@ int main(int argc, char *argv[])
 	if (fd < 0) {
 		fprintf(stderr, "%s: mkstemp %s failed: %s\n", argv[0], tmp,
 			strerror(errno));
-		close(fd);
 		goto err;
 	}
 
-- 
2.55.0

