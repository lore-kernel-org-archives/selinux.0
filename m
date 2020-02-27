Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A1C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C670A24699
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAul89xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgB0ULM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:11:12 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:33065 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbgB0ULM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 15:11:12 -0500
Received: by mail-io1-f42.google.com with SMTP id z8so909898ioh.0
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFWNxM6I+jRioIVMfi9w6Bdv6RpSw0/mCywwE+wQleA=;
        b=SAul89xdArB5TV7ocAsmcwArS1yCFbGcGaznPiYwZqDDPaTw/EpI8aiL3r4zZ01URZ
         JiHEZKvjQ6JHa2D+qzdYI/cMjEgGIq1UdQoNbKocFnoPw9nWlzZAndA0vxJZzOw8DggR
         XgSkhWl4NsFCmPBxEVwSUvemyhf8Wm9Y+qRTU87EcF1a0PbgJkACLvoITiKvFxonOyKE
         yagqH4cZbFFHn94lweLdO4dA1impXyC+Pufi5olQDJfA9d2lDAdqRejITHS+eYnL6qU/
         TIoXR8sMH/yW2AhDu/LldnP4+5S5rwYWj146zzWPcaI+QxyomTAo0S7rkvUCGy7ar0ah
         yrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFWNxM6I+jRioIVMfi9w6Bdv6RpSw0/mCywwE+wQleA=;
        b=ZP+cRJZOoMfOLisMIn9EcHzOHcRuBoxbtsHeuUQT3Xbs3FRyAYlUNDADoX4AZeskDH
         LUcQ/maAhPJbFq50wtAM1dMrJ3lH1b1I7hgDoJPUTwGn1v2Djki4ifrtMmRP7IK2gXSw
         sWLBas5XjDMqJ5bSnW3VZVE8I88C+MHEa/q+ZJbdt1HtVBK9OPGHgzYUlDk5bGAT7mpE
         EOd7w+lDH1FcPWahyQinOBJimCkkywqmYC1C5dNE3k28l+iFaCOdCVlaYldhGRFbd6uy
         STuC6GnscYMEYWWqchiHBNJI6KMHaY4CWU5Y1H6bp5gpOPcBUwb/uJTEbcxChQAoD392
         cSQg==
X-Gm-Message-State: APjAAAU0mYEbCC0rHzbSobctdMIub2LHjIUVtPaYvxn+hazNTlQdBON6
        iZ6hLHXDCENes2kNU6kWcOiD+u0/cVWrkmqa0Kk=
X-Google-Smtp-Source: APXvYqxLrPlsXLVlUufLF/MbhyiuMmOLzbaa+XDcB9Nx8nC/oTGwKcWdeKMAC4UnboaIw10I9/jR2wp4VeY6CPxnOOk=
X-Received: by 2002:a5d:8796:: with SMTP id f22mr802594ion.163.1582834271409;
 Thu, 27 Feb 2020 12:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com> <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
In-Reply-To: <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 14:10:58 -0600
Message-ID: <CAFftDdqhFufuZkA0XYztuHH62KkawfTMjimTCx_cztAq0DH5wg@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>
> > The hidden_def/hidden_proto stuff originally came from Ulrich Drepper,
> > glibc maintainer at the time, to eliminate unnecessary runtime
> > relocations and PLT entries being used for local symbols.  Per the
> > comments in https://github.com/SELinuxProject/selinux/issues/204,
> > these might not be needed anymore and are breaking building with LTO.
> > Willing to get rid of them if it doesn't produce a significant
> > regression.

I guess that's my major question, how do we determine this is a regression?
Obviously a functional break is self explanatory.

>
> Ulrich, could you help us understand the macros you proposed to add to
> the SELinux libraries (probably a very long time ago)? Specifically,
> we are talking about those defined in "dso.h" header files such as
> this one [1]. See also GH issue 204 [2] for related discussion.
>
> Thanks,
>
> [1] https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/dso.h
> [2] https://github.com/SELinuxProject/selinux/issues/204
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
