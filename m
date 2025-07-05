Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394862E370A
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717676; cv=none; b=irX64pPGnnyyUmYA3UtLJ04abf82PSwJqNiNBEd7dOKvPdaWuKZkSOKL/oSD2k8YhGQBq+a8tdI9reNQnkuLZk6pepntuYh8CGJFnFGWKTywFQCdBjAXnv1ajUjlNWKeB9GHUdJe2vlJZTJzSsDLI+0Q85Wo78j8OvJDrEewllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717676; c=relaxed/simple;
	bh=ENdjD6m3DRgHyfYyoQVDce5JEpTo/n6COH2w5QukDVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3rE5WJ4sbFUOFvPKkIlxZDKBC7vBCq/KCD1Q0ILHWGDTLV394bxj3Epb6UgUxgw+8xm0ipNYzDsmsiCo3W2FmaG88TDNhO0Y2kBu9cyl9cQ5B+G7Ohr0DzDJAB8263rSZHkikpa7MNBQ6FWSRxmHHNmLjQ9RoSiD/yfgWO8nZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiF5/Na8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiF5/Na8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlKh3MlxLIJ7kBSUNZuaBm8Jv2wgjEkj5IP5WtogyNY=;
	b=MiF5/Na8eyftBB5E9LhngxfhZ+c9FBVzUZHn9KeQxdOktDIAVY2FtdHwjxz1VdET2DvNeH
	VkmQ2uhfvmAkjjlgx2XIKvlCx2p8TE41aa4+JdQvK+d+LWj2BpLzG0YDQc27e3okTIUZSR
	HeWN++xownQTg7jbFWkV5+zrWW3kki8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-OGQWS2uIPreO64D2OvH-ww-1; Sat, 05 Jul 2025 08:14:31 -0400
X-MC-Unique: OGQWS2uIPreO64D2OvH-ww-1
X-Mimecast-MFC-AGG-ID: OGQWS2uIPreO64D2OvH-ww_1751717670
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so633029f8f.1
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717669; x=1752322469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlKh3MlxLIJ7kBSUNZuaBm8Jv2wgjEkj5IP5WtogyNY=;
        b=Luxlcf6stCvew/c4vmq1bHUh4fwTF4vIWzTpalpVvcUjCRD/EXGliClECWlhwz8XBt
         u5f7WLLB3RHBSgOjtQMkSGLKKIWRa+MLaapAUC03pADRjwwYVq3UcNniLLmaXb02YGtQ
         5FBr/k4KWA+ysgf2elR45My/rrlr7xPJdBvTXqaFdpGn+w+AZLQ3R7FjxIRhCb6jgvN2
         lLwGORf6oneMvGC2i3LPOWdUPpOW7+mgAarfbI51B7kSnhCy4Ac/fHA+OX2mZuJk+19l
         4yxbXFuGlZ5fS7ZzRTft2oPYQb+bsLP3UE+DMgO7Y3uOtZIqOg9WLD4jEhb+2rjbFZB2
         xBAw==
X-Gm-Message-State: AOJu0YyN0z9fNvvyuSyPk8fWsErcb0+CA+I46LA8JmW0GicZijv8gzui
	oYvlzQTWHF/G1qn5m1JF1ZA7EU3iN5b+E/cijYtXumlscLcogwbo1By4nRRsbQgMhRUvVNh/cC6
	WlP+NeMha5bXIaVH4Larz5zg0aNyfEVIuxyaxnG7D/A5O8qbMENzWmmiWHMMscPi6t4Vp+xeN1o
	HOEgwlmv3Cms3HM+AVP7Z4e66KmBydkQp0dFjQBCBWCZA=
X-Gm-Gg: ASbGnct8+1zTX6yTgyafMA6VappeZnBpn4N/1RiF0q0WTdxpuRVw0O5BHTJYcsu2qD/
	4kxUNFoVeC1vml18Wbn3De4a/on8h9mAht/4q+cSiNBnuF8/BnEvcZ0nzkvCnIOpRu0W+2ObyS7
	EPF2HOzt9h0+2ndwThx6wDlZNxhPl3MI0eI1EikNZ4uBanhF6VgDT9TYDS7CVqk6bwizvdJTEPk
	opQKO/bxtXGatZyl15iWyq3tnxerKy3HL330cJlR1pFp1SnEs3jvayoc3zN5/+V+Egi6mnTRBtG
	4+ZlLouzqwaVMRG2qg==
