Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79010C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 02:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C40B20825
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 02:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dwe0g2p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHTCH7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTCH7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 22:07:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBEC061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 19:07:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c16so724310ejx.12
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH0o2ACywhoyWqluc5W7F52s8JPrIvFPdSzJu5VYIfo=;
        b=dwe0g2p7BZV3KNo9W7azZkenebJliT8ybnWQxv3sdO+4LPEAwjk1AMMGTbnIjZBdep
         MN/VVaCY9ESTIZXE3MhAtrfnBfqtXE6DOxR9x7gqmN7xc1VvU7Ocr15j0AliiMwqmlYC
         bOFXMBaQBNnouxxUyTVaKMRnW+wdTicnKBb+l9ijIOiwT+XfTNL768Pwe6KuIaqxygPp
         H3DB8YHLDZotpoipcdDhg4LCQo094qW+bvGNSbS5vaACyY588Obiwm4C9OkT5sSla9nK
         noM7Fm7ytNh6tZicKRNAwD62010SLMqfJzP5frjza30pj2kZVW6zJN9YAgEf7Sd1CG7Y
         nVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH0o2ACywhoyWqluc5W7F52s8JPrIvFPdSzJu5VYIfo=;
        b=Zv2feA3EieeHYTj1tG/siWFC8xzD1S552EZf9UNSbcvwuiZhbbhOm32MvQuB3yJvAo
         qT6rMKDKwSgSxcKDTAkl00XBCfFmg9DQwjcXMtjSybMo9fbUyUQR/fGSQ4+wXH/ZDHAO
         xAnbO6kCMyiqjNomGAUOo2S8iTn4SvGQxcgSbq6Q3YHzj8UZpe8v8obvpSgcXy5bDkQk
         14YZp1u4f0EqSVD8nTaSlLTo+Sh7AteluJJgDQUPRRYCj4ONGW19mnvBrHDtvaSM1SsO
         Tejl37TPXd8+fw69gG/DAPvpCIid5/hFc7XzXFcz58uwj55PMprliZlMVKUGKYoJnCQu
         O9Fw==
X-Gm-Message-State: AOAM530XzuIYXQSiG7OZzOI4fiAQxzofQ8srFh71UTWvnGVt+hFwzdeq
        QPRO5mzoqbHPfeIgEp5JJAjhqtzYdFXKZPiuiPLuh1bvs4s2lCk=
X-Google-Smtp-Source: ABdhPJzWkvgK23mauCUjhUy8jiyFyIkcQIoiVoEw1kHIXeb/GMbOrM778MmktA2ClEWIwrYUjX/oqfPOP4SeieWdT2g=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr1063762eje.431.1597889277141;
 Wed, 19 Aug 2020 19:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
 <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
 <CAEjxPJ6TEk=iXHkB0=6EytMeJo1R+ZSgS8O0-32NPHpR43PhsQ@mail.gmail.com>
 <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com> <CAEjxPJ7d1Si+FcsanaKUvENCrMnHPQOohOdKF6A7VFaigw8bFg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7d1Si+FcsanaKUvENCrMnHPQOohOdKF6A7VFaigw8bFg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 22:07:45 -0400
Message-ID: <CAHC9VhS1HrDaBF2R8quwCN_sfELoBOxn7t4Gxc=rCqJVudBOVw@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 9:06 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Also, there appear to be other leaks of memory allocated near
> net/netlabel/netlabel_mgmt.c:88
> net/netlabel/netlabel_mgmt.c:201:
>      86         struct netlbl_dom_map *entry = kzalloc(sizeof(*entry),
> GFP_KERNEL);
>      87
>      88         if (!entry)
>      89                 return -ENOMEM;
> ...
>     195         } else if (info->attrs[NLBL_MGMT_A_IPV6ADDR]) {
>     196                 struct in6_addr *addr;
>     197                 struct in6_addr *mask;
>     198                 struct netlbl_domaddr6_map *map;
>     199
>     200                 addrmap = kzalloc(sizeof(*addrmap), GFP_KERNEL);
>     201                 if (addrmap == NULL) {
>     202                         ret_val = -ENOMEM;
>     203                         goto add_doi_put_def;
>     204                 }
>
> Probably the same cause for all of them.

I've had a number of interruptions this week on a variety of fronts so
I've been late in looking in on this further, but at the very least it
looks like netlbl_domhsh_free_entry() needs to free
netlbl_dom_map->netlbl_dommap_def->addrsel in the
NETLBL_NLTYPE_ADDRSELECT case.  I'll plug this hole and check the
rest.

-- 
paul moore
www.paul-moore.com
