Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAE25229C
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717676; cv=none; b=QkqnUbqFm23C9E50cYQA3C+uxXyiTcG7KYjPnjeL5iBax7D8BTJcE9HPbxGp+FQOuLEeiJ8o9t+EwcYhq9+p+CBNjyNU5gyGiwiQvNfAU8aGcgsyHyaOwd5uCYIRlDjT11HYTNoVHdYV5w4s0DxTx08MglR0+OKi52mXNISJ+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717676; c=relaxed/simple;
	bh=7wgJFC0h1iNpXh0NYe4q1axtn9UaNYMeE+ulepYUNOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUBDylGYSfRMBUWd/K2bN+INdYEkqd48Zc9GNdXzrmQVt8VUl9XzcMr0KsVZ+uLAm9XAYHz2oxLcsSYPAKzaZ+ndHqTbtHG0Okz2a7xtQapdJbO8Idm8pgewkBlLUgbE0anuzQqTSztiZ+0zqAj1oaZorNErQJw5OQIpqMz+lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3DiDRHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3DiDRHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHtA3yCLEQOor5HqWS5Vkcxd3AsYSpzLYFkBz1gxVhI=;
	b=i3DiDRHfqls4/tl4HTYj/eRDVUq90YJvwHQ5PSZYvFaA0YultI3DV6SBRx2OzS6lNlSvqJ
	QjhvcPVBMhS/ZRTC9gfNKwhWs+TwwxiUzThuZjJ8ppMcgDlY0E4xRUG0ualqgvbP3LN/0M
	as3SxX5U5nYcUcriYzsQ4ExqVW87fZQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-uBV48PSvPcG9xxn-ZnTq0A-1; Sat, 05 Jul 2025 08:14:32 -0400
X-MC-Unique: uBV48PSvPcG9xxn-ZnTq0A-1
X-Mimecast-MFC-AGG-ID: uBV48PSvPcG9xxn-ZnTq0A_1751717671
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso659872f8f.3
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717670; x=1752322470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHtA3yCLEQOor5HqWS5Vkcxd3AsYSpzLYFkBz1gxVhI=;
        b=iQnJ1gKaiBqgJf07gmlAIHDCYSwUPG9agp2z2T+AlRwvTbatIN2Rpmf2byd2d6QFCj
         OiGZYNBol/mD8dI6EYu3d/gDnvukSjA7osoxs1rxLy7bSViNz53tAY9Y8UH6Pt2LPn8S
         4gXaQ57xrkqAhuz7GsBJAx/9nRMaC+9LOvekoUcDLrSidyWePjb0LLYsDDjuS8kKZwFK
         ivleiGPvXZ+dwZEabeq45+arwrPJpFyubbJR4DciGaPnlF44iZT0Z3kRScuvWL9GyH6o
         YaMIJEBze+VpN9noEGA6WhneOrg/ij9CZYspPsaEbrBFVqTrxYQwQfA6QwKQ+MHMYNyp
         4ypg==
X-Gm-Message-State: AOJu0Yxx7ep67pRPho23F62My8imLBOa0qBP7aMsjuLHLYSCxV6drtbZ
	9GEIZTtrwIN0slfAady4mCamXtU7lsguwXGXC8oO5XeY/0KR6B6lxIOrqInYG+Lbrkf9ZnLuFxK
	eiTdZ+b82CyUM1RJvjJZAmibtZ+Y7pCQMPzKSyFJO8PUrcfDVR4pQGZUzB2+bV/+p5cdBAtHeHw
	l9mDdkAK+ixlLp4qptUnDUiG33SkQELscqPbQb5KMCSQc=
X-Gm-Gg: ASbGnctJMalzzdCr8BkEZtQf713VXONE/lFXFRgkVqwky9F9oJZ3CYt8oszUrq9wuAF
	FoIoiuO/KSjaTOkOdQvOJiGEOiLvqBGkQUmy1ySn2m1FPT9KKqRMd/fNwvaon3/iw/zZD47sc67
	P/D3doTntvVsgMEXunt+E0OFop9LI0dZxPAQZnlrDdwJdHIh5sLstrHV0Oqi2n4BQiO8iZYKEYL
	/wZ9vZ+g7fmhAQZGHoBwsmoMSIPCTBg6UY4kNMLXLdHa8/IY5e118D+b8jU+ZNRT3MNaypXjinI
	oFO5xIZ6dT4TnmgSLQ==
