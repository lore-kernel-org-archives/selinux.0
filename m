Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB9C433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EB464ECF
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBJRcP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhBJRbx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 12:31:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833BC0613D6
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 09:31:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lg21so5619047ejb.3
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 09:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5okXJGdhCni/rS8k7SUNOaMDUW+bktNEWwy+e3hLzDI=;
        b=cGJSgMjbDRG5IEjpuF0lQ3Xm4DwtA9n23sFs3l5d10QUXw6cOjUIB2edhsIO1PRa3o
         fGY6a3E8QN+Um+W4nL1BPzeRcCvpaZtFnDaDCAW8vbWRZCbqBcHtiqb3a452hyrbPv1Y
         wBA4U4iwFCag5fOV85KBgFu1PQxBIjoRBF4GlZbPfL8II3C8OoiSBFdvvSn77E6Z1TmS
         tolj7wjOc4UGQneQqzWe9Myy0tbpdXHT3K9GvqP/jz46rOZta3kB5+0OVeisGoaKCv8v
         nkgc+A2L68Ui58BZVwW6+WPOGVvXgKoDL8qOXIQk8pcmJcXt57SSHa4at/UAYg8y166i
         hVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5okXJGdhCni/rS8k7SUNOaMDUW+bktNEWwy+e3hLzDI=;
        b=onvB9ziy2O8+InrCRmLftjMbB++eckWpPZsluyqGv/SNo+iadr6d3S712yCAd7rkjx
         CYAwriKs79MZPUtFGbgnZBmx2GxIvwoim9i8hot2p88y35UgFiVThXs42TyGJmvApu7l
         wCmKmIF3UU11/t8ndCO90ea1+GsIs1hjB63o3LnOmQYzv6tYuzjsO1b4e0tYY4IqvZYk
         +rZuXNUCBeuU6ouAtrgmo7HVgl6HG57mHa+CaWOv6rIXEWp3OD3vbkjbe2z78sDZZjEA
         2qMbWFrir5fYFwqzSUEdy7pyj53maEFlEOtp9vAM5T/1fl+OpZN6WxK2wEsYeKhLDTUl
         0iaw==
X-Gm-Message-State: AOAM5319Q2ka/TwGEvnKJ48xUEgYi+7yzZqES/G11FbL+/sdcKzRMXYP
        rdpBK2z1CHybWDejW+dBS7tKWUlblAm2FDRqeUZ1p2AxDKPX
X-Google-Smtp-Source: ABdhPJxU5rSfPY4f4RBOKsRdAM95zSxy1T+ayYmYRlVnpcrUnsUs3mNPTU7DamLMS9QlIgg4jaPnozFMOiTWOJ5jVcA=
X-Received: by 2002:a17:906:f6c7:: with SMTP id jo7mr4166017ejb.178.1612978271667;
 Wed, 10 Feb 2021 09:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20210208112736.247195-1-omosnace@redhat.com> <CAHC9VhTN+2kTxXvu2JtDGM1mATVT6PoBWojE=-xDMz1Mer85Lg@mail.gmail.com>
 <CAFqZXNuywOQfY4P=SFpB1szGf0x84S++2ArB_qGD2_8S1W2AfA@mail.gmail.com>
