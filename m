Return-Path: <SRS0=hgLN=ID=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CBC433E9
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 19:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F19650A6
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 19:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCETX0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCETXD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Mar 2021 14:23:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91FC061756
        for <selinux@vger.kernel.org>; Fri,  5 Mar 2021 11:23:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so4130841edw.9
        for <selinux@vger.kernel.org>; Fri, 05 Mar 2021 11:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArZhbmvqEdmzARCu90VggFIPvPrDP31aX8oRDa73ETo=;
        b=Htyw/sFVHs/0xXtay5vW8sOmGYl9EHDXSo9vVE1XC9zXbFevZQkPknr/as1fXldzR6
         a5se4Mim32VABFeSd8big3Mf2d+HvqR8ABGnr1jNGHqS1cZqe6UnY5a+3oDVxpUHc/5G
         ZVqV8mKkkNRjsxy+oD9hUTtvUmILAUNC6IbVmeaXdfvR1zTxaUWcbkiP2Oa1ruG1Ng0N
         Y338SqY30wtznddTPOSqVztxrbHRGqtogI+F/3F1QbjNfdWQjQjl9sWC7ZdlRaq+zCqL
         iB++8tMySOi/Ynf5p/8guCEWb0X86NMzQa9zAwxVdXdRvf3swmVNqTk/sivgvRNdo1X5
         IjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArZhbmvqEdmzARCu90VggFIPvPrDP31aX8oRDa73ETo=;
        b=grFEjbL+juM3kUPE5J+tZKJkn0p6HpOLmN4SZxQ49FngyLZk91bRAPkL1u8N+re1bM
         B+G8BwnMsQ/gqGKjTucKHHx6Til/piaUqDw/jBjY5kB2CmTaTuLYxR1FGV5rVQT7UmC9
         pOHpCSCVAbNpW8GB1UsxdyqqyGRWbfMxTDRj9QJjjHp83ekqkKD8tO/+FEECxgeoxqnc
         X+H2XbQUFEAnB1cY4sifmn/bTDfDwWm5a+wsQmhhYi1Tc/9l+9jIB/TtMLJTent9By/r
         vAp6SDtJXiDrbl/t8kkcQ9bD1NBugUafNt4Q95cU60A/6KyZeGk+oCuCPatxK3It3FcL
         wucQ==
X-Gm-Message-State: AOAM5338mZ80Fz748gmhx3zsbIjETIkcepwfE3X2UIXeSB47rP41Bzvc
        QLO9paSoxHxW5w4P3sBmFs00xtaJ/OxybekSEmghnE/+CSrbRMw=
X-Google-Smtp-Source: ABdhPJyVEvSo6YyUyhR5EpkOHk6Q5MkSe4+aUSesETw1433XvkjQOq4OuidXiDbyqSjArWY5CPpq3jGGM758dVF/GEc=
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr10517327eds.31.1614972181250;
 Fri, 05 Mar 2021 11:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
 <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com> <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
In-Reply-To: <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Mar 2021 14:22:49 -0500
Message-ID: <CAHC9VhRBdJ9Vh1ESezim129OEf1UJ-Mxm1g9FpxEJmt-PUSLjg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
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

On Fri, Mar 5, 2021 at 12:57 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2021-03-05 at 12:52 -0500, Paul Moore wrote:
> [...]
> > This draft seems fine to me, but there is a small logistical blocker
> > at the moment which means I can't merge this until -rc2 is released,
> > which likely means this coming Monday.  The problem is that this
> > patch relies on code that went upstream via in the last merge window
> > via the IMA tree, not the SELinux tree; normally that wouldn't be a
> > problem as I typically rebase the selinux/next to Linus' -rc1 tag
> > once the merge window is closed, but in this particular case the -rc1
> > tag is dangerously broken for some system configurations (the tag has
> > since been renamed) so I'm not rebasing onto -rc1 this time around.
> >
> > Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
> > next week I'll rebase selinux/next to -rc2 and merge this patch.
> > However, if the swapfile bug continues past -rc2 we can consider
> > merging this via the IMA tree, but I'd assume not do that if possible
> > due to merge conflict and testing reasons.
>
> If it helps, we rebased the SCSI tree on top of the merge for the
> swapfile fix which is this one, without waiting for -rc2:

Considering that -rc2 is only two days away I'm not going to lose a
lot of sleep over it.

-- 
paul moore
www.paul-moore.com
