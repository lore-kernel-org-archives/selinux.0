Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059472F2913
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713247; cv=none; b=MIOO2ugOXN6vlDnjEc6XwEy5pfQmicCgCRgN4SQcxmFSnxIEWGeYHXymGH/2t59OQdrn+f7OZJ0i+rZx5yN7ujbmGpmbXcxJq1069U1U/qVdz3/K9AiZIKxgwFl2QZHBlMulb+MGYyG9czKPpb1/exp70wn3GIEQnVkpHTc0EPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713247; c=relaxed/simple;
	bh=nqgazrMA/G7+6QfM26UcrMPpy4IMpFL+odNWyLxLzuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ineonFE7F78BJlITV1OaXDbAz7cLo+h30p6Co85zeIp6UTRnamESEEzP1eIbD3PMK2j8bDJbvt8jlMri1/lM/qTOLB4M3e1J84Qkf7hA10+RNi4uEJYQkx+z3LJqa609zwfGakKWOKcty3IvfcMV1kCra0MEQVt91Jmq9p9ACzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMmYKawU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pMLoDkVr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMmYKawU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pMLoDkVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763713244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JxlK/bTO11ikyc5qW7M+kk69v3YgGFHOgmcntvaVDcM=;
	b=ZMmYKawUQ+k0Zvj5eEBXvgQvHWmO8W6gF1L+ZcmWlIvLCvNj01ncVvs4uwapCp5+pUAu2P
	5GEvlbFRvUGYwWE3SiV0fHmr0LGKsorJqsUiK0FVPqgCxj/XwL6eNayCJMwBXljJv56Y9W
	CIFKllvucKylTzQStifX4OgUvsH7YPo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-oZKVKI4dMIWk3k7BhqfL8g-1; Fri, 21 Nov 2025 03:20:42 -0500
X-MC-Unique: oZKVKI4dMIWk3k7BhqfL8g-1
X-Mimecast-MFC-AGG-ID: oZKVKI4dMIWk3k7BhqfL8g_1763713241
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so3242923a12.3
        for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 00:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763713241; x=1764318041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxlK/bTO11ikyc5qW7M+kk69v3YgGFHOgmcntvaVDcM=;
        b=pMLoDkVrFJ2yj1wCWcX+sCUN9rmEqce2o1qXlQtKcV3484EiUUgSfOY5Lx1dOokHIc
         lx/A2K9aKkoqL3VVXi2F7GMFeif258EnwZ98F92oR+Nx5y7HqzL7gq2WfzT75smImELx
         zAGzPkWS2k71ppfYea76kjQveR9SvZEDckkTyRL9UA48I/MCKSX7WdOvSXWD4/e7ryKh
         Xald5FNWsYMnZMPqKfoCI8L9iNugTC1+1WxYchIaf469AjMDRp44CY2P2i60oMa2Md6y
         iN1Q/sxDxd98MJu2DnJaL9jSPZx2YF8lxoslaTxW0xgmYb1DeuRx2wsqJr9ZdGziQsIO
         /wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713241; x=1764318041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxlK/bTO11ikyc5qW7M+kk69v3YgGFHOgmcntvaVDcM=;
        b=VvkqX+w5v3Juwo+dZlqok28sCIqdSoVK2zJLW6PtftMKa62yq4+5OwS+PNyIh7i1zG
         fjy4SIlDOeNaLhp9aZeyhbwutD9AE43Ol9+lwtdX7vF0hpO214coCKDHnjJF096ml878
         tRl3n1mdc3gxqxUL+rUmhE7lnS7yrybyu86nNjMMts5c8T1chXFv3xKwgwYlYZiWQFEb
         LljJGjxF99dySZahHGP9w5UO32tWugpNFPScT370tX0b/BbJC2ZmLFCwBP9+3OLZaUqc
         ObjqRMmbY0MUBHT4IEcy4HFT/kfxH0WxAL7aRhpa/J0p1N6QFA4+2IV7XsI2yVtvdn3z
         foYg==
X-Gm-Message-State: AOJu0YyXOvhQxPp4mOkesXTxsfsujMERv1RqxFmSFNlqJmGu4iFMvW8J
	LncyTzOMKQlhJ0gJ400wI9WEzqd1fK61PeY+Vq0f14TeHxXvJIXuv+jSuCHL9zv0f+c+cE9Z1dW
	BuVfcUvE55qeOa2ATaVtbEj4sS7trP/J46loJkweX0jke6e8+kFlFXhivtjXoTUnYZfv3knpCVW
	rX5/xQ4zzBCAI+ayKzO4MrG2kj87a7Ry3mqmACNsxph/w=
X-Gm-Gg: ASbGncshrHVjbEVOzdWft83he3rrsteKP/QsKvoSLKCC/OwYgUyHhIsUanJFsRtixDw
	H+glJ9NR8q0vC2K6GzduqgTRo1CQsSdZEBTyHnENDwKKOdns57MDMYk7wdBUR7AsPkaPnXRNawv
	6CPQdMYmQwxUJ9tT+cKFaBEoujbX0/O3IYhU5W3pTTKBksGYGBCN9/kWgOQwg2SojJb6gXhk2Nq
	ALjIMIuLV7UPWYflyPgvOkIeVFjZccTetDIPMhi0SxJOIO6AOEYMCJIMAzui0Qy6PLbMbs4546Q
	8xScOQMYWlX1z1RqPzRGBx6WJeSe5hhqGTMfqLMecEjSKZdENnU+lqpDl0e3j9HRNJEWNwY+Nsm
	B6LLayA==
X-Received: by 2002:a05:6402:5247:b0:640:74f5:d9f6 with SMTP id 4fb4d7f45d1cf-64555ce8d37mr947126a12.25.1763713240871;
        Fri, 21 Nov 2025 00:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIV0ESTg5gyiqFtjuINovpvTaioVVL5oyM5v966pmzqOv7Hd0q56XcPg5e00rnnGb3yddrDQ==
X-Received: by 2002:a05:6402:5247:b0:640:74f5:d9f6 with SMTP id 4fb4d7f45d1cf-64555ce8d37mr947111a12.25.1763713240431;
        Fri, 21 Nov 2025 00:20:40 -0800 (PST)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d267sm3882762a12.22.2025.11.21.00.20.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:20:39 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: allow testsuite caller domain to ptrace testsuite processes
Date: Fri, 21 Nov 2025 09:20:38 +0100
Message-ID: <20251121082038.735276-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this is not required for the testsuite execution itself, it is
useful when debugging by prepending commands with 'strace ...'.
Testsuite domains outside domain_type() aren't allowed to be ptraced by
other domains, so the permission needs to be allowed explicitly in the
testsuite policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 759353c..cb7d9c2 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -69,7 +69,9 @@ optional_policy(`
 
 # Needed for domains outside domain_type()
 dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure rlimitinh siginh };
-allow testsuite_caller_domain testsuite_domain:process sigkill;
+# ptrace - only needed for debugging (e.g. strace)
+# sigkill - needed for some tests to pass
+allow testsuite_caller_domain testsuite_domain:process { ptrace sigkill };
 
 # keys test may trigger search AVCs for root's keys
 dontaudit testsuite_domain testsuite_caller_domain:key { search };
-- 
2.51.1

