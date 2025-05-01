Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D68367
	for <selinux@vger.kernel.org>; Thu,  1 May 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746127455; cv=none; b=qt30cz7cB70NVL/TJQjxSyJmHQ/U8fEWZ7ax2iFP+xJmTX/oe//dYmXCEzTqJvZVClOb9qSJQ+nVrSVCiNS1lI7cbCro1UjG8lb/OFQP6FCeXLFVZjwiRFJ7Spl8Lb4uXhctlw+7Mic8UkN+sX0Ijx3XwIWWf+hUjSBTO6/KGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746127455; c=relaxed/simple;
	bh=Ak6CVCiRRsfIshMkTJgPy5IyYmt2LNTZoqy6mgNLl3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QnBj2hSQMbjUxy9xmokc9u7UTe8UxUaV1u1gO/gSYmgD55E/uzf5UKxYgHwe6O/hf3k7H5X3shFyqCsayo3xbwd3ndzgbaW4ZbT2tMWoLIu65CwYPBG+HhETxjm49swUcVDuLrbpq/B/pGq4BSTixx+d1nZx0W1gezf0R5buzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dGtpDp7T; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dGtpDp7T"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so18792396d6.0
        for <selinux@vger.kernel.org>; Thu, 01 May 2025 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746127452; x=1746732252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0rWPrBSQszGs7I9gcxIT6/hNoZFckO00dIFZ+7V24w=;
        b=dGtpDp7T6IWroX3Ljn4kjVUBiksWTAZEPDHkILxt5HQCkLGikxndX+BAIc30TzDxgU
         jSNIWeLrQMNlFQuh6PeEDG+9ZWP+DXx/iMtb6Ncy+Uk1dVeBwz+1Mw0ghp61E1QkHByX
         HC9cqoTmZA6k9pd7Ui7uGhRfcktVd82qB2kwcr+lYSp55SNCrFemaT5YVLK96w2QXLhO
         rgjOW1yYQGA4hlf18nZ2GbbSxqWoUEFhARf5Y19aQ1xsW94eIb5jJCdItJcIMq9UN5MI
         hVH4osaGFnGrIMzwknTGtC5MX4z8L5siNzG55+B5rrJZlpv0VEcQdh2iiRk1vg70JNR4
         NKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746127452; x=1746732252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0rWPrBSQszGs7I9gcxIT6/hNoZFckO00dIFZ+7V24w=;
        b=e353S206PaML4ddXAv1S6Hgi4zT0TtNw5byuXKA5mg4iaP/4jaimLHpwDNNjwXCJIU
         ie9QdN8FL4s6zwesZpye5zCX9A9mrVK2Z0S/8OIat9baIS2lLEDOATmoasLuUByNHBBd
         kHKTNGmyrzAgRGvCghmbVN3xQKlcXE+bJn0CNljhAjg5lk9cGzbVKnfcRN+UYlVwvomY
         b5FU64DO/Ln7Aqd2JLh8JTPia0nyi2VtlN1OYXhMiWanhiTOWmAEiT6mR4ae5DmOre/y
         vDankrueDYijMgAp31pJ/RJRcpbhn8W+RCywUa8umdNHpSAnC0VezZKKyz/KYF/IoIAW
         A+zA==
X-Gm-Message-State: AOJu0YwHitMvdgdE9o4Ate1Xy9sk2fVbpi2YoTXPdPCb/U8im4I+WnKN
	FV7LHIvKl7nYwpZ/euwxluKNNeA4KWwRQUzgTscXNpDk3fePMO4QlitnwzusIzprrGLAx8LqN9g
	=
