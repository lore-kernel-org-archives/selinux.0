Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D3C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 04:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11560207ED
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 04:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pceqo6sP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgFLEAG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgFLEAG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 00:00:06 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17640C03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 21:00:05 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id k18so4202407ybm.13
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1u2kI9khfoeYIvO0coxcnr4u4S65TxdFJFl+mGsUHuM=;
        b=Pceqo6sP1BSyNvrn9ym4kvymr55VHor39qWLcSMXk7rhVg+HfwjO6jMDeYlhBXtsiC
         32xQnfxP/ByJuSlGYC5lXK112+sm79RMn+0CbNqDrryubmeVECuHmrhC4dnvBig1tp+P
         SxSgd1uVjRZ28HaSQOpIChjx0VWZLiu3rDRXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1u2kI9khfoeYIvO0coxcnr4u4S65TxdFJFl+mGsUHuM=;
        b=LD+54jwdo34uC30YizwdurqG29ABYiLHaYSDW9SqUh+sCXcGQzjAsvScgzE3avXfjx
         LLj2K7eXiepS9uqC2pYMpLkpDsp4Sbow8MKfcMx1jOrd3qs1dU2GsdNvVb1lV69c7/Ny
         3Nh4DtM5pz9QzLzVPFZSjGRXlpN1nG3+eFB8++xrHFPZ6wtaBJvafErUju2bb3OcdoHO
         UOQot2GYlu6JavajUro+mjOP8ntFYOgWLD3tN9CLIRbJcyRX73/A+903uBEGbv7qrqZv
         D0QI2j0bG40/v1o0pLF8uxtLca1muMJ7q+rTb2b4sobASLw+99gGbtu/Qj2GyxkcCndp
         DGow==
X-Gm-Message-State: AOAM531dAV8v2l3DtJJtFPE4V3hKKu38avOtBWk1GeAczGscQzV64Ww3
        j2dvbVCFsbkySNj+eINuPxTfy6J6dO7lHz2YO+idAQ==
X-Google-Smtp-Source: ABdhPJyvnPg8zsU3hzyC1f6tMEDu3oEKjoxx8AAkgnDrwby1KgLLbOPDiEuhocfKQbP7fqv8h1niUaXJ2BaLd6/0IYc=
X-Received: by 2002:a25:b8c:: with SMTP id 134mr20649147ybl.428.1591934403882;
 Thu, 11 Jun 2020 21:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200601072916.219197-1-chirantan@chromium.org>
 <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com>
 <CAJFHJrp6pM1EUcBWFL4bKQUA4wZT4N5_0QutXv5vXr7TNAvqVg@mail.gmail.com> <CAEjxPJ7QD-zPyytQ6-VpuoAqnuS91fzA3nj-711OsK_9cy-kWQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7QD-zPyytQ6-VpuoAqnuS91fzA3nj-711OsK_9cy-kWQ@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 12 Jun 2020 12:59:52 +0900
Message-ID: <CAJFHJrp560C=KB-LNdMAbJB=r9byUJ0Pgd5u9=o8vHrsB3Ht2Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow file owner to set "security.sehash"
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 9:23 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2020 at 2:21 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
>
> > The background for this patch is that I have a fuse server that runs
> > in a user namespace.  It runs as root in that namespace and keeps all
> > the file system caps so that it can set selinux xattrs.  However, it
> > cannot set the sehash xattr as that needs CAP_SYS_ADMIN in the parent
> > namespace.  Looking at the code I thought that might have just been an
> > oversight but if it's intentional then do you have any suggestions for
> > how to make this work?  I'd rather not weaken the sandbox for this
> > process just so that it can set this one xattr.
>
> I'd be willing to move from requiring CAP_SYS_ADMIN to performing a
> SELinux permission check (either FILE__RELABELFROM or a new one), but
> I'd like the Android folks to chime in here.  Maybe you can ping them
> through other channels since they haven't responded yet.

I contacted them separately and they are not interested in relaxing
the requirements and also said that the kernel shouldn't have any
knowledge of the sehash xattr.  So I guess we can just drop this.

Thanks,
Chirantan
