Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0C32C8E
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243788; cv=none; b=fr0HKf/1jh653rXNYBobVRAZlAEWNcXRMkqmxVuQV8Xb6tJ7qna5XnjHG4YOlYWJtGPwf0jGmBezWili3wV6MkT9HoY5Ia9PjtjPDv2ps13ChLP1Wc1wrVra7ywb4O2CLGON1Is5mkzHDpK5CP20JzAgfcSbkQdekQycbQDTzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243788; c=relaxed/simple;
	bh=y5lto+r8LGyF/3clpEwWSuOd8iUXHKRtYpCdhlYACps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTXoPvVBQPldyfN8Y9Ha9dh5Rg//jyiJmX95AAN1V8rbA8qQKyQ7m+kikM8zBZOfidH6gdeomXr/FIAtqww2fbjtSRpagR1TDLi5B3t0Tz8gmZw3qSsC9Jypib0Ba8ldFjg3af9bR7pr7PkIgpc9eG//rXH+4AyA5GA9UIFi9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvxG2vvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvxG2vvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712243785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kdgzYfixhSyPbFbB5sJQKimFLTqqPhBdLCU9EqEF5r8=;
	b=UvxG2vvVV9rd6lS6Otg6Bz/Zo0f3r+xvk0yQlkFgadZEI3Rod3I63wfqyGhekEUsWLjJ9P
	CDL49JJ/wva6BgecMAQTMSJW5lQ8mJSUG7kEwwjyoUjMxqeUj+pvlyfMafflCREmqJdYa+
	Wmfjp4WLNMbP9ZKwvkKV6rv5F/opfqE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-UcFmzw4GNL2KOMckexbi8A-1; Thu, 04 Apr 2024 11:16:22 -0400
X-MC-Unique: UcFmzw4GNL2KOMckexbi8A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516c2460d95so946757e87.0
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 08:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712243781; x=1712848581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdgzYfixhSyPbFbB5sJQKimFLTqqPhBdLCU9EqEF5r8=;
        b=buybhSMu1Gj/ICeJm1MWcIthxV/ik2giSOf17bDYq52JTkAKa+f9aS2DPlxf5DU+VH
         OmM3pOWjSl+GnH8kYRcoLrWXediTZZBPU/wwzAms6hEzWMdpgTwuTjw+i+K+hay4HuwK
         qQhaeVZHnJf3eLSOPDZ/y9FjTNUX23ePijXmgH9K3ii6XPL8I8IDLfPUAQqhVPs84Jpy
         +9zuJjfHqiCMtoaKsK4re3R1dZ5+7/pmYQxGzZt0rDfljg07YjlSZGXxy6IdQW9On39l
         53KbHKkR5tEmyOBhYpSiHSOqXl6ck1ORkwvNECqCXOLLgEubgvJShKTVrknptmc2yda3
         vuxA==
X-Gm-Message-State: AOJu0Yw0lZ0WKRBiN7HVq7An4/MsAbUcchlPSB2y/wO272u1bnFiZqGM
	CQeOOfcQ8bbf5AK5hthbjmnAdyllkbjmapQtCSDtRF1P/s56ioSZiI0VPWb8Xyf8exDq7cC1+Nu
	qBaYSgn1f52BoY6e7Xa2zTPrhd7P7P3IqpsrgWB1FgLUysnd5fX28qkQ=
X-Received: by 2002:ac2:5981:0:b0:513:39a0:1fec with SMTP id w1-20020ac25981000000b0051339a01fecmr2026771lfn.66.1712243781234;
        Thu, 04 Apr 2024 08:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdbdz0eoY8FXpIAITBTqwSNlthtrnn6XEi33cUY9QH77yEsDSZyYB11coyodPA1qWRLrtSvA==
X-Received: by 2002:ac2:5981:0:b0:513:39a0:1fec with SMTP id w1-20020ac25981000000b0051339a01fecmr2026752lfn.66.1712243780897;
        Thu, 04 Apr 2024 08:16:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id bj9-20020a17090736c900b00a4e28cacbddsm8633341ejc.57.2024.04.04.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:16:20 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] selinux: clarify return code in filename_trans_read_helper_compat()
Date: Thu,  4 Apr 2024 17:16:19 +0200
Message-ID: <20240404151619.868283-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the "conflicting/duplicate rules" branch in
filename_trans_read_helper_compat() the Smatch static checker reports:

    security/selinux/ss/policydb.c:1953 filename_trans_read_helper_compat()
    warn: missing error code 'rc'

While the value of rc will already always be zero here, it is not
obvious that it's the case and that it's the intended return value
(Smatch expects rc to be assigned within 5 lines from the goto).
Therefore, add an explicit assignment just before the goto to make the
intent more clear and the code less error-prone.

Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/selinux/722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain/
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9a23362c42f47..383f3ae82a736 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1950,6 +1950,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
 			datum = NULL;
+			rc = 0;
 			goto out;
 		}
 		if (likely(datum->otype == otype))
-- 
2.44.0

