Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E083FBB69
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183053; cv=none; b=Nzrg0Jjm1HhUPMGfkChiU8PRhZv8WbPn24Xx4FNuxd5bIEfywvKrcR00qIpDsyC77Z6PtxanVuR6ZxOI3TbgYZ/LnCXSG5X3NewvveTA1vCpVerotPG35RdgDpNfbIJUNtZ82yqUCGjezjMy+rVU/YxtOvyjBhd/EsGcVKeDrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183053; c=relaxed/simple;
	bh=IB3Wz1lctWPzCVEaHV/bqpCEwe115jm2iiu/xyoMMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScMHlWswXV4YDPtGy6kvzKFbn9t9PlXbfzftOwziJC4S9fumrikCTRlOnNMNFLhd8JCriqQdD0CEsPz5BrXe0hIXlPyXDd6vDD5QQ8xqdfV+hNWYpRrHcjmQmVbno8yGdhftgAivIVs6ctwCiiz+8OVA/9DMcc71Bnjs9kqcHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fROBjidg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fROBjidg"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177945a279so85703231cf.0
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781183051; x=1781787851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AQ7AtbYevre9SHJ6fcrTXSLtsjSMiY+QN7kSpTnrSg=;
        b=fROBjidg3MJ/w+aj7sXxE/trzl5LQs/JVluK43kYZCpVFXe4gQsrvus2gpdVFAAYwo
         5iI01hwQmj9xRXvMPyFIybZl2OkYJ2RbVAXXlopkfQlzcGomjKEeSyIHIN535qURWjlR
         r3WhmWCrrTagDkhtyzm09gW4RfUFQj/82WsnoDdi8Q1fxoZ1QDH/qjbKJPrXedRALVuR
         OY7o94GEuNmbMWdnl6BSe5UFDmiUJNrIwUPJ3o0yeDsePgxJbCEFrhFFypay0Rej9LK9
         Hw6xc31lA2+4FXQ73vIuBoNQZixrLc0coRYB9nzQ/FSzFGlFjkG8/0XojM3YJesJKw6r
         3roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183051; x=1781787851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AQ7AtbYevre9SHJ6fcrTXSLtsjSMiY+QN7kSpTnrSg=;
        b=FuTTK2neJnISjzp85XwJ/Ew7+Gck6z4UmsGGMMCBQ8Xjn4pBLyyWByhTbPcYasA4mM
         RU1sDDTJHSjF4F9sNFZcEbFkN918NjB2XJ/LxTFuRGrWXaVOm9bcGBm4in70rz1/8GgP
         o0RmCz7ImxZLPiMMn34sxmk6vmALFDZI68GgMN1UXwj+d2cApPS9L7aF2D4qqHG+sqAa
         uTffK2dfzUeG1qlORzKvxfT6TSX8T2SlWIMzPQoQK4LPSLp2KFf4GPhs0enJ30dCggse
         iSqDmlaxyPUgUxoO9Kg/AB+yjKC3HTMrCwx0Iz4qx6sbiUwYB/2il6rvdf+y6lLlBdSd
         UKlA==
X-Gm-Message-State: AOJu0YxMdd0hRy3R9jTqOPJFlAaRFSp8PDo8iN5wtB4SWAQBsOo5TOS3
	jORfBVrSMUNJVlTgxOomiXJUWMZEIgChIAik0EFqyUjv8Ibyt/fqfpRpimFlew==
X-Gm-Gg: Acq92OG19MhizFWb8MHyVWjnLZNW92GCJqF5WBucQgnYDO4b8YCcGBlGXSIK1T+JxvR
	sd4uQ6zo8wXrDP7OHD3ffHYteTO8qKB3E14CBQ9WB9S/tMOqLafJOuH0xa7OFjKYM1jkfSwje2D
	rWBnFIOtk5FpPdpBkU3b7EZJPy7TrMw8LKRdd/e9v0hVqtYler/SIvq2ztZAW1akRP7P/eecPII
	yrx4VdupwNcfS449INP4PmvbMpehgj+1WIF8U0gnMRzBejoE604ucOP2WZ8su8ii2ecKbwEdXbC
	FfuUENvo+QLKUYIWwyWlzjGJFzgRWSDdSW9300mlI/Aa1ZYQnGmKXSdybHbNZ/7N77APCb4O9gR
	2BIQ6U2N1fN9Gnohdgqe4RUY6/DMuOnLoFmz4F8DVcErqIf9UXwSEAq3L9cyvntpKfjE/I7VToN
	YDj1fhM0DCyGuNX1cbvQsicWUHil8aeK8ZQMY54+2p71KPUYEO/3VN6Z3u0NZX0CGfSlNB+Nz30
	6kGOAjYrHxtk+g3UdVWPLWhC6CXsRxr449DZKGBpUodFuHw
X-Received: by 2002:a05:622a:189c:b0:517:260f:8e95 with SMTP id d75a77b69052e-517edccc907mr42606741cf.8.1781183050496;
        Thu, 11 Jun 2026 06:04:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef3eae2dsm17546691cf.2.2026.06.11.06.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:04:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
Date: Thu, 11 Jun 2026 09:03:51 -0400
Message-ID: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
configurations but added it to libselinux.map. This was benign under
GNU ld but breaks lld due to differing defaults for
--no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS to
avoid breakage when building with lld.

Fix: #512
Fix: #513
Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
Reported-by: Pepper Gray <hello@peppergray.xyz>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9982faad..35f36b87 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -91,7 +91,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
 
 override CFLAGS += $(LFS_CFLAGS)
 
-LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
+LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro,--undefined-version
 
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include
-- 
2.54.0

