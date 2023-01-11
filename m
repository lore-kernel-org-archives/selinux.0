Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB09C5479D
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAKPxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjAKPw1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:52:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADA198
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:52:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fy8so37803708ejc.13
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/+I87t8lQ3OR5/Dmj1xvsThdoL8T7RVsd8ndnzbic4=;
        b=DYnxDq3dRixoBcCsHQNdU+QTkyoXJ6fsuxWkO+rz4ofp4R1BDOEuQC/pvnnZVrCRZb
         ilMJWxjjOWGSlgvYXB9Ak3zd8Xu+4w61vmO07qEmZrvHSRNgMQusYFCbhpU8sRKYgW1V
         WSCNs34uVovsd5Bu3YOEkNbh4+nquKO9e6YmjcEpTYJqdHzBfdWmbXVZntoQOQT9rQFk
         jsXj0nd/4hT/t4V563wEft0QI9uIiPqmiPTK0Yk9Auvs6rkRVsv68iU3cZf34lpTCnIM
         FpObvzEggUDvksd53AgLZhM9FfDZItnz5AIT6a/x2BnAVj5qo2HowF/KBgy2NQtWHt5/
         XAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/+I87t8lQ3OR5/Dmj1xvsThdoL8T7RVsd8ndnzbic4=;
        b=MOUgKIKIxtOgb5AnVWuFFtsiINGMYrB3rSS65kR1Hr+0peiKf1HUM56YoU49ICzhur
         xbl0DldEt62tVCC8HXfGIabgN22deXZlvgo+/TdNLH7XcpKsAM8gWOO+j3DOCT1tmXUl
         gT08k1HhMNv6C2JztAoT+nTaMqL0xdS/vKnWGylYDBSTnYwt6aNkpi1uTMJZGNYkRRvx
         5bEs+Xw5IwM0Imep0BkzWgzMPVaFJI3OKNuIsjZQ0m+IunGKfcnEyI1WFSB3tzByH1wB
         kHgsADu79jRs8oy17tOBFsKpTILyDqy0ma+JEGt01J0WJBCujeABGZUhFvyoBGZvp+lC
         tLGQ==
X-Gm-Message-State: AFqh2kqb8Z50X6IbUBk8KqCisfXtqi9bs4gWPGaNq6AYPNqLsvHa+3C4
        04geiEj0+XQmd1qppzFLYNLdrfSK++EHg/Gjpd7uG9/7
X-Google-Smtp-Source: AMrXdXuzTxUehdTsht3gRpSbPvigQsSJHpudBN3tRrdVk4O7QjfcQU/roniGvfgqA1aWY1nBWrAtbUmUWsT7Toew9Y0=
X-Received: by 2002:a17:906:1481:b0:84d:1760:3981 with SMTP id
 x1-20020a170906148100b0084d17603981mr2362111ejc.705.1673452333222; Wed, 11
 Jan 2023 07:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20221216153311.17638-1-izhaoshuang@163.com> <CAP+JOzRrByJ34RP46kzPzUJH0_bvsRcwD5vmizFW8mA_OiSiAQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRrByJ34RP46kzPzUJH0_bvsRcwD5vmizFW8mA_OiSiAQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:52:02 -0500
Message-ID: <CAP+JOzS5pudkFkuyPvLFzfJqEx920f4fB0JFBCoVXN7qg1tKVw@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: fix a spelling mistake
To:     zhaoshuang <izhaoshuang@163.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 4, 2023 at 12:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Dec 16, 2022 at 10:49 AM zhaoshuang <izhaoshuang@163.com> wrote:
> >
> > From: kkz <zhaoshuang@uniontech.com>
> >
> > Signed-off-by: zhaoshuang <zhaoshuang@uniontech.com>
> > Signed-off-by: zhaoshuang <izhaoshuang@163.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  python/sepolicy/sepolicy/templates/script.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/sepolicy/sepolicy/templates/script.py b/python/sepolicy/sepolicy/templates/script.py
> > index c79738b8..564a6b38 100644
> > --- a/python/sepolicy/sepolicy/templates/script.py
> > +++ b/python/sepolicy/sepolicy/templates/script.py
> > @@ -75,7 +75,7 @@ rpmbuild --define "_sourcedir ${pwd}" --define "_specdir ${pwd}" --define "_buil
> >  """
> >
> >  manpage="""\
> > -# Generate a man page off the installed module
> > +# Generate a man page of the installed module
> >  sepolicy manpage -p . -d DOMAINTYPE_t
> >  """
> >
> > --
> > 2.20.1
> >
