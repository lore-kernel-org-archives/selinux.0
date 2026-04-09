Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFA3A9605
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725518; cv=none; b=FXU+33rGCjl47XbSWV+SvR+/yCzA074g3/3PQcvHlfPsrSDPvbInoNPsqe22a+N/rgKn+fl3hG8SNZ3dEvVleEIJRzmkgmqUg7T3hRxbURng00tPseVry54IKrV/d9FE32C4+QxHPWb+2FSZEOFZSvktsYb05osu8UHtxD3i76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725518; c=relaxed/simple;
	bh=ieUxjFZ1JG743WreN1z0xuJU/p/YqADG6pb4ci3vFZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M3ScS2uEhEu8Xn9JELnlDkW80/Yos21l6/TsuJ9s1zmiR3au1ArOoqu7tyL8Jb1ZBNEsZWZ5naV1KA/h9yTvug6H5rfcuPWnv7QqJQIFpczHL9Vz2ZV3Bg5Tw0cPgqIHQPxlOHThvh5jIeXbuRPnjN3zJu9mhzE8prqgeDgNn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7VKlLuB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8xb6QtY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7VKlLuB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8xb6QtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775725516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8HWtUsDvIF7beau/kF01SNRewLTknYba2uCh96C/8Kw=;
	b=e7VKlLuBBBn+b3ItCc50crG5fPUTkwbCn8W49VyJMcm9tda37qAo8XNuSmk3Ar7QEgd9t8
	0EP80ndqFlK8zktky7+TQvQ1sPvIWYWBikr/Wj2EoNKccK/iEVT9qSAHvPgyp1RUdwQxV3
	NUyt9lntnrdpLGz957aMLc9YXCCz6pY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-sO-eVRtMM2i8FNJUhGURLg-1; Thu, 09 Apr 2026 05:05:15 -0400
X-MC-Unique: sO-eVRtMM2i8FNJUhGURLg-1
X-Mimecast-MFC-AGG-ID: sO-eVRtMM2i8FNJUhGURLg_1775725514
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so3600085e9.3
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775725513; x=1776330313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HWtUsDvIF7beau/kF01SNRewLTknYba2uCh96C/8Kw=;
        b=U8xb6QtYi76DSM2VS/Fuvrw04J8tOL41NZuQwRQzEtN/dmWnQy2PffWr9NW+Ay7066
         L8aeZ6CjpbCVldDcdQcvTV4VP5Ppox53gkSf1dixX1At7xbablBwfYT0u2LxbmPx/c8e
         3Dm/uPtqes6Q3urk8ARPhvCLls4Q4snUAkTX35gYa7MeMQ9Q8sOhemxCT8uqhBmzK1Bi
         TbXxIIh+m5GHPv7+otRoVY9AQdxl+BsUz000rknDbjKStHF4ciI8iCwObAq2n0UXvk76
         dWbB7qaYQQofDXCRlPJmfT1es7QWpykqpZw6DrIXyxYvmiA3lrHWVizfY88Q0y0luTNo
         mbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725513; x=1776330313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HWtUsDvIF7beau/kF01SNRewLTknYba2uCh96C/8Kw=;
        b=LJvGLNgdcoJVF0kno8hlMZkF/UKGMPBhr0PmCtlb5AN779vfcB5tzpsOFoJOOqgjiB
         XkUTym28KQezWYgGVMAj42aiLm1EXA+vBU/YyUvaBCP69on6Fn3clADgLoemXTXqDfQO
         t8dVf6yQO1Q5Ib8R/uWQ8Uo0jSpLuhY7Yt1KfJkmG7l1KW4PA2VhYS0Rc5LMw4HjOCKU
         fQtIyd6LmLHx9Dwgt/b0QP3NG7toB2g1cV3qelQEKh5QqVT9T0dYYq2AR6WNpfUr/VhC
         7+fxeXSPNjM4tZerNpqYPX4nZe/U88usq0jvttllqCx1KNwbguBJJp2vzcXcxPx5ELk6
         R/Bw==
X-Gm-Message-State: AOJu0Yzfw3aPXor4LBV2ZHUZVALP0wHx8Z/Vz8xrZBydzNDLm2jqlwOM
	Gb7fk4jM1QRVSonh/Mon5EtOiAuiAkigcKV0OmlDtNrigg5B3Y1x4bDYnB62nbBOoXpZHIVcGIs
	fslHQveIBZvpMOAlw68Rva+11QrlaSEVOMWGs4YodR659DZCCKNlRRyaoap62NkbFnfV+3G9z5D
	8bfhq7UNLBMdaxS4Qf8LyEwYGeGMqNCSr/nvj+px9lAOPo6A==
X-Gm-Gg: AeBDiesIvsaO7H7YqQcG5Dbjv5sZhnJNrv8JkbNYDROpNgDmewSEkLmKLhAuBDnjfqH
	46zy+PQxBYA2KYNbaQOm2gbUKC12rH+BWzfu1lPUl6CEpMTjp2FYydrejpCNyyxHI/2/PdKvR2O
	v7CkVvdYCrQvY6o1bxkcuu9Szqox0V8Sw8EuYZNc4NZqOt319tmUI/8BSY54+3snonYe2qPV+sd
	41deqFaNtvI79ZZH24X7l8JmceYUnxGgRY8vFGQG17UXL1PxUawef28McUc1xW5ImU77O7NNJQF
	WvkHuMg2hNZrJV8yBziUn/TZb5miJAC0Cil9SX0yTRHQraxcGiyJKvfmzOV4WlAwa+d2z7321j0
	1o7Q=
X-Received: by 2002:a05:600c:1554:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488ccfb7907mr38866615e9.11.1775725513385;
        Thu, 09 Apr 2026 02:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488ccfb7907mr38865855e9.11.1775725512721;
        Thu, 09 Apr 2026 02:05:12 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ccf9b919sm38660825e9.0.2026.04.09.02.05.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 02:05:12 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tmt: add setup for BPF token tests
Date: Thu,  9 Apr 2026 11:05:03 +0200
Message-ID: <20260409090503.2846202-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the system policy such that the BPF token tests get exercised in
CI or when run via tmt manually.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tmt/tests.fmf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 1df3a5d..88039f8 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -42,8 +42,11 @@
         semodule -c -E base
         sed -i \
           -e 's/\((class system (ipc_info syslog_read syslog_mod syslog_console module_request module_load \)\(halt reboot status start stop enable disable reload undefined ))\)/\1firmware_load kexec_image_load kexec_initramfs_load policy_load x509_certificate_load \2/' \
+          -e 's/map_create/map_create map_create_as/' \
+          -e 's/prog_load/prog_load prog_load_as/' \
           base.cil
         echo "(policycap netlink_xperm)" >>base.cil
+        echo "(policycap bpf_token_perms)" >>base.cil
         # allow nlmsg to some system domains so that the system can boot
         for source in daemon initrc_domain systemprocess unconfined_domain_type sysadm_t; do
           echo "(allow $source self (netlink_route_socket (nlmsg)))" >>base.cil
@@ -55,6 +58,8 @@
         rm -f base.cil
         sed -i.orig \
           -e 's/module_load /module_load firmware_load kexec_image_load kexec_initramfs_load policy_load x509_certificate_load /' \
+          -e 's/map_create/map_create map_create_as/' \
+          -e 's/prog_load/prog_load prog_load_as/' \
           /usr/share/selinux/devel/include/support/all_perms.spt
         ;;
       local)
-- 
2.53.0

