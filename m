Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C5AC433E1
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 00:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71ACA207F5
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 00:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hQjpoWbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgGaAK5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgGaAKz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 20:10:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504CC061574
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 17:10:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c15so11544116edj.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 17:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/c3Gqo/VuJH9Te0wfR5KkQ1b5tqi4LaEcIsr2+aGts=;
        b=hQjpoWbKwSo962FBXzbf+uLdnaYYgz1qvwyi3z5gClS4E7Hix1ZIjw5dgXFgB+UUtc
         17ydKnguUlQT4R/LS1zo87E3kYuexH0qJK4hcNgMcqJCYUE/rb/Z+Cqsg26dNJDE7wAj
         GR+ijAxI1YBW4gMD2Vn6sNKd0ODKz9T+7jjU5sfNgxDDDD7i39khYM2g+20PKdxrgM3w
         5TH7PPr1KhUxOQUKZDUt/VC5iWIP2MKNB2hRBIRvimwHFCi6sYHPbWXkN9upRfRTK+74
         yxlEongyoivcPjpM1YWDjkLV4xj+RBWyYmc0zIr99J/jj1u/jl6zAMGtR1cH1PHs021L
         5kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/c3Gqo/VuJH9Te0wfR5KkQ1b5tqi4LaEcIsr2+aGts=;
        b=MJRM12HSvpHRsKY31sDnpVyD/f4Y1st6smt6VMNfFaCpkcZqpmLRDwyP3HUL/Wcb1m
         DmQypSvdK4WSDNTudHDcGyS1iwV2y0iVUBnj2Hk1Iyb9bMnF4L5j3LitzhPsy9Yt61Nr
         gW6rQB1JJR0zPypKS2jXGvgJiXhzCvptLNLQmQdp+4wx2EYDjhJywcBfuBVue52EI2z7
         BPzcyOvMc1FFbXVmmoONc/NiHIwkIFZvf91dPOeuJqCXgVqVBEwtnyTLOYnf9I8GgleC
         NH+B9XPJgLasJgOWZmGz0d9SPWZH34keZ4xw7wJnXz3IFF+hLMRNEhBw5FhivnELooLP
         FM8A==
X-Gm-Message-State: AOAM532HNcGEWfNkrw/0fkg+n5AK9RtvMI3RrbJpUARgzlnglfN/Ihuw
        DMgFCUBji3xklZC+GCrNdy2AqdNK11FuClZdKe+W
X-Google-Smtp-Source: ABdhPJxYlzswlbkTtbLywWhycYMa8wEO2lmR94+HhAXQarqDQyRUmGuTFgj1dwwvBunVNDl2dJRiEHm8JV/TMU6PN2A=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr1435586eds.196.1596154252877;
 Thu, 30 Jul 2020 17:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200730220905.60088-1-stephen.smalley.work@gmail.com> <208642b5-b046-a26f-09d1-9e05377cefe7@gmail.com>
In-Reply-To: <208642b5-b046-a26f-09d1-9e05377cefe7@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jul 2020 20:10:41 -0400
Message-ID: <CAHC9VhTZxW8EnZ+tUQyDWkcJjcKjtCD07aUWZ8qZ71rX1K71jA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: encapsulate policy state, refactor policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 30, 2020 at 6:33 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 7/30/20 6:09 PM, Stephen Smalley wrote:
>
> > Encapsulate the policy state in its own structure (struct
> > selinux_policy) that is separately allocated but referenced from the
> > selinux_ss structure.  The policy state includes the SID table
> > (particularly the context structures), the policy database, and the
> > mapping between the kernel classes/permissions and the policy values.
> > Refactor the security server portion of the policy load logic to
> > cleanly separate loading of the new structures from committing the new
> > policy.  Unify the initial policy load and reload code paths as much
> > as possible, avoiding duplicated code.  Make sure we are taking the
> > policy read-lock prior to any dereferencing of the policy.  Move the
> > copying of the policy capability booleans into the state structure
> > outside of the policy write-lock because they are separate from the
> > policy and are read outside of any policy lock; possibly they should
> > be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
> >
> > These changes simplify the policy loading logic, reduce the size of
> > the critical section while holding the policy write-lock, and should
> > facilitate future changes to e.g. refactor the entire policy reload
> > logic including the selinuxfs code to make the updating of the policy
> > and the selinuxfs directory tree atomic and/or to convert the policy
> > read-write lock to RCU.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
>
> > @@ -2098,10 +2104,12 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
> >
> >   static void security_load_policycaps(struct selinux_state *state)
> >   {
> > -     struct policydb *p = &state->ss->policydb;
> > +     struct policydb *p = &state->ss->policy->policydb;
> >       unsigned int i;
> >       struct ebitmap_node *node;
> >
> > +     read_lock(&state->ss->policy_rwlock);
> > +
>
> Oops, should have moved the dereferencing of policy after taking the
> read-lock here; fixed it everywhere else I think but missed this one.
> Will fix in the next version but will wait for other comments on this
> version.

While I haven't looked at this patch in detail, I'm generally in favor
of cleanups and the encapsulation work has generally been a good thing
in my opinion.  It also should go without saying that fixing, or
improving, the atomic load issue would be a very good thing.

> > @@ -2132,112 +2200,58 @@ static int security_preserve_bools(struct selinux_state *state,
> >    */
> >   int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >   {
> <snip>
> >       /*
> >        * Convert the internal representations of contexts
> >        * in the new SID table.
> >        */
> >       args.state = state;
> > -     args.oldp = policydb;
> > -     args.newp = newpolicydb;
> > +     args.oldp = &state->ss->policy->policydb;
> > +     args.newp = &newpolicy->policydb;
> >
> >       convert_params.func = convert_context;
> >       convert_params.args = &args;
> > -     convert_params.target = newsidtab;
> > +     convert_params.target = &newpolicy->sidtab;
> >
> > -     rc = sidtab_convert(oldsidtab, &convert_params);
> > +     rc = sidtab_convert(&state->ss->policy->sidtab, &convert_params);
>
> Should sidtab_convert() be called while holding policy read-lock since
> we are passing state->ss->policy->policydb via the args field of
> convert_params and using it within the callback?  I think it happens to
> be safe currently by virtue of the fact that nothing else can write to
> it since selinuxfs is holding its semaphore during the entire policy
> reload but it seems inconsistent. However, if we do take policy
> read-lock across the call, then sidtab_convert() needs to use GFP_ATOMIC
> allocations instead of GFP_KERNEL.

Without looking too closely at the call chains, or the allocation
sizes, I would vote for taking the lock in the name of consistency.

-- 
paul moore
www.paul-moore.com
