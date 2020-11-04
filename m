Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8AC2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43BC204EF
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PSmjLCkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgKDUk4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDUk4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 15:40:56 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9455C0613D3
        for <selinux@vger.kernel.org>; Wed,  4 Nov 2020 12:40:55 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id s25so17782098ejy.6
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2020 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOvOv6k4yxUy0hyawpvvCGGKwO1X441zF4A9AtOMrdE=;
        b=PSmjLCkAh+tIc9NbfITOvBRkKiWDnO80opt3qIqCSXQQTsixM9SCCNDDHcEJnRuqIz
         abB5KKtzf2ObH9dyFQNSMRXlwPgb0roeePf4z4qMoerGYzzo32lDfBDRmeNAnzSPL0fr
         muD5aW7EWjR0p8kDND1mhYymyBir12oOTsp9uVjV3IEn7vk/MX/F0gm/gMaXxaecDdwZ
         IbPin8k/mrxRGv/k8RHST3XIinryQXZ/7e4mI+OXS62+NmY09vFEQMHritLkEyIDvGM5
         gCrkCQ3/i33cO2Nf6zGBcZB6DPkNUn6ktOLpY6CrEIL1rPKG8+6s2gY5PE3HA908nSdE
         HYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOvOv6k4yxUy0hyawpvvCGGKwO1X441zF4A9AtOMrdE=;
        b=a2oQEilh08wk05Deyfa31HR+CTa1wHuIRbRRstSaV1YwiP6dz3cywArUC2blHLt10D
         P8dP2LnGQZR/D95YFdeUyDI5KOh9lkCiFUSOK8sn33sgesPO/k20wMhIH9ygnRddjgoo
         n2ELNQige9k0mkuQ1bjwps4QX/1Qh+guucLazhxeYjeinKpxCBshi0zJKdY3Hj0bEope
         Ski+BMjHbYyxf6LTk72h/KjN7oHZHSPmZboqW4dG40WTe8zkB3iFW41f34LotkaUPUgl
         tNeXpOA4PLC7t5JdFutaDaACwe1tzk7ZsZBfTWbJS9pAgOgKW2X+JvJoh1nqRPj84noy
         0csw==
X-Gm-Message-State: AOAM5336ouXSpcuXiuu0cXlccG9yzygTmSEIpWPsgYzaOkP57rS4dxSk
        d9kcSyZC/ANYLHY7+L5qYCsUZ9QlizGsDQIiVqpE
X-Google-Smtp-Source: ABdhPJyh4WUv5vFp0gfxQlwd97hCqaxvwLiCSg9gka7Yv4g0BlXFbWbPQ4ZynRy96ZD57vo9hNzGK/6Fuq4ZIOzWzJ0=
X-Received: by 2002:a17:906:cb0f:: with SMTP id lk15mr17846190ejb.431.1604522454330;
 Wed, 04 Nov 2020 12:40:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
 <20201009013630.6777-1-rentianyue@tj.kylinos.cn> <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
 <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
 <yt9dh7q64m8a.fsf@linux.ibm.com> <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
 <yt9dpn4u9scs.fsf@linux.ibm.com> <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
 <yt9dpn4twqp1.fsf@linux.ibm.com>
In-Reply-To: <yt9dpn4twqp1.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Nov 2020 15:40:43 -0500
Message-ID: <CAHC9VhRzJEdqTywGnCtq8mb5C=4k99oJ1ZTH64n4KcWn0mF0pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     rentianyue@tj.kylinos.cn,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 2:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Nov 3, 2020 at 2:02 PM Sven Schnelle <svens@linux.ibm.com> wrote:
> >> Thanks for the patch. Unfortunately it doesn't seem to change anything
> >> for me. I can take a look into this tomorrow, but i don't know much
> >> about the internals of selinux, so i'm not sure whether i'm of much help.
> >
> > I'm sorry that patch didn't work out.  I just spent some more time
> > looking at the code+patch and the only other thing that I can see is
> > that if we mark the isec invalid, we don't bother setting the
> > isec->sid value to whatever default we may have already found.  In a
> > perfect world this shouldn't matter, but if for whatever reason the
> > kernel can't revalidate the inode's label when it tries later it will
> > fallback to that default isec->sid.
> >
> > I'm sorry to ask this again, but would you be able to test the attached patch?
>
> This patch fixes the issue. So it looks like your assumption is right.

Great, I'm glad that fixed the problem you were seeing; thanks for
your help with testing!  I'll post a proper version of the patch to
the list later today.

-- 
paul moore
www.paul-moore.com
