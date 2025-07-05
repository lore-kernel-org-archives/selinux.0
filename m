Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D822A807
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717674; cv=none; b=ZBXC4hurN0UNhOeZzztjB67DgQoE3sqrspmtxFYjS3xDG2UW6e70M7K3fhA6PWhHSb6p5ufLg2FLKQVA1/th1dexbmZosWLY8NQ2B9JTcOvaDX6qPdlEOey4jAdSpZBM4ZwbpQlTouhhseThRocNFOZA9bn8GZhwlrahZqSIZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717674; c=relaxed/simple;
	bh=8KF2obdWu4BGt+wXo9NPaMHYs6L0CYDeLPSkiDiGaGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izvjDmEcHAzWLvboawrk1Gl4CrbAKaV7x29W431dRoOOpoE6Dhu43JyUz9YYXLLa/u2NN2omuKm+ekX5BESUPlnirIzg5x8PQf5dVH8gAuf9jXQ0pDRWaxLN1ladP2TWWLy7Y8MS9Pt87QIv156gs5tk5ITFpkKoNMkV/ldvLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7/HVGQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7/HVGQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvH07+ak6IFvfQlTgRwbelxrT21uNdMiIeH0wOTqrHs=;
	b=i7/HVGQC+qRbnMGIybQbvZCTkP1KbmR8S6K4629VVK/Nkl8y8r3/uA+LVNzOnLLoC4IqeB
	b/5E69h8SjLTlGnJtQS2vFiu0oJgqx4xeN5Hy1OTySa1ANC9r64Ua2/RHDac3y6UNsNcmp
	kSJdvaDWvkLw0T0Ui9cifL5WvJUQQl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-CKDLOpreNQKNQCdJWflkKg-1; Sat, 05 Jul 2025 08:14:30 -0400
X-MC-Unique: CKDLOpreNQKNQCdJWflkKg-1
X-Mimecast-MFC-AGG-ID: CKDLOpreNQKNQCdJWflkKg_1751717669
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso9129195e9.0
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717668; x=1752322468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvH07+ak6IFvfQlTgRwbelxrT21uNdMiIeH0wOTqrHs=;
        b=cn1CLzDf4YsWfQYOU2nosLlZOkN0B9ewuWYHgmWSw1G6HvDUHiJvoHre1su0NWMpZV
         syibppsSpv+zpFu1wwhwyHqIepwop+ORhj3RY0LHnJ3HxIgfsi5kW3vhrashT/ANhM5h
         AQ7hkppl6H0a69czTAgqHMKbk/8M3LTIkhAc1TF7GfN4EEm58zEKOtV7vDfog6ILqwPR
         VC70XKm9TlWAZ/wBSt4meHGip25BLtDLHPK2ZCKYuEYnLqt1gNpPfbV2g0miyWkpiTCg
         1yr/RxQMP4rpElSc+FnI+5LCHmpeVowQ2V6bdmwSqn0Ub+pl5RZKl9FiHbhVLcMpIsBM
         7VbQ==
X-Gm-Message-State: AOJu0Yw1tiBBZFi71MJ5bcRCkpxuX70Zoe3lKRTomHEJGD2iFXC0RRMq
	T7z8P2LIg9XtBfxQOHc3IlO3GqKUk+5szkpLHLMutqdH8SihvwLYp/s2zTPYIpxtIsyOYenG49F
	mCsn5mkMNGNxaqHcP5WcEuwZet3wD/2Sp3xfx+FUJ1n/nCQIwqwFt3i5ntERd1Z5fG8eFXOdWJP
	Htl2MJt39gm3poDOgR73zfLjR6JaMI3rYS8T5BconKiVo=
X-Gm-Gg: ASbGncvldnzaDyEO06riFzCvuoslsN5u06J+odDmvv2d+NpdfixGg8FZyKy0rMfRNX+
	CIBnXSspjiyQ1rFSMU2VYZQSfKdnS8PDV9wx3ON5XkOlWhc+6J/CAdui2EVqg5r4Gab/atiKChh
	NRKGpY3rjreRz6P1k2lfvCp3VnJkN8W+H6ReGrzyq7/OdBS6bAWbLtx44HIq00VsjErkV2EkTeN
	Y7PZ5Dr+OxQkvjy9NT7vyGOvpq6F9Up8AB/jROxu2QQLbAm/rFlbiw9mUR95wC37rGfSPy7pXV3
	RR4aalyG3IXAODlw0Q==
