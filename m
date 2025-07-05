Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D2231845
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717678; cv=none; b=iY2lf2eWQCqP8uKZEM3bddJw5tornOMlbIxAIaXDqRzLRc2bjmLooLkrVVoh/GL5B5W+2dwy9v/OcsaAOFaF1/l1dXPSUN29yYGxToEw8pizvQvaqHX0M0QdLgjETyyeOkyO7R8k7mc+fHFEDKk/67Jtko06rHdTyvSsKt6MF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717678; c=relaxed/simple;
	bh=VYfud5Pq6KqmVFMnz3YZ1VO6ISWpxCQ4OnGvMVBdXXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1CDd1vAXV1jGqjS1X4bzIPHHVQB6JYDy9OuuHMAQR7Geu9KRyzByfG9Gdq0/Z8cFpN3GPYyVsW4a33bIv5S/fgakHrGjRzNKMipGDGVDovtfEo8tjrcacJHb7MIk9ShQwSM+serW1AmOc/WYWWTmjV6Zjn48/pGoVDa+SxkoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsWTR4NI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsWTR4NI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3/yTqCqT2BcOZlwhNQFs5eeSh8DKEtFYfHVU7SURZs=;
	b=AsWTR4NI5PGJQ4kRi/c0Cwtdl7PAT1g+j7w8jzoKHhN8k03FJ/TLoLx0KOmC/4OxVWVSTk
	YdolU0si8Lnj0/nUggxoOMuMmWWsSEHGnQ3S4OrskNR5oTVP2+UvWBGt4Z9yjlxkmvdlPM
	ptI31ZIJYILxilec773XZMnvDMcp4RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Nd4TAJ_aN9qimA1KLoz14g-1; Sat, 05 Jul 2025 08:14:34 -0400
X-MC-Unique: Nd4TAJ_aN9qimA1KLoz14g-1
X-Mimecast-MFC-AGG-ID: Nd4TAJ_aN9qimA1KLoz14g_1751717673
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4530c186394so6542265e9.0
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717672; x=1752322472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3/yTqCqT2BcOZlwhNQFs5eeSh8DKEtFYfHVU7SURZs=;
        b=g3QuMu05xo7gTEtKnxgxGflyGmdTDsQxCCZwNJ6UNyqc9OZUtDgMiFay4HqPFyzcc8
         9x0K7mu72Lmih9PEi3K5F4YoFlwJh+E/3F7G6nssShJVC4ddUTtzo/q0dIhZ3fDYFa9e
         FCly7tEVsWXbuVuhoX0UPBqPIFrY7tLSs7PgdEFU6Dl3m7eAaMUdMl6h5qdNppQzcsiJ
         he8n4JuwI+5PM07nVlZwOIApdIWA+BxYRAgO5afExjKZ0b7Io0fCIBPTcVaIHknaQNuX
         gHtmD2yXHeeZOzdEt1Q/WTr2nJa4k0BpF2zsvEBKHWPwzXqqF9LeZo2Oea5BosXGPRVC
         kvFA==
X-Gm-Message-State: AOJu0YyHelMozJAQOr0JFy3cVcJlGzKNj3VdF17w0iSD0fP+u+wtCl4j
	L4Pdl0EY94AIFfdFTatROc50gMrG1vrVMtGd8NUlA3GGD4jlAzKkqvhhaRS9qroAVy/zxhfwUGZ
	lrIgRe9b66ujJqj++l1SAfgv9sjDQaDMNzsUity4Ok23Yd2npjmSSAGaVI1bROZhioa/N9cyhg4
	H5E34lZC9xh4gS36QmzZ5B516cfTy17DSJ+4895xP00Lk=
X-Gm-Gg: ASbGnctVWei2ZGShW/L5CBP7Qx2Ix5dO0/MR4cCywIQ7Sn3fYi2J89OPjh9waKyrLBa
	0U3xTQhwKQAHfTvJ2P8/uj6rtSMgH4Qh23VQhT7UuvzkJU7Llxl5k1GB4xOOdF4Dv8c6akYFAEa
	7wHkPEeeg7po34itQCEujfAlTrMfeLB711O1fyVRJdnDxN94XMNF7/1TQnxNf+lGm5yosfNnr78
	6IjYcvkOCNBAaNAHnpMABEfiaIg8lFRxhVOGw3JCtFdlThPwsrDOWZvPS0irvJEfplMgkGsdjsR
	fSGayqfyAEmLBBY+yQ==
X-Received: by 2002:a05:600c:530e:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-454b31878e0mr43302905e9.28.1751717672473;
        Sat, 05 Jul 2025 05:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtenJMprMT2L9G0XmEC2Dg2ET3rKlv+W5ihhjbsEyBQemqmAu8iF/bTWC+hX2ls7JaDOvUZw==
X-Received: by 2002:a05:600c:530e:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-454b31878e0mr43302795e9.28.1751717672039;
        Sat, 05 Jul 2025 05:14:32 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:31 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 5/6] tests/module_load: fix the location of "2>&1"
Date: Sat,  5 Jul 2025 14:14:23 +0200
Message-ID: <20250705121424.1221268-6-omosnace@redhat.com>
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

It shoudln't be used in the inner shell invocation, but rather in the
outer one.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/module_load/test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/module_load/test b/tests/module_load/test
index b7318ef..3229f34 100755
--- a/tests/module_load/test
+++ b/tests/module_load/test
@@ -121,7 +121,7 @@ qq(runcon -t test_policy_allow_policy_load_t sh -c "echo '/tmp/test_ima_policy'
 
     # Deny system { policy_load } - EACCES
     $result = system
-qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy 2>&1");
+qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy" 2>&1);
     ok( $result >> 8 eq 1 );
 
     system("rm -f /tmp/test_ima_policy");
-- 
2.50.0

