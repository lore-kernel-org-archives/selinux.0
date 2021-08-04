Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A14C4320E
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B860F58
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhHDOCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbhHDOCl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Aug 2021 10:02:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675EC0613D5;
        Wed,  4 Aug 2021 07:02:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m9so2683820ljp.7;
        Wed, 04 Aug 2021 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXGldMG7puQrCMALwd9fpgaMEUUvke4GBGbDk8aMeMc=;
        b=BHQN9wnCLMTvst19eR8wv8XIBKfFiOC/6lpoPTMdpliSImBLm7RWzg9nZOc3ldlUV9
         N751o0jyiO4fMHxKxA9WqlirsBxdRXg8k7sG8yx8cJMj8pwggCR0PleFtX1Xj5fCpo6c
         jypMVE5+v1NITUk0e+4hImsDdqvtnHCasCkigDOldaWS087XOZzy3FLqJK6sVdVr0S17
         CWRn3i0qadScrqG6UDbU3FYrLEg2MyXqOOZ7T9S61Nr+iOIme5gHj+90fDGIEGNGVx4+
         OUfvEH6lC5eaGrBCASW0JHVIKB2BkiQrWcrnkQh5SyMuYoOIM9DbXZ7zS9Qh9vfV7RB9
         buLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXGldMG7puQrCMALwd9fpgaMEUUvke4GBGbDk8aMeMc=;
        b=EXQBciFJ040IAm1fq4atxNTRBQub7mIPXHYfPF1WAPeB3ktwrxC+g1yERlWztzzq1G
         GJkbFwCd+F6NhZ+leDC1FD9WeKXaNt8wq5fDaopx5Epk+uo2Eq8eR2y+7tj8Sy/6vXfr
         cC1zQryHAu+Ds6RE3Q1I50Bj5r4hL0lMfnn34F9d1VWUj7XxFN/i/Ctp664r+Yn/DNCa
         3Qcq87X2VkSIaaQaEGLLip+LMq81sE+PRR4DqVwF2zgPumsBRIlS4MftpmUanILRlioT
         uzhqfwhVGtjnLBENrUuZSpkV4g2AeDLz5Pnal0gErtzGDVDkksXfeKwwlmhl2m3v7fFa
         IvYQ==
X-Gm-Message-State: AOAM531S3Q9x8ITHDDZwcmFpgpY2aiIb9IVYn352DMCrvhi3hadrRaE8
        5HNxhBB8S/XV54PcGG2jMXjykZzeLlPIgPZL6Ac=
X-Google-Smtp-Source: ABdhPJyqtBKsuGf/fQp0+uw6qZ4fNgeKHRZ3gphvym4DqLAWN+s1SHCdsxC3O3M8Rs+NEfFTOULW4TzTxHTNO3bQCX8=
X-Received: by 2002:a2e:8791:: with SMTP id n17mr18118053lji.500.1628085745578;
 Wed, 04 Aug 2021 07:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <CY1P110MB0102ED0206E9498C742F6DC0F2EF9@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
 <87im0m789b.fsf@defensec.nl> <CY1P110MB010233780A4A54DE7580F9FBF2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <CY1P110MB010233780A4A54DE7580F9FBF2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Aug 2021 10:02:14 -0400
Message-ID: <CAEjxPJ5EdNYVnViyH6YteTEUm4ZHpa5xNLAk-uZoOgU2nPOVJw@mail.gmail.com>
Subject: Re: [External] Re: LSM policy options for new GPIO kernel driver interface
To:     "Weber, Matthew L Collins" <Matthew.Weber@collins.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Graziano, David D Collins" <david.graziano@collins.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 3, 2021 at 3:17 PM Weber, Matthew L Collins
<Matthew.Weber@collins.com> wrote:
>
> Dominick,
>
> > From: Dominick Grift <dominick.grift@defensec.nl>
> > Sent: Tuesday, August 3, 2021 12:22 PM
> > To: Weber, Matthew L Collins <Matthew.Weber@collins.com>
> > Cc: selinux@vger.kernel.org <selinux@vger.kernel.org>; linux-security-m=
odule@vger.kernel.org <linux-security-module@vger.kernel.org>; Graziano, > =
David D Collins <david.graziano@collins.com>
> > Subject: [External] Re: LSM policy options for new GPIO kernel driver i=
nterface
> >
>
> [snip]
>
> >
> > SELinux supports IOCTL allow-listing and so access to the various GPIO
> > IOCTL can probably already be controlled.
> >
>
> We had been looking at this option but noticed the GPIO are broken out in=
 groups by the "chip" providing them so a granular single IO "write" action=
 can't be controlled through an allow-listing.  One idea we were going to l=
ook into was to break out all the IO in a chip as minor dev nodes which the=
n could have specific IOCTL controls applied.  The default policy could res=
trict the "chip" node and then have broken out rules for each minor IO.
>
> > Other than that you could consider adding LSM hooks for GPIO object
> > related syscalls and adding SELinux check for GPIO syscall operations
> > but not sure if that adds any value to the above.
>
> Assuming you're referring to something like SECCOMP filtering the IOCTL, =
that would shift the responsibility to userspace to properly use the SECCOM=
P filter...  Or are you referring to new hooks on the kernel side of the sy=
scall handling that would partially decode the payload of the call?
>
> Thanks for the response on this.  I wanted to have some debate before rea=
ching out to the GPIO maintainers to look at options from their perspective=
.

Circa Linux 4.3, the SELinux kernel code was augmented to support
"extended permissions" with ioctl commands as the initial use case for
Android device driver whitelisting. This is supported in kernel policy
version 30 and later. A simple example can be found in the
selinux-testsuite under the ioctl test. See:
https://blog.siphos.be/2017/11/selinux-and-extended-permissions/
https://selinuxproject.org/page/XpermRules

This may still not provide you with the desired granularity. Depending
on the driver implementation, it may be possible to automatically
transition different "objects" managed by the driver into different
contexts through the recent SELinux anonymous inode labeling support
merged in Linux 5.12. There is an example of this for userfaultfd
inodes in the selinux-testsuite. We had previously looked at using
this support for /dev/kvm. Correct labeling of the inodes may require
modification to the driver depending on the approach desired.
