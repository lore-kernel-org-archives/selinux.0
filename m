Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF9C47256
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C32078C
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 20:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRNiGfg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgEFUH5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgEFUH5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 16:07:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43996C061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 13:07:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z17so2457061oto.4
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/KhdT1aVQ0p0sDMZWj9qLdJgoTas7eJHjqavSpqFrA=;
        b=cRNiGfg/ccE0mRBDv7MgDaNOlEO3yBiUbrdqTLHGu0VXNJK5xUHilGwyk27dRqXg2Y
         2X2bml6ihnptsXV9cpcgfaIyZDRlwYhgaUxiNS3fv3+uqKVPdzCIjQ1I/MBpCbjvPtTn
         8IACcuL7PHPIhay2JOdXgifzwdrT4jml4tK3ZMX/Lu3/+xgmDS+y8Gz+WJciD8UCuZZL
         CX/5s2DI8Ob9MtN2ZGn82uYg+3bhwOnfOuMAREFOHmErRCv6BImGIs05PI+raI9u/tmO
         HEeKUzIrqDPab7OWUEal0rVSx3Ehb9XE6E7pl2G+l5hcQiBwwIVhk3wyqhxGlaU5iGh9
         8Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/KhdT1aVQ0p0sDMZWj9qLdJgoTas7eJHjqavSpqFrA=;
        b=EaqPdao/akS3YQ9EGSXC3KSxoukOdYJulV7egpw4xm3vR159dFuy7xoao+K2Gfdl+t
         dY+XlgLk7nLZGVE3y4ixzRQGcGAnlkJfo6deY/0YDGPduM8rXuyfatlAxGCcj3fVmZSL
         FhntDvbe3ZU2ctc/sDJVEWqibn7WhYTEfD5PwE4mcbaZIuO8KflAx8w7VVyZXjSxAflK
         T3C4R+0r1fsVoN5AFbtP/LyljUz8vG+0fflvoadBJt8dmq4ZtkxM74GTZJgyF85L3cg/
         MDsm94wzTG8r8+6yvOxX/nzzPzGiXt7Ma9Iat5DBnKYmLolhh8RzhR1iE+OdfhuBW7wm
         SDnQ==
X-Gm-Message-State: AGi0PuZZQoe7C/YvbPGaY30nde+MA6cmdmxzPoP4C3yIVlqgGEZC+XIT
        gzzBq24gMG9HqRhQekQbBPQ2eLizQOx9NAulhqQnIcRRMnA=
X-Google-Smtp-Source: APiQypJ5h14Ydlzcg/6/3VsmMOvg9L6LNHcwTQkGzOnNmDp1LAyvSdLo5ZW6KZRczoyyC7CgjUYzHvSJEVD3h7twNqM=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr7978637otb.162.1588795676429;
 Wed, 06 May 2020 13:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <CAJVWAV07O-cQ5EzqYpodjeVRjdtD7ga=bUwEiTm00BaKRMiyFQ@mail.gmail.com> <CAJVWAV3Aq1VQodmLSOr-qV4AFXTz7CPV4fEUuSTqBTHseOFzpw@mail.gmail.com>
In-Reply-To: <CAJVWAV3Aq1VQodmLSOr-qV4AFXTz7CPV4fEUuSTqBTHseOFzpw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 May 2020 16:07:45 -0400
Message-ID: <CAEjxPJ4Dryp2QFAg0a6xwNzp15HELSy5AcGPb=AzM9y-xzaHYw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Dac Override <dac.override@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 4:03 PM Dac Override <dac.override@gmail.com> wrote:
> I think one reboot should be enough but i don't see how you would do
> it without rebooting at all.
> By adding selinux=1 on the kernel boot line you effectively disable
> apparmor (the apparmor service unit has a condition that disables when
> selinux=1 i believe)
> You dont need that selinux-activate script either. The pam config
> should be set up out of the box.
> all that remains it the kernel boot options and relabel AFAIK. The
> boot options can be added without booting by editing /etc/default/grub
> and running update-grub, but relabeling requires a reboot.
>
> Enabling SELinux is actually amazingly simple considering the circumstances.

With installer support for SELinux, it should be possible to specify
SELinux enablement as part of the original install and avoid the need
for a separate step to modify any configurations, relabeling, or
rebooting.  Just like Fedora.  That said, I don't know if such an
installation option would be accessible via travis-ci configuration
and thus still might not be possible to enable SELinux on a travis-ci
instance unless using your own infrastructure.
