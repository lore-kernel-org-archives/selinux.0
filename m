Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC860C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AE62078D
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u80xsY4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMR5K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMR5K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 13:57:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD6C061757
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 10:57:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v21so5494538otj.9
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OfOPi1w6JLKm8MHEoe5AjkMKff7jSfgtLZV6kyJPWs=;
        b=u80xsY4qDMKYsek95ujPeowwWIjxLH5XQygjiYyNI9SqU45wtjpgxtDJZRE6bfArNt
         5LxpWOoOe653LSi1li/8kOktt892x66SuICVeD4LLhgDAVLWy8qsgDb2JY6r9j185uGm
         jWGfP6ctg5SKSf5tGwPMwBHUKBrCkWqepFlgueRo8ibcr5jDYaCYMij24ndGFtwR3eb8
         Y2owRrn7P6MOCeZnxKARIdhb1RM7YEu6S/mGFSMZihZzhn6u3Smuq3/Gh/TpQPv7218H
         8pGMFahZrU8UN33A6IQHrd3ZGcQqDQA+lYetNKh9VYhEFXUNXo6hYKT1BtdyervQ/KpG
         bVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OfOPi1w6JLKm8MHEoe5AjkMKff7jSfgtLZV6kyJPWs=;
        b=P7vE+wJ5mENV6cwqTTEF6VFiX7akSl5WuC5kK/crCiYUEkGz3r0+Kv9jTPmPwJY3LR
         hpwZLWyYSrC6AKZXTpd9seKjIXfUj5ucLMiub6XxYZGGEOCjRtuSfQkA1c21J0+RcWob
         Hn0PHoNuGK4PUrPW2iEEBDUVGvfn5FO4lehgJkxn/LmsGsSWph2EGvp4okfesI5GJ81x
         7oabG3ZKG0qkAZOqBYWa7EHb5AbRiZ0Ux02IRk9aObJ+DmXQITtlTD+Eo7W61qAe31Pr
         cFlVo2jX/3MrHPiUt2Fd/JWkIZV5kwLMhkaxI9hHn3gULlknL7tadQazA0/ZrQdb+fZl
         4zwQ==
X-Gm-Message-State: AOAM530xM2lPGwM4/JsmPcXQgug3VdlQGK6W0n+sfsJGykUqPX0+gLGn
        CQQKxwo0PxbZ0+m6EBhkSSa+BoS0Vc2U2UQU8fg1rUrl
X-Google-Smtp-Source: ABdhPJwlZm0NUNhtlVFdTEpeNwQnVWeONkqbfyWYJNIA0ab4Xns7ZMsW1m/0AkJNAtlZxOmyaoge7z7cwiRM1P4EDLM=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr5495514otn.162.1597341428222;
 Thu, 13 Aug 2020 10:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
 <20200813174722.GA14310@localhost.localdomain>
In-Reply-To: <20200813174722.GA14310@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 13 Aug 2020 13:56:57 -0400
Message-ID: <CAEjxPJ6_V9Uo7XwY89WKX9NBp4ACd5Sn3m7pDf2n+hYH0QYkMw@mail.gmail.com>
Subject: Re: drop symbol versioning from libsepol and libsemanage?
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 13, 2020 at 1:47 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Fri, Aug 07, 2020 at 02:54:18PM -0400, Stephen Smalley wrote:
> > As noted in https://github.com/SELinuxProject/selinux/issues/245,
> > symbol versioning in libsepol causes problems for LTO.  libsepol and
> > libsemanage have a handful of versioned symbols due to incompatible
> > ABI changes made early in the CIL integration.  However, as far as I
> > can tell, these symbols were only used by other components of the
> > selinux userspace, not externally.  Should we stop supporting the old
> > versions going forward and simplify the maps? If so, does this truly
> > require bumping the .so version or can we omit that since there are no
> > external users?  Thoughts?
> >
>
> AFAIK libsemanage is used by some 3rd parties. We've had requests to ship
> libsemanage-devel in RHEL-8 repositories in order customers build their
> applications.
>
>
> From my packager POV I like symbol versioning - it helps to prevent some
> dependency issues in development branches, e.g. when libsemanage is built with
> new libsepol symbol but the new package doesn't require newer libsepol. rpm is
> able to solve that:
>
> $ rpm -q --requires libsemanage
> ...
> libselinux(x86-64) >= 3.1-2
> libselinux.so.1()(64bit)
> libselinux.so.1(LIBSELINUX_1.0)(64bit)
> libsepol.so.1()(64bit)
> libsepol.so.1(LIBSEPOL_1.0)(64bit)
> libsepol.so.1(LIBSEPOL_1.1)(64bit)
> libsepol.so.1(LIBSEPOL_3.0)(64bit)
> ...
>
> $ rpm -q --provides libsemanage
> config(libsemanage) = 3.1-2.fc33
> libsemanage = 3.1-2.fc33
> libsemanage(x86-64) = 3.1-2.fc33
> libsemanage.so.1()(64bit)
> libsemanage.so.1(LIBSEMANAGE_1.0)(64bit)
> libsemanage.so.1(LIBSEMANAGE_1.1)(64bit)
>
>
> LTO seems to cause problems to other projects as well
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/XMIQMN5KNAZUPX6O3LN6JJGTCZTP4B7J/
>
> So I'd prefer if we try to do and use symbol versioning correctly, but it's not
> hard requirement from my side.

Ok.  An alternative to dropping it altogether is just to try to fix
the particular problem he is seeing with the duplicated symbols in
LIBSEPOL_1_0 and LIBSEPOL_1_1.  If we can remove the duplicate without
breaking anything, then that might suffice for LTO.  I'm not actually
clear on whether it is correct - there are technically two different
versions of the symbol aliased via symver.  If the seeming duplicate
is required then I guess we just have to wait for LTO support to catch
up with symbol versioning.