X-Gm-Gg: ASbGncvyk+0Bsda7UrLvnk7XtrR1GgB5MFRLq60Y1cYfRQgX424VzTpfJ1PaTs75N/P
	AR1EzEYw3ocXb7pWVqkLOb4ZN58dzwIwmpMyxbeZJehAueD6OBr5qri8R4+UGsQvR5ufQDpHDq3
	HZv/xnPoUmXyFoHjjWEl1knzmDB/Q1Jk+Ht34hhp5ICX6d9BO5ekZj+vk7Qj306zLcJVgZllpnP
	NIwbFhcdWJ3iRHYjYi9c6OGaPnPkmS98WeEPFnnmdGBTXniWVcQGa2batArV7CyOytra8hoq+GL
	2kJDKLPdOuL2SGU20n12ry17oHWVj6ZS2hajDQ69jdJoNHuDRohHOUM1nkrnq5kHSJCFgC9Ez6V
	OWDqdYE9JHQ==
X-Google-Smtp-Source: AGHT+IHoS8vwYLy1Heqikc60613gqv/wduosgv6c3Kfg87sLud6602Imc3iKQSlMfOj32SVVya4BQw==
X-Received: by 2002:a05:6214:b6e:b0:6e5:a0fc:f65c with SMTP id 6a1803df08f44-6f514a7f2b1mr8219416d6.0.1746127451995;
        Thu, 01 May 2025 12:24:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f480e6bsm8159756d6.102.2025.05.01.12.24.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:24:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: add a 5 second sleep to /sys/fs/selinux/user
Date: Thu,  1 May 2025 15:23:48 -0400
Message-ID: <20250501192347.189307-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=paul@paul-moore.com; h=from:subject; bh=Ak6CVCiRRsfIshMkTJgPy5IyYmt2LNTZoqy6mgNLl3w=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBoE8pDR7zNvWzxtoa+RjUVY+KVhKxEf6FJAyAGb p8msECtiKeJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaBPKQwAKCRDqIPLalzeJ c0w+EADNVPj2F987f4NybO2KSJY7DxDJikwG2oxLgjRDcx/JrFmxp36LvOoUqt4V49Wmeera4Of uha5vkPrJmY0kfpsAdWW9ZjJDDRbXlZ/bWlL9jJDYggMF3QHCdQxzr4wyTeMds6aWcywolvSd85 LlhZNczEiE48FBLqLXsNwT8EsLxWxKU5tcbVGlQowWHTOixcJdnbTw9WRpuM2R2STxZM4PyVY9M BciHaKYTlshTLxs2XTXccQRQsdKdRczbesigb0MFT1VV/PVlaA+UfjhnYzVrm2YgPsxSF0KjV5K ZSNTNUZD+I8+6IEX/nIZAbzk1Pn0dqyoiYJwXbI7P3E8tle3pPZBZ5uuM+dPof0fJYogh6uZLl1 kSYxvhh54kivQyCuCvRHI4glNoLpmsY49VPE9S9/0xtebSbpuZ+tlu0ANY5a0m77dyARpI3xHJf dHEJ6YkxmxJtpqvBOlbepdG30tX039dy104yXM4RaEvOJQxTJPHtfeJJa7GBqICaP/pS5r93NO5 VnahDPVdLPwUyrci1GHLXXJL5+KMDyqsdkwpzMu5VZhvJoyXd0L8IQ5f/AJ2USzmAL8SyEnzgBa bX3I4ysNYlKcXa29L+1EZNB2A5FhhEZezTxzyk6Hq5pDmlkalwyJAxQhbhNq5aqMrOR+N7suCXY aki+jg5Wfe2LdVQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
the deprecation process for /sys/fs/selinux/user:

  The selinuxfs "user" node allows userspace to request a list
  of security contexts that can be reached for a given SELinux
  user from a given starting context. This was used by libselinux
  when various login-style programs requested contexts for
  users, but libselinux stopped using it in 2020.
  Kernel support will be removed no sooner than Dec 2025.

A pr_warn() message has been in place since Linux v6.13, this patch
adds a five second sleep to /sys/fs/selinux/user to help make the
deprecation and upcoming removal more noticeable.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 47480eb2189b..8b2626c0ffcb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1072,6 +1072,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
 		" This will not be supported in the future; please update your"
 		" userspace.\n", current->comm, current->pid);
+	ssleep(5);
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
-- 
2.49.0

