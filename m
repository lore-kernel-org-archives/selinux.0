Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370CCC4332D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BFE2072D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5KHucer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSTiB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:38:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37611 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgCSTiB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:38:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so3681523otp.4
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IASiWHRZ/UNF28eXo96IZXDNcFP0r3luFN03V331IxI=;
        b=B5KHucerMlwGkTJEiVMR5dnc1jsbuxsJrzHQtW50RE6gcwdWJVR8bq4bQZEfcKeKAx
         Bn1Vp5WUiZ5D+F9Kf6HN2m5mst1eGaZHFORlFybakClNwQOdDAKDGtsm0kA+VyWN4CF/
         jvXXIECHUQUKmxz4KFbsDAfRG1Vg7UmSDon4YsCZkZBeVFkTJBclv4OFmOKiZf4U8Vih
         NaYka9liTwLA63/6+qCTvjjfe6Uekz6RmTWxCU/4BUGI8REQ7RGrJol1Mnaoz5mLN5nt
         xqOqEtmgltxN0VqX0Jv4X9x0DqJ04L99T9laDFMRXrBQUWPW2QGwt+UVJsyaKem3yuvj
         kHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IASiWHRZ/UNF28eXo96IZXDNcFP0r3luFN03V331IxI=;
        b=SngPVcImS3KKu0WapXDopRrSKu4np5ev6Ss/8R1HMq7BmdfJc0zamCJJcE7slWWu8e
         Y9sP9SlyKFmsdtMxJlnvk1C3LAD/eUVzEFXzKL+cas3vwh2MeTo571wb8876TawUEoeH
         qrSd4qApFhMiql8CauT9fNpaZu41WByDiNNB0273S7nFaV0syGe3eeyh8FxGwjyE3d7X
         aMWuch3IDFosLWytOzJJUY7Ca6/OnQxcmrrQ78u1ctEszUiNiBwWYwCsEgl0igeZhrp6
         cxpgnfgI9bmJ4KfvZoWznRQV4tXorSNmwoCkopUEPaB9DvxVjok4B1Hlyh9VNBi/FqUd
         UhCg==
X-Gm-Message-State: ANhLgQ1MVgGruIXq7XjuweZmKuNVVsK7B1IA2BAUeVL59ebAL+5QLAI4
        o893lDH/TsxUWN1J21mi114L4sf5nKu2mPpBEZc=
X-Google-Smtp-Source: ADFU+vtqG4/LRTSJv0/Stdzb7vddoAQOctKGjszuP2YPwvxGXsEA+ABXa8L+4VkbL5CfMhrKAfpqgpWBk6YcVPD1dVw=
X-Received: by 2002:a9d:5607:: with SMTP id e7mr3911638oti.196.1584646680638;
 Thu, 19 Mar 2020 12:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-3-omosnace@redhat.com>
 <CAEjxPJ7cduc9M41JsCQMi60T6-jq+ijR7epjOjmK6UtoHh7ipA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7cduc9M41JsCQMi60T6-jq+ijR7epjOjmK6UtoHh7ipA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Mar 2020 15:39:27 -0400
Message-ID: <CAP+JOzS4OF8p9HPV2udAsFKSRUT2pOOKQWohyzmxw6HnhOAo+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: optimize inner loop in build_type_map()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 17, 2020 at 2:22 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Only attributes can be a superset of another attribute, so we can skip
> > non-attributes right away.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
Thanks,
Jim
