Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA645278149
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224838; cv=none; b=ptIQXRWwYbTwcBqE9H042CgaEHi3ZPzj2LsxyXGRl2dXFHzZDbxHSL04Gc+uTEpO1MhjoH3Dm49lMasaUbCqjA967ftmSD4QyUbZgO75DMC+y3hBd6xFH+Pnk3480gqk5mORDXyGvaLuUFpqYvNqBnLhPYLVyCYvK+DwOGuUoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224838; c=relaxed/simple;
	bh=EOhKFjWPk2W+JME5T82mhmndtBkKJ4lU4BvvjUFikbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efMahmHiCT1H7t2wnSqygLdzxV2VqtDCXVFrTfARIPfHiuug4iF4jwMGB3/z9d9A8Uo0qzjXXib8WYzTK9XSEqPqsBQ1/HO0GyRMdvUKXqTPPtqroFPbJGUATyGq4mdBqwZJcpfLedYKr2bTsh9Xnu0ctzMfDU7Nn5NyGqbBRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CsTLtt5V; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CsTLtt5V"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so11159336d6.0
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224836; x=1744829636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FznqwKTb5apAKN7+PdryvYkHD8cDOK5T7aoHaw7NUu0=;
        b=CsTLtt5Vw0RXkken0N8YjsPORF8mLyHFZ0YXh/8IbHm44jrOdpKe6MDn6jvI2WPG2w
         w86XA9Ia6zquksFtR5r0aErwZLEfDVxGkqhgWtWF453+g+4wkWtEbweADVmhwcbFMwmn
         SD/LsqvvLZdZQpVVBX/N/kSplrKirdbSHXlbdisQQQBoGQV81GnJKiiU+ijmfzl/GahL
         J+dP/AM6JbH7WRIAWHnnbq8cFgR+ibIqocWO5F3mfehzv1vxIQ9HvGmsQhIsQHSiEKTi
         +oWF1vf24K1MsMuUZsSHmyNyuF2wNOHrFOQdYF3AjitEh85qtBD5AYVWNukCziwlwyx8
         PyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224836; x=1744829636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FznqwKTb5apAKN7+PdryvYkHD8cDOK5T7aoHaw7NUu0=;
        b=rZjBEuR5CN84nwCvGRpWQCEMj4TReecUfoKzdRLlyx3nI0Zj7Wuk1hJj0J0soocx/z
         rr1R1H31MbjkAwfVX6HDGP+ySJr0t3biJLtHxI6XR4iv7IJGhthsPiuXGJYIf3d6yWT5
         Hf4c+SYhHwppZxQ1LbfFJfrvXz+3PVCpixMtuRJFsy8zRgUh4tRes58TrYZgnECtEfF6
         my96JzMQgeh2L4YDzM7BiiBAGHdSXeIn1cPBWBbyV0jrIGE2BAy1gxb5Ndy40biE9R23
         V4l0qPa07CPghtQHJtWho+TLlvxvW4xBB0hbVRo7UKIlvITevYhiBXLDER64uQJEx11V
         G1kA==
X-Forwarded-Encrypted: i=1; AJvYcCXUkQeB8R1ThnbGY8k8YkyIas88Y0Uz1MAbAxuKkA/akndl69OakXViVggnafqgY1lCGe0FxuTa@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaBeUAhwl+p9+7yXU0uv79aZFo3jvZZ02r8YBCKehXsGyH23d
	R3ohIFj8+XAydMWfLc50sITiEqqvgsDlfbHCxN76Ol7NMIszMFn/uJTRWVYB7g==
X-Gm-Gg: ASbGncsvQwy2K6Lgh4uUnKWtN272cAkRC78sLec2qkQWRM7lDRe0bBfBU3fCeK6qgmx
	GISEdQeImHSoA+6ZV6WaxX3dVaMSh3fo7auPh4ocbJ6zB3s1xz16efpSOyCpS824MJoiLrEsMNY
	CfWPZG1EQq12k1E/tQZbYCY2dods9UVoUNAEcXMLTLKXe0lnRY0XPXQvfvVcaTfGL3M4wbIl0Rf
	lb7VA9wRWYh2HorOZL4Z9/E0oN7cJ25QF2te2ZMYIaszSbzLSNDdBqMmj/Mup7AlX6EjFYSU2+b
	TaPf/ciMXtWKtlxPQKtrlQZSCUnjc0Z3FLNKd+qIoQEN+u3FkUoVP6hAdtWQLgn9YO9vwmQUPdz
	FCXXYaPAhyg==
X-Google-Smtp-Source: AGHT+IFcpDIpn9yzoagNWWHWb0KRZQDu1+LHtagATeLv2Xto1aKeAbvvTuZ3Ieu6WEHXP5eExSlB2Q==
X-Received: by 2002:a0c:da0b:0:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f0e4cd95d2mr9685806d6.15.1744224835695;
        Wed, 09 Apr 2025 11:53:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95fdd1sm10572126d6.18.2025.04.09.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:55 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 28/29] lsm: add a LSM_STARTED_ALL notification event
Date: Wed,  9 Apr 2025 14:50:13 -0400
Message-ID: <20250409185019.238841-59-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=paul@paul-moore.com; h=from:subject; bh=EOhKFjWPk2W+JME5T82mhmndtBkKJ4lU4BvvjUFikbE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sIVMDPtmaBS3eTRatijsag/DCisyb4Lmzoy2 Rs47FQHppuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCFQAKCRDqIPLalzeJ c/RFD/4o3uzOvFwpzkMnP8y/Ozb/Np5gbUiHvWCt3vtNSOHqvzf0kuvVf7K5dmKldtN9VG7Fezu fWYpsoGhZq1z49oePGfOIAM4XWj0xIayB/J7ufugfCI31/BQHMPk34mgdIpFiRlFjMTJD1KFpWg ZYWf+18CAuYoS9wIZmHMJlsCWtYzYOXy/ahoakG3nmIJ4Z+GmMq+ofY3qFV4zo2Eo6v+61VGyNZ Uq6hHMbSW2PfT0Is3JBP2lOhMOmnFKkhRKKCwDoLihPwYTIQdtu+qaK7y8LC7ucVTU0cAXT6RGL eFpYPjQJaKBmUvbBLfxv5Tc42Uv7cWQ+q1qfZo5bHyN48RutQHFZVbvJ1D7JWF0vsgj114lQaeZ m7Mu4Gms3TrcFwXePRReawxy9shpXmPvBOZQxu1ZRpfm9M+jkSy6x4QzBNaWT5LogVX85zm3m8A 7ibswbi2ktT2WSqTN3qF9mYhOoMAKnaEGmvyWG/7hPZTAHtTZx9SMnExdo1qacaqvgfKszoEnqK IGORQ4NgoeRN3eDQ//A1nhOVv5t2+yBkmRYY36PlyByhrLMSyspPDATpYz+WAEnV70rUObVJ8Xe BYGN0lmKkTl2Eketjbl9HRhYZkElCMGP+VjXuLOBTTDLVDMDDP4fF1NBNSYKygjirwv9SRmxVEc osl1Vp92YTaoFUg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8aac21787a9f..a0ff4fc69375 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index c0881407ca3f..cad6d243a2a6 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -553,6 +553,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.49.0

