Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCACC433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2820825
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eA1hNMpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHTCCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHTCCG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 22:02:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37AAC061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 19:02:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w2so122095edv.7
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8mCQyjxGS5HK60s9U2rXsyX2dfNE1i/0FbssAhALoI=;
        b=eA1hNMpfaLn6b/taOzUmPwy6cyt0bcohCzH7ZBIYgdzFoyliVMzzWwrS3od5ctnI3q
         QPJtwTl5EN57qCtcUvUfWVfR+JpA0K0dhQK0mdXd5MtmY8t/mf8Bz1GA2CH3qxxZxbF5
         KxodMYBQSWqv5fDk/6zhHYNGXHLege1DV9VoQAMiq7pg5GpGaUublBbeAzZuRMdigxvH
         odAPVdeY2o8Zk0+QYB87cE7fgi9uZrlcC/6owhb+Wrtl65g55Q9kcTWqaefSaBnT5Y37
         6zQfSaA6U+OcuhU2IbeR5Lw1kP0Y7bY1lXxi/RZ2qcVpDh53oV/GwWIUoCcpf9IsNt46
         9n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8mCQyjxGS5HK60s9U2rXsyX2dfNE1i/0FbssAhALoI=;
        b=TBATMro4XCMmNih7q+h7TLEWsOWnutYem0+HgKsrzNhMdQhelTZ+YhlgWPp2J1sc3U
         zx8dIWB9ynmMOxfCe4GdkpneU6nmF+AS6mX9NBbNnEmU9jRaKyxUDzvTyBEjtCAeVNas
         XbzPDtnUil09BwFJbmIZVMIIXvZ2tCj5/Xh7prxPemyi/qVKZeVUfaOlTPgsvDmOCikl
         3nYMJrfiCgnTdXiv3LNCb1PXC0zXsO3y7gadbwUkFux0YNFwb/vsdaRyxnP50G3hBAsb
         pM/rMDod8zeqzpLvjTrHFpb4JvuIYWNNYdQn1Jh1xGgqrZK+U41OeopsHhFjUMqlFTTx
         Xudg==
X-Gm-Message-State: AOAM533H4Jfi+Saj5zUKxR857t2CbS6Qh9yTMbwSGJyKMriHPV/9/tvW
        CsdeIWVSi3exwl0t7VVI4lhoxunMpBLtbOAyns1B
X-Google-Smtp-Source: ABdhPJxaDtaHSknM8Hk8XhqiMkqN+JN3CWxgcemK8DdcjzK86qSwkVQeG88+tnhmNN780j+F93IpyF8ThrDbbXj6nqE=
X-Received: by 2002:a50:ee93:: with SMTP id f19mr802546edr.31.1597888924031;
 Wed, 19 Aug 2020 19:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
 <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
 <CAEjxPJ6TEk=iXHkB0=6EytMeJo1R+ZSgS8O0-32NPHpR43PhsQ@mail.gmail.com> <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 22:01:52 -0400
Message-ID: <CAHC9VhTamho=sNaABtt1JUG_q7kdfAWL69tqMgjZ-trwK9ovjw@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 8:59 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> And the full stacktrace fed through decode_stacktrace.sh (which I
> didn't realize existed until just now, was doing it by hand) is ...

Ha!  I didn't know that script was there either; that definitely would
have saved some time over the year.  Thanks for the pointer.

-- 
paul moore
www.paul-moore.com
