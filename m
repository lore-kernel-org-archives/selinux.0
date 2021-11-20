Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3EC433EF
	for <selinux@archiver.kernel.org>; Sat, 20 Nov 2021 15:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhKTPIT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbhKTPIO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Nov 2021 10:08:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E76C06173E
        for <selinux@vger.kernel.org>; Sat, 20 Nov 2021 07:05:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so55442508edd.13
        for <selinux@vger.kernel.org>; Sat, 20 Nov 2021 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzXH6/BOaOyR+jOlLVV20rWFQH1HC0nLxgMbwNTLeoI=;
        b=VnIx/cKqCwk7FUlSoVAV4wSek3kpa3WFUTdjwmdqZMRL96DRCl0Hknvun9NouwIiE5
         nimOfQku7kHUbG+NdnxA1I3SzQv4rOaPBkIerrluolnSLHGSaVwDgo4kz2ENY0W0jb+z
         ybzjoTA2xfI3bpx10DPjOWg3xXXdfyuJQAmyYIQff7rKwKX8IcWX1bnd9R5XO9CyZ37k
         SLvD3gM8e9DvI7IOmvGRoa7BEhld8JChZEyprR4UnIlUYTkWXSad5vxa4ffUlwXxlDm6
         wHh4JdR0GBZOz6nmiT/LRDpv2bU8EMsG3sXyJ5XeUJF7pXg3GVUCglQXoAGEBBwgQ2d5
         lrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzXH6/BOaOyR+jOlLVV20rWFQH1HC0nLxgMbwNTLeoI=;
        b=zB+RJuRNWiiNxw6f6dT9QCkhUW7mWt4nSaVEtWS5TcaebbRBgoTexgdz/SZVOhPyQC
         kK2X9rne9CW70DaulTzs/Z1N84u1Aws+yz2rt8loC/0r7cx/D7nO3WLRbk+23yQOylB2
         OpcbiCv8195fuAKgW+OBhshC4xOpenFdIh11tDYFV9QO+khsJQliy1FyVE1hrm6o+d6A
         KmDRGtB655OyEFm6VBzBmYIrD6WLd/IBjQr+Np9tzNVvw0uLpH0TZDwJiT2GblRlmTdV
         bqzbuKoTCZU4V2fVX2Kw0LCCOGoBRkDXeJF561LZ/aGoI7MztZ+AKjdOcjVBiHuZBHRh
         j7ug==
X-Gm-Message-State: AOAM533Vlo8w7ldwYIYsF+rq35VCa3SVBtyJhYCHbJgeeIfCvtK5EPPc
        RJXezLN3S4V0//TXJiQUVMVmQo6hLm+7RLgTjx4i
X-Google-Smtp-Source: ABdhPJxju8kR43yEDBDGQj/pr7f6xBNBvAklXH+iF7Vnxl/SDis6Bwh8preUc40IJfplUuRIPyCeJggoZvlMh2CCBx0=
X-Received: by 2002:a05:6402:1a4d:: with SMTP id bf13mr39139436edb.101.1637420709675;
 Sat, 20 Nov 2021 07:05:09 -0800 (PST)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <20211119232305.GA32613@mail.hallyn.com> <aeb3a040-b1b2-f6dc-6744-4e9d1979e351@canonical.com>
In-Reply-To: <aeb3a040-b1b2-f6dc-6744-4e9d1979e351@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Nov 2021 10:04:58 -0500
Message-ID: <CAHC9VhSoJZdTgBaXxAT+5=xi1HD_B4gSKVjx2ZQL56qOvRBagw@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 19, 2021 at 6:59 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 11/19/21 3:23 PM, Serge E. Hallyn wrote:
> > On Fri, Nov 19, 2021 at 05:52:33PM -0500, Paul Moore wrote:
> >> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>
> >>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
> >>> callers to specify a task even though the hook is only safe when the
> >>> current task is referenced.  Fix this by removing the task_struct
> >>> argument to the hook, requiring LSM implementations to use the
> >>> current task.  While we are changing the hook declaration we also
> >>> rename the function to security_current_getsecid_subj() in an effort
> >>> to reinforce that the hook captures the subjective credentials of the
> >>> current task and not an arbitrary task on the system.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Makes perfect sense given the motivation of 4ebd7651b  :)
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > Oh, actually, one question below (cc:ing John explicitly)
> >
>
> << snip >>
>
> >>> -static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
> >>> +static void apparmor_current_getsecid_subj(u32 *secid)
> >>> +{
> >>> +       struct aa_label *label = aa_get_task_label(current);
> >
> > Should you use aa_get_current_label() here instead?
> >
>
> yes, that would be better

Will do, thanks guys.

-- 
paul moore
www.paul-moore.com
