Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F954C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6720679
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HnDSyi/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFSOkq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:40:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32932 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOkq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 10:40:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so3561025ljg.0
        for <selinux@vger.kernel.org>; Wed, 19 Jun 2019 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPodMjJflzukJStp1coj19KDjJRQYH4LgzAe+D47LI8=;
        b=HnDSyi/5cJS5Er5/sadx55NG3R4XYZKjayj7BTlvRnyOZO/RskzmH0eNqRbF02hjWE
         U08PmFIxw1vWykLxSyITv+I2ScJxjhZZGDUP07u7HyvpvVXV7XvrdAci29/fsq5I0h90
         A9qQ0D9g2SN6byzPFrvdK/AG2ina+/DcIAoKH6jf73LMnAOjhZzDxxdvAy2dkYMPda4S
         UJlV1GpIf45Li15BHXo/B2DexUi/jkdo7X8skXMLMFIGm+/GiJ0XHNkdIcdZtGB0zvw1
         wWBiQq/ONPVpSB6JdUL62TmTIhrFNGIiV78sVZVMTPSXPWMKWd+xEGJxKVyK+el9qeGH
         meOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPodMjJflzukJStp1coj19KDjJRQYH4LgzAe+D47LI8=;
        b=nIyC4S6rGHzDZ2bmDL3oLw0hLtmFZD604DRF8fhXgsj6ydoasCx83lj2L4AfAyo3FI
         1+w73kWUH6V4z8GPu/iDAuJjbfFZ1d5bVb8phpGZMm+lkXvYfLz2HOK89xa4s23vHXvJ
         jMSMErPqmcZwI65PAtxdZuaIQxKUmHPG00EqJ2eztAExTuMLMoHg4cJn7HeQFqpLD/GP
         bv05vcQjz1y7fAV+Q8UmT+Q/gpTYoAtOWVMOXoCBF5BLejLpxy9SRE188S2VYEKrIDDU
         J58TZZThMDzYwX7tWpuL8zYxzuIshdGshsOAJe/YOZl0XURc1nWNjux/zxedMW3aML96
         vB4w==
X-Gm-Message-State: APjAAAVlKfzZvqRQ5JBwoL6C5KICKbXrJhoR6NuPBk648TQgMsO4ERNz
        0Giqqlo2eCX+Z7b0C4dUzDPYh0GOyuXQEVJQcqY309JmPaHL
X-Google-Smtp-Source: APXvYqwhR3+zVFicz84FdyMKNQPhNHwklyb693oiKSp86LesWMPJcAKN6XNqR9IqlX+Hlyu5/TFPC0OxGRGzq0Ktyjg=
X-Received: by 2002:a2e:6e0e:: with SMTP id j14mr558894ljc.85.1560955244349;
 Wed, 19 Jun 2019 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142630.26648-1-sds@tycho.nsa.gov>
In-Reply-To: <20190619142630.26648-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jun 2019 10:40:33 -0400
Message-ID: <CAHC9VhQ1Bo-xpROgZa18MqxJSnTLoYoj6GbQR-pmDy2jSDs1bQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix old python shebang in tests/overlay/access
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 19, 2019 at 10:26 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> /usr/bin/python is no longer installed by default, so this test
> script fails on default installs.
> Best practice guidance appears to be to switch to using
> /usr/bin/python3 instead, per
> https://docs.fedoraproject.org/en-US/packaging-guidelines/Python/
>
> Fixes: #46
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/overlay/access | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think it would be better to reference the Python upstream guidance
regarding "python3" instead of the Fedora packaging guidelines.
Keeping things distro agnostic is a good goal whenever possible.

* https://www.python.org/dev/peps/pep-0394

> diff --git a/tests/overlay/access b/tests/overlay/access
> index 5a47eb145904..e50d5b402ebd 100755
> --- a/tests/overlay/access
> +++ b/tests/overlay/access
> @@ -1,4 +1,4 @@
> -#!/bin/python
> +#!/usr/bin/python3
>  import os, sys
>  try:
>          acc=eval("os.%s" % sys.argv[2])
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
