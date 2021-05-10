Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E663C433B4
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CFC61359
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 13:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhEJNb0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 09:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbhEJL7I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 07:59:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1801C061761
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 04:56:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gx5so24033785ejb.11
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mbKIh+0xPML6rdCe7nBfcKMHLjKBqBM4VA1Iha2OCDU=;
        b=IHZ6B9i7v2bK//BwmZJlGHWSxEZ/P6B623xrg4/i9hmlOfXacN5uCkW9oqxV1C+1g4
         YOqOvrEQb12ooT4C8Lj3+KKWHPVVqQnqrhEOeyB3skGwFXIwxSMPHUXitGe/hNeb/fds
         kxj5s94aBT8B9z5W5crM7/D/ZsLSUKKPVtdR3pGc9b5qCJr3oZ9h8ALtrm+jqMctxD9q
         oXiLo/FwNjmRiqZ2QyaGkE9NM0kCTznDJ8/tiXCS1WXuFx/u9zi79t1is3h1Fwily2sC
         dYc2aW93Db1vyFPzu0zzyxdIV2UPBcYrccDgdpu5Iip3uu7HD8rP8F2cW5gSQMbqndsf
         QbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mbKIh+0xPML6rdCe7nBfcKMHLjKBqBM4VA1Iha2OCDU=;
        b=Yejt7UGBNp3aCNa3pEAArtO6cvKSxAo5DmwhPW/EC+WCXjd7vf14ZhkgtJkZ/HWrGy
         oc7dC8fsPJs5umGv4qFo7gVnSy8AnO6Bxgyds2ce5szA3hjRTLH2l2Fmg7jpWSYj0jT6
         UYxlRJEC+AOnVHi6K5EwUoOSKv6BBUw274GdOQ8BINgd7ttuMU8OMc5clvlcUkjzlDt6
         fbX4vhvLsp3RbNS6pK5acrefZZTI9pXHPQ47JKWuIDQTpGPyGS6HPPk83mkj/QZRxnnW
         iRR/McslMHEfRiYmt8vh3lw9oJEPbGGNRQXi+7i2IYPW2O6n5goM2ls1mJhtcMASr2va
         W4IA==
X-Gm-Message-State: AOAM53321J7rofIOyRU6nish2SWDurQNZpi97ULYDxKkVfmythmCQG4h
        khPF5qCZBak0ki9rDWBE9NF5LZk/y0eb+lA+ioNswgpVP5Qtu5iW
X-Google-Smtp-Source: ABdhPJw6KDK1oR3uYcSRkidvZbAJh3vlzrQdI+TYNJn0Jn8PYBZDFekpkpz6kWViv1/yrtuf0KvBLAeP+ktQBhI1eRo=
X-Received: by 2002:a17:906:158c:: with SMTP id k12mr2816305ejd.274.1620647802415;
 Mon, 10 May 2021 04:56:42 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 10 May 2021 13:56:31 +0200
Message-ID: <CAJ2a_DdP0-mZxAvp+opOfYhksDNa51RyDzjy2wbrZ3oZ_i_VVA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: make selinux_status_open(3) reentrant
To:     cgzones@googlemail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> return 0;

It should be
    return (selinux_status == MAP_FAILED) ? 1 : 0;
