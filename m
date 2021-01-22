Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F51C433E9
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 16:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DB239EE
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbhAVQ2r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbhAVQ2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 11:28:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61046C06174A
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 08:27:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hs11so8515200ejc.1
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jgsNuXIvqI1oHQAXZn5JgFsfJjKCytYZ7OT3GPhwD2s=;
        b=m1niqWPuU3rIuTtteJhO8buTSqZqubfb1+C5wLRudtNLNFYsNCmiXJ5j08isZGt6kn
         xQ9KYuqOA6DThK8GDcz0OXXlKetsb8UqXtKBjZCTOSyV5xEigLmEzTO7aNLZrOMzpd2s
         DRpmJmcFSebTjV75kEtYFGbYu8kZysAsF5H4de4bOeyF4kQPplXUEDsCvhZiadzVT6od
         qJ12pfQzZobvPa9CZX3qE9fileXI5boKNOC6zohN/UntcQRMroes2Bz5lI++duXoicJO
         nDXj07Jo9AD2/UJo3ZzY2yrm4/jprOhn0cUz82QL+7wylEfCIgldPQDpnIGaCbO/L75l
         RBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgsNuXIvqI1oHQAXZn5JgFsfJjKCytYZ7OT3GPhwD2s=;
        b=MUhItHborlv7iQbq4C13bT2d+Gn55IezIEy5bUxRdWNBoBVFN8L8mD52rPGiuKEQ5K
         Ago/RNd2EZEXVeHn2J2yd8eZSOftmN5gzfanAjXezEQ/prIfDtypNfy34ffNQeZ5DOLe
         A2kONtCvyHCFRLGkBdEAN1I2ASKf3zFyUn97O1qZX0vZt1IDc8x5g0+6HHsikXaBSwBb
         OnLn7LGFcB/nYaXbSE6ay15jr9GCDDVUhVlrCntgddyjTFwCca1ld93nwwMMA9mUISlF
         0XU/KYOYkrPqp7Oj9ctjcsi4J0YNdPB3BjHE6lk6nBVTuIdv+aamXjzH5tDTfUQKfqOp
         Lkaw==
X-Gm-Message-State: AOAM531QlRkczRwidEUehO4V2fWGGWyZjY0cUNPNSMu2cFimczyc9zB1
        rRJzWnXoYL5HJ6iOQldwVQ456DPds7dbRw8c1nOu
X-Google-Smtp-Source: ABdhPJzWEwVJKbZaM6j/eQx4wUwSt+814v0b6qxEPB1OIQkH1K+MeoSxbRfnWjdX/YQuqA3ea5RUDFiQxuqnMorwPOI=
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr3610842ejy.178.1611332856027;
 Fri, 22 Jan 2021 08:27:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
In-Reply-To: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 11:27:25 -0500
Message-ID: <CAHC9VhSCmhkcRgWtGQNhSr8SQueHWtw3qW9SEtNnEgC=AyzVZg@mail.gmail.com>
Subject: Re: VSOCK & getpeercon()
To:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc:     selinux@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 16, 2021 at 7:48 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi,
>
> getpeercon() isn't implemented for VSOCK. Note, I am not very familiar
> with SELinux, but I was porting some applications that uses AF_UNIX to
> AF_VSOCK and reached that point.
>
> I found some previous discussions about VSOCK & LSM from 2013, but the
> reasons it was abandoned don't seem so clear or valid to me:
> https://lore.kernel.org/selinux/1803195.0cVPJuGAEx@sifl/

Hi, my apologies for the slow reply.

The SELinux/LSM VSOCK support wasn't abandoned due to any significant
roadblocks, it was simply a matter of time - I seemed to be the only
one who was interested in working on it, and I couldn't find enough
time to work on it ;)

If you are interested in spending some time on adding proper
LSM/SELinux VSOCK support my gut feeling is that it would still be a
good thing.  However, I would suggest spending some time investigating
the current state of things, while you may get lucky, I believe it is
safer to assume that anything from 2013 is horribly out of date.

--=20
paul moore
www.paul-moore.com
