Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33738C433DF
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B3206B2
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 01:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rGgllMmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgHLBvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLBvA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 21:51:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35757C06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 18:50:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so480029ejb.11
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqEdxH//Jgv4KJnwoKDdCxh5vDuRqxe1VGG8tALjNBg=;
        b=rGgllMmvVOVW6Etf2yMJbb1ePq8Xht+rlD9c0eLJpIsH7JWIk2VlvOBrSnIze0L3B6
         unggwruEYv0GJrwg3CcdtukRbE7Y9Z+i6kzh7JU4wQ7Y8i9Eh+aFIWMPpLR9TQ+C4+1k
         oxhYjBa+4veAlCH7xQZAVZpQ7XMB2OgsO/168LUHH34RoMlEB7EnoY3LX1OqEK40td92
         cmdFCx0Dr6DKGiUZtuCwDPKWVW/xVJpOCUJ6vg1OeYWu7VAwjJOz7CIXl7c55muGAwpF
         pjItzQmuQjp0dKU+hb+JSHAQI2ca5X47i1C4hCvd5Ii270+kEvfoRMmtlHcbJqb1Vb1X
         WqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqEdxH//Jgv4KJnwoKDdCxh5vDuRqxe1VGG8tALjNBg=;
        b=t2ENhCqtvTGQeESdn+3VReuEEfPpcdN34VaqqzZt7N0RpaQfJG+JZixRZfonDty8hL
         sbgpW9zXMkxhk4QY/JcDe3X7eGl9t+8OeoBMku4DbV+BNA9aSccxQfAvGxmbj9o1J5WK
         H3DkDFGnF2ozCC4TRrBTzAwpTZTH1OJ6KnTsx+QcqwOvUS8893SmmPdNPTePUgJSEBfw
         DiSskHpE0s69vgVa83wg++ZIVsdiGlgxz1BcVSCOKIolKjRhrEkYWqId9pSuqk2FMPkg
         p+xU3OopyOsxEMrefZOzSN4UCUkM1pl3QOXnJBxr0JFrn75J8xuNsF0QN3COKsHY6uTT
         HwdQ==
X-Gm-Message-State: AOAM531UbhN5IjVnhAWH2UTiTUxqZaCH6OS6P0vXkKpGevTTFBdpWFVG
        f4BeIqHtn866LDz1NtdX+Ewley+LuaeJa0Ctc+lk
X-Google-Smtp-Source: ABdhPJzsYHAlHBb2CVa7ekdoDFo8bWuH4r284XVfnHxU+axKhKa5aYvTbGkPMJkBgZd30KRVy9cgePxY6Upj6D1qUBM=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr28762825ejn.542.1597197057842;
 Tue, 11 Aug 2020 18:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com> <39643c6a-c32e-8cd3-ba34-ac37155c314a@gmail.com>
In-Reply-To: <39643c6a-c32e-8cd3-ba34-ac37155c314a@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Aug 2020 21:50:46 -0400
Message-ID: <CAHC9VhQUQDeEZ-3JwQE_UbeQFxVvwx3kxSgjxaTc3TJ=egPKCw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] selinux: encapsulate policy state, refactor
 policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 8:20 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 8/6/20 11:41 PM, Paul Moore wrote:
>
> > On Wed, Aug 5, 2020 at 11:52 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> Encapsulate the policy state in its own structure (struct
> >> selinux_policy) that is separately allocated but referenced from the
> >> selinux_ss structure.  The policy state includes the SID table
> >> (particularly the context structures), the policy database, and the
> >> mapping between the kernel classes/permissions and the policy values.
> >> Refactor the security server portion of the policy load logic to
> >> cleanly separate loading of the new structures from committing the new
> >> policy.  Unify the initial policy load and reload code paths as much
> >> as possible, avoiding duplicated code.  Make sure we are taking the
> >> policy read-lock prior to any dereferencing of the policy.  Move the
> >> copying of the policy capability booleans into the state structure
> >> outside of the policy write-lock because they are separate from the
> >> policy and are read outside of any policy lock; possibly they should
> >> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
> >> Restore the load mutex that was previously removed by
> >> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy")
> >> to make explicit the exclusion even though it is currently redundant
> >> with the fsi->mutex held by selinuxfs; this makes clear that we do
> >> not need to take the policy read-lock across sidtab_convert() and will
> >> be useful in the future for lockdep checking.
> >>
> >> These changes simplify the policy loading logic, reduce the size of
> >> the critical section while holding the policy write-lock, and should
> >> facilitate future changes to e.g. refactor the entire policy reload
> >> logic including the selinuxfs code to make the updating of the policy
> >> and the selinuxfs directory tree atomic and/or to convert the policy
> >> read-write lock to RCU.
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> ---
> >> v4 does not take the policy read-lock across sidtab_convert() and
> >> therefore does not require changing allocations by it to be atomic
> >> or dropping the cond_resched() call.  To make obvious that taking
> >> the policy read-lock is not necessary in security_load_policy(), restore
> >> the load mutex to security_load_policy() that was removed back in
> >> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy").
> >> However, since we have refactored security_load_policy() in this change
> >> to split out selinux_policy_commit(), we need to take the mutex in
> >> security_load_policy() and release it in selinux_policy_commit().
> > I'm not in love with the idea of splitting the lock/unlock across
> > different functions, more below in the relevant code section.
>
>
> Me either, but I see no alternative other than taking/releasing the
> mutex in selinuxfs, at which point it is truly no different than
> fsi->mutex.
>
> > I can somewhat understand if you don't want to have all the old policy
> > cleanup, reset, and notify code in security_load_policy(), but I
> > really dislike that the mutex lock/unlock is split across the two
> > functions.
> >
> > What if selinux_policy_commit() returned oldpolicy on success and we
> > created a new function, selinux_policy_retire() (name?), that would be
> > called from security_load_policy and could handle the cleanup, reset,
> > and notify code.  The mutex unlock could happen between the calls to
> > selinux_policy_commit() and selinux_policy_retire()?
> >
> > I'm open to other ideas as well.
> >
> I think if you look at the 2nd patch, you'll see that this won't work
> because security_load_policy() is then changed to return newpolicy to
> the caller, and selinuxfs then calls selinux_commit_policy() after
> updating selinuxfs.  In order to provide the full exclusion guarantee,
> we need the mutex held across both security_load_policy() and
> selinux_commit_policy(). At that point we'd have to take the mutex
> lock/unlock up to selinuxfs and we already have fsi->mutex there.  This
> load_mutex was just to document the exclusion guarantee at the
> security/ss/services.c level and provide something we could pass to
> lockdep for safety checking when/if we convert to RCU.  If you really
> don't like it (and I'm not super excited about it myself), then I think
> I'll just put a comment in security_load_policy() explaining why we
> don't need to take policy read-lock there and drop load_mutex.  Thoughts?

I think this is a case where the separation of the security server
from the Linux integration code is not doing us any favors.

While not taking a policy lock does seem a bit awkward here, I agree
that given the way the code is structured we are pretty much stuck
with doing the locking in the selinuxfs code ... which it appears is
what you've done in v5.  I'm dealing with limited network access at
the moment, and the merge window is still open, so I'll defer a proper
review of v5 until after the merge window closes but if the mutex
removal is the only significant change I don't suspect there will be
any significant comments.

-- 
paul moore
www.paul-moore.com
