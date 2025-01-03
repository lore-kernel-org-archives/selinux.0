Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF5186A
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898534; cv=none; b=kKfsKo5exaQm/MKaynIMofxWNIOjrhAFk7v7iUDDVvhNV31Cd5o2OBDWYdwZHat5ytzdNciNjUvhRnD5qvIKLYum5VovbRgTc4c8dxM7qlCK6crc3FuI2JqVyqFs/Z8QzJKyV94n0o1MmxraS3FQjJrwbR0zNhVCApTkXjBaqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898534; c=relaxed/simple;
	bh=8bN93eDBy4maRyHKrOFs53z9+4wbrG6YHdypmOXY7/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuKZ5JAlhGaXozc3eB+Dk/h1qw5GQ+2x96cU1fMZgW9K5urmehZ+CBmU/vTy2WD+O4cchE9Yuaoj4XU7jaqHQLiSAdIAzHerTYEEFe5IpfTS60inBWFkfW4H7yz2JkBW0Zp0uBaoWmpuFQXT5kOyOlWGg2fumOSW5PAwvJ62pi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+WuWcHy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+WuWcHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735898531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0E7lMkFxLNv+bmegyDePTNm/pZ64a/c/8BjpTnOstk=;
	b=W+WuWcHy3Tz1Xs0eGgsk06ywAJmxBQmq+R/C6hj3n8dbXGkTtioMTAcmbXE5cmGy4kn1CQ
	ieKvVYdl3sTeRyMiPkdo9VIyCAs/2GJRsUWCVko/sYKnSyl6j0UAROMdiZyDoDMMxzct+S
	Lw4JxoP7e2mmMimuLg8fUd5mWrCJB0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-IicvdzzzP6uAW_RlG7EDqg-1; Fri, 03 Jan 2025 05:02:10 -0500
X-MC-Unique: IicvdzzzP6uAW_RlG7EDqg-1
X-Mimecast-MFC-AGG-ID: IicvdzzzP6uAW_RlG7EDqg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e3cbf308so4835753f8f.2
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 02:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898528; x=1736503328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0E7lMkFxLNv+bmegyDePTNm/pZ64a/c/8BjpTnOstk=;
        b=V7syQJBrHQoqY7YUdA0ku5Zh/Rux2XevM0re+9/xnQWVB1PhyxIUUbE74stczNb9ge
         eUMJqbxhPIojii/kipOaghDMBNQ14XzqnVO3l/pWvlgvzuel/Ztnll0OhCu2Wok5AX91
         hTe13ZC00pn7da8PUGr2i8s+bMz0M73aT44enw3pPjrcuyn8lvHxx2/5XFNz6QqcP4qp
         ntdwjRe10vQ/gEaJj/NeRAeZ2hQZQH+mMIJCCcStqR5klemfmm3H7YelEgd24NASh3n1
         xNVA4KDCaUowzj1vOjlEVoLmFjYGYPii11nbsHfgHYkIxmFf85LkZWKWdg7mnvLKsT7z
         L0zA==
X-Gm-Message-State: AOJu0YwmKr5iqaMlUWJM2l1UqUVjdAK4k9X6B/10KUCLgYF+UAMCFflo
	ZxQcPEyberKXNKzZzDRiFe7GPxJCxOHCDZepB5Tv6GUuNiXVzv5iO/1qizd/e7CrCe0CNMiVe4M
	CDGxEFVeFLT+LYETbJclp7LPl4GFkNpofPKG7YoRixJD8dXqnUULnzXxrPnDrOfkKPsAHOqpqtL
	7VjjNfe51vs2xbkfygGIV08odil8+XVakfmvd9ksY=
X-Gm-Gg: ASbGncu/vssGf1jucOewYqN08E5wE2YKYFd5wTLw0Y9eb3bInQqggSMPmWMZ7t46/9r
	550vu0r5GnRcWG3ctleXO+Sntlv4Q5P/sbksVLUAyCYPgZB6WUzNGV6BmhIj9HEUBjEZL8k3Uv5
	e8zEq/dIlfhab945jt1CebERpBkMVZuzu1P6UyCc/DYf/0NLiBEhV9aMqog6zhtBSD6ucwrowhy
	oXV2EH/7AdZ12wYRkYqc0R6GkJLA2UJsg2+H/UnhZ1ads5uFEpl4kMfosrPst2VgkiMR2cF
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr34802864f8f.30.1735898528628;
        Fri, 03 Jan 2025 02:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES+JDc+ooc4Kvv1//hQdCe0s1+PqBTrd5l6vhoLajLMwrjZQi2ttYyAqlGO/KM4bIucsMpoA==
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr34802831f8f.30.1735898528179;
        Fri, 03 Jan 2025 02:02:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm519175535e9.1.2025.01.03.02.02.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:02:07 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace 3/4] ci: add missing libbz2-dev dependency
Date: Fri,  3 Jan 2025 11:02:02 +0100
Message-ID: <20250103100203.32580-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103100203.32580-1-omosnace@redhat.com>
References: <20250103100203.32580-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/run_tests.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index af913d63..63c26210 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -61,6 +61,7 @@ jobs:
             gawk \
             gettext \
             libaudit-dev \
+            libbz2-dev \
             libcap-dev \
             libcap-ng-dev \
             libcunit1-dev \
-- 
2.47.1

