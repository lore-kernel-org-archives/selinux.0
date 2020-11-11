Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91AC388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CD220678
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwepiBcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgKKQXt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgKKQXt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 11:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605111828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i4METgfOS5g+kwvGF60ODUV2dt9wFT7pe+sxkfeJ4ZU=;
        b=XwepiBcs0e8WY0oqZ4ezjtxGJHSPY6SzRAFSe6PpzrqxN+qpHNHVAtHbqQb5ACSkKVv+z8
        IMLJJNtPWfOz7uM9f/U1+PEENyaKNpAhzSYEYmAqEAwyYLVp37am/iyFFkdNEVgnuPlP/6
        jJqNnTQQzGnbWjFff3FQEzu5DBnF+Pc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-WcjQJaU8McqBw3GPobhn_g-1; Wed, 11 Nov 2020 11:23:46 -0500
X-MC-Unique: WcjQJaU8McqBw3GPobhn_g-1
Received: by mail-wr1-f70.google.com with SMTP id c8so768798wrh.16
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 08:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4METgfOS5g+kwvGF60ODUV2dt9wFT7pe+sxkfeJ4ZU=;
        b=JSaTap2vpVfAKygcni31UMOPQGILKlWJ80RSuMdvcM66VXi4W/tOWzfSGUtJkRzCUU
         Owmy9g2rxUpSXe0O09MxpGhyvyc6cD0dvBsscW80nMKaSnvp1pZB+RMcdw4MxpaEmFNb
         nfjLegG4hVhDNn7UYekISDGRRfVvs3wNPjGtnVVXYU5Rm0OkN/sPWlfwVve4wQThjRYY
         ZhdBLims5mthhb1eGSxu+v6RuseWEg+t1+No8UmlpK/yQoXI33ls27KH9IcCqfw9ELZ6
         KpxfIEr89UZYeBxhhFQ2ROSReVSrh5vKB5gjYUPyjCv0JsIT6eY+CSEkwHzu3Mtp/T4Q
         VMLw==
X-Gm-Message-State: AOAM532tHLhnuE24qgs9wB2tSdRpy/DOcMYFdnLnV9soPU4XWuIp4wHe
        +duc29sFGYRaspnyV/PbmEiYSGvttgXp5D1ksyznYjD4VmzzYcUqTnK7osR5t6du109Q6UAXM50
        DvVcu60qzZ8482eBCCEUUwcA8G2ojQCP/GsMQ1XjGm3iweW8zMJpiI3hkg5ks4+1vkwLHRg==
X-Received: by 2002:adf:db85:: with SMTP id u5mr30305869wri.155.1605111824919;
        Wed, 11 Nov 2020 08:23:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJdundMLhaUnYrbv8Lnm2USRlABmkhXYIAAgmYioFPY7I3mrLd3LZV1OvZgTEijW44yAuU5Q==
X-Received: by 2002:adf:db85:: with SMTP id u5mr30305851wri.155.1605111824707;
        Wed, 11 Nov 2020 08:23:44 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id h81sm3152934wmf.44.2020.11.11.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:23:44 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace v2 0/3] Update manpages to reflect that runtime SELinux disable is deprecated
Date:   Wed, 11 Nov 2020 17:23:37 +0100
Message-Id: <20201111162340.527105-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SSIA

Ondrej Mosnacek (3):
  selinux(8): mark up SELINUX values
  selinux(8): explain that runtime disable is deprecated
  selinux_config(5): add a note that runtime disable is deprecated

 libselinux/man/man8/selinux.8             | 42 ++++++++++++++++-------
 policycoreutils/man/man5/selinux_config.5 |  2 +-
 2 files changed, 31 insertions(+), 13 deletions(-)

-- 
2.26.2