X-Received: by 2002:a5d:5f81:0:b0:3b3:ec10:75cb with SMTP id ffacd0b85a97d-3b49aa31072mr1868116f8f.26.1751717669466;
        Sat, 05 Jul 2025 05:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeqyCWMPvPofIpF+bMpOyvbIXgh63vrZoKCpyuSXqxyaWQ74s+/G8kz0jVAQQK24x3UD6Dog==
X-Received: by 2002:a5d:5f81:0:b0:3b3:ec10:75cb with SMTP id ffacd0b85a97d-3b49aa31072mr1868094f8f.26.1751717668868;
        Sat, 05 Jul 2025 05:14:28 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:28 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 2/6] policy/test_file_load.te: use testsuite_domain_type()
Date: Sat,  5 Jul 2025 14:14:20 +0200
Message-ID: <20250705121424.1221268-3-omosnace@redhat.com>
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

The minimal version is not necessary here - use the basic one.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_file_load.te | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/policy/test_file_load.te b/policy/test_file_load.te
index 2b52ffc..2e3f71d 100644
--- a/policy/test_file_load.te
+++ b/policy/test_file_load.te
@@ -9,7 +9,7 @@ require {
 
 ###################### Allow sys kexec_image_load ######################
 type test_kexec_allow_kexec_image_load_t;
-testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t)
+testsuite_domain_type(test_kexec_allow_kexec_image_load_t)
 
 files_search_boot(test_kexec_allow_kexec_image_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
@@ -22,7 +22,7 @@ allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_load;
 
 ###################### Deny sys kexec_image_load ######################
 type test_kexec_deny_kexec_image_load_t;
-testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t)
+testsuite_domain_type(test_kexec_deny_kexec_image_load_t)
 
 files_search_boot(test_kexec_deny_kexec_image_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
@@ -35,7 +35,7 @@ neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image_load;
 
 ###################### Allow sys kexec_initramfs_load ######################
 type test_kexec_allow_kexec_initramfs_load_t;
-testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t)
+testsuite_domain_type(test_kexec_allow_kexec_initramfs_load_t)
 
 files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
@@ -47,7 +47,7 @@ allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_image_load
 
 ###################### Deny sys kexec_initramfs_load ######################
 type test_kexec_deny_kexec_initramfs_load_t;
-testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t)
+testsuite_domain_type(test_kexec_deny_kexec_initramfs_load_t)
 
 files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
 fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
@@ -61,7 +61,7 @@ neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_initramfs
 
 ###################### Allow sys firmware_load ######################
 type test_kmodule_allow_firmware_load_t;
-testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
+testsuite_domain_type(test_kmodule_allow_firmware_load_t)
 typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
 
 type firmware_allow_file_t;
@@ -74,7 +74,7 @@ allow kernel_t firmware_allow_file_t:system firmware_load;
 
 ###################### Deny sys firmware_load ######################
 type test_kmodule_deny_firmware_load_t;
-testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
+testsuite_domain_type(test_kmodule_deny_firmware_load_t)
 typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
 
 type firmware_deny_file_t;
@@ -87,7 +87,7 @@ neverallow kernel_t firmware_deny_file_t:system firmware_load;
 
 ###################### Allow sys policy_load ######################
 type test_policy_allow_policy_load_t;
-testsuite_domain_type_minimal(test_policy_allow_policy_load_t)
+testsuite_domain_type(test_policy_allow_policy_load_t)
 
 userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t)
 userdom_write_user_tmp_files(test_policy_allow_policy_load_t)
@@ -95,7 +95,7 @@ allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
 
 ###################### Deny sys policy_load ######################
 type test_policy_deny_policy_load_t;
-testsuite_domain_type_minimal(test_policy_deny_policy_load_t)
+testsuite_domain_type(test_policy_deny_policy_load_t)
 
 userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t)
 userdom_write_user_tmp_files(test_policy_deny_policy_load_t)
-- 
2.50.0