X-Received: by 2002:a05:6000:71c:b0:3a4:d4e5:498a with SMTP id ffacd0b85a97d-3b49703d745mr4087419f8f.42.1751717670504;
        Sat, 05 Jul 2025 05:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmPp16gH4p2nv00XMySggWvi4hqUN+tE01qqO0RdTwHwOqiwzLhQ5gf/lpISBeSIdVBf9bBg==
X-Received: by 2002:a05:6000:71c:b0:3a4:d4e5:498a with SMTP id ffacd0b85a97d-3b49703d745mr4087407f8f.42.1751717669983;
        Sat, 05 Jul 2025 05:14:29 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:29 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 3/6] policy/test_file_load.te: adjust to kexec behavior on aarch64
Date: Sat,  5 Jul 2025 14:14:21 +0200
Message-ID: <20250705121424.1221268-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250705121424.1221268-1-omosnace@redhat.com>
References: <20250705121424.1221268-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On aarch64, kexec writes the image into a temporary file and loads that.
Adjust the policy such that it is able to create it and load it as the
kernel/initramfs image.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_file_load.te | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/policy/test_file_load.te b/policy/test_file_load.te
index 2e3f71d..5e5c85c 100644
--- a/policy/test_file_load.te
+++ b/policy/test_file_load.te
@@ -7,9 +7,19 @@ require {
     type user_tmp_t;
 }
 
+attribute testkexecdomain;
+
+type test_kexec_tmp_file_t;
+files_tmp_file(test_kexec_tmp_file_t)
+
+files_rw_generic_tmp_dir(testkexecdomain)
+files_tmp_filetrans(testkexecdomain, test_kexec_tmp_file_t, file)
+manage_files_pattern(testkexecdomain, test_kexec_tmp_file_t, test_kexec_tmp_file_t)
+
 ###################### Allow sys kexec_image_load ######################
 type test_kexec_allow_kexec_image_load_t;
 testsuite_domain_type(test_kexec_allow_kexec_image_load_t)
+typeattribute test_kexec_allow_kexec_image_load_t testkexecdomain;
 
 files_search_boot(test_kexec_allow_kexec_image_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
@@ -17,12 +27,12 @@ exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kdump_exec
 domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t)
 allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
 
-allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_load;
-allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_load;
+allow test_kexec_allow_kexec_image_load_t { boot_t tmpfs_t test_kexec_tmp_file_t }:system kexec_image_load;
 
 ###################### Deny sys kexec_image_load ######################
 type test_kexec_deny_kexec_image_load_t;
 testsuite_domain_type(test_kexec_deny_kexec_image_load_t)
+typeattribute test_kexec_deny_kexec_image_load_t testkexecdomain;
 
 files_search_boot(test_kexec_deny_kexec_image_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
@@ -30,34 +40,32 @@ exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdump_exec_
 domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t)
 allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
 
-neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image_load;
-neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image_load;
+neverallow test_kexec_deny_kexec_image_load_t { boot_t tmpfs_t test_kexec_tmp_file_t }:system kexec_image_load;
 
 ###################### Allow sys kexec_initramfs_load ######################
 type test_kexec_allow_kexec_initramfs_load_t;
 testsuite_domain_type(test_kexec_allow_kexec_initramfs_load_t)
+typeattribute test_kexec_allow_kexec_initramfs_load_t testkexecdomain;
 
 files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
 domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)
 allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
 
-allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_image_load kexec_initramfs_load } ;
-allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_image_load kexec_initramfs_load };
+allow test_kexec_allow_kexec_initramfs_load_t { boot_t tmpfs_t test_kexec_tmp_file_t }:system { kexec_image_load kexec_initramfs_load };
 
 ###################### Deny sys kexec_initramfs_load ######################
 type test_kexec_deny_kexec_initramfs_load_t;
 testsuite_domain_type(test_kexec_deny_kexec_initramfs_load_t)
+typeattribute test_kexec_deny_kexec_initramfs_load_t testkexecdomain;
 
 files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
 domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t)
-allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_load;
-allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_load;
+allow test_kexec_deny_kexec_initramfs_load_t { boot_t tmpfs_t test_kexec_tmp_file_t }:system kexec_image_load;
 allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
 
-neverallow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_initramfs_load;
-neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_initramfs_load;
+neverallow test_kexec_deny_kexec_initramfs_load_t { boot_t tmpfs_t test_kexec_tmp_file_t }:system kexec_initramfs_load;
 
 ###################### Allow sys firmware_load ######################
 type test_kmodule_allow_firmware_load_t;
-- 
2.50.0

