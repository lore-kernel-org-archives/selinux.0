Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E4C433E1
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18FA20734
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 14:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxM+Iu6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFQONB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQOM6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 10:12:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E70C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 07:12:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so3006269ljb.12
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAijIKIcf/PBQSSdVGg8w/9/60dGC4EvCeDWsNM9nTg=;
        b=ZxM+Iu6kMq+Eqe1X+jrXAgI5i0/NsevHCDXiqf1Wqg5QU4tQ28PY3cMZwa2/YiCJi0
         sMAXGfPSEgvcCVUQNQKL4cMKXN8PwSh8pBRAFfMDe6mcTexZcIjdJF+7AYnuCR/vUk8X
         aq+8RHcsKaieNIYojfJBFn20VD3qI480T8PKkKHaH2IJEAQAXxfvIbu+hAP5PhlUVfal
         Np1LvL6kAr5sJEQpaUONwV3BK0Hw3tUD0LaxGhjj4N3iY+huqnJ2f3F3A6Kyfqw06rIc
         9NT45jOqE3XoI7Zv2ewL8E7YGUxbVSblC7phpK1wdJ8qFCqRCu1uwb5KBJb841Rba6+8
         Wq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAijIKIcf/PBQSSdVGg8w/9/60dGC4EvCeDWsNM9nTg=;
        b=QOx9k0Z+pKDdqGAap5zR8K7lC7Ld8DLtVzqa+SWpILlzmyIB29fsmd6XcsVIZcvK9+
         ekbbcCTYLB7NmtnfAX7hsQ8nAcfDcm2u2LDB+lvjkG33DXs6P7qE8gQ1w5ckAbDsCA//
         VdAeuIpJHrvbK0sU2zKg7t9iOc/2iyDPhfHjj1uDgOiq72TgYCCW62XzA+FNJPET6vUA
         CBkjRURiuhWN+bh+Bx4MOIb5T/gXxdduzRTQLa9uY3zYDEVJiNMvLbPnYxtp/UL3omis
         ojo110sOodvMk2zEsgsmGapIZQavRC6IK6vKAJ4sdZQPSJolT5m2umW8e6+p1xkh+V/6
         sCdA==
X-Gm-Message-State: AOAM5300SC9vc3w0mbJxxrXgvQV1B16tQQbQ+ilwH5U2LRyqZS1HdtIi
        t425zpDFZ6+hayob6LmjZyQNR+XFjplPc9XD6Sj7Gg==
X-Google-Smtp-Source: ABdhPJzOsJYaqWmSGOdI4uWjdQ+qQfiwPfOPGMxK9n3EqUt0v0mMyrb3LQahOtHf65Bu6qb22p3tsASGXCoVtDosu3M=
X-Received: by 2002:a2e:9786:: with SMTP id y6mr4044416lji.398.1592403175003;
 Wed, 17 Jun 2020 07:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
 <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com> <CAEjxPJ7rygAQjqYBiYHRw__cJjO4mJdV_7K38aG=i19s2_-FNg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7rygAQjqYBiYHRw__cJjO4mJdV_7K38aG=i19s2_-FNg@mail.gmail.com>
From:   Dac Override <dac.override@gmail.com>
Date:   Wed, 17 Jun 2020 16:12:43 +0200
Message-ID: <CAJVWAV2x42n-5TJa+v=KkETao2jvL3qMPD9PKm9HzKXaGi6V0w@mail.gmail.com>
Subject: Re: Minimal CIL policy requires process class with transition permission
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     bauen1 <j2468h@googlemail.com>, selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 3:36 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 9:24 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2020 at 7:10 AM bauen1 <j2468h@googlemail.com> wrote:
> > >
> > > Hello,
> > >
> > > I've recently started playing with CIL and for various reasons I wanted
> > > to start with the smallest possible policy.
> > >
> > > After having some issues with a tiny CIL policy that compiles but does
> > > not actually load, I tracked it down to a hard requirement (of the
> > > kernel ?) on the permission `transition` of the `process` class.
> > > Is there a reason for this or is this a bug ?
> >
> > Yes, the kernel security server depends on at least this class and
> > permission being defined in policy for some of its internal logic;
> > otherwise you will get some rather odd behavior.  I suppose we could
> > make the kernel handle it more gracefully, or change libsepol to catch
> > this and flag it as an error when writing a policy with the target
> > platform set to Linux (it wouldn't be an error when writing a Xen
> > policy, for example).
>
> By the way, there is a program in the kernel source tree, under
> scripts/selinux/mdp, that will generate a fairly minimalist policy for
> that kernel with all of its classes/permissions defined, a single
> user/role/type, fs_use and genfscon rules for all filesystem types
> configured, and allow rules allowing everything.  See
> Documentation/admin-guide/LSM/SELinux.rst.  That however generates
> policy.conf not CIL currently although adding support for generating
> CIL is an open issue in GitHub,
> https://github.com/SELinuxProject/selinux-kernel/issues/45

Speaking for myself here. I want to be able to clarify as much as
possible, without having to resort to: "this is added because of some
kernel internal", because those aspects distract when you try to learn
how to write a policy from scratch. Things tend to stick better when
you understand their purpose.

The situation is improving though. I don't think we were able to write
a policy by just being aware of this "process transition" internal in
the recent past. The lifting of the classordering make it possible to
start with just "process transition" and then get all the classes and
perms from dmesg as you go without having to be aware of all the
classes and perms needed (let alone any ordering as now you can just
all unorder it)

Another path in this picture is the ability to omit unused isids, It
just does not help trying to explain "were just adding these sids and
sidcons due to some kernel internals" Now we can just stick to used
sidcons and explain why they are needed.

So aside from the "process transition" secret sauce, I think the only
other aspect that might be hard to explain are the sidorder and the
need for sidorder.

But other than the above now writing a policy from scratch is just
easier. Thanks for that.
