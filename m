Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B5403AF0
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868478; cv=none; b=km0oZ2Uknz5hEQNkZQM7/tFTpeDoTsPVsuMiOXaqboIXqX39B9hTi9Ur/nMLR+qQQ/WKoWQW/uNEZ2ZUVOCOgE1k3UsCBspVU0yP2fYPKxyOIoSFg7pdz0Cz5PUDJDYoX8N0qpYnh3cCRTLnnnXNv/sNLRa1y+Af4QZW+S1U9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868478; c=relaxed/simple;
	bh=AhtzEs2R2QCa+OzLPrK/6Wo5SHYASiBFEyv1Io5+Cxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh2TCAJAg9Umb1vUEhBd56+kSMK8E7jWmUBCRwG2wgqeSISrKLCVpFA/n3SrR0C+bw+0uL14OXCWIuScrRyKSap4bnVJ/DejLIiy7Va3MZxx/L0LF3Q+2aKfDw2MMxllFmktQsbVWcxES2/4tMqaSDXv8zuMqAAK463A0Ux7Xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce0HQ6fm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce0HQ6fm"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-934974844ffso14305685a.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868476; x=1786473276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mkb/ew2/ozHVq6JnvU2CgjbALANwgv9sf4rBC0yMfU=;
        b=Ce0HQ6fmNnJifqIa1AfbqPbHz9C4IQM/BoJUwWy1s36XShUXJMqHhXy91y5zT8/ZKr
         86e/ggVI8wtHJa6/gnzY2LKZ2e0CvMmjOUkfU3oGcyqCpmyI+W2QQVaGgwYGWvcI9bVV
         sMGxMjPdzWU0BdQ+ry0wQmql+ZbDZ22IJOAIVSsHRHwsjzAyznbu276v8i3xqQly3Xdl
         jZdDDOTrwJrDGw1gMEZAm2UTS6dzdfXyItb1a7U2+AZHR+pLE612xja8O8Gv7Xqjb5Hh
         XRFHKNeGvVY8PRKmQY556h+yu2tOtFQEXZoEus5jadgKMuQx/38wfg4NNIc3MogJGuXY
         J28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868476; x=1786473276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mkb/ew2/ozHVq6JnvU2CgjbALANwgv9sf4rBC0yMfU=;
        b=bnBro0sq63bv7igfsxMdDIkAfVkRmC5nMTKLd1A8fQTXCBhns+jXdpFYlAbt3g2PYd
         /9vlX5mURclnZVByXJ107YRgsSLv4CUedRceZXkxUVv/oWFFY7w7P7xH7eXDcQaG+KBt
         8oeN3/ny7UNdFSU3/DeVfGbv4gMhSC/0tM+dmccwnvt/GXqXdDYFTxwrRc5QJlH+/1QQ
         rzOnFn7A6FXnmB0bKSKVa4tP3qXuSPFt521XyeoSgByNF2PFhwS7VISyogHBBsHhpmQF
         ZTLDGRMxqMH+FhlO2pV1lzHG2jF9e2iI63S9jrSWqzCdprbiMuGUvmXFJA5B/gnoGUCd
         a1Xw==
X-Gm-Message-State: AOJu0Yx/QJBj5t8NTvCW0klWWrFZ3Z8aCsoXAf/gaolS0LG+XjR3qla2
	s38SB2xzB4FzFe1Ma6ni3s9CbHktydimFl4cLGZTqDnsBIrQjhugMj1xxTN0Gw==
X-Gm-Gg: AR+sD11WO11UQ6+Bch6/8V3QigR6WSkIIzuk2EnkQiBNwhHstFGaq8tYyaKPAqVQ0un
	xTYGAgLdAlmjtuJZsUnQmJXK3IqqPS9fl2ujUR+z5WUvzyPTiN/s+mdCcAJ5SxteQiqv13BoczT
	GFHeW6zU3+ia1d/1i6vvAJUv/pcKf1A3dHLrv4NGu24jF8pngEC2RBS0y3hZgY6GTr9y2bJbp74
	QY1JclUjmwbCyu4IExqB/niV73dCkPzA4mwKjIkdU3TBWU61dTYLfWBIFfsWmxO4Idxo3ciU79N
	6OJ1xmV1fQc2KI4LC1m3C2i/7wH6SpuafEXJHxGF+PxCnT/GdPANNwrh+ENFbCHTTQSoO5zQQZc
	HIALl2+tJ+5fnRAmqORo0SZNculPv8vAE39v3Hv4zQybze/zdCt3GdgKZmy/3H5gP94cpTew88G
	9jCoXi+RPXi59ZAt93eXAl8MFfxDPn86V8YHkXQ/djWeCXR5FkFTs9mNu+LJbic1jzJn6EZ9aS+
	owDcUc//cXgi4OCMyLKVxP3Wts0gyogtGS7LrnHh2jFPc8KV0I0sKVB6rWjz+LB
X-Received: by 2002:a05:620a:701c:b0:933:ada:c3b2 with SMTP id af79cd13be357-9364922acd7mr41853485a.34.1785868476026;
        Tue, 04 Aug 2026 11:34:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffbcce4sm7338416d6.13.2026.08.04.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:34:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/check_format.yml: run on all branches
Date: Tue,  4 Aug 2026 14:34:20 -0400
Message-ID: <20260804183420.23718-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable running this workflow on all branches so that we can
see its results on other branches besides main.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/check_format.yml | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/.github/workflows/check_format.yml b/.github/workflows/check_format.yml
index bb44e60a..be85972b 100644
--- a/.github/workflows/check_format.yml
+++ b/.github/workflows/check_format.yml
@@ -1,12 +1,6 @@
 name: Check format
 
-on:
-  push:
-    branches:
-      - main
-  pull_request:
-    branches:
-      - main
+on: [push, pull_request]
 
 jobs:
   check-format:
-- 
2.55.0

