Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E66EC47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3047221848
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CiSBZ0zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJIOEF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:04:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37218 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfJIOEF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:04:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so1766855lff.4
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2019 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDK+Jfvol7rh6cLegzhW9/SVlf4FWinv3rs9c01PQ10=;
        b=CiSBZ0ziWo0zdzet0ZWssXZQ/jPdyvfHhSfx3rgKZfArcqu0bIjCK/CVE4I3q11Ma4
         Sa6rlv1cLkC2LMB3aMZMXrNnGV9ux8vZerfZvJrndFRdsaWLhQh70tcG+ZITwqJbqrxc
         Y/aWkJqxB6liii0Fr4Z5bS4bXPpNRJDG+xt7FoANuJyDGRaCaCEXL1zTnT547rIE1W0t
         QK/JsxyB+LTmSWNFEJdby17dRbOVmH2uzuNmmYhge+4qzAmdFqqgMRpf8eVCyrChhwiG
         8zAH0glkFZCamnUty/S2yhk4GXArvNJiEtEqSOxwiRojRWXACDejVztMYUycBZ+KxRRu
         ua5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDK+Jfvol7rh6cLegzhW9/SVlf4FWinv3rs9c01PQ10=;
        b=GDPADDGc9F2slLnKgDCpsKqtBWALThGLkCpPDUx9+Vw3lhndcmgqKlEk/01Q0fv00y
         F2A1IwqE9LfbcWgsNauxHMiAUPYEC47ecut9J+KF+EzbGO2cGSnNgtKB3zVQbJiWhEDi
         R5ck7k5uxgZpVYqWjQQrkFQqxpzMIakDZQ0genuYxYUzzdaOlxzYOXCiMMZWmji9DSJ6
         OegOBpb/qH9ztDNAaKe/88BAieYU+CmycORWn84lb2yzgpQUfQKjeFvTgiRsI0p9MgSb
         wZaFZwZqFf9DpYDI3f2tW3aaOPlafV54Z0kFrBQ3wavCej7x8+gclNgSqwYmJe84Z7na
         aTYA==
X-Gm-Message-State: APjAAAWNoZJXYP2uYm4KkvkPjP34F7x89cpyF+tD2V/VZDhSq2+XVM7V
        CZOEVdP7xyeSqQCqCFX/CPH+mk5nUUXDYM9G/rid6mw=
X-Google-Smtp-Source: APXvYqxDpAByrWVOp7QJt3xjWS3cxqEQwB9scYKudSN+etYH93w4bJD2QyYzEni7k+1N0ypVpz3K68ECPVj08Mr0B/A=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr2169796lfk.119.1570629841722;
 Wed, 09 Oct 2019 07:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
 <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov> <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
 <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
 <CAHC9VhQcvFna_Jj5kZaJVbUtY_EW97sreAODTiaH8pb8nEqZjA@mail.gmail.com> <e9b371bc-f028-1f0e-2b7e-628c11c1a0db@tycho.nsa.gov>
In-Reply-To: <e9b371bc-f028-1f0e-2b7e-628c11c1a0db@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Oct 2019 10:03:49 -0400
Message-ID: <CAHC9VhTmzp=miTR+aSvL+onOtd1P5=Ln1EKjLqFFuh7wkr1OYA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 9:56 AM Stephen Smalley <sds@tycho.nsa.gov> wrote
> On 10/8/19 5:43 PM, Paul Moore wrote:
> > On Mon, Oct 7, 2019 at 12:35 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> >> On Mon, 2019-10-07 at 16:17 +0100, Richard Haines wrote:
> >>> On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
> >>>> On 10/6/19 4:51 AM, Richard Haines wrote:
> >>>>> Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c
> >>>>> ("binder: Add
> >>>>> default binder devices through binderfs when configured"),
> >>>>> changed
> >>>>> the way
> >>>>> the binder device is initialised and no longer automatically
> >>>>> generates
> >>>>> /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> >>>>
> >>>> This seems like a userspace ABI break, no?  Same kernel config
> >>>> before
> >>>> and after this commit yields different behavior for
> >>>> /dev/binder.  I
> >>>> suppose one might argue that one would only enable
> >>>> CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
> >>>> /dev/binder
> >>>> but the original commit that introduced binderfs specifically said
> >>>> that
> >>>> backward compatibility was preserved.
> >>> I'll need to check this further, but from what I've seen so far, is
> >>> that the /dev/binder is not available until you mount binderfs etc.
> >>> that's why Paul had the failure on 5.4 as before then is was
> >>> available
> >>> when the binder driver first initialised.
> >>
> >> To confirm tests using kernel 5.4-rc1
> >>
> >> Test 1 config:
> >> CONFIG_ANDROID=y
> >> CONFIG_ANDROID_BINDER_IPC=y
> >> CONFIG_ANDROID_BINDERFS=y
> >> CONFIG_ANDROID_BINDER_DEVICES="binder"
> >>
> >> On boot no /dev/binder
> >>
> >> To get this you have to:
> >> mkdir /dev/binderfs 2>/dev/null
> >> mount -t binder binder /dev/binderfs -o
> >> context=system_u:object_r:device_t:s0 2>/dev/null
> >>
> >> You then have devs:
> >> binder and binder-control
> >>
> >> Test 2 config:
> >> CONFIG_ANDROID=y
> >> CONFIG_ANDROID_BINDER_IPC=y
> >> # CONFIG_ANDROID_BINDERFS is not set
> >> CONFIG_ANDROID_BINDER_DEVICES="binder"
> >>
> >> On boot you have /dev/binder
> >
> > Disabling binderfs during build is probably not the smart thing to do
> > considering where the world is at with namespaces/containers, whatever
> > we do we should make sure the tests work with
> > CONFIG_ANDROID_BINDERFS=y.
>
> Yes, I think the question is just whether we want to have the tests use
> binderfs for kernel >= 5.0 (i.e. the point at which binderfs was first
> introduced) or for kernel >= 5.4 (i.e. the point at which binderfs usage
> became mandatory if you enable it in your config because /dev/binder is
> no longer automatically created).  I'm fine either way.

Agreed in that it probably doesn't matter all that much.  I might be
tempted to start with v5.4 over v5.0 since the old way still worked on
v5.0 through v5.3 and it might be nice to notice if that changes in a
v5.{0..3}.Z release.

-- 
paul moore
www.paul-moore.com
