Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D7186A
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898536; cv=none; b=mNqrtWF62VtQ5VnNIrb+vlzZAr/OKRWWT4xPy21l+R273SpKlausmmyTHX9/DYlg7xO8i7RZsmw6es5hCGomgZyetvTclqZhsfwpXHvKlu29LKGfeiy9ofSVSNwq0bYT2AMPFN6OzT9mmQOCZ9Gw6NkRMJ+XVSfTe8/VQwncv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898536; c=relaxed/simple;
	bh=2N6kR5k7NdMWVbwI8Q4dIFASrR1TqL2rb8c/ZfgSFz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amke5HffoD3Zi3arPGF5hzIInon2MOj4W3cFDgs0SrUREcb6Xfev8PWdZRWxKhvraySV3t0jy22qgk1Z5sCFmGNjOmk+eEp8AVZGkqkut1uWXuwf/pSoooxQQsXRbB21SaREenVI31wNF078Mx76VTGgk6tj1QfLPOVdK5pojdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DT2DPckg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT2DPckg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735898532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be+aZxZ39TqXNefI7HNfPmhrf5w9NdIqpE1UuK0AZQk=;
	b=DT2DPckgVcdsGjOEjtJaWoKfGfNqioL+3v/uM8K6uJ170X2opPQto72EI9HU8lezd35TnJ
	a2mB81FaY62t1ySekHrbQhVC+dQQQSRcb9nHcK/ulke5BMPr0G3puh7/WsUcHNFu3cBtA1
	XhAMoFWCUrcQChOAy7gXBpQhHRFh1nQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-xU16MuY7OXaLV5CrABhSWA-1; Fri, 03 Jan 2025 05:02:11 -0500
X-MC-Unique: xU16MuY7OXaLV5CrABhSWA-1
X-Mimecast-MFC-AGG-ID: xU16MuY7OXaLV5CrABhSWA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so96108685e9.3
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 02:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898529; x=1736503329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=be+aZxZ39TqXNefI7HNfPmhrf5w9NdIqpE1UuK0AZQk=;
        b=s1Hr9UAV4ho1a0Bbu3N+Twh6GYsD7hlh96HyCde94/5CAVNp5z+nLyQR53xTxqG2M+
         +hbHDWIny900A0t25+1Pe9q5BqdwGSm/Q++MWCYKinwG9FGmtVrzKNvE5SD1OZ8jIrf0
         xUY0R100AOkvEJTTrJ88ihNl9k0geKWlNV13w8xvBuZw1FbCtESJiKplrDDnjGFOhi0M
         5D5o2MnRWeb/KOlS2I18afUC5oM1ezBY2jyRM1rshTda5BlRYHNFBaQveVz75vDI/R4t
         iUXZtSBgIjqsk3+OUmJ/68n5r5bL5/mP4idGHNKHYH1RtVTHBdQh6D4o9UfgbcGIYdLb
         aCmA==
X-Gm-Message-State: AOJu0YzG3pXjaVQTfjqBahaNUH4c810eFsYvI2xDfS8Nfasp3m/5XI/D
	KGC5hPINOJFCOSSJtmq9xQtE7FY8yMSsyrH6NQYWi89pBgdE/ZBiTInGQ5NToQN3WNhSK9Va2ae
	GqJrfSI+Dw7K3YtJV98IrDZT+p/mgKdmfua9TZbJ1VbFGhd3dkrLBaRvyrwPxGKpbH4Np0QGxXt
	z4Xxa0Wrx47dFasXaZIx2RgkwFFpqssSS8l+DCJgw=
X-Gm-Gg: ASbGncuy98JlAFV54mIT9u8P007yMzL8IbqosIt/PIiZ/X2K9zn8l2VX53tR83cIDrQ
	ALH95AcvqE+NOEvabt4UlsWe3MRly6HGs0FrbFztoolJ0Eutow3n3sY7zT2zIiuAZ0Y5FLoDNZv
	L9AjwdWkMerqvivF4GgPREklFEizUc19tni/aXh2rRgueiAvVMiOB/ejE+L70MRVcxTRExjacg7
	xSyrNRZYjOnXsB4+omzJjPabx355Vqf+DnKpwvVS4qrP/BLIkOz3chxsa+aW6Y+aXF875bO
X-Received: by 2002:a05:600c:2312:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-4368a6fb89fmr275558395e9.22.1735898529456;
        Fri, 03 Jan 2025 02:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnkT4vLTQa7YpSLOojoIm+uhzRnBwDxwiXMO08CYE58zA4paMd/FyhALhOArEkFLCZhgTXBQ==
X-Received: by 2002:a05:600c:2312:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-4368a6fb89fmr275558095e9.22.1735898529059;
        Fri, 03 Jan 2025 02:02:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm519175535e9.1.2025.01.03.02.02.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:02:08 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace 4/4] ci: fix pypy conditional
Date: Fri,  3 Jan 2025 11:02:03 +0100
Message-ID: <20250103100203.32580-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103100203.32580-1-omosnace@redhat.com>
References: <20250103100203.32580-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operator = doesn't do pattern matching in [[ ... ]] - operator ==
must be used instead.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/run_tests.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 63c26210..ed60921a 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -123,7 +123,7 @@ jobs:
         PYTHON_SYS_PREFIX="$(python -c 'import sys;print(sys.prefix)')"
         echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
 
-        if [[ "${{ matrix.python-ruby-version.python }}" = pypy* ]] ; then
+        if [[ "${{ matrix.python-ruby-version.python }}" == pypy* ]] ; then
             # PyPy does not provide a config file for pkg-config
             # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
             echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
-- 
2.47.1

