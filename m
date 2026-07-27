Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14553BBFAD
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137947; cv=none; b=CbQ2/53rAFTThgXQuPU6SI1hUbsV/mfa3M4puy6H8KyaBy3oROlthv5VC4LdBRZ/vor421sNZj7OYTaV53MDeO82HfVzVykNwe9pAYiAuVHGw+qKTf11S1cfX5Q+gHT2LlndGbOFRzeE/jzpWEOMCOOTdRRly0WbokrlTulWAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137947; c=relaxed/simple;
	bh=hQ4+Az1Kj2qdWP18+epz5OzOIKX/PTrPjRWDym3Dz18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=poA/ND2ZlvhLuBHN7tdZ0J+GWIl7PF73CdffViEIxahAUoN6lb+DO4QnM4ErnRM24IoJlvsWAulVyE7koeLBBKKf2ewLlK01nHLP0C4bWOAk2VbD0cmcaa4iOupzw6RVXJEVVG7wtK2qMNUyYsUv6boZQ3dW8E7gOsTZGw9VeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk7pAwu+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RifTAfIC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk7pAwu+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RifTAfIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785137944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RRRdgC97mmJ53eP8Uvv1Ytnka1oNqvbBpWr4wki3UJ0=;
	b=Hk7pAwu+6CrGlNPz7jT0LyI5BOzjAkrKBnyXGOimfnoc0vn7s949izENcq8JlEVSkbsWGH
	kWcgvSbY2kABQXMr0bQEVxUlmS29JDMMdgPLPAeTjpMi0FpZmccykG5plPtltd9KS9PFTL
	6ZjCYQUcRSNG8EVHA2nHAEk9SEkWjsY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-dKTiTwssM0aoddiNOs4q_A-1; Mon, 27 Jul 2026 03:39:02 -0400
X-MC-Unique: dKTiTwssM0aoddiNOs4q_A-1
X-Mimecast-MFC-AGG-ID: dKTiTwssM0aoddiNOs4q_A_1785137942
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso1495746f8f.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785137941; x=1785742741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRRdgC97mmJ53eP8Uvv1Ytnka1oNqvbBpWr4wki3UJ0=;
        b=RifTAfICAMvZbtPw6WbXLBg1pkoMkGsD1DY1KeMahdS5BKxqPX6DWXZeoAa97etSvI
         Z6Wzt/JaDs3JxFRsATZ+NJeiUg9mTNKwv4pZpA0QTiXhxOUv+Iwyg1x6f3r1FgrzkMaT
         3nJH/nBUX1V3ClH72jBCeHmCX07ZS8asPCMnugMO9Xi2zIePxH+mqcKhqfMJckS/fi1n
         Hi9Mad0eRsvSqMZxOXEITovqQcfqM5vF+L3RcMbf7uvGXWSiNrE+TUuC3WQCyAfSA9ig
         BEXTlIrM5SNIdRxE1xQB3j4Ws69ZgIz5z72c2bNBMNQRe1z3ySZfd1hpi/oTD+haKf3F
         Wl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137941; x=1785742741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RRRdgC97mmJ53eP8Uvv1Ytnka1oNqvbBpWr4wki3UJ0=;
        b=QBIYVRqmgGQgMZpTFYRqFfLs3cfZKvXDiLCkiHkEfPJ60whAsR5WBc+BrjqkClnuj/
         8ktsFvVRmgetIkSyNCC5wi2LwHT2NWuEeYW+DC6fOpFJaerSGSrIgpLwkxxGv/6uOhLQ
         HMlt6V+n7iO7p2I2VvOCXQ/PT9yyqCsKO11nC7YOCFmaertwFulu5oxH3TN0foNCcC9+
         KaxjU6Q1+bq12YuUvpBXId/A57K5On9uWj5hrLKdESQF5GlrgCiFlqJOfgMePsdKIeoU
         8rCLwG4vXHvoMVAH1xAgasIayo6Q8cjAyUl2mL/wz30OWWhj/vJ81QGKFJpfrx6KAxGG
         j9bQ==
X-Gm-Message-State: AOJu0Yy2mS2eY1Fr5F4k1v9qMYUKYFqBUYC4XSfSnQsChJwS7SJ3yJgT
	YpITxQwjP6wSqmEBvAniN5Ju6D0Y3sAQOFDuLBSpFoHqcMsxu46jOQp0OE5U9J8eCQ87GSr2BFz
	j00nLROv4GXv7VNG6xFlU4rgzkQ8exkkbcGCaJSOd97EWG8rmkHMXZutHlTIjwVj7UCgYkdqjiL
	bN5zmA+0cb1pZcNGQ2PZuKcCXzxi6KvPDPnXxMGbrWjlSMTw==
X-Gm-Gg: AR+sD12dOopdR+vrrpeY+mSj4cfPIprwtyGkrkZfuEjkeKu37kGiwmjcnG6ZToW2xMN
	h2iDaO/eEuz8UeO1GL41qT67SZrBeQJ7+KcrmMWg51uOK9Px2gYVuOLUf+L7PofPWyPhgvv3uVU
	VUPH+17ltoFMtPZXHiXyuFMqLJUvabTXh8tSpGDS4XGFRBruPMfEUFeuWahJmmlpsFU0PyNfS4O
	uI71rcRL/XcaT2nxLJSHxgxOhGoRkK/zqvKXfiE26fKERlLxiG6zrW4MXTCHm4AM47+HQXrWRg1
	CPN08vIOc/uFA5MoZz6IPm+lTWxH6sbgBmM1XqXqUIxhbT0H1PyeqByYqA==
X-Received: by 2002:a05:6000:4285:b0:47f:7261:3a5c with SMTP id ffacd0b85a97d-47f9fec71c0mr9496248f8f.56.1785137941617;
        Mon, 27 Jul 2026 00:39:01 -0700 (PDT)
X-Received: by 2002:a05:6000:4285:b0:47f:7261:3a5c with SMTP id ffacd0b85a97d-47f9fec71c0mr9496200f8f.56.1785137941185;
        Mon, 27 Jul 2026 00:39:01 -0700 (PDT)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5d9sm45033930f8f.5.2026.07.27.00.39.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:39:00 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tmt: allow nlmsg also to the ssh_server attribute
Date: Mon, 27 Jul 2026 09:38:52 +0200
Message-ID: <20260727073852.283623-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this SSH doesn't work under the latest Rawhide policy and the
test run fails to complete successfully.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tmt/tests.fmf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index fe90c69..08bd129 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -48,7 +48,7 @@
         echo "(policycap netlink_xperm)" >>base.cil
         echo "(policycap bpf_token_perms)" >>base.cil
         # allow nlmsg to some system domains so that the system can boot
-        for source in daemon initrc_domain systemprocess unconfined_domain_type sysadm_t; do
+        for source in daemon initrc_domain systemprocess ssh_server unconfined_domain_type sysadm_t; do
           echo "(allow $source self (netlink_route_socket (nlmsg)))" >>base.cil
           echo "(allow $source self (netlink_tcpdiag_socket (nlmsg)))" >>base.cil
           echo "(allow $source self (netlink_xfrm_socket (nlmsg)))" >>base.cil
-- 
2.55.0

