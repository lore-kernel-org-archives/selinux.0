Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E73C32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C70E20652
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="STkJLrxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C70E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeJKVLF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:11:05 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39114 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJKVLF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 17:11:05 -0400
Received: by mail-qt1-f170.google.com with SMTP id e22-v6so9846448qto.6
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qe9ahbILhECsU4+DVf2NaapEpKG6mRtgcSouOmwvd0=;
        b=STkJLrxBcKVHhAHRcuUmrrO+EmYSXYvQbKg5OVJzLIrOo6dtfvdJa70FwK5YbwO4xx
         Rk0zPr5TzAonmWlKOLHaPS73Au+c5/0EHUUv+ObK2TlsgtIMKtOanvPAE0cT4ogG9yrE
         BoUyRatEssP94ZFRW4ZtcHvIqs20EYk4DLrE3De+9EijLduGFrOrB4D563u4Ew02U8p8
         H8eluw09Su0UJy2m983o37syK3VICalLpFvI9GzOLJMp9TfNLWb3UYXX2UrUnG7Uk12n
         GiMqov5c4H3CjF9/89bBuazJIkmv3ZypRjWfrO8q+UupTqjngJkhfp1eMcHdVByqQOI2
         c+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qe9ahbILhECsU4+DVf2NaapEpKG6mRtgcSouOmwvd0=;
        b=YXWotqOOm7D4WB2NyV/qKiwPPl5Ys4FuvRTQFLu05cS26iKnIHK00CpqUq0mfBzWHO
         a8RViv8ySr9qk1swGEHEsvbM4TJEli0sOIv2B0NthAYw9IpY7Qco9HVmnVcGhkXNGK4K
         v1wXd8gznVJkFlKE8yj1Xk+DEWnqU/R1LOVxFyNKfHILkxeI8ZsBLBNaJ0SJwUrq43om
         qVsO//bpQ4et0Wmhm2jSjTfCiWLFXNI5W4hg6L1RnR69Qo3LpJtxWrWlDcA+pnXMUYI6
         +PGhypgyzv9UupW4s4Z2dqXHC+llzv5Qz+JpTEdoXZpelfhMi/u0dunD6Byv3tJ/1hB5
         KrIg==
X-Gm-Message-State: ABuFfohMagOoSFtNv+DDsxII5R67srhZ5p/8KJ3sSCUhhSSMkTvNwtye
        uqI0dULpIjHd7I7rUIWT+tdcPdC9Ipg=
X-Google-Smtp-Source: ACcGV60ZW4GUTXW5dfssST65HeupGbXUtXIOuaVB6BEmurRq/cLcUaJeHlpRjgMfMEfxdB4UMAGRTg==
X-Received: by 2002:ac8:3236:: with SMTP id x51-v6mr1533667qta.275.1539265429561;
        Thu, 11 Oct 2018 06:43:49 -0700 (PDT)
Received: from mls-centos.localdomain (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id y51-v6sm16933964qth.66.2018.10.11.06.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 06:43:48 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH v2 0/1] Modify exception handling in semanage_migrate_store
Date:   Thu, 11 Oct 2018 09:43:32 -0400
Message-Id: <20181011134333.16468-1-yuli@crunchydata.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm resending this patch since it only made it to the new list before.

v2:
- No longer handle catching raw Exception.

Yuli Khodorkovskiy (1):
  libsemanage: improve semanage_migrate_store import failure

 libsemanage/utils/semanage_migrate_store | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.19.0

