Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7354EC433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3469461183
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhELK5y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhELK5x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 06:57:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8160C061574
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 03:56:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f1so4290252edt.4
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bT8Wzqgl0NEbMATYodQHmDb+HMYJD2ESRCVFA4J5USg=;
        b=edpRtIYWJytMqMarU5P5ba+cFpic/2h8KEueeWMQ/KIccCpvzBiMTlFGl+U1Frp5bj
         i7DNyy8meVs2+59VYAWqNZZ4RBjX3XfowEL0t06dTuDzf2auYCraf/dAMyBSwyGrTDbg
         dh9pFbKu9p9vI3RRR2FyJ9LmgqNNzOPzVC8CxA+nlSPcMtznCS6cW4PxfQuiBg0tlLCr
         Sl+JFz7fTXJK74KbMqEx2rpxsrGirtIfF0Qw8btJdCr1tHj3gBPqxJRvYz8MUGSchp7W
         /7JWCsn5sM4oMeN5SyIBIdZ1ptMVbyuvp9PCHSJHHWVgCLYsD5dxpWralJZk/cJKokHp
         6aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bT8Wzqgl0NEbMATYodQHmDb+HMYJD2ESRCVFA4J5USg=;
        b=k8S9uP9C1Eb2WCoOBfComLxut9/i3+1/OdDc2ps0ixt11URtsspaHJgvCxcX5Igqse
         3sgFT1swQcLDWrMW30l+pmAy5r3oG2YJd1/35vtJCVJ5sGo/50fhpJX7fxn9VYr3vdGS
         oQfEwqAgLkXq7uVH4LlTESmaCIMwOIWmEBf3lavcx1GZ4AA04nwQREqb/GPwCl2g8Ki1
         B2LRCJShVShLPPSsqCn9AWjmQyC092dVGTYRDXG/DlE0W6QQ9SfrB1mGsFJ3MLtJi0MQ
         F8T4Xx+ntcc6pVvTSxcjSV0evXCpziBr6NIlkFi0FC9R2ldQsWHQiSHRR0ApOaE3sg8z
         X+Wg==
X-Gm-Message-State: AOAM531rYVUHJk20ubtL/vI5MW5dZTl5K7vH8q+u/My5CzvJ+LCfFR+6
        Y3nNBlsT7hkRW1a725zq2Goym+bLw+rRtDvEtiA=
X-Google-Smtp-Source: ABdhPJwLcbdD+4jqoPWlSFSrPIKptaplVTJTLRfVH3XSw+/WWm+ofvrjjY8TbVy1y70P4rjD4Agdiav5rlpjwF12Qew=
X-Received: by 2002:a05:6402:1bc9:: with SMTP id ch9mr43231399edb.136.1620817004533;
 Wed, 12 May 2021 03:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210512102529.122753-1-omosnace@redhat.com> <20210512102529.122753-2-omosnace@redhat.com>
In-Reply-To: <20210512102529.122753-2-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 12 May 2021 12:56:33 +0200
Message-ID: <CAJ2a_Dfacd18naq_FnnG86B_erzWW9z-EPjqf088mEHfREwGrw@mail.gmail.com>
Subject: Re: [PATCH userspace 1/2] libselinux: fix invalid free in store_stem()/load_mmap()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 12. Mai 2021 um 12:25 Uhr schrieb Ondrej Mosnacek <omosnace@redhat.=
com>:
>
> Building libselinux with GCC 11.1.1 produces the following warning:
> ```
> In file included from label_file.c:24:
> In function =E2=80=98store_stem=E2=80=99,
>     inlined from =E2=80=98load_mmap=E2=80=99 at label_file.c:277:12,
>     inlined from =E2=80=98process_file=E2=80=99 at label_file.c:551:5:
> label_file.h:289:25: error: =E2=80=98free=E2=80=99 called on pointer =E2=
=80=98*mmap_area.next_addr=E2=80=99 with nonzero offset 4 [-Werror=3Dfree-n=
onheap-object]
>   289 |                         free(buf);
>       |                         ^~~~~~~~~
> ```
>
> Indeed, in this case the pointer shouldn't be freed as it comes from
> mmap. Fix this by adding a from_mmap parameter to store_stem() instead
> of overriding the saved_data::from_mmap value in load_mmap().
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

See https://patchwork.kernel.org/project/selinux/patch/20210503175350.55954=
-17-cgzones@googlemail.com/
for an alternative.
