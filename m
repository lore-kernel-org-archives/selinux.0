Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C7C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiIHTcr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiIHTcp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 15:32:45 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A8C22AF
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 12:32:44 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso3112986ooo.12
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oz+xWV2Ha3/Bioj8A/jew3c5IOrm/IjPXTsz/FZ84pw=;
        b=Z5tFiwrF4iPkfUHabtdsjes2kgG60WmvA0YDoccY7M+P4OhqXtUDNu7pA/SNhCMOIi
         5VlhQH8YSOT6CnnUbu8OhmlrhKAdr826mykiPO9bvoSDkgp/we9I4jgfmTtNVZbh8SjI
         +OTKj3+vTKm1RupkLrRFvqcQV34yR+6DDB60h7pNQF7jV0ZnjMPBRAddV5HVWCyfJmcG
         6XUorjVb2LdSxNWJiX+cshm8bzmjmacaBkAA1fniyjQg3ebpyWh7vnPapIkCRpXoUmT7
         rk3HoVlJ2NiZ+mLUhFhN/rBhfFXc3w9cTdYUMJuYFQrO9ZjHXXAOXgSjisyads33DfSg
         MbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oz+xWV2Ha3/Bioj8A/jew3c5IOrm/IjPXTsz/FZ84pw=;
        b=wfw4GesfPRqfennIVIKJRjK+DbY6+fJEDR4GcL49ZNphKCSp4MkOrzBn7w+GpyD0y3
         N9J6hDgoRQ52lU4dNOZ5CcyNH4T6inwkOYHshhdrOf2iSypFCEbLyrxqiCPxH9sfVexq
         keqzQ7hpviWqYzw1gpWeGdPXXTLbZ6V0xGIQggsWhyHBNy3oG+qx1v391U9qOXlV5b0v
         0nzuvnW7pPP4eIVTZdlZCSXeBhWyW73eei1SWZ/2na6ktjCCN44LE3zpHitdC8dsMaVt
         57h2eWiQogHcwO0K76P7APuSClvJxlRiIFDKGVZhLy7gNHoxlQVxshIJSsQIpEQffaLA
         KQeg==
X-Gm-Message-State: ACgBeo3GeFJ0RTfBzFxh9zw5kBPZzHxldwaQJ2pyRLwFMNSpy7iv9pb1
        /aOzBKNfMRUfl4Vxgu0QxHjMi9SV3lq9fjF7xcTD
X-Google-Smtp-Source: AA6agR6BC6nRGcz3GZmGJYopvwo4LF7o/rx+rccli/unq08GAsfiSc0uTJJvM+7cQkyNPbS0wnm6D7384DRpoMEHaKI=
X-Received: by 2002:a05:6820:508:b0:44a:abd8:6d59 with SMTP id
 m8-20020a056820050800b0044aabd86d59mr3624743ooj.11.1662665563850; Thu, 08 Sep
 2022 12:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
In-Reply-To: <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 15:32:32 -0400
Message-ID: <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 2:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/7/2022 8:57 PM, Paul Moore wrote:
> > On Wed, Sep 7, 2022 at 7:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/7/2022 4:27 PM, Paul Moore wrote:

...

> >>>   The ease-of-use quality is a bit subjective, but it does need
> >>> another interface to use properly and it requires string parsing which
> >>> history has shown to be an issue time and time again (although it is
> >>> relatively simple here).
> >> There was a lot of discussion regarding that. My proposed
> >> apparmor="unconfined",smack="User" format was panned for those same reasons.
> >> The nil byte format has been used elsewhere and suggested for that reason.
> > Based on what I recall from those discussions, it was my impression
> > the nil byte label delimiter was suggested simply because no one was
> > entertaining the idea of using something other than the existing
> > procfs interface.  It is my opinion that we've taken that interface
> > about as far as it can go, and while it needs to stay intact for
> > compatibility reasons, the LSM stacking functionality should move to a
> > different API that is better suited for it.
>
> It's going to raise its ugly head again with SO_PEERCONTEXT for the
> SELinux+Smack case. But we can cross that bridge when we come to it.

There are also problems with IP_PASSSEC/SCM_SECURITY that we've never
fully resolved (and have gotten a bit lucky over the years); it very
well could be time to add support for IP_SECURITY as the multi-LSM
replacement for SCM_SECURITY.  We could leverage the same LSM context
structures as in the other multi-LSM interfaces.  Existing
applications could continue to use SCM_SECURITY; in fact I believe we
could have both SCM_SECURITY and IP_SECURITY in the same message for
maximum compatibility.

https://github.com/SELinuxProject/selinux-kernel/issues/24

For SO_PEERSEC, we should probably just introduce SO_PEERSEC2 or
similar, using the same multi-LSM context structures as the other
interfaces.

> > In case it helps spur your imagination, here is a revised strawman:
> >
> > /**
> >  * struct lsm_ctx - LSM context
> >  * @id: the LSM id number, see LSM_ID_XXX
>
> A LSM ID hard coded in a kernel header makes it harder to develop new
> security modules.

There is so much precedence for defining a token scalar value to
represent a "thing" that I don't know where to begin.  Look at IANA,
there are entire organizations that exist to map "things" to numbers.

If you're objecting to assigning LSMs fixed integer numbers you've got
to give me some very explicit reasons (complete with examples) as to
why that would be a mistake.

> The security module can't be self contained. I say
> that, but I acknowledge that I've done the same kind of thing with the
> definition of the struct lsmblob. That isn't part of an external API
> however.

I'm not following you here.  See my comment above about better examples.

> It may also interfere with Tetsuo's long standing request that
> we don't do things that prevent the possibility of loadable security
> modules at some point in the future.

I already replied to Tetsuo's email, and while this particular point
about LSM ID numbers wasn't directly addressed, my response there
seems to apply equally well here: it's not so much about loadable
LSMs, it's about out-of-tree LSMs.  These are two very different
things, with different solutions.

> On the other hand, there's no great way to include two variable length
> strings in a structure like this. So unless we adopt something as ugly
> as the nil byte scheme this is supposed to replace I expect we're stuck
> with an LSM ID.

I don't like making general comments, but when in doubt, consider me
not-a-fan of string-based identifiers in APIs.  Give me token scalar
values instead.

> >  * @flags: LSM specific flags, zero if unused
>
> For an API shouldn't this be a specific size? u32? I'm not really
> up to date on the guidance regarding which it should be.

Enh, sure, whatever.  You'll remember my initial comment about not
being a syscall stylist; if the discussion has moved to seriously
discussing the syscall prototypes we should likely start a new thread
and bring in the syscall folks ... I vaguely remember there was a
mailing list for syscalls and API changes ...

> I will head in this direction. A couple questions:
>
> Would we want lsm_prev_ctx() as well as lsm_current_ctx(),

I'm not sure I'm following your thinking, what would lsm_prev_ctx() do?

> or should we use the lsm_ctx->flags to identify the provided
> context? If we did that we should have an lsm_ctx() system call
> that returns the current, prev, and whatever other security
> module specific attributes might be associated with the process,
> each identified in the flags field. While the "current" context
> is usually what we're after, there may be cases where the other
> attributes are desired.

I don't understand what you mean by "prev"{ious} attributes.  I'm
thinking of lsm_current_ctx() as a multi-LSM replacement for
/proc/self/attr/current.  If, for example, we wanted something for
/proc/self/attr/exec I imagine we would create lsm_current_exec(), or
something similarly named, with a similar prototype.

Or perhaps we try to stick a bit closer to the procfs naming and go
with lsm_self_cur(...) and lsm_self_exec(...).  All things to discuss.

-- 
paul-moore.com
