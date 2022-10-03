Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D2C433FE
	for <selinux@archiver.kernel.org>; Mon,  3 Oct 2022 13:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJCNrv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJCNru (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 09:47:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B012B246
        for <selinux@vger.kernel.org>; Mon,  3 Oct 2022 06:47:48 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j188so11387181oih.0
        for <selinux@vger.kernel.org>; Mon, 03 Oct 2022 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R3YcVIrTb4inuvbuYhq9vi6T8Pa33mbPskPhHqjkGBA=;
        b=gsCsBlTZFbLeMeB48ObHiks5wCZILZfvh9ixi7HprQmeNPFSIgDfcHXxYSP//Qka0U
         zc9y1Xrojyf78hbt3soqCgGnQ5CwJO1MWLz+7SHboUXueGMr3sttE64g+7cniVIzOOjn
         aGYNKTGBF2KNAOVIgPWEgBBvz2sh4o3AELZLFeKsJAQV71vhHpPzf0X7W02gDT1c8qpQ
         dYQeYvTG6BcBDPAsSioSdhdbv3xJgCxNVcSf7Ski+r2pILi9zbf2PfaBXwV9WwovygbZ
         Wp26qB3eywZ2NCcd84cteuMRFN+2PMFBS6ESDqmiQJfIy1ItJq27uo2f747yAMv5oy9d
         LloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R3YcVIrTb4inuvbuYhq9vi6T8Pa33mbPskPhHqjkGBA=;
        b=v4m4janNzdKDSHDUH4UGGAOANCyAIVuo44Y4WeHRSeVt3zhgjJogNMDgixujggjMPj
         fRzYOKHNrJMU1KWoWUPcdyOzdrm+s51IHmFdurwOivHPt5qsTOnbc8G4KhMgW5gnCQVt
         yBIHR59wX/8AP252Uo5uEBQ5S75WB2IM7h4sC2n/6QkW389qx84DiZuvoR5zWk6yoVN2
         MrXGEAKTrJtN9onLtP0qFY4UOGWc1YDrNCRx/7idZfBmgPg5Y1jutjqPuoEDbpJUFobO
         4buoPrtgKK6otUieKdICEIlZ5TLAdM0Zspe2u31NsRj1LGEEAYez4fbDi3DVw+3/3mWT
         eesA==
X-Gm-Message-State: ACrzQf3AKEqM1SlLxB+iBKtcJm7fCb+swW46pHN6tav1w5fBD9EZcIok
        7VZ0KDHQQtPtVRPhCl+Sx/0HoHKzK7q9fF2KEWKHBDIlPQ==
X-Google-Smtp-Source: AMsMyM7A9Ms68OOLUo8JLb+Y/FMXw9BiiaRKMn6vCF+zVRXfg89ld622Fvz6EG0u2V5YHCzgNlQsLrBEkByH9MteCh4=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr4245776oic.172.1664804867764; Mon, 03
 Oct 2022 06:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <166463207266.6015.2704084637353753709.stgit@olly> <bf2cf936-1832-bb8d-33fd-b8ff1759e352@linux.microsoft.com>
In-Reply-To: <bf2cf936-1832-bb8d-33fd-b8ff1759e352@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Oct 2022 09:47:36 -0400
Message-ID: <CAHC9VhRTOZsG8r1jdE2yPndc1KStMGri=pZ1WfjfYjECaZW4kw@mail.gmail.com>
Subject: Re: [PATCH =v2] docs: update the README.md with a basic SELinux description
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 3, 2022 at 9:36 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 10/1/2022 9:47 AM, Paul Moore wrote:
> > This is to help meet the OpenSSF Best Practices requirements.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   README.md |   19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index 74b0a0c3..e820ac30 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -7,13 +7,18 @@ SELinux Userspace
> >   [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
> >   [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
> >
> > -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> > -
> > -Subscribe by sending "subscribe selinux" in the body of an email
> > -to <majordomo@vger.kernel.org>.
> > -
> > -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
> > -
> > +SELinux is a flexible Mandatory Access Control (MAC) system built into the
> > +Linux Kernel.  SELinux provides administrators with a comprehensive access
> > +control mechanism that enables greater access granularity over the existing
> > +Linux Discretionary Access Controls (DAC) and is present in many major Linux
> > +distributions.  This repository contains the sources for the SELinux utilities
> > +and system libraries which allow for the configuration and management of a
> > +SELinux-based system.
>
> Probably should be *an* SELinux-based system.

Just posted a v3, thanks.

-- 
paul-moore.com
