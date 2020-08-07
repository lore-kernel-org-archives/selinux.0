Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC2C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBC220748
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXNPN7eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGQnO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGQnO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 12:43:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7887C061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 09:43:13 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v13so2425893oiv.13
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xsKu1tlzkOfkI9dwP/8fiqkCcGKK8sD3mzqMA1V84k=;
        b=lXNPN7eF66p1u+hzxwMcKTpCIVebV+wIpSZK8VMDdsYFl0o3ob8e90AFD30cVM3rmT
         4GVVPBGrJWOtfZoKXiuMkXfkhPvjXTTzRufDAn0qPYpVhim9ECutMH9OZoLheVGiDY9s
         GnaEDvnyFKo0noBBorThO6wA6R9wNUrPOAwPKqI9fkeA0A7llBCDOb9Iqh3PQwkvmqE9
         HMNJXnuZIqAocJMEjWN0MfJDOybmtzgm1hyt5CXho5izJ/1Gbsy9fjJd22Xi91FZ+Aj5
         WvzwVinlLmcvmwqgf/t+/a9Bq6KJ+2TuTJIeWDL/TLmFNoHO3JBBPDePxFA5uUoda7lo
         Kg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xsKu1tlzkOfkI9dwP/8fiqkCcGKK8sD3mzqMA1V84k=;
        b=X1ICvb/N3w4WwYFM3KeS0HxwS2O9tklTPO5cc7nN/VFiUJNMAj1NNIJGksschmxqV6
         5gKXH6Dg2AGSZKizXJVPdmEeL3UKWf1YYK8/TWiN7wpafaI+6mNSucGLk9CinNRuWcVW
         s5Al4ASt0X8A/DYy0InbTKRqmfcrjgZblV6pdFgkxkt8rmt1TEczOiUz4wnXuMErCiao
         fjJmms7AF+ddQRLn/wufMfVhPIQZR/Nh1mw8KrOL8DcpitnUr2ypTiQTksbaCfglsNX1
         SK02N59D3M+O6A6q3IXAaHfR18Oq3Ous8iiMhOTGePT0L4vgAF+pWeWe675G2Cx6qdO3
         /TIg==
X-Gm-Message-State: AOAM5330r+fWZaOFcFSBYCYXf3XuXJQUpTVRyGJT1NBn9NTSjI0zOUWk
        kXugGz4mE1y6mEuBKzdnggYyYV6hlvwti6FcMkc=
X-Google-Smtp-Source: ABdhPJz7R1j7K23YHsp02XyQcYOGX+LUXjmZ01W26987mvmGtpooRqhRCdAJ4QUNoHBFdN4KSPi+cDfY2wQ8+jMq/28=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr11649772oic.92.1596818593308;
 Fri, 07 Aug 2020 09:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
 <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com> <ypjl364y8msx.fsf@defensec.nl>
 <CAEjxPJ6kkZ2uHeO=6ozisBdcYoK_bzTP2-zRFFug8Sq+r+5Ypw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6kkZ2uHeO=6ozisBdcYoK_bzTP2-zRFFug8Sq+r+5Ypw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Aug 2020 12:43:02 -0400
Message-ID: <CAEjxPJ58VAODF5MHNREBVSMFrOWJ61-HAE0apo4OrBw_Ve1uwQ@mail.gmail.com>
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

Oh, I see; it is to allow validation of e.g. cN.cM notation.
So that's a comparison within a context, not between two different contexts.
