Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E12773E5
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734143; cv=none; b=IEeA7hG8MVAU/PwU9PyXjT7SmeuNiuR6F5p8BDFLmNizRPsfj1UKhmdvUEevPZSY1kT1oidseAvwDWdbk83ra1EOpQmQR2hoGuxxbynn3MCqH76LFjTN+U1mHT/0MMVQc+g5ZQdGtLU2uqIeRWni83Vq/+S9nz0RZXLehOyHogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734143; c=relaxed/simple;
	bh=9Y2Zrx/Cr8b7TGO8ZCajAJplVcXFy71y4Cg1wFPKLBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBk5/tsKTebtw9/IirIQDO7raqDaTY1N7sa8XgGim5lslAEuQTNJmPJ8YoGFgBQlzcuiDglcn5suIXss3v7/M21WRzKnHYaXIzVyl99oBrOFRfpuIKgzD+XLLh8QnVEx+6GiIt9eyUlr1UcPb2g1Y9w3eooU/3peal1KZnQcViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KNMnkLWv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KNMnkLWv"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-883902b96c3so234355385a.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734140; x=1761338940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6P4WI6kq9TcSDMRGH/ZyspTQ080SiUOr/PdVMdw5Zw=;
        b=KNMnkLWvsn0Es8/GWBEbWyZZuwFNmsQavoylirNX8J0iNZUBSPiYygYpJ6GLcol6Yl
         /SG9U6ZNSbtObzQmsS8/2W+S7b2Ig5RJQebdSJMpxDqtWNB6fGv9CFmuQj7fQIU9AjIj
         7SxENS9Vh8H4Km6chRGY6sRkq51OVq12t+Vwe3LX00FXq6y14md6YexrwWm4SOA+gvu6
         T5a1UVw2rsKszw/gfQplRMUBEzpA+zbvWjLMlLrOB/EtQeyZABL6jkquBKv/+73A08bx
         MTdfFtZfkV3OjIcuUaKNdEQoKa2OVAS9g4Q2I6TSXjprLKTO/HL4jlREZKwnHK6gkgn5
         UlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734140; x=1761338940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6P4WI6kq9TcSDMRGH/ZyspTQ080SiUOr/PdVMdw5Zw=;
        b=W/Jvc7nLT4WC4Ia3MwrqiVZ1XHPMKi8Wl8ce8aKjkMVgo2vPbJHuy+P2Z9n/48kDti
         AYR9tHrEqy8nbMAzOvd4fqS85R74w1VOSrlDLFrS0YTCTPQEOd4BuOTKGsu3ok4q7D+2
         T3yR1bfZ/xvmJ3Fmoz0YvkNijo7TtTRDMHLd/oxDI8D7wcuqN04+7ZU4myl4k5W1S7vY
         PFuOGC+hUxBLRhMRYecRq/+zHU/ZF6EgWnK2P4Vq6X5M/p0OQY+CPShfsRVtr/Y3p/qh
         FVj50JTgZjOtqOYghDskcl/YXn1YJRWD0FPmN4S7xP/7wdh0q61Fvh0VpsmQN/XypyBO
         rlHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZwr2vjt6WuYJFS44KIkd2BfQWnlFqFrYbBjkPsH2eCT1PUK8TuzaBviEmiVDCbeIRkdYqYG5@vger.kernel.org
X-Gm-Message-State: AOJu0YwPutQFnevzRQNnUr/6V6NfPnD2rga5iRVO5CO2U9NM988RWIH2
	HRf6UHzcF5Rb9OEDPvKWqRWWh8tK66NS13je7d9Kdhy8JqPZizEDAmokmYQCGMQxT+FhhbXXzOk
	9mjW9Iw==
X-Gm-Gg: ASbGncumZfEDjcz7Ag6mmCwHRNVsDHgODd9HR29BhVcSx2Far1IqNUx44t1bfVzHNGb
	1XrF1V/5UapNlPUpOfc9QlYj3LVBWqDfwmMC9RMuvuQ3aPwxXjKWX1dI76+xucmwN+U5umOTjau
	8pcInUMJgUpepuFtPzw13cW6HkuIXHhUEjj++kr9zuFTY1cw2NgVvuUDLO0E4V9I5nb/tCaKMMC
	9CaIr0jyVV8lsueD92iHtPxcRyuGBOZDxPcXNivs0LN/pejGCVNdgOoNSoyvU5wyqZaZn16MZOQ
	rzPcejhLHuwvpCGr9z/MdBeQfX+Rmr68vyQQMBhwVZKUcZUW+Nh/JqSGBBY/BsPOkZ5chOu4c8/
	Z4fqT4XQ0C72z41LtIUfMzot0k8eXJrExKzXC8iSAXzl43KLgyqTA1DP2JKclLQEFI/vHd8rqHq
	L9LEDcJBq9jFCiILmj/uWQCGKrB9r8fKa3Udbs0M6mKMhvxw==
X-Google-Smtp-Source: AGHT+IGEKeIk1mH7UjWm0L+4D1j3Z5SFblT+9YG1M1mQSzQraCNCKG1c8R97qqMFLE4kXWs5QXuoVA==
X-Received: by 2002:a05:620a:4621:b0:865:cacf:e11d with SMTP id af79cd13be357-8906e8aff83mr726508085a.12.1760734140485;
        Fri, 17 Oct 2025 13:49:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58ede4sm41969385a.42.2025.10.17.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:59 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 05/11] safesetid: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:19 -0400
Message-ID: <20251017204815.505363-16-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=paul@paul-moore.com; h=from:subject; bh=9Y2Zrx/Cr8b7TGO8ZCajAJplVcXFy71y4Cg1wFPKLBs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qucbD3hqsn007tssjS8Pw6v4x1QocL1W4pVP /T+zQ0MUw+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrnAAKCRDqIPLalzeJ cwTID/9d8707/NwnMIb0EAR7uaqqYuf1JO2bnmAyPlZC4haQVENWGQ2TGjn79Il8LSCgMaM0gnu eF6Y0U0lMWhROvyUVgvkrNnGmR2lj9wxG0QrvL5sDHZI4Ao6NGi+5zhDEd2I4rgBAIbdSSt9Q67 KqJNgUlN+4i3Ckauym5QCUpVtm09QlVIHLSdY6gY0OzLITgldomNntpEK5BrzPQhzZ3KuKNRk37 6bNTi1VRYn5FOO38cinEWpFeuH0+i9+do7FyjmCTU5eisH5RCF0Y5nDQPCfQ8Cn7SyUL69IjUsq sObQXxq0yJH9KH775vIAPzV6gu0977mcCMR+vLR5Os9liS44kXZyRnuTXq82JKOSpgFRCe4IKFD rGdS6Q1YzaZlawAJi+I0N7gsHLFUsQ3GbZMjn5ZA/6g1zF/NXZYPdoyTVYVm2xdgx2o3dAjud37 vu3dxcCs3JzOiTbPdGsO5ZF3UGNs3xai2hNnPS8Q54nFZySdPJnMQoUQJzzi37HbyqM8JVUR5g0 Se2bB6lChCoKzRpXNsv3VTM4IcCf/EqSV0voNeYZq0jnwE7dh7I7m+rmXJsLICAbWF64jtQLdcR pzy8xjgYP6S+alwXGdL39YELmxEiWLmZeg1iHMUtTquN6UL0XiU6jWHictF8wNfIc+wKxFMyvOF HcmRgdXkjtaLEGQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.51.1.dirty

