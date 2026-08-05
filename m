Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F1442B2B
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928056; cv=none; b=NMNLcQkuXDDCdyFfTgSSwRphidbjGH6JQWJizL2Ahj8cH8GtD8jP0F9VJDwjEQDHmT3fn9ykly5PuBZ/XuNxGDzozJRtbN+O8NjKkMRvmLwOpEELnk0OxscoeERj3diWxwBkJ6hSrpV4L8bpdJwo/OV2BR83wSJlFfquM4VmyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928056; c=relaxed/simple;
	bh=r6jY4CynhAj15fk2uerljIqT1nydzqWmpcFt8/7veRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XDeCm1/viH+iAUlUY6oFvRxGVMn0ohwRRpdJDls340wR541gZi9myOH4EDNAPwO30OcA2OrkWvKZH54RlFIFkywnNai/yznLh5dc2Y9u3lrn1Xah1C20+WojN7TemKsVtBs7b5Rqvt1SxjNZlkA6U6EBCvjXa12NIhXx4oInjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsadPMyU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mIRbXsxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsadPMyU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mIRbXsxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785928050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s15wJic66O/3Ry+l8pO1dYHCPVVHD3M9zZvYwofku5I=;
	b=LsadPMyU0fTa/PpNQGnG9/wG7s4ShGmTjYMYMk0dlPbLv/K7rLjVm+EI1EbRnX2TGzRdVU
	NTs40NBSmNYL3Bf44X1bEB3y3OR+/9rhV5Lan0isn5CXFFKJXbR9TY065knXhDspZ75i6D
	9np60M7gHJ0SDFBvX1kz4BBNxdTICqU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-iK7G6_-zNSWiCS5wkOv4Zw-1; Wed, 05 Aug 2026 07:07:23 -0400
X-MC-Unique: iK7G6_-zNSWiCS5wkOv4Zw-1
X-Mimecast-MFC-AGG-ID: iK7G6_-zNSWiCS5wkOv4Zw_1785928042
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47485fde05aso518675f8f.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785928042; x=1786532842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s15wJic66O/3Ry+l8pO1dYHCPVVHD3M9zZvYwofku5I=;
        b=mIRbXsxGacDwew2NLiFZU/AVfo8UWKqFXSrnn8cap0kwF+rDKA9d9+xNUfNaVq3PhO
         rzfaR6wmOAzpyOAbjYQcgmtn3Zo2lPSMc0scCrfzXCJhlzPXrnDOAshHCO8kLeaMIajS
         IhZqJOY4twLIsYa6Yhztv02HSYSOijQSBwmaVVNCftc4+miexk+W92GSv1DyrHsJ4hLA
         T6TfwFqT7KhPCPFNl66/l+WCp79/Ycc5rcbVwpPZ7NnT6cDy3WIjaB85ZpaFPemKYHjd
         DV8jdq9mpAK7h1LP6BM25IyZfU4Nm/LdauJSr/PRUat7hjz91x+oh/Ed+lm0L0Y9HgrZ
         zxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785928042; x=1786532842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s15wJic66O/3Ry+l8pO1dYHCPVVHD3M9zZvYwofku5I=;
        b=ffSUGVz0nuJwChUo9GBtMyqv3IqaMf+0pDPg61jIgMffjVV12a0lEKIKAAn47o+lOc
         aS4tmRAwo4HSH5kUInI85Zb+TSUMt3QrrXGg0ZhQFc/tChnNlOn4Si08bfHsCZeojn4D
         mVYlgmv6YjmPFJakebgR2bGw5fE7QbsZbT/gcnLUrkWhHuoFPNqtQx4zTKxLViT1Fd4O
         yyU34LxuEgA0yPTkMISK5NhgzSnDBB/rN20FwgIkPqp104CNQaxRf4/axNSWpqfHpKUd
         j7RSGFXcEpczt2g07lN4w+y+M5217fNGefGWZh0HGxfi8i49oOFN/WUJoDxpkV29fV0G
         7+cQ==
