Return-Path: <SRS0=mDct=7F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB56FC433DF
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 01:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627AB206DD
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 01:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/1srZPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgEWBXk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgEWBXj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 21:23:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB8C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 18:23:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so5084059plq.12
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IydOybA53jXifMxgaMP2V4E8QnWuRVBpxoYw3oE4T+g=;
        b=W/1srZPbTgfOz8KgdLqvTFviwQDaQm068ex3YiGiAjKr6KdfMxw0y59nkHsraybbMQ
         ryYlC88pyCYY86zwkT3FnRoSRJOIXYm1r2JeHDKTih5AhseDkijiXy/FNZlG7osVfE2/
         SjDkEVBbx60m0OyAVPeRlKku7FXvfOhWf6Nb8uhhRkXRnd70fdJFw0WYXVe+6UdsDCtQ
         MO58aRMjOwpfY6+liCm4KdhpH7XHcTlh6ZksjABccP4COn4OZkASZ2TbMecYD8ghuQJi
         PJlIwIelV8cKiX4GYPYIErLA57EaPpWVocAHUBlVqRM9Vn3StH4Mg6DvJdpnS2xmU6rd
         dJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IydOybA53jXifMxgaMP2V4E8QnWuRVBpxoYw3oE4T+g=;
        b=jkXRRa30o8L0I1PsGlrFS2RV750Yir/oJBGowQIsTmPj2HpABAAZju65eoKLeeSjs3
         JIvNn+kwhjX7F8zRaJBupZzCFUuIFonWtTLtaTDleRcAh3JtKGTocacbBshzb4HzVQo7
         CCfjUokoqqJbup6cdNKoDT146shwDT3H5onc8lJYkT0bZMVU8E5rPEIqTc3QbnvMZg45
         kNFC/nD4lqXPcnsJOmx6HUqi7SeXvG6gOKWBiHIIFYr27aXb8PRp2BblFvuOtoD3gg6O
         JKyvvP4CaXv/LkUST3rQJsMePbaD4RDYUUFFU6wvWJhsOA1EEyVWMyVyGq5/xvsU8fza
         VAuA==
X-Gm-Message-State: AOAM532+N3zQsgB7kt19Ufd5wQKgS0XAe4Ros9QrrWRkT37/aMFPaGTr
        hwW8WX2JM2Y/EGs4mBviXlFLmXbd
X-Google-Smtp-Source: ABdhPJxKRZwtjVH1eCySdVN2hq1iJipmwcP4XsIex43oTugTw8L5cDVlC9z2qx/3Zs6wn4FNnyrViA==
X-Received: by 2002:a17:90a:881:: with SMTP id v1mr7791236pjc.227.1590197018990;
        Fri, 22 May 2020 18:23:38 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id k2sm8090271pfd.108.2020.05.22.18.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:23:38 -0700 (PDT)
Date:   Sat, 23 May 2020 08:23:35 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: utils: link with shared libfts
Message-ID: <20200523012335.GA3283@danh.dev>
References: <20200522074648.24538-1-congdanhqx@gmail.com>
 <CAJfZ7==OdP23Mh06V=qaktKas3wOkz12=ZELj5vOHsDN1t_5vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfZ7==OdP23Mh06V=qaktKas3wOkz12=ZELj5vOHsDN1t_5vw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Hello Nicolas,

On 2020-05-22 20:59:43+0200, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> Hello,
> A few lines above there already is "override LDLIBS += -lselinux
> $(FTS_LDLIBS)". Why do you need to add $(FTS_LDLIBS) to LDLIBS again?

Sorry for the noise, I patched this for libselinux 3.0.

It's was applied cleanly on master, hence I didn't check again.

-- 
Danh
