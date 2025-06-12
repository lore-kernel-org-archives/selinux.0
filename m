Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC718DB2A
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715938; cv=none; b=Esvo2/UE9OaaoqeAmB/JcjeA3rSxGh2cv9ArheW46QL650CXd+Y/4ttofHISKt+7n4SlOeZcitKW7cYDFO0tmoXqm3LigM/Yab1GIFu7jLb10KEpdaTFuv6DGB28J4MY1ZQbhmauZl2B9GeLnXCUHWVPGW9kL4IZu9q6CPnEanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715938; c=relaxed/simple;
	bh=1U9uObgbCLzgD2iKs2kAWoDTy9tWAkpvl9dfuf2J/6Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LW/dD8ZbMwJX7G1HIKUPTgLPZuuppCvqh+4PoHOX1lWXu8A5MtjrLnXoxamulu4vHVOOMfxSwJ9zdNusnC7g+Yq2AOsvkpvnknkYSpltRf1jGKAEt4cdihMcgw0D3RIpZfqu4GM3vYPDxYB9oLbTqjlCfR7DjO9fqIfrSkbO0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGzXpA+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGzXpA+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749715934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JYgqLzbMkeAtQC2XdY93uk9vZNKaKsCEM6/4cjK/1AU=;
	b=hGzXpA+Wa3OHg7LRgWwRXJqztoCimK7DpG2YkUjBM18EYW3p7/3OWRrLc4omxI1m/6m/AE
	Ar3+oAYLtGfENT1/ubh51kuXQso4iZZk1gXI2043Ob2ePKK5T37hh3uDHuF52tEUUFknWn
	3DB6bVdRdIDI02VU7n3gon9W77E4SC4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-3PKo17RCOCiLOMUzcCPVJw-1; Thu, 12 Jun 2025 04:12:13 -0400
X-MC-Unique: 3PKo17RCOCiLOMUzcCPVJw-1
X-Mimecast-MFC-AGG-ID: 3PKo17RCOCiLOMUzcCPVJw_1749715932
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-addd0146baeso58012066b.0
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 01:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715931; x=1750320731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYgqLzbMkeAtQC2XdY93uk9vZNKaKsCEM6/4cjK/1AU=;
        b=Lv5txgKVY7Dbz+v2llA0vcy74mj/EBB/S/cE7sqYmI/d1dzGIkI07GGZKUdh4GQZUF
         65aSWOGI/KUr/0J8N/d9fI2KSTRTqTdZb4Ag7NbDivCJWgOG5suwFrj+edw5VNwvrfT7
         vWS90paAcpdA0msEI4Q6ErBBjQSDHaQxyeDevfFiFc1u9vVlKXMnnQH0w/XSOcFbzFLT
         Uo3hDJlFlHwDC58bHfni3Y/fq+3DF1tPlmOJ/BQdPy/RQ2AJxrOPmnlTV7jQgU90Op2S
         gR6H8Ewe7e7In8qa9pOE8jrfOsgEmx+nBtjuzLUUUeivH2UZPt0ZmxPqjNmtFqLOlT+T
         A/gw==
X-Gm-Message-State: AOJu0YxXYwxANNy13fEVxtD6DV5CAmjdirrbnRdKOwsz0e8T0Gza12hQ
	ZcM/dBIjVf4rra66HhH8ljEMzqGVb9DYcIQpohln0Zh+dgaVzgKbVFdrDVn+b9szQwCAkCWPGup
	7TK+3I/KZqA0ZXu4kXE5diKpIG99FPkf+Esns4LmH1z0W0YWZawPE3TWiY9SEkr8BPU6WVqf8o0
	pDZIT+WlURM3NWTIu8+x4z4nTPNqG/HtTXMOzOsuz8byWPEA==
X-Gm-Gg: ASbGncsw61G9Wm/ZWysPl5+ZhOFefKCTZX6LDQ6Fz2FVQbJDpn6C3+B1E0ahVDWe/TQ
	psi1xHTTl5P/x9cHSUF/+Rxm3lu9sWicXYco1/LXV3PebPP1OxeJRAsJ+XkSi4k104ufiW5YXQ0
	+EYkEadDk2DArls31rDowJYMpCRZRFcolOTP5EyRsX7VdFVu5YAZyDJ0XUR1Gq17/SgGbItjPrs
	XVE+8gvYYgylFyv4H2Hg/u/pOlWXN0qJ70zTsASXMNhLGZ7R9O3S1LHIeVLJOgQ9ypBlY1NKNg3
	HSHpy7JodIIXy/GBskuquH2lGVx2877SxQ==
X-Received: by 2002:a17:906:f595:b0:ad8:a41a:3cc5 with SMTP id a640c23a62f3a-adea8d36614mr208200666b.6.1749715931310;
        Thu, 12 Jun 2025 01:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS6yVy5LsMwY4U/zfsR1B9RHYpG98ZxPTkA4KJk1N3fZgE1gYxrBTLUXh+SBAXTglStFq5OQ==
X-Received: by 2002:a17:906:f595:b0:ad8:a41a:3cc5 with SMTP id a640c23a62f3a-adea8d36614mr208197966b.6.1749715930830;
        Thu, 12 Jun 2025 01:12:10 -0700 (PDT)
Received: from localhost.localdomain ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadb22d47sm91065066b.86.2025.06.12.01.12.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:12:10 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket: properly detect IPSEC support
Date: Thu, 12 Jun 2025 10:12:08 +0200
Message-ID: <20250612081208.1721183-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if XFRM itself is supported by the kernel when deciding whether to
run the IPSEC tests, so that the testsuite can be run on kernels with
CONFIG_XFRM_USER unset, too.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/inet_socket/test | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index ae06ae7..4cc3852 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -25,7 +25,9 @@ BEGIN {
     }
 
     $test_ipsec = 0;
-    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
+    if (    system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0
+        and system("ip xfrm policy list &>/dev/null") eq 0 )
+    {
         $test_count += 4;
         $test_ipsec = 1;
     }
-- 
2.49.0