X-Gm-Message-State: AOJu0Yxb4mBklw3tybGG/F8lHEPhk+itZugc88OKbKKnlXtxf1utNMd9
	YeDpJXDTmFGneW8Yl9CbRtrVHUyLxZIJJEBIkRi7Eu4Osw5k28g0niuUVm+sBj94s2nsJyjgEvi
	bSqPugQ6iHos0iFm1iNxnzDMAGC8/Bn2D4wqkjGHgcTcbLVgfnroRNgI5XfFpwhyQcZEqhOWEEz
	BLhVSUmM7MRvMJyDG9YUWrFB2AznUbhM6S9AYwVPhhDK0=
X-Gm-Gg: AR+sD10zbyhqCv8dhnFu31UgfOChRIc5IzYFyW9Rt5O4ReHdx9X8K54b9K459Eq8LlX
	t/sahDNsJB7HTML34DoReuA4KaMNKfkpZrPwzXwOr6CmBbpInMEaoTsu+0zvnBbz8cdF/G6owu1
	wK1wTEI8DwCoFaaIlH4H4rozNN2VUu995Ozvc1/zYhCN88ii7ZLGluxBsOdK2oSU7HLEEluF+tx
	OohPteYyFzZ8qQphZBmAcW1Vl1aMh2cRTH4ZbzPT5dd8TULP/pt4mSrHjrJSHDkUjocSNCwfeGm
	iJ71/j2Hve1JGsn7aA3N44HfqDOwfjHjm9rEs1Y3Zruu3AOrEeCkN25XtKeDYl6GT3X4SMaoJQ=
	=
X-Received: by 2002:a5d:5e01:0:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47fec635c89mr9087252f8f.30.1785928042333;
        Wed, 05 Aug 2026 04:07:22 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47fec635c89mr9087152f8f.30.1785928041780;
        Wed, 05 Aug 2026 04:07:21 -0700 (PDT)
Received: from fedora ([2a00:102b:4001:f01:854d:6fd6:b880:4a14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda0d7sm7619569f8f.2.2026.08.05.04.07.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 04:07:20 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite v2] tests/io_uring/iouring.c: bump RLIMIT_MEMLOCK up to hard limit
Date: Wed,  5 Aug 2026 13:07:14 +0200
Message-ID: <20260805110714.17403-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test domains may get their soft resource limits lowered on transition
due to the typically denied rlimitinh permission. However, the resulting
RLIMIT_MEMLOCK limit may not be enough to run the io_uring test program
in some cases (low init task's limit + large page size, for example).
Ensure that io_uring tests can run successfully in such environments as
well by bumping the soft limit to the hard limit (which should be
sufficient everywhere) in iouring.c.

The issue can be observed for example on CentOS Stream 9 on aarch64 or
ppc64le.

Fixes: 3b4e44eb3243 ("Add tests for io_uring")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

This is an alternative (better) approach to fix the problem described
in the v1 patch:
https://lore.kernel.org/selinux/20260804071454.2122438-1-omosnace@redhat.com/

 tests/io_uring/iouring.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/io_uring/iouring.c b/tests/io_uring/iouring.c
index d5f9cbc..36b014f 100644
--- a/tests/io_uring/iouring.c
+++ b/tests/io_uring/iouring.c
@@ -68,6 +68,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 
@@ -475,6 +476,7 @@ int main(int argc, char *argv[])
 	struct urt_config *cfg_p;
 	char *progname;
 	char *progdir;
+	struct rlimit rlim;
 
 	enum { TST_UNKNOWN,
 	       TST_SQPOLL,
@@ -500,6 +502,19 @@ int main(int argc, char *argv[])
 	progname = strdup(argv[0]);
 	progdir = dirname(progname);
 
+	/*
+	 * bump RLIMIT_MEMLOCK up to hard limit (some operations may need it,
+	 * especially if PAGE_SIZE is big)
+	 */
+	if (getrlimit(RLIMIT_MEMLOCK, &rlim))
+		fatal("getrlimit");
+
+	if (rlim.rlim_cur < rlim.rlim_max) {
+		rlim.rlim_cur = rlim.rlim_max;
+		if (setrlimit(RLIMIT_MEMLOCK, &rlim))
+			fatal("setrlimit");
+	}
+
 	snprintf(uring_path, sizeof(uring_path), "%s/iouring.out", progdir);
 
 	/* simple header */
-- 
2.55.0

