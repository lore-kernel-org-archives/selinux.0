Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC2C54EE9
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 01:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIWBva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 21:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIWBv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 21:51:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7BEBD6E
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 18:51:27 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so7419193oto.5
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=FergUShp4d+bQJTHsxMNFf/r38EsKlQ5fK8P7eej5aU=;
        b=1SS12C9WPgfPI0RQygKfKXSvr2FE9EPITeCebIwJh9uw9M3VHyGAoZdd9UUqblZStU
         8tXs3lTfOE7SxqC37C54pPmEbZCXW3tudpSnlJRsIJ7E59n1ch8nHj1xfkTZ5BL3ct8Y
         Xl6bNwYse+gvM036N/iNIQ1NH6Wu75SPxBUKODahpzP05mf9MCE5iQFbdGA85ZQ/XyKW
         pV/8UDsxps7WfvTYL0xQslLwKAP2G9zWv0MLvnbYrij3pFsmxNLf1Wc4XsrEnE0b5q0a
         hTXQGtAlsJEed6SZW3/0ivbMdMKnprR2RlLLkyMS4ox9pZSdFT2nKLx36id9/PaPeIZO
         YQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FergUShp4d+bQJTHsxMNFf/r38EsKlQ5fK8P7eej5aU=;
        b=zIQCtkSorsmWc4OZgNgb2qSwtTB2ygpBKjOaN4ulEtHZ0oQTc53qmFffhz8qFzxgka
         f/xujT+eeXIvTz8rgtn7Z+X9T92nes9fgYj4hoVwQdTXHpMWU5Fh59NhIKc6Wt8SprR1
         TyDEjYMWi0dfD16nx535KL66fck88b+4+CLcxCnz2t22QkLPkIPc85ul0uXdZQvlDSnd
         Q7+wAanVqhxmKjtrkHW2AccqVAY6DytFi76nPgjwDEl9NIA2HW+u1av9aALnbzBgLDai
         vPIUBBbjUULlakVME/qF0ghXx23UdZ8X1sNx6fQplF1TwkR6aNO62YcsnX8xz8KPxpxY
         zZpw==
X-Gm-Message-State: ACrzQf3+SMGSbku0MaZ3HddFpfU7w+dXbwt/UX3qRqpjK7Uiuk4gFjFo
        XATwTN4/nURfL8QDg7d06nnxnX0do9ek6ddTU1XyYRvrbQ==
X-Google-Smtp-Source: AMsMyM6Y3YtsaaeCz8CUqbYHngq+/zoauQ1mrtp7o+zf58mScDFY+tAE3EPTkkXXfYspUhFHB6bvZCbahOXfMkIZED4=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr3012083otq.287.1663897885992; Thu, 22
 Sep 2022 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <166389782245.2164705.1324707815130435654.stgit@olly>
In-Reply-To: <166389782245.2164705.1324707815130435654.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 21:51:15 -0400
Message-ID: <CAHC9VhQRNxoCg9BKQ9t1wLuxq51yoqEPEZbswbg7dwGC-22y=Q@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: increase the deprecation sleep for
 checkreqprot and runtime disable
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 9:50 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Further the checkreqprot and runtime disable deprecation efforts by
> increasing the sleep time from 5 to 15 seconds to help make this more
> noticeable for any users who are still using these knobs.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As a FYI, assuming no objections, this would be merged into
selinux/next *after* the upcoming merge window closes.

-- 
paul-moore.com
