Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AF7C0AE
	for <selinux@vger.kernel.org>; Thu,  8 Feb 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408693; cv=none; b=qPpcvsnjP6W6NRDmZDvrCh6N4x2a5IsQgqWliZQSG+vaevo+/9VAcxDkduVPwm/ZMF6odL5WFDTtiSQg4t3i4gg+VEiuKZU9RXEydKWSmNI/ZVJQaBxCEmoo8WHQMcDG+G8eAdoTFCwJ8CmQLcBuARFicT3F7qxtk5r0XvmYU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408693; c=relaxed/simple;
	bh=/NXcvUn5qGmPhodlyQuXcmGpHgJ6pbA1nAIUjKRmOGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HvLx30+tLgYDXPfqoF+nJrENG+pCvl2cZVNEoQdnIPJl4bFYz9rOZc3CnzMSI3V2gdsRZQpOY2wlMpY9l8ssNK2WYwGHREnlm1LQFVpmtet2eTDHpHen468zQRSyLHOn73tJEUVDIixtvwz/VEYxNvf/lIXScVj9TrRoNLPBik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W59SPXoP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W59SPXoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xBfrQMQgiXNS9GfXjW9puvj9gOKtXwNglgru6kDO8xs=;
	b=W59SPXoPnpoDgMbrsgOVGFTm+tVM8s6sjY/67jZkMBm5v9ZhKw9dd16w/5KIALiTme+r7k
	5kp+b56pRTtc+oi2OFelQOEW4HqfLjspXNmTBUxmygvPjGE0Toeqa/62pNjpG9FY+Ra/FP
	/3LQZtGco+H4VlJYrWm6g3yuRHVu3ko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-gvM62gnhMuCLZuE7VCBMHw-1; Thu, 08 Feb 2024 11:11:29 -0500
X-MC-Unique: gvM62gnhMuCLZuE7VCBMHw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb3b64751so184825e9.1
        for <selinux@vger.kernel.org>; Thu, 08 Feb 2024 08:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408688; x=1708013488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBfrQMQgiXNS9GfXjW9puvj9gOKtXwNglgru6kDO8xs=;
        b=tqdP3usS04hRMyShiMR+AkyiRp+TBaqBs0pJcbnvw1r1rH9dFoLQxSEKrsGXoVcF2Y
         LURcS78nI1O7Bz+gWKmGzWFyzVAPeyylqVJfKdmkrfh9CvWdLNmZ4dFoagq4FmplDYmG
         VpIVVRUdXSc8fX/REHZmKrRXSv9h+U76W111JlQvl+BAhWLVbnY4XUr8HLazcGP/2dgu
         PJBuQsgw7QX3qKFHFEYcWeXdozWMRYqYlP0Fia5e14pLka68EYRfQ2VjqjX6nZlaoTsK
         ktMtMDnkrmczR0Z+MEB5rEVuh5mC2GhWDcUH5fhbKLv6mi+2RPIzni+W8qy7zm2xhbsB
         SlTA==
X-Gm-Message-State: AOJu0YxwbGgLW/aVgzKnjqIJ0xs3kVRSpXq9fum/NdYqd4cZRy10DR0I
	uNcRfKyRtkqUJ1my0eYOqofUxd/gZmxUoZzW14pHqnMfzckyKVtV9Ltz715Kg1rgdyAOCO4hjiP
	QWeqW9qO14SYdcI+RURM5MGXoOPlIWU4/k6MdNHxfgQA7gBUYgBf201RWlh/0FXRDY2ozYc7w+h
	ynXrJzVCYvwxlrxymt3i7gtvDQFj1jmHLOH02oCDQ=
X-Received: by 2002:a05:600c:310d:b0:40f:d162:944c with SMTP id g13-20020a05600c310d00b0040fd162944cmr7641554wmo.31.1707408687941;
        Thu, 08 Feb 2024 08:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2zRtuPxDzZW3XohFigL7QYtX5VDvfZiyplRJBf/61XyWqowmdYnnpWjzjUSzgTtVWLej0sg==
X-Received: by 2002:a05:600c:310d:b0:40f:d162:944c with SMTP id g13-20020a05600c310d00b0040fd162944cmr7641532wmo.31.1707408687528;
        Thu, 08 Feb 2024 08:11:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:e4d6:c16f:d2a4:23cf])
        by smtp.gmail.com with ESMTPSA id fm5-20020a05600c0c0500b0040fd1629443sm2070110wmb.18.2024.02.08.08.11.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:11:26 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: fix testsuite_domain_type_minimal() to work with rpm-ostree
Date: Thu,  8 Feb 2024 17:11:25 +0100
Message-ID: <20240208161125.620477-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a live package installation on an OSTree system using `rpm-ostree
install --apply-live ...`, domains need to be able to use file
descriptors from install_t, otherwise they fail to load dynamic
libraries. Thus, this rule needs to be added to
testsuite_domain_type_minimal() so that the testuite ca run successfully
on OSTree systems.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_policy.if | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index b20baad..e590f0b 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -37,6 +37,7 @@ interface(`testsuite_domain_type',`
 interface(`testsuite_domain_type_minimal',`
 	gen_require(`
 		type setrans_var_run_t;
+		type install_t;
 	')
 
 	testsuite_domain_type_common($1)
@@ -46,6 +47,7 @@ interface(`testsuite_domain_type_minimal',`
 	allow $1 proc_t:lnk_file { read };
 	allow $1 self:dir { search };
 	allow $1 self:file { open read write };
+	allow $1 install_t:fd use; # for rpm-ostree --apply-live magic
 	dontaudit $1 security_t:filesystem getattr;
 	dontaudit $1 self:file getattr;
 	dontaudit $1 setrans_var_run_t:dir search;
-- 
2.43.0

