Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA83DC433DB
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8CF64E83
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhB1Sxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhB1Sxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 13:53:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D24C061788
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 10:53:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lr13so24106828ejb.8
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwQREwvjXQq2EK9+9WS/oLnljsLOZdBWLryisGeWHrE=;
        b=aFKCgHh7eIYYNYL3+ImdSfygjPjBylz+UiAaRS9+Tx4qhnXk+knwsfxOETxh5uOLVH
         buVbDc48o+D2tEzUJkbR1eQmvkm6M556v3zrUBNpNMhrNWV0XS5qIuPTiMOzQ8GZ9SNH
         w0NLPeDGM2RWqR8DqbAtqwR690kwaEKb1kFsKD7yNU4T5HNTAoG23KHW1uYNaXrmbmDI
         wlPxzwdQ7+D0lCGzTbbUexPNkxzdl5wOFPPSOyIMA//0FyXR4vcsuvRReetH0Wmrfv5Q
         9ScnSgt45wqVUSvoU47uGuTmFXNyRVoF8VS+rNVrSY4sw0FYFys+MXUNdjfX3yhyE6gM
         3fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwQREwvjXQq2EK9+9WS/oLnljsLOZdBWLryisGeWHrE=;
        b=R3to+MieoMHPUlvlzaffRrHH3ob1+6n23yX0FRF2m5pTGAiiLmjLXPP1qsxpNl4l3u
         SHdKjmjHtksN1zjyJFV+/8W+VH45WrqYAu+A+1qojpOpGIy76LmH4hyKmUe53P9RpTri
         6PoxiodsPsJu8cqBq5lyJyy3Boneu7cM9vJMCYIBKG2uvKEpBcd38hyP846wIJB4lj+1
         taVdjYBlG+BahbpPHi33XYPFBHXjQvGmYhWc0LH4DiiVEg9FtE2B6rpk4fOY79pF4u/v
         O6U+QDCgg3F7dKcJRgHlfJiiygSUjfRiys5iFXwrMvf4YbqnXzYSOgvmT1AnzJKT8ue5
         WQnw==
X-Gm-Message-State: AOAM533pWAXdtWjuFmjVC5s14ljwTkD+NGl9gRnxBR/hB75jAOnwCwUV
        DKQA+oKir5xx6u6ao4a6NmZ+H+knxZcMCXcll5BA
X-Google-Smtp-Source: ABdhPJwbelUHTGs4DOgyyVITJExzti+cZ8g9AAgeK0av8RmBgF3ePhWVBlhf7B1/ZMTtXojBVT03OBPlNhyKJgMvixc=
X-Received: by 2002:a17:907:3e14:: with SMTP id hp20mr12899204ejc.106.1614538383282;
 Sun, 28 Feb 2021 10:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-2-omosnace@redhat.com>
 <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com> <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
In-Reply-To: <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 28 Feb 2021 13:52:52 -0500
Message-ID: <CAHC9VhSzDVyipy2y8ONiR_Q0YG50FnCJxgHsoi9Nee09hN0WCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 26, 2021 at 9:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Feb 25, 2021 at 7:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
> > > as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
> > > even though the policy hasn't actually been reloaded. The 'out1' jump
> > > label now becomes unused and can be removed.
> > >
> > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/selinuxfs.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > > index 01a7d50ed39b..340711e3dc9a 100644
> > > --- a/security/selinux/selinuxfs.c
> > > +++ b/security/selinux/selinuxfs.c
> > > @@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
> > >         length = sel_make_policy_nodes(fsi, newpolicy);
> > >         if (length) {
> > >                 selinux_policy_cancel(fsi->state, newpolicy);
> > > -               goto out1;
> > > +               goto out;
> >
> > This looks good, especially with AUDIT_MAC_POLICY_LOAD recording
> > "res=1".  However, now that I'm looking at the error path here, we
> > don't display anything if sel_make_policy_nodes() fails, do we?  If
> > security_load_policy fails we at least do a printk(), but if this
> > fails it silently kills the policy load; at the very least I think we
> > want a `pr_warn_ratelimited("SELinux: failed to load policy due to
> > selinuxfs failures")` or something similar.
>
> There are error messages in some error paths in
> sel_make_policy_nodes(), but not all. Those are pr_err()s, while in
> sel_write_load() there is a pr_warn_ratelimited(). Could we just unify
> the sel_make_policy_nodes() failure to a single message? (I don't
> think the information on which part has failed is very useful as the
> most likely cause here is a memory allocation failure, not bad
> policy.) If so, should it be a pr_warn() or pr_err()? Ratelimited or
> not?

My personal opinion is that the kernel only needs to provide the error
details to userspace which can be useful in determining what wrong,
and how the user can fix it.  For example, if there is a memory
allocation failure in the kernel there is often little the user can do
(and it is often transient anyway due to loading and other factors),
so simply reporting that there was an allocation failure while
attempting X is sufficient.

Beyond that, I think things can get a little fuzzy, e.g. pr_warn() or
pr_err?  Ratelimit or always emit the message?  I also think the
answers can change as userspace behaviors change over time.  If one of
the policy load error paths uses a pr_err() then we should probably
stick with that; it also seems appropriate as failing to (re)load a
SELinux policy *is* a serious matter.  As far as the rate limiting is
concerned, I'm not sure if that is an important difference here; if
the system is getting enough requests to reload the policy, and
repeatedly failing, such that the ratelimiting matters there are
likely other, much larger, issues at play on the system.

-- 
paul moore
www.paul-moore.com
