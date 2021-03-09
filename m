Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A26C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39DC65275
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCIAnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCIAmf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 19:42:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A44C061760
        for <selinux@vger.kernel.org>; Mon,  8 Mar 2021 16:42:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lr13so24147808ejb.8
        for <selinux@vger.kernel.org>; Mon, 08 Mar 2021 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C76/WHac0N5dofcpCfqmmbgG/z/7d+A5P13qFcVNTw0=;
        b=aNi9vvcZjpTpC0ikBenjWHm1ZPsi4x8VyV09lw4CeHGd5H4Vaph8cgfFK3uIS8FqfJ
         KQ2jzaGIOm3wrWNR9VmtZyy7ECTl6fqS84xHDSjqj/3J8uCNjZoJZTr/72IHbUg6YvSX
         yZI07xMyXmv88iUtWnafN0Oucy3z3yEC/vmyxh+yMA1yEcSAQgw2Y947s+sIbyXZJgmG
         p4U+/iPP3AcGRJOncOCbb5NnDt9P2hriv6UROarWJ+qSSXmNc6te1gHbXnIaifZIwEjr
         jheymuT2SdP7g0l5H+zNWEFkqHdcrjavhRaK95kB+a/FaljGtFCaZjJD3peWQY/zhKUN
         R+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C76/WHac0N5dofcpCfqmmbgG/z/7d+A5P13qFcVNTw0=;
        b=jBk5iUO35dKU3+ydQGcfhx7W0ClfDLJgwMrNGfbXzHb6wJyER6OQPrbo3Z1uNrQJYq
         3zi8erFHK7eNk/P6mwe9DZRvjRGFmMGJTEDCouFVqJo4b/TE9LF1KzQ9VENwJCvsEpBm
         qDrcMws411/gjULP76Vu20qjgiE411gGR6wAM446jYCk8pZY9bq0uTvyioBNUzaVtrAO
         qVfD67F0Aeuul1/mndqrWCTSe7EZr4D0Hotr1/3/p009B4h5sTMTTMBE/F3xaqdGp1K6
         VuWGzoNuobf1TooqB6zr7HxQepAw8LsDzEFSAvAQlaIosu3qPLRV0rP4BIBOmjb2l/+8
         3mdw==
X-Gm-Message-State: AOAM532FejXLbpY5rkM5wR9/47/4VaoYrY99mxcrrXlNr57FDBMTsKBs
        6z/yVHYndXXAIlc75t7jnD6uNDso8boEAPYKLeCU
X-Google-Smtp-Source: ABdhPJwIXGkaBF8V6dy+G5/2xAXi9yydRYkl9mxsxD52Mh+nITMM46/Nu7niLBb8GSPoDLAba2ZlQ7UqF7KtZM2svqE=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr17224484ejf.431.1615250553701;
 Mon, 08 Mar 2021 16:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
 <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
 <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
 <CAHC9VhRBdJ9Vh1ESezim129OEf1UJ-Mxm1g9FpxEJmt-PUSLjg@mail.gmail.com> <9170636f-1793-2272-e3fe-1551c18edeb9@linux.microsoft.com>
In-Reply-To: <9170636f-1793-2272-e3fe-1551c18edeb9@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:42:22 -0500
Message-ID: <CAHC9VhQEAPB_kQFxBrJWtsL8wP9YoQkCzXnXmaD5gm9duBzYcQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 5, 2021 at 2:29 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 3/5/21 11:22 AM, Paul Moore wrote:
>
> Hi Paul,
>
> > On Fri, Mar 5, 2021 at 12:57 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> >> On Fri, 2021-03-05 at 12:52 -0500, Paul Moore wrote:
> >> [...]
> >>> This draft seems fine to me, but there is a small logistical blocker
> >>> at the moment which means I can't merge this until -rc2 is released,
> >>> which likely means this coming Monday.  The problem is that this
> >>> patch relies on code that went upstream via in the last merge window
> >>> via the IMA tree, not the SELinux tree; normally that wouldn't be a
> >>> problem as I typically rebase the selinux/next to Linus' -rc1 tag
> >>> once the merge window is closed, but in this particular case the -rc1
> >>> tag is dangerously broken for some system configurations (the tag has
> >>> since been renamed) so I'm not rebasing onto -rc1 this time around.
> >>>
> >>> Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
> >>> next week I'll rebase selinux/next to -rc2 and merge this patch.
> >>> However, if the swapfile bug continues past -rc2 we can consider
> >>> merging this via the IMA tree, but I'd assume not do that if possible
> >>> due to merge conflict and testing reasons.
> >>
> >> If it helps, we rebased the SCSI tree on top of the merge for the
> >> swapfile fix which is this one, without waiting for -rc2:
> >
> > Considering that -rc2 is only two days away I'm not going to lose a
> > lot of sleep over it.
> >
>
> Thanks for reviewing the patch.
>
> I can wait until the swapfile issue is resolved (in rc2 or later) and
> you are able to merge this patch. Please take your time.

Thanks for your patience Lakshmi, I just merged this into my local
selinux/next branch and will be pushing it up to kernel.org later
tonight - thank you!

-- 
paul moore
www.paul-moore.com
