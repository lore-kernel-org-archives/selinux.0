Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8700C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCD821744
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL7R2Q8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgHGQjo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGQjn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 12:39:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30DCC061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 09:39:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x24so2088272otp.3
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jzKjJbLNRz3glu4Z4iEtTlnQuL9KwG41UMhj0530r4=;
        b=BL7R2Q8bzVG0TOe7+M5r2h0+Ts/e7raXhYhofAQLWzatCMrBQ/Ltet10sl5YgF0o9A
         hyD92yGgk7VjLfxF4SprAROqnySbhcnERGrEGng793inpq/qmuog6V0iICYDa/KPdyoF
         tv+O86kAml+fd+hsbYwFlvcoloEuHhPrqtLk92bDsVMnXPM7iul/SUz0WpiWFzvAnkz4
         Q132m8XJKYnIhn/Tx7dChcJBCGEJZK3kK3SqaQFQQF8ku0IXfx+5ulqyz4fNqqx2uwX0
         46Jjk+W+kuxP6OljNhYqV8C0LNHrUqHmgmo38XncH1p88vw12BnjqJUrs0/ONADPIIDj
         HS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jzKjJbLNRz3glu4Z4iEtTlnQuL9KwG41UMhj0530r4=;
        b=nCQLQzv6Z/Na21vSTLRHqDNy84WJ60cp3Z12c2qwgbz2E1ZG27WZD1vH97QJK/9G2j
         FYEsjLO+lqz+fjsv2LqcZ64fIhnTC9M3vhmrMXqO5w3NB3tSqtg/sHS0yT1ZGf07ekF6
         emiysyOFXnHIUp9+gBg2APMD1FY9h3tWNd9HAB0WF27WkrOnDCuMwrM2T19OBPjpFeMN
         ypIqjuzSvev3mxsTEQ7q+MHNrrb3cJgd9Yfq+y2Xxp04cSMtKLw29lEANlxUcvqFQAML
         7+trZakIRyM0eRwbmDO8YV2nYp/3iT/d66pPNx3pfRRWtqtnOQfv27TUy1TGJ9Y5MAcR
         D3qw==
X-Gm-Message-State: AOAM533i0mn7cq83OaVvq9I4VZMZogwCFdY5rsoi2AYfYnTejJ5WKSRX
        9nNdkSGNra1Hemvl7PTggFY9h5kP55bQW3qEFmo=
X-Google-Smtp-Source: ABdhPJz17do0nqH9RDciVYSsDM92qa+GIL8Xdzh/XOsX8vEJapbgMVEl8ecfRBXfQm7TkgdvEJs+h7jGhi0jijHGTrE=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr11969064otr.89.1596818382380;
 Fri, 07 Aug 2020 09:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
 <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com> <ypjl364y8msx.fsf@defensec.nl>
In-Reply-To: <ypjl364y8msx.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Aug 2020 12:39:31 -0400
Message-ID: <CAEjxPJ6kkZ2uHeO=6ozisBdcYoK_bzTP2-zRFFug8Sq+r+5Ypw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
To:     Dominick Grift <dominick.grift@defensec.nl>,
        James Carter <jwcart2@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 12:04 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On 8/7/20 10:40 AM, Richard Haines wrote:
> >
> >> This is an RFC patch to get some feedback as:
> >> 1) Table 1 is now a pipe table, however it still has <br> codes to
> >>     break up the text. Also updated styles.html.css to match the pdf version
> >>     to allow correct HTML rendering.
> >> 2) Table 2 is now a pipe table with updated text.
> >>
> >> Add a TOC to aid navigation
> >> Add text to clarify MCS/MLS
> >>
> >> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> >> ---
> >>
> >> @@ -48,6 +56,18 @@ The sections that follow discuss the format of a security level and
> >>   range, and how these are managed by the constraints mechanism within
> >>   SELinux using dominance rules.
> >>   +### MLS or MCS Policy
> >> +
> >> +From an SELinux perspective:
> >> +
> >> +-   An MLS policy has more than one security level with zero or more categories.
> >> +    It is generally used in systems that require the 'Read Down' and 'Write Up'
> >> +    services, whether it be for files, network services etc..
> >> +-   An MCS policy has a single security level with zero or more categories.
> >> +    Example uses are virtualization (see the
> >> +    [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
> >> +    section) and container security.
> >> +
> >
> > To be clear, SELinux (i.e. the code/mechanism) only knows of MLS,
> > i.e. it has a MLS engine in the security server and a MLS portion of
> > the policy configuration that drives that engine.  That MLS engine has
> > been leveraged by two different types of policies, the original MLS
> > configuration modeled after Bell-LaPadula and the later-introduced MCS
> > configuration (which underwent a fundamental transformation from being
> > user-facing and somewhat discretionary to being a transparent
> > isolation mechanism for sandbox, container, and virtualization
> > runtimes). The number of sensitivities, number of categories, and the
> > set of MLS constraints used to determine whether a permission is
> > allowed are entirely up to the policy author. A level in SELinux is a
> > combination of a hierarchical sensitivity and a non-hierarchical
> > (potentially empty) category set. In practice MCS is used for simple
> > isolation and therefore doesn't employ sensitivities since there is no
> > hierarchical relationship to be enforced.
> >
> >
>
> Compartments might not be hierarcical in the sense of dominance but if
> there was no hierarchy then I would argue the there would not be a need
> for categoryorder.

In the policy.conf language, there is a dominance statement that
specifies the hierarchical ordering of sensitivities.  There is no
equivalent for categories, and the kernel never compares category
pairs for any kind of >, =, or < relationship; it only compares subset
comparisons between two category sets.  So there is no hierarchy.  If
CIL defines a categoryorder, then that's unnecessary.
