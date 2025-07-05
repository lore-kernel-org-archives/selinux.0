Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D0255E34
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717677; cv=none; b=EuzaUUCHHxxCKapBXslao8TtlwJlrjsRzWVdj91axOuT6V3J93FjdOVLOeJbL3SgEz8WP6943VVA2CAgDBAX1Rm83EXMiHJiCyrzMdoYCCwAsK4uHywfmfsYFtA7H/+Hdyrdp5+1QdsrvHITKGwl4SOvIQPHdcLRwe7LHGUZTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717677; c=relaxed/simple;
	bh=GPH3DeBMhdWSD57GM/RGxj6Wj1eJnCP5P/43DDc+0YI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPQJE2B8U6hAZqc+/TBalALs7NeM7gT7Z/H5iFYzGA/C1hXWT1BOP9oPjmgeGOyA4FyfyxE0cGf+9sML0WwWiNsq6T+xImCwKnHOPvK3nIqbZAsEX8iEcg5PpJawCPfGWE3XRC4EljzCQkmlRoTw1Ci/hCcWLSIj7LPYmkDYdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epwm+X1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epwm+X1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Uiq1xFqAGyrrIuteaNTBDZOghJ1afLhRlmMKsiajfs=;
	b=epwm+X1i64mWbmVRU+w+H8EM9HToCv8qzPmB65ydbUx0Pk5+Uc5lduHzhT0CFs4UeEGxVO
	zGCkpurPVVxG0q6+vwnFBDmDfEYu6/ZnMwiXYopp+D6vw8XQZ2b9xFAeQIHTWyQzjtqFH0
	IdzvImQUSMKMJ4YhoGgibmmD8uf476Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-HahfvH01NIaFmAijsBJw0Q-1; Sat, 05 Jul 2025 08:14:33 -0400
X-MC-Unique: HahfvH01NIaFmAijsBJw0Q-1
X-Mimecast-MFC-AGG-ID: HahfvH01NIaFmAijsBJw0Q_1751717672
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so12735365e9.3
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717671; x=1752322471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Uiq1xFqAGyrrIuteaNTBDZOghJ1afLhRlmMKsiajfs=;
        b=IM/EFYA2L6+VwfiopxvJ5p4yy6XwT9DGSJ5W+haL0zEZHvpergxUxg2nhTWbFiLClM
         amt4JXT/P5vJgjd6DnUgRbKP3WZxLdV8YUOZHbMQQO8oNWRp3gnR7Ws65lwhl3hMQUkH
         PNsVuzLp4ezCDy/H2rIrrfy4xCKFDqaDk8IFw1Qb7U84Zp3kL/osi8WCIUYEMhJgYa3j
         /RDYE8NmRxxoWcDSh47oMJhrtbUlWAdZd1gJGvRyM+1424dna8bLlX+PUOgE3JEzwxEg
         /0LqAJOGWqZblnqCTPHqncfcmifDUO1pya+YJp5T7wmjfU0lOXZjm+lb7c0iFhX/9QrJ
         +Rsw==
X-Gm-Message-State: AOJu0YwxR6vDEQ1Qb961Ekb6ObUE0yi5fMgTAZgRc6ySVAHRY/VFqQu4
	mYrrzzd/8t8OpdfWTCsKdW28fAq7u4yCMFJde9KXrEKEHEQffO6Gx4wnr3/17jatS+Wq9/5bytC
	NafebuoJ//+uaJoZMU9ZP6mcgDuwAS2MeNxx6l5viBgb/uycmyu4f/Tp+L2V7lrM0tEE86FP4A4
	NlLw2IAJDxsjFgf5b82TBVY0Ad/Gvjk0VBoJ2PBuWqMfM=
X-Gm-Gg: ASbGnctNKQs9M/HK8UNA749PK8Cq5tOX00ffWbtwZ+NiE2WcpzruKeXhOgDjJkDDSZ0
	5tDIn4y5FbdbhhinFq3Ad3u5jCgf2/hxqv3wT6B8AhzYduZh2t0srDuHLwwNn79c/TKTk7J2fTG
	b2feda9t5gWcJyFCZJvl1E7Zrimd4kyIy2ANneCI4S6V8041ELUYPM5bMOQthxnyQDDR+IfK7cB
	mORmPW2zglG3PiM6Hb9GLz850nbtPCCXD8MxWyqfIGmcs8Krk56N5xK1cvQ1tORzlFlLz8E6BSh
	BUr6BAsUyVkl61sGJA==
X-Received: by 2002:a05:600c:8b0e:b0:450:d104:29eb with SMTP id 5b1f17b1804b1-454b4e6bc38mr49033415e9.5.1751717671521;
        Sat, 05 Jul 2025 05:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0PP2Ot1MpUgwKi1FQzWaw2Lefh31b4SRFdsludiIK1Vm8ozHF1t7WV7NJC1KsfknpuYEh/w==
X-Received: by 2002:a05:600c:8b0e:b0:450:d104:29eb with SMTP id 5b1f17b1804b1-454b4e6bc38mr49033245e9.5.1751717671054;
        Sat, 05 Jul 2025 05:14:31 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:30 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 4/6] tests/module_load: run sh instead of bash
Date: Sat,  5 Jul 2025 14:14:22 +0200
Message-ID: <20250705121424.1221268-5-omosnace@redhat.com>
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

This avoids "bash: /root/.bashrc: Permission denied" messages when
running the tests.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/module_load/test | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/module_load/test b/tests/module_load/test
index 98c5946..b7318ef 100755
--- a/tests/module_load/test
+++ b/tests/module_load/test
@@ -116,12 +116,12 @@ SKIP: {
     system("echo 'measure func=BPRM_CHECK' > /tmp/test_ima_policy");
 
     $result = system
-qq(runcon -t test_policy_allow_policy_load_t bash -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy");
+qq(runcon -t test_policy_allow_policy_load_t sh -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy");
     ok( $result eq 0 );
 
     # Deny system { policy_load } - EACCES
     $result = system
-qq(runcon -t test_policy_deny_policy_load_t bash -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy 2>&1");
+qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_policy' > /sys/kernel/security/ima/policy 2>&1");
     ok( $result >> 8 eq 1 );
 
     system("rm -f /tmp/test_ima_policy");
-- 
2.50.0

