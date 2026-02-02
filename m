Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68A36C5A0
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042258; cv=none; b=Unc+L+CBEM9Ame54QdMnuKHae2ie3K5i/JphW34O4HlU1rxu3gPwqiqFhtf2Uk6Fx+YqygM+IpqoU9tD4pvuvcFDSL7mtC0pMJiPQYSGCL4YZ72QZ85PTO+U/FOJhmOt3miHarFayCcZriSaoUiDG0A78PYqQhs0heO4rV+rae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042258; c=relaxed/simple;
	bh=dYd1FUkP9JCdFRJIJtRMqvm7OUdcWkJzWFSd54FIP/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfzRsOUZ9sCLB9yLFr92Ic4tVXfMMxsXgPKtqg5VpRz/CJxNuFQC7/yBBJrfPAIfntNCD4brjN/aGP9YKfTzZ6FaO+DHv1SMRHg3QBAglPPPdH1Cdn660vx1Q+dtUwTfd/T+pfqQ+XP5995d951qiBMlDU2H0Z03qGvZxG0NhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kDrjkKED; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kDrjkKED"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042254;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zLH0PkgzbsuiX+6aDW6ERqfAvjSMPo6PLbgpl2AAU=;
	b=kDrjkKEDaK8JntJOougN5sC0/hJS8ru9o5WE/qPpVEgL25SpkoO08Qs84p6wqtg+rIx7bK
	fViuYm1hBORNY9r3IwqqBd5IfumL6c3a3aqcCWhOiGTiuDdjmU89UbhO5TeQzGZmGqsY9q
	DlE8xgcY71P0+4zyf83mqQF1hUY3wBnHXkwJ1GvRaSIRqbT4XnqRDhHPicRBPE7KDvIa5E
	PVzfuJl3GNI+ITfna5+j0QsM8+QOxnQs4LTRQ+vhbkonA1Hw+dk5V8eCn8dHRpMzsm1zXo
	Bz7aEHceEASTpWdVVtnzI3hbF312lq0Vsu/6dQ5lSOZEJ1nwhI/xO5D5dO7ddA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 8/8] libselinux: drop unneeded warning overrides
Date: Mon,  2 Feb 2026 15:24:03 +0100
Message-ID: <20260202142404.92347-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
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

For the SWIG generated python code remove warning overrides no longer
necessary, since their occurrences have vanished.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 0dbba7f4..5ed88a6a 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -116,9 +116,7 @@ ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return realloca
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
-		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations \
-		-Wno-deprecated-declarations
+SWIG_CFLAGS += -Wno-error -Wno-deprecated-declarations -Wno-missing-prototypes -Wno-missing-declarations
 
 RANLIB ?= ranlib
 
-- 
2.51.0

