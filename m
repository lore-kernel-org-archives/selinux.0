Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D1C433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 19:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350522AbiC3TJE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350500AbiC3TJD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 15:09:03 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC425C7
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:07:15 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e4so23013515oif.2
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueVq/OeA2b083TSw1o31yAjqgUaBLlKohPxZ9hgGry8=;
        b=msSZfMiO8YhFM7tj4GlN+L1lNnrSFor9ArL/LuIL7NpdqXxgktynX/LR2tIDttMjvQ
         OKZIz4i2jOSK1RG0LKWuDIDmVujjI9050BQmq8L2kpHVq7m1O+z/tSbvbae8GAJIz/nI
         Xs18ZIyLXZqLvjCVICLlD1Zb8EqoikX8MVGOLao7ja4Bzz668AQ5Lt2rU+ko0m9HBOcl
         hnP1J4HqY4QGt/1y1GO7GdXbv1zqPDGRqjbKs5vpoU9TvfrRIR+Dzd9LtdRQqxcWt+mm
         ZPO9+YNmmDfCkj6C4GdoX8m0PxTsPtIE6yCSj1R3gf9e33iR1d3zN1vdRG2T5FfnRuAS
         7AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueVq/OeA2b083TSw1o31yAjqgUaBLlKohPxZ9hgGry8=;
        b=ukiiyDBxdB7Tp1DnfNqv83pOM1XtJjrVbSz4Pn6frczeGotl76BF0wpXKjfQjHShOP
         34SGiZViygN/cSlU0BXBuyFzSYUp9yKjMkqbzNAMIWUSCi7jP4znbLPBZJKMmdjFQCLA
         +qKSrnngeJqvfxcOkdSJipWPRW3aIkCy2jdqvFM3Gl7UhnTElMuw3oQAa6wOUaaRk9mq
         sz7O77JXcopeB/eZtLwcuhubi4ee+6Ld3onFIINCmg/6lq8eA9o89vaEVTygjWExt8UU
         XiSv9gopPoAm+ZuBgskoNz4+wNZ57t980SequP2qIG1xh8Dbo9fACOvWlPOfUUzOd6om
         IsJg==
X-Gm-Message-State: AOAM5318lNLZU/cn5ShE2pMJv+8CbNp1rhzwXNAHcs6lnpu2bX0WcDgB
        tU5nys6t6pdVChhSM3VXrkWhx9Ld5PhzZ5BBEqbsvvg5
X-Google-Smtp-Source: ABdhPJyZfHYYSRW9Ra9zOZaBS14v9cN9f3Wrw5PUqzJRcz7eLr/cxopUWK1OxDEcel2IVR15OC/VXoAKJIlophv/xp0=
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id
 q11-20020a0568080ecb00b002f741cc21b9mr708416oiv.156.1648667235035; Wed, 30
 Mar 2022 12:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220325173013.448231-1-jwcart2@gmail.com> <87v8vy30xz.fsf@redhat.com>
In-Reply-To: <87v8vy30xz.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 15:07:03 -0400
Message-ID: <CAP+JOzQQ16Up41MjBKe2xpz6FMR0mhLzDhLpwu8oSahiptuN0g@mail.gmail.com>
Subject: Re: [PATCH] Add a file describing the security vulnerability handling process
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 28, 2022 at 5:01 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Add the file SECURITY.md which describes the SELinux userspace
> > security vulnerability handling process including who to contact.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

Merged.
Jim

>
> > ---
> >  SECURITY.md | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 SECURITY.md
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > new file mode 100644
> > index 00000000..37630585
> > --- /dev/null
> > +++ b/SECURITY.md
> > @@ -0,0 +1,59 @@
> > +The SELinux Userspace Security Vulnerability Handling Process
> > +===============================================================================
> > +https://github.com/SELinuxProject/selinux
> > +
> > +This document attempts to describe the processes through which sensitive
> > +security relevant bugs can be responsibly disclosed to the SELinux userspace
> > +project and how the project maintainers should handle these reports. Just like
> > +the other SELinux userspace process documents, this document should be treated
> > +as a guiding document and not a hard, unyielding set of regulations; the bug
> > +reporters and project maintainers are encouraged to work together to address
> > +the issues as best they can, in a manner which works best for all parties
> > +involved.
> > +
> > +### Reporting Problems
> > +
> > +For serious problems or security vulnerabilities in the SELinux kernel code
> > +please refer to the SELinux Kernel Subsystem Security Policy in the link below:
> > +
> > +* https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
> > +
> > +Problems with the SELinux userspace that are not suitable for immediate public
> > +disclosure should be emailed to the current SELinux userspace maintainers, the
> > +list is below. We typically request at most a 90 day time period to address
> > +the issue before it is made public, but we will make every effort to address
> > +the issue as quickly as possible and shorten the disclosure window.
> > +
> > +* Petr Lautrbach, plautrba@redhat.com
> > +* Nicolas Iooss, nicolas.iooss@m4x.org
> > +* Jeffrey Vander Stoep, jeffv@google.com
> > +* Joshua Brindle, brindle@gmail.com
> > +* James Carter, jwcart2@gmail.com
> > +* Paul Moore, paul@paul-moore.com
> > +* Jason Zaman, perfinion@gentoo.org
> > +* Steve Lawrence, slawrence@tresys.com
> > +* William Roberts, bill.c.roberts@gmail.com
> > +* Ondrej Mosnacek, omosnace@redhat.com
> > +
> > +### Resolving Sensitive Security Issues
> > +
> > +Upon disclosure of a bug, the maintainers should work together to investigate
> > +the problem and decide on a solution. In order to prevent an early disclosure
> > +of the problem, those working on the solution should do so privately and
> > +outside of the traditional SELinux userspace development practices. One
> > +possible solution to this is to leverage the GitHub "Security" functionality to
> > +create a private development fork that can be shared among the maintainers, and
> > +optionally the reporter. A placeholder GitHub issue may be created, but details
> > +should remain extremely limited until such time as the problem has been fixed
> > +and responsibly disclosed. If a CVE, or other tag, has been assigned to the
> > +problem, the GitHub issue title should include the vulnerability tag once the
> > +problem has been disclosed.
> > +
> > +### Public Disclosure
> > +
> > +Whenever possible, responsible reporting and patching practices should be
> > +followed, including notification to the linux-distros and oss-security mailing
> > +lists.
> > +
> > +* https://oss-security.openwall.org/wiki/mailing-lists/distros
> > +* https://oss-security.openwall.org/wiki/mailing-lists/oss-security
> > --
> > 2.34.1
>
