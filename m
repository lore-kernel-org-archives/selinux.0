Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E67C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDCA22CA1
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgQSi98j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGQnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGQnB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 12:43:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B7C061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 09:43:01 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so2452888oiv.7
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmg4wl4/usU4jbnVNhIeTUafGKZkRLXEZk0K1yTCcjY=;
        b=HgQSi98jzqYjA+5jMWfD4yBU9PlyF2nXD55MUx8T6s2QrSK2kmNM+cSBoCr6DIhFCS
         SCxpFYneUxzmmP5zIwR3yXfbOlCvKlxoBOSSlxW54fDFbZ/Aq7+Gu9h6yTzvrswLJCQf
         1TsBhIHfEQNpC1euYmfe6cVrUKPmpqnQZilvTxlSY2HFNvhjyGMGnsYY+6XNOKuLAZVb
         FboB71aTnLQUqxx8P2o3wFulKyqHmrXAWdX0zqCoE4E4xZF6LQqYD5m5IYZxTLqV4JeN
         9OPNNe0goE0NMsTsUXrkEidLEF1RILsyFgTeTK1p03ushzzVXa/CILWfz1lmYSYELxsi
         vQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmg4wl4/usU4jbnVNhIeTUafGKZkRLXEZk0K1yTCcjY=;
        b=VKHTbAdjK5+ewT86ms8NmMKWgpy5vB3MaKBAdg0OsJPjhEqku1XOjGvyRPkHcAcMj2
         raM3M7k/O136M4GcMy61h35+I191aWlVRlrhrNFY13/DJhbbZDvlUeonATenJFT31GML
         ETzK0QsHhYJePj1umfEmJw+m+eFPxZG06fxmbb0NKQQcJ5VUkvK8+3/q+jN50JZDitqG
         LQXtBSdp+mgiY2DQD3sKdrrJ8OMgfy/3suyoo+PntSTUgIZmkso6MnE1RflCgMLI5aoJ
         15yT5TsgGSEKMp1BQ/g7Cn5TIOI3rv8cA/Z84h1WW1GKDNMVFyxvbTZjdmlaG60Nu9pl
         559g==
X-Gm-Message-State: AOAM532sbh+kgT40xPmMRoE2nNPlKRX+JEyMKs2ml9g65eeQnwWWkCy9
        YHUGd8FThNqdtFpUbwbiBlcmKXxvpT7tolOjScl5dA==
X-Google-Smtp-Source: ABdhPJylXms3+wD2BGQq4vJL8C9pS80hmrKI3DQz3geCXRkcmjK5UHMC9qPAJ/Ep+948JSMMaSvMGf6rmOIIxcr3tU8=
X-Received: by 2002:aca:cd05:: with SMTP id d5mr11423128oig.138.1596818580395;
 Fri, 07 Aug 2020 09:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
 <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com> <ypjl364y8msx.fsf@defensec.nl>
 <CAEjxPJ6kkZ2uHeO=6ozisBdcYoK_bzTP2-zRFFug8Sq+r+5Ypw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6kkZ2uHeO=6ozisBdcYoK_bzTP2-zRFFug8Sq+r+5Ypw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 7 Aug 2020 12:42:49 -0400
Message-ID: <CAP+JOzRqGqu+a6Ja03PK4ZvcgiMYS2Tc66ud=Kt-jP=vWKJ4SQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 12:39 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 12:04 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On 8/7/20 10:40 AM, Richard Haines wrote:
> > >
> > >> This is an RFC patch to get some feedback as:
> > >> 1) Table 1 is now a pipe table, however it still has <br> codes to
> > >>     break up the text. Also updated styles.html.css to match the pdf version
> > >>     to allow correct HTML rendering.
> > >> 2) Table 2 is now a pipe table with updated text.
> > >>
> > >> Add a TOC to aid navigation
> > >> Add text to clarify MCS/MLS
> > >>
> > >> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > >> ---
> > >>
> > >> @@ -48,6 +56,18 @@ The sections that follow discuss the format of a security level and
> > >>   range, and how these are managed by the constraints mechanism within
> > >>   SELinux using dominance rules.
> > >>   +### MLS or MCS Policy
> > >> +
> > >> +From an SELinux perspective:
> > >> +
> > >> +-   An MLS policy has more than one security level with zero or more categories.
> > >> +    It is generally used in systems that require the 'Read Down' and 'Write Up'
> > >> +    services, whether it be for files, network services etc..
> > >> +-   An MCS policy has a single security level with zero or more categories.
> > >> +    Example uses are virtualization (see the
> > >> +    [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
> > >> +    section) and container security.
> > >> +
> > >
> > > To be clear, SELinux (i.e. the code/mechanism) only knows of MLS,
> > > i.e. it has a MLS engine in the security server and a MLS portion of
> > > the policy configuration that drives that engine.  That MLS engine has
> > > been leveraged by two different types of policies, the original MLS
> > > configuration modeled after Bell-LaPadula and the later-introduced MCS
> > > configuration (which underwent a fundamental transformation from being
> > > user-facing and somewhat discretionary to being a transparent
> > > isolation mechanism for sandbox, container, and virtualization
> > > runtimes). The number of sensitivities, number of categories, and the
> > > set of MLS constraints used to determine whether a permission is
> > > allowed are entirely up to the policy author. A level in SELinux is a
> > > combination of a hierarchical sensitivity and a non-hierarchical
> > > (potentially empty) category set. In practice MCS is used for simple
> > > isolation and therefore doesn't employ sensitivities since there is no
> > > hierarchical relationship to be enforced.
> > >
> > >
> >
> > Compartments might not be hierarcical in the sense of dominance but if
> > there was no hierarchy then I would argue the there would not be a need
> > for categoryorder.
>
> In the policy.conf language, there is a dominance statement that
> specifies the hierarchical ordering of sensitivities.  There is no
> equivalent for categories, and the kernel never compares category
> pairs for any kind of >, =, or < relationship; it only compares subset
> comparisons between two category sets.  So there is no hierarchy.  If
> CIL defines a categoryorder, then that's unnecessary.

CIL has a category order statement only so that it can handle category
ranges. It is not a hierarchy.

Jim
