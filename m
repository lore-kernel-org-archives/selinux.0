Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D265C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A61A2078D
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BDf9azaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgHUNrI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgHUNrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:47:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9AC061574
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:47:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bo3so2314914ejb.11
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCNzDue0d+9gLeuNDZrCDBO7b3B7dWV+FryyxTem/wM=;
        b=BDf9azafY0usvDzD6SWESmOB5PViNnJj/9/rufIn6pIb+SY+E3IMtw8WgrrAe16c4D
         4N8dFgKM6uDJ5zMAeHRHVh2MspW7Vyqt4+RMuWrtXCAaCTzuLDaaynS6Xh7n16Druirz
         jcpfkpFlm4VZpqGAv6FeR4sQcbKFoxcUoI9PiSQp2IX8EAvR6ej9RtSNHVACLazukIfV
         nmyeHO03NRVFJEKHpywQOu/goM180NbO31Wc3qb2ZZwR3x3+nzZBtDf2svECy09qT82G
         mwkkIc7GZ9nPEBr821KMJE0RuuapIE4o0Co9wpwdrldJBb6eTDutPhyuviqb3sI1SyIC
         7SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCNzDue0d+9gLeuNDZrCDBO7b3B7dWV+FryyxTem/wM=;
        b=fgGXh2CK3HGBshPG5mwZaTxm4kiSxVRu56CfwzQWUr6sDfl6KlSieYO6vcyzHWC82H
         IMzq+o8+DNvaP8lP5gQNM2G49kXqgbpBMI1L55+RR5SW7NJPPuMrT7CEtwylv+paYUjp
         lpy6mhXgCfNVLJAtFMtY0erAAS61Ns3Hx/q+Fo+UVB5Xv89btwvRdwcqmK1z4x9dDexP
         +bsIF8kGQ7UZ2b2qk5tMx5NIV9mU2sUEQFt4a4k4VQBs7TajeFjaSVueHV4DXEXvT+gG
         bazLOUygpS9AgAB4fTPMXEaIZbqSKB6xEz5gQ8nBjxmcjI6+PBUa/irtee+JBP2tVO2M
         1Vcg==
X-Gm-Message-State: AOAM532+Ej94kbl7eI45WWtOZJ5qJYjiEPQaRyKKljPjgoX1pkqCj/Ek
        SZtzja4LFYF5q6ZTrND9bl6ZY8TohZ38EeVkfQL/
X-Google-Smtp-Source: ABdhPJy6zIIVIwF1GHspiGxBu6rQjz/cqHvYRzEm2Z4xJYFQGvRzpYb/UmjUqCMgmnE906lKpJCPOKo+BUF7LdsX8Lo=
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr2792528eji.398.1598017621287;
 Fri, 21 Aug 2020 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com> <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home> <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
 <20200820223136.162850ce@oasis.local.home> <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
 <CAHC9VhTLOWsD9LbVGBj=o3N3SPe-uJDvrdQAySy6MmE4uyuzng@mail.gmail.com> <CA+zpnLfNjDwxgoG2p3W8YfXxYVQDum4Eh_MJQvKP4rGLqsqACA@mail.gmail.com>
In-Reply-To: <CA+zpnLfNjDwxgoG2p3W8YfXxYVQDum4Eh_MJQvKP4rGLqsqACA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:46:50 -0400
Message-ID: <CAHC9VhRXZXiYFX20wtMt9bTv-6sAer91gY1x5ueJv4fa-i5jPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 9:21 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>>
>> I'm okay with merging patches 1/3 and 2/3 wth the changes Stephen
>> suggested, but I think we will need to leave patch 3/3 out of this for
>> now.
>
> That works for me.

Can you respin patches 1 and two with those changes and repost?  I try
to refrain from making non-merge-fuzz changes when merging patches.

--=20
paul moore
www.paul-moore.com
