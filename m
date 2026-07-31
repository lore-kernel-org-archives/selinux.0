Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B03C1D77
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487228; cv=none; b=Qrk0eGD+H8MWMdY1fdJ+wSOv3ntFa6inAlUZMKxJQMJioBb1p9LgqwBSXnv5qGq/d6a9gvr4IklnTmTM/1Hr4IgPddf4x6iMUZVFuy7+wkXnD3p/KYf9Zbp0XpeFrspleJ+ifICw33iQWiftwZg1DCUmr6sY8lZRje0cnQ6IhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487228; c=relaxed/simple;
	bh=1vsv7Wiqfz/vr0JUjoqx8My13GfjdsnaYIKc0RV3d5M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m/yicSdkrRzupJEPpCcC5tS10ac/pWvOGWMmM/RJmBk152BZqhTs6q4W8X/lClXNwLkgvSFQBdsIL/v2h85aRhYt9vguo58wUNTPBLmDq/JQ4DArIAs6n4PZLilvnYxxKmVhX3Lj0na+Ibt22UDKu4FsAMkaRDRTwe1TAtDzpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ge+Wvwh7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJFuN2Au; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge+Wvwh7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJFuN2Au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785487223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FKklpqNY/gvHN9vuAlKT5ZYIn7r6z31Ldc+OP9GFdVI=;
	b=Ge+Wvwh7nhKZv64ApQ1nWvte8jNMzb3KGWYE7Vz78k8V0UBOs8hMjSuc33FKIDgs+hYQrQ
	Yj0CTBI2njrYauzZ5YZigkP4GAcsm3lbD6Y8iHxw1LgJt6JCdTYfiJJMD30obb0knHRiJ8
	2hPCTDNv5YCw6wqw9mcBy8WPZsNan1w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-XgB2DWOlNcGzS3LLZ1V_4A-1; Fri, 31 Jul 2026 04:40:21 -0400
X-MC-Unique: XgB2DWOlNcGzS3LLZ1V_4A-1
X-Mimecast-MFC-AGG-ID: XgB2DWOlNcGzS3LLZ1V_4A_1785487220
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1c232fa136so94573766b.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785487220; x=1786092020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKklpqNY/gvHN9vuAlKT5ZYIn7r6z31Ldc+OP9GFdVI=;
        b=DJFuN2AulU9oLmT5za61jn/DQ6KPLA3YNdukf2nmRT3Ga9ZoWGMz5dWYbPsg93NvEW
         v5MwBV7ggZ7drPiX/Gt2TPBU0Dp2JEn5tHhH0Rg/xZj39oABETdCS2i69Qpc0PHXYgkT
         W0gaDUKgnrIADw8hMOo1UofkZSgg9ap2PnN961suOmuuyxpwgqvpeYJvhX5uTGkeJWgp
         DqZ93tklNgdrErnbJ00OddD2OLTTog3iGsLqCTdKc4zLs8K9VxAlI+qfrTPw8eCypvwd
         TEQVUUw6nNUSSr6oLobaRlUEih6j1U5KczwcKXTtoUwNHBrgAxTNXU3NmZ6+HrvjQEoD
         VhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487220; x=1786092020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FKklpqNY/gvHN9vuAlKT5ZYIn7r6z31Ldc+OP9GFdVI=;
        b=LEX0OI3Yvdy9pZxgKa41fWDBQLO8gmWvqzM0lfQlBGeVYGngAyl3o7FIEl6p+2B2V0
         /s0lSdpQ4Xj1Y2BU/yHCwAv+ivZZKEhkh7OqRZ6V3lH7e8H/0IwE1lwE+T+q5kv5cOKx
         Q9JjoFR/XE7hyMtcwkt6fZteNkajTt1x0QySzmp6B5dUb2kPSsXlBOQXk2C5691h9s6m
         S4ttFhvChpjZj2LzMMeXuH3wQHfSMSYrBhvcZTofVvTdjc29gk6uHNcvLHcVyjEUr16s
         rEfCmvDjx0LUr+ICkctgK55//sBuiNTP1JRo5Pf5oQEZ/p4L1M+TeVA/lsviEIiPAYoc
         NdHQ==
X-Gm-Message-State: AOJu0YwbGqkYVFaJ/oj0PQhFtr4jwmcHEKs1LpWAOOB1tYuHEq5KnuAc
	NnGfgn+ex59JZK5d6b56vhAQfC/DkHpZaa7JmowBRI5AOtkIxDAOmAsELCu1MBAwThbLn9AXljK
	q9Lb5noNLA4mBNvV20NXoFHITJy/EqMO6awRsYuz1a61Hgzxpp+ux6iTUeb+w4rdk0hwID7Yv1l
	whdbVK7GNo/KNDtcUO7PSda2KjcAtlDGe/jVLN6PrS8Qk=
X-Gm-Gg: AR+sD1249dF4D/XkbiuRpqnwTRcltbnbqejuDv8V7g6m1PT284QI3WEi/xOJbCznHhW
	1HHlh+yPVcK6Sc6NXvOvMEqpUfvamX59gn6n5oDQCibVzu+uyNvYRuLI9Q+ZInz/5706OVkELH4
	YryaDJKIkd+nD7WkPrJtoSlYUIGSIAUUCGLUXtY10VV5RT9X26jctNtTwjsOOeoRbntkGAQrBvd
	qevQ4FghxwPn7/xqJ6MFnkdv8BFuteGIZAjfvr/K4j40NX3jHB++j2YFAORuPW9HLU8gye+1r66
	ZTBm5M0UW85dPGTM+cFEy6RcuJcrQWfjtgKsKJkRVxrfrACc7Wn7CNMxoA==
X-Received: by 2002:a17:907:960c:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c1fd2b43f5bmr75311966b.0.1785487220012;
        Fri, 31 Jul 2026 01:40:20 -0700 (PDT)
X-Received: by 2002:a17:907:960c:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c1fd2b43f5bmr75310266b.0.1785487219425;
        Fri, 31 Jul 2026 01:40:19 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5b11d2sm563705a12.8.2026.07.31.01.40.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:40:18 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests: disable testing of f2fs when PAGE_SIZE != 4096
Date: Fri, 31 Jul 2026 10:40:09 +0200
Message-ID: <20260731084009.1285103-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current latest f2fs-tools release (1.16.0) doesn't work with it, so just
disable the test in such case. See the added comment for more details.

The issue can be reproduced for example:
* on a ppc64le machine with Fedora
* on an aarch64 machine with Fedora ELN or CentOS Stream 10 after
  running `dnf install -y kernel-64k kernel-64k-devel
  kernel-64k-modules-extra` and rebooting

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 4fe6f3c..084c788 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -21,6 +21,15 @@ POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
 # Filter out unavailable filesystems
 FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) > /dev/null 2>&1 && echo $(fs)))
 
+# Filter out f2fs if PAGE_SIZE != 4096.
+# Latest released f2fs-tools (1.16.0) can't produce a filesystem that is
+# mountable on a large page kernel. Latest master branch can do it with
+# `mkfs.f2fs -b $(getconf PAGESIZE) ...` and device size >= 1GiB (in case
+# of 64K page size), but that's not packaged in Fedora currently.
+ifneq ($(shell getconf PAGESIZE),4096)
+FILESYSTEMS := $(filter-out f2fs,$(FILESYSTEMS))
+endif
+
 SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
-- 
2.55.0

