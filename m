Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098047FB08
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328911; cv=none; b=UAa0bZac0M4IPmZMih/IN5WgrnhpevvC8NOCJv6tGPtYf4LNOKVWokr9chALZzWSlzCsDJ21qFpsk7EES6GhHx7zKnR4gGdXYa36yUO1ogJs8u6Tz3WSO9HfBm7GLoos/HFm0ewNCPtkIqbW13VXwEn3dK+3AqUKlLtV2zyOAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328911; c=relaxed/simple;
	bh=81iXs8TotOYyT5HCzo/wxN+vSnf6LIAnsNu1FpjYj14=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P6Stdj0LK5lOajDNQwb9E54uUXOXePLGbovULg+Zs15yhYpQ8EYb/OJTzixh3eIlFEY+KRI0rLvDIPu4eiqd0LJIuLlsEb9pyfeCjWEBEkzSiYtM4zjF9WNhh5kXNa06dQChj2ZEJoflfas9VTZfnQsViJuH/mT5NPCTDe+4yPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaPipHRO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AthA5EX7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaPipHRO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AthA5EX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785328903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qgdh6U7/okADxATspXvn+QGrC5w/x3aiuxsiRAECOfI=;
	b=gaPipHROrf29fKV+681MkpBvEKJX7ytdUQHfz4Su4JfkP/Zs1yrnnokRZmPJarcheHkmew
	jIEcQAN1h3Ruu2gKI6Zfgx8YVeGKshElGpJfgvpaSCFwajjK2MMSaNQ81/3G+fqXO7eRdV
	uDyLT/9OIDkFjERgW10KaxXgkyufWjE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Xa3fLOfLM5OwgQeHSqVapg-1; Wed, 29 Jul 2026 08:41:42 -0400
X-MC-Unique: Xa3fLOfLM5OwgQeHSqVapg-1
X-Mimecast-MFC-AGG-ID: Xa3fLOfLM5OwgQeHSqVapg_1785328901
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so1196484f8f.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785328901; x=1785933701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgdh6U7/okADxATspXvn+QGrC5w/x3aiuxsiRAECOfI=;
        b=AthA5EX7sMY/PLij9TjglTlsFEgTG+hqy2C1Cb/Vi3lBWwlVA8VywW/sjnkK6SCn9D
         dJ6gtoQLZNCbqkS4O2HQftm6j87Nuy39+ssNz0OJI9mrcE5nMVXFmc6/oQCMfkp1rMtr
         oRB5yndMEZ4lrcBZxGP41ICrIJcqNs67zRW9Ju5OrBupTRpDQxZ4o4A1BnLVj7YRQGAo
         81ovaQ2yN08lDojPWejn6VmxEjS41R1KCU6mc63HnNcMa8SqFFq5XyPS7gLOy4H33kzw
         KY0jqVbx2OnCPUve1ZrJt0puKitvR7F1V9VkLKFS7ePoZbNR242c86ZtmPUcK1rHehwG
         AFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328901; x=1785933701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qgdh6U7/okADxATspXvn+QGrC5w/x3aiuxsiRAECOfI=;
        b=cMCswQTlI+NXeqJJciPOBArgPk5HRs4e4UkBsHZSndOYZ/IZ6ZCNXuLNa2uxegZqf0
         8F9HXNL7IV5Y6UJXBXB9gQRCTFFchtjUS/IWtJELJ6vlK0vdAu2GPx285wUuYlln/bDm
         9+gIpwLsjIBxX1Z7gdwXRpljoE0pt4q0Pm6RUAHJWFwqBqLosm9qlWJyxAhHS5Ch9ZqV
         6FWOsGtLkH4k5ZPwA+0mCIJlH/6q7UT07fqfg3ME2oBi5GYa7z7J5R/jmYyOYsEtJLyE
         CnDTMCCM2SRQ2+dwdMXj7SMPb95Bw+Fmfi6tdTESntLU63JnVfeH2l75CrZYdduUAkfP
         2lYQ==
X-Gm-Message-State: AOJu0YwN4+vNLEiq9K6FHIBToaDI2ipRrVdQamWsQE6xzsmcwYUts0FA
	w9OsJrmLsNUG4LJjAK1F3rQbtnH4UU1calQgLk7URlYso79Hw5HIzQLB+nBtE0t724BV4wui9yc
	wJ5SWGVejbniAi57pJgQOCLcRyhtHRSUJDKjl3FLJvyWsy+RctbVY4jt1n9dvvaMQDFIGL54zg7
	dVaCOr1KqQP7weTc3orrgKVBdIkae3t7ruWF+hI4Ej1Og=
X-Gm-Gg: AR+sD12rgjfEHZUXrWoghkpVdlW5nV13RKrLl5s4RmB2Out1jkpFp9VjY6DVHHZlC+s
	d/wNTJjTmyqc4VIrrsFWWOBz+Vnj4AluKtjlCCB77Goz8KuMQsJJXpwVJFc18e2DmWbHPiziO3t
	YUQZj8oeaCxbzYnNr0uQj7LO2rfWf/b0Kvufc7VoHquYm9JoObmGB02tCPL+pxy0UFZNLYc9N1V
	gpu2v4qPRasiqjWDDnwurKM9YYA0wVZ5m+vnOekTPklBYOwsrnnaxUQ98POODDBuTZB/97uzCMa
	u9jpERxd4Eq4rUt+P5fZW1HZeB6p5x4v4r48AMVzX3kh3nNsDlOh4aMTiAH7mtoWm7cwYk8IjEC
	4U92jXwpue4lW
X-Received: by 2002:a05:6000:186f:b0:478:19e7:22a2 with SMTP id ffacd0b85a97d-47fb1e950b5mr8067260f8f.25.1785328901017;
        Wed, 29 Jul 2026 05:41:41 -0700 (PDT)
X-Received: by 2002:a05:6000:186f:b0:478:19e7:22a2 with SMTP id ffacd0b85a97d-47fb1e950b5mr8067225f8f.25.1785328900541;
        Wed, 29 Jul 2026 05:41:40 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:102b:4000:2380:8716:1aeb:5153:819])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6abc703sm7777619f8f.9.2026.07.29.05.41.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:41:39 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/file_contexts: add test_multiple to .gitignore
Date: Wed, 29 Jul 2026 14:41:38 +0200
Message-ID: <20260729124138.941391-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new binary target was added in a recent commit, but it wasn't added
to .gitignore. Fix that.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/file_contexts/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/file_contexts/.gitignore b/tests/file_contexts/.gitignore
index dd877b4..8b95fcb 100644
--- a/tests/file_contexts/.gitignore
+++ b/tests/file_contexts/.gitignore
@@ -3,3 +3,4 @@ test_lookup
 test_open
 test_open_base
 test_validate
+test_multiple
-- 
2.55.0

