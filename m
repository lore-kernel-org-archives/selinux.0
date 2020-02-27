Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA7C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4192469C
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrK1Su8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgB0QDE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:03:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35802 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729235AbgB0QDE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 11:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582819383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=422MM+dX8SeyrozZfwnYxcqpPJs5evrxiAguBDF1Z7Q=;
        b=GrK1Su8yI9uMbTTDAzPYthAlwVbegbehElAz1KbpTzeviYdPkmgdt6JkdoUZpzkBa/1tum
        nrI6ymyd/057n+9PZMvMQDVP7JOxxEQzUcGtLB4n7pnr3PxvmDuTezxeQNYxOAfNg9ZqGH
        jXbsb7hprSZx8qNP+b/9OswmURcOQM8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-hib09oviNEmgXAlDGDNJyA-1; Thu, 27 Feb 2020 11:03:01 -0500
X-MC-Unique: hib09oviNEmgXAlDGDNJyA-1
Received: by mail-wr1-f72.google.com with SMTP id m15so19945wrs.22
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 08:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=422MM+dX8SeyrozZfwnYxcqpPJs5evrxiAguBDF1Z7Q=;
        b=fdppekj9v0iuPLBSFTMPfJF7I1iL9jInLgidOEF6AuM7JntMAXvmKo1WQu/xL86sQ+
         dW2pqOYyKGVPPf8L+BNixllisJ+7l2uazR6huJBDu8gt3HgVW+q+L5X1UVJCH6uvU3u4
         CVFCdVCJEzdRB/mV+0MH20Zx4aF7PalnHarY3Uxi4lHMRPrXGAL4h5xc68DgIyU5ePVJ
         UKxf1+NCqY4jPzaaJAy/QzuTb6wLZJYDQnfboZKsjAHR04fUTAj/L8uiccgVQ2T88RI0
         TJOeZyLxn26fNQzQMPM+pzsyYydIc3YH5B8C9l+aE1NX5wPup693yKHkG8H2qoKFlFEB
         lU1g==
X-Gm-Message-State: APjAAAV1lduS0XTUP8I3XNWRXivx3LxiHfjYNgcJZdh4tC48kfBxl8RK
        gi86kNTk1EQGx+Oj7WCG7f/zPY4Cyskl0FO0FgTpxEItsyjOS5ThvLc58YY+Ulqm+wJdFvqDKmc
        7axIkC+Vm9gQAHIyQxw==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr5256443wrw.47.1582819380032;
        Thu, 27 Feb 2020 08:03:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5sQbrJJSfsEEI2oLxCIqRE7nl9hCJOEls7W9asuz9vLtvL2SNa2ht7BpyooNBWjVW5tLchg==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr5256419wrw.47.1582819379778;
        Thu, 27 Feb 2020 08:02:59 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d17sm8063456wmb.36.2020.02.27.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:02:59 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH 0/3] libsepol: Speed up policy optimization
Date:   Thu, 27 Feb 2020 17:02:54 +0100
Message-Id: <20200227160257.340737-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains two small changes (these don't seem to affect
performance measurably, but are nonetheless logical) and a patch that
changes how the policy optimization "type_map" helper structure is
represented, which speeds up the whole process.

Ondrej Mosnacek (3):
  libsepol: skip unnecessary check in build_type_map()
  libsepol: optimize inner loop in build_type_map()
  libsepol: speed up policy optimization

 libsepol/src/optimize.c | 119 +++++++++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 25 deletions(-)

-- 
2.24.1

