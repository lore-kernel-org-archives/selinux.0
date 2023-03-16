Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F093C6FD1F
	for <selinux@archiver.kernel.org>; Thu, 16 Mar 2023 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCPUWO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCPUWK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Mar 2023 16:22:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C8E500E
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 13:21:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i6so3393528ybu.8
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678998112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNELyMFYQ3E5IM6Bv8MMesyXF2Jl9Zu5m81e3F3V3lY=;
        b=cuAwnKU1af2vaASb3Lb/E+svpI5ZkG7HLQ2xV/imN+I88wrD2YzUgpO+hZn2BB9/oy
         i/7Hs5NEwZNflLSoDOtYQqOhi3J4lhgmVMnZVjjZNY4O3TFKDADQi35BEr8H+2grDxH+
         KWdRx2vB9rbqq0S9HNYGc9N7y0bZneToDxBfmEgZSBEF53rSeygh6kGFm/3M7RxWkSf9
         ly5Q3WPGOU8IkjcwCKEMOzee+lCoTGtNMVWuz/Kz9q8nzrRSLdK6x5YEJN0VjqmcW3CX
         iCUDH9p/YscgROaoI5MjIFf4xq4Nb4WS2vOTNAwTfV9b6oLSfLX1NxSMTIBLDfYO4Luf
         NUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNELyMFYQ3E5IM6Bv8MMesyXF2Jl9Zu5m81e3F3V3lY=;
        b=qHZBDzcSebN28S3OnOGnMELfQDun/i9zRuJGFsSkrlzr3VL7VgtjcXyrCX89DQiAmR
         pW9MwFP171y+gcMWP+rAESROmkvY/Mf1a81FF5LDAnup3QI1fMnKrKFimKj0QaR1/DQd
         lfkHp6zM1aa/j2mW7Wu/hKp96keFUyTOjvUJHxRxpH0Lbi73H8bmYTb9yRCwiuAeIWlq
         DVITXl6AkPlEyWcNTaXaHMVsfadopvhufKw2AUIGet67KVblZ0kVx5ST1NrpUTRfMR9a
         ZfjAwsuqV/YERew6VvABSCCgeh2lOt44jOHzZYzB6tHfN00CYf/tlPH6oLXK9XFEz0F3
         rmlw==
X-Gm-Message-State: AO0yUKUmqhl/2C/eJlkk/+eO46PED8pL/2dTGkGGU/nI3PRcUt+wZSW+
        3cFMWp/zQt/SnjG58E6zcbB9HhRqHsHhiBEI6nfwoiAKr16KZ58=
X-Google-Smtp-Source: AK7set9uBhgzbmhDJCi0vSwei7yt7owdxxv4r10RmPDwX9b/iT9fNRgcOW9tiVqjYCNRwf+C738zFHavozwUxQbQaZ4=
X-Received: by 2002:a25:f512:0:b0:b3c:cbdb:ed5e with SMTP id
 a18-20020a25f512000000b00b3ccbdbed5emr8239740ybe.3.1678998112637; Thu, 16 Mar
 2023 13:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230316175749.233373-1-paul@paul-moore.com> <CAEjxPJ4v3KWoBidGpbrU9ibiQeuwUh34uEZg3E8tc7vPJ9dH0w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4v3KWoBidGpbrU9ibiQeuwUh34uEZg3E8tc7vPJ9dH0w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Mar 2023 16:21:41 -0400
Message-ID: <CAHC9VhSzrF6QUgYSXGMUdS3J8xrWTNXT4onG7FV1e2nrVxuh4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the 'checkreqprot' functionality
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, selinux@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 16, 2023 at 2:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 16, 2023 at 2:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > We originally promised that the SELinux 'checkreqprot' functionality
> > would be removed no sooner than June 2021, and now that it is March
> > 2023 it seems like it is a good time to do the final removal.  The
> > deprecation notice in the kernel provides plenty of detail on why
> > 'checkreqprot' is not desirable, with the key point repeated below:
> >
> >   This was a compatibility mechanism for legacy userspace and
> >   for the READ_IMPLIES_EXEC personality flag.  However, if set to
> >   1, it weakens security by allowing mappings to be made executable
> >   without authorization by policy.  The default value of checkreqprot
> >   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
> >   actual protection), and Android and Linux distributions have been
> >   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
> >   initialization for some time.
> >
> > Along with the official deprecation notice, we have been discussing
> > this on-list and directly with several of the larger SELinux-based
> > distros and everyone is happy to see this feature finally removed.
> > In an attempt to catch all of the smaller, and DIY, Linux systems
> > we have been writing a deprecation notice URL into the kernel log,
> > along with a growing ssleep() penalty, when admins enabled
> > checkreqprot at runtime or via the kernel command line.  We have
> > yet to have anyone come to us and raise an objection to the
> > deprecation or planned removal.
> >
> > It is worth noting that while this patch removes the checkreqprot
> > functionality, it leaves the user visible interfaces (kernel command
> > line and selinuxfs file) intact, just inert.  This should help
> > prevent breakages with existing userspace tools that correctly, but
> > unnecessarily, disable checkreqprot at boot or runtime.  Admins
> > that attempt to enable checkreqprot will be met with a removal
> > message in the kernel log.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks Stephen.  Although I just noticed that we can drop the
checkreqprot_set() function entirely now, expect a v2 in just a moment
...

> I was wondering if we could remove the reqprot parameter altogether from =
the
> mmap/mprotect hooks but looks like IMA is using it.

Yep, there was even a recent bug fix about that too.

--=20
paul-moore.com