In-Reply-To: <CAFqZXNuywOQfY4P=SFpB1szGf0x84S++2ArB_qGD2_8S1W2AfA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Feb 2021 12:31:00 -0500
Message-ID: <CAHC9VhTFYQDXw2ZT5yNRVAPDbU2_HGMzELEVxwPgzcV+in5+1A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix variable scope issue in live sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 10, 2021 at 9:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Feb 9, 2021 at 3:20 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Feb 8, 2021 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> > > selinuxfs") moved the selinux_policy_commit() call out of
> > > security_load_policy() into sel_write_load(), which caused a subtle yet
> > > rather serious bug.
> > >
> > > The problem is that security_load_policy() passes a reference to the
> > > convert_params local variable to sidtab_convert(), which stores it in
> > > the sidtab, where it may be accessed until the policy is swapped over
> > > and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> > > called directly from security_load_policy(), so the convert_params
> > > pointer remained valid all the way until the old sidtab was destroyed,
> > > but now that's no longer the case and calls to sidtab_context_to_sid()
> > > on the old sidtab after security_load_policy() returns may cause invalid
> > > memory accesses.
> > >
> > > This can be easily triggered using the stress test from commit
> > > ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > > performance"):
> > > ```
> > > function rand_cat() {
> > >         echo $(( $RANDOM % 1024 ))
> > > }
> > >
> > > function do_work() {
> > >         while true; do
> > >                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> > >                         >/sys/fs/selinux/context 2>/dev/null || true
> > >         done
> > > }
> > >
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > >
> > > while load_policy; do echo -n .; sleep 0.1; done
> > >
> > > kill %1
> > > kill %2
> > > kill %3
> > > ```
> > >
> > > There are several ways to fix this:
> > > 1. Move the sidtab convert parameters to struct selinux_policy.
> > >    Pros:
> > >      * simple change
> > >    Cons:
> > >      * added fields not used during most of the object's lifetime
> > > 2. Move the sidtab convert params to sel_write_load().
> > >    Pros:
> > >      * (nothing specific)
> > >    Cons:
> > >      * layering violation, a lot of types would have to be exposed to
> > >        selinuxfs.c
> > > 3. Merge policy load functions back into one and call
> > >    sel_make_policy_nodes() as a callback.
> > >    Pros:
> > >      * results in simpler code
> > >    Cons:
> > >      * introduces an indirect call (not in hot path, so should be okay)
> > >
> > > I chose to implement option (3.), because IMHO it results in the least
> > > ugly code and has the least bad drawback.
> > >
> > > Note that this commit also fixes the minor issue of logging a
> > > MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> > > which case the new policy isn't actually loaded).
> > >
> > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/include/security.h |  10 +-
> > >  security/selinux/selinuxfs.c        |  18 +---
> > >  security/selinux/ss/services.c      | 159 ++++++++++++----------------
> > >  3 files changed, 78 insertions(+), 109 deletions(-)
> >
> > My concern is that this is something that should be backported to
> > -stable and I wonder if there is an easier way.
>
> This would need to go only into 5.10 (and 5.11 depending on the
> timing), so I think it should still apply cleanly. But there is
> additional value in having small patches for stable (less likelihood
> of mistake), so I'll try to revisit it...

Aiming for a simple solution first is generally a good first approach;
things almost always get more complex as they progress :)

> > Since the core issue
> > appears to be the scope/lifetime of the stdtab->convert field, and
> > since the ->convert field is a struct with only three pointers, why
> > not either embed a copy of the sidtab_convert_params struct in the
> > sidtab struct (net increase in two pointers),
>
> This has a hidden catch - also the convert_context_args would need to
> be embedded and that has pointers to policydb and selinux_state, which
> sidtab currently doesn't "know about" (i.e. it would slightly break
> the abstraction).

Fair point.

> > or do a memdup() (or
> > similar) into the sidtab->convert in sidtab_convert().  There would
> > need to be some minor additional work in the latter case, but I
> > imagine adding a kfree() to sidtab_cancel_convert() and calling
> > sidtab_cancel_convert() in selinux_policy_commit() should be the bulk
> > of the changes.
>
> This should be possible and relatively easy. I forgot to list it in
> the options - my only problem with that was the unnecessary dynamic
> allocation, but i concur that keeping the patch small is more
> important in this case. I'll try to do it this way in v2.

I'm not that worried about the allocation, in security_load_policy()
we're already allocating both a new policy and a new sidtab with
GFP_KERNEL so we are already looking at delays when under memory
pressure (which is okay in this case).  I view this as more desirable
than the approach taken in your first patch.

If we wanted to try and reduce our calls to kzalloc() we could always
allocate the new policy, sidtab, and convert_context_args structs in
one block via one kzalloc() call.  The drawback would be that we would
be allocating a bit more memory than we would need for normal usage
(the convert struct space would generally be wasted), and I guess
there might be an increased chance of the allocation taking the slow
path since the chunk would be larger.  Likely not worth pursuing
unless we see real memory problems in the future.

-- 
paul moore
www.paul-moore.com
