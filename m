Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049AC4338F
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D38260F36
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 14:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhHBOVh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhHBOVb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Aug 2021 10:21:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF1C061799
        for <selinux@vger.kernel.org>; Mon,  2 Aug 2021 07:04:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz16so31043649ejc.7
        for <selinux@vger.kernel.org>; Mon, 02 Aug 2021 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1RlFtOczU7bqdeC9+xI0lJWMN+h+lumUpCgvelVcrA=;
        b=sicBxFjABTilN0mVRBL8M8lqKLzZcUdNbBrYstWs/mIx4KMF7R94fbC76LVGZZxG3a
         TTyE6cLj86gVEFEMoT0QnxZeST7Ko76Dpx7Ne6Qt0UJroBr2DABQRqCTyRh/IaxmU5Wh
         gZsFgkXHMVmWx2jL7nRI+tb4Gh25KPitoZJPrRam8n9/4E/IpWACCqKX50Nhw4ylC0v1
         CDhQwzSLpMILSsEKhN4YLsr1K8sfJ6xTEkWYR+OY6Vhrawg7Ux19AZj1dDG0hIUmQgZb
         40IwzYQbe2WIraeQwxi6y3CS6nQGxYqhbe6VRIF3iiS89Q/QtmkYlI/AfeSxn6JPaloo
         6Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1RlFtOczU7bqdeC9+xI0lJWMN+h+lumUpCgvelVcrA=;
        b=tjFXJGZlVKcm7idfO6B9j7xtdR37LFq+Ioeb1yoiduT8EZy6vTaH4fh1tM9EPgoprA
         OOs73nN3BeCLvjbfN2RRnTuMPnggwloFNlxdalfiL7ty8l9pTKy7DXrHbzkRa9yQ+rX9
         NmHKIKOMvQ2SXM6YtMoYG7rg5KI9B+GZSwUEkrksrnOSMKQUH5+gCimKo9SkXmQ/vWSw
         LcN/kB/kIbp5ODu9XQlRpYkp3BD3KLBe9g0uYP0uZGCGALn6jqH7FkVqViXycadOK01h
         Si8LhwkIUgKOUXo+F8XtNc9KOQUsIopx4sN+ZKzN561vHl8TLCQSZj5bKWXv3VArG6cS
         kGtA==
X-Gm-Message-State: AOAM533vEIEzVpLEBxb0Q95cv4rrl8ce53V5gNHPMoZjuEPyu11SSKcy
        29QSMSqzGQeZgZeoEDVzf0xDiWyRsjicfhB32YE0
X-Google-Smtp-Source: ABdhPJz3kbyxu7m8WdqExQQ8inFRy0slhdrCxzUYCW4C6yiiyhNLevqwJTeEV/T2krM+O42Zg2oj/rwLYkB+ozzVCAY=
X-Received: by 2002:a17:907:3345:: with SMTP id yr5mr15563499ejb.542.1627913073888;
 Mon, 02 Aug 2021 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210729031644.47679-1-xiujianfeng@huawei.com>
In-Reply-To: <20210729031644.47679-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Aug 2021 10:04:23 -0400
Message-ID: <CAHC9VhR5LA5e7rpphu7Sg1-pGrtKMkGcU7Q6TBYWyKK_23JB8Q@mail.gmail.com>
Subject: Re: [PATCH -next, v2] selinux: correct the return value when loads
 initial sids
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 11:15 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It should not return 0 when SID 0 is assigned to isids.
> This patch fixes it.
>
> v2: remove the "out" label and return directly.
>
> Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Thanks, this looks much better.  I decided this is worth sending up to
Linus as a fix for the 5.14-rcX series so I've merged it into
selinux/stable-5.14 and I'll send it up to Linus later this week.

-- 
paul moore
www.paul-moore.com