X-Received: by 2002:a05:600c:1f82:b0:453:ec2:c7b2 with SMTP id 5b1f17b1804b1-454b26b2c22mr59112125e9.7.1751717668336;
        Sat, 05 Jul 2025 05:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7nzuALrFUz0VG/OMW3kUkdcwGQYUIyh2bWZFw7ZyzQFmzZByKce/amAAplBFlLTKmABAoHg==
X-Received: by 2002:a05:600c:1f82:b0:453:ec2:c7b2 with SMTP id 5b1f17b1804b1-454b26b2c22mr59112005e9.7.1751717667888;
        Sat, 05 Jul 2025 05:14:27 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:27 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 1/6] policy/test_file_load.te: remove excess semicolons
Date: Sat,  5 Jul 2025 14:14:19 +0200
Message-ID: <20250705121424.1221268-2-omosnace@redhat.com>
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

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_file_load.te | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/policy/test_file_load.te b/policy/test_file_load.te
index e98503a..2b52ffc 100644
--- a/policy/test_file_load.te
+++ b/policy/test_file_load.te
@@ -9,12 +9,12 @@ require {
 
 ###################### Allow sys kexec_image_load ######################
 type test_kexec_allow_kexec_image_load_t;
-testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t);
+testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t)
 
-files_search_boot(test_kexec_allow_kexec_image_load_t);
-fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t);
-exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kdump_exec_t);
-domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t);
+files_search_boot(test_kexec_allow_kexec_image_load_t)
+fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
+exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kdump_exec_t)
+domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t)
 allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
 
 allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_load;
@@ -22,12 +22,12 @@ allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_load;
 
 ###################### Deny sys kexec_image_load ######################
 type test_kexec_deny_kexec_image_load_t;
-testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t);
+testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t)
 
-files_search_boot(test_kexec_deny_kexec_image_load_t);
-fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t);
-exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdump_exec_t);
-domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t);
+files_search_boot(test_kexec_deny_kexec_image_load_t)
+fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
+exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdump_exec_t)
+domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t)
 allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
 
 neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image_load;
@@ -35,11 +35,11 @@ neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image_load;
 
 ###################### Allow sys kexec_initramfs_load ######################
 type test_kexec_allow_kexec_initramfs_load_t;
-testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t);
+testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t)
 
-files_search_boot(test_kexec_allow_kexec_initramfs_load_t);
-fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t);
-domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t);
+files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
+fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
+domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)
 allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
 
 allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_image_load kexec_initramfs_load } ;
@@ -47,11 +47,11 @@ allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_image_load
 
 ###################### Deny sys kexec_initramfs_load ######################
 type test_kexec_deny_kexec_initramfs_load_t;
-testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t);
+testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t)
 
-files_search_boot(test_kexec_deny_kexec_initramfs_load_t);
-fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t);
-domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t);
+files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
+fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
+domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t)
 allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_load;
 allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_load;
 allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
@@ -65,7 +65,7 @@ testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
 typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
 
 type firmware_allow_file_t;
-files_type(firmware_allow_file_t);
+files_type(firmware_allow_file_t)
 
 allow test_kmodule_allow_firmware_load_t self:capability sys_module;
 allow test_kmodule_allow_firmware_load_t test_file_t:system module_load;
@@ -78,7 +78,7 @@ testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
 typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
 
 type firmware_deny_file_t;
-files_type(firmware_deny_file_t);
+files_type(firmware_deny_file_t)
 
 allow test_kmodule_deny_firmware_load_t self:capability { sys_module };
 allow test_kmodule_deny_firmware_load_t test_file_t:system { module_load };
@@ -87,16 +87,16 @@ neverallow kernel_t firmware_deny_file_t:system firmware_load;
 
 ###################### Allow sys policy_load ######################
 type test_policy_allow_policy_load_t;
-testsuite_domain_type_minimal(test_policy_allow_policy_load_t);
+testsuite_domain_type_minimal(test_policy_allow_policy_load_t)
 
-userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t);
-userdom_write_user_tmp_files(test_policy_allow_policy_load_t);
+userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t)
+userdom_write_user_tmp_files(test_policy_allow_policy_load_t)
 allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
 
 ###################### Deny sys policy_load ######################
 type test_policy_deny_policy_load_t;
-testsuite_domain_type_minimal(test_policy_deny_policy_load_t);
+testsuite_domain_type_minimal(test_policy_deny_policy_load_t)
 
-userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t);
-userdom_write_user_tmp_files(test_policy_deny_policy_load_t);
+userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t)
+userdom_write_user_tmp_files(test_policy_deny_policy_load_t)
 neverallow test_policy_deny_policy_load_t user_tmp_t:system policy_load;
-- 
2.50.0

