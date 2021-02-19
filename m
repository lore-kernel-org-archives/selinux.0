Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42096C433DB
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 19:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C5864E77
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 19:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBSTSH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBSTSD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 14:18:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D068C061756
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 11:17:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id do6so15566956ejc.3
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZs1wSdgL/SgoAFkReiUr/6KBmirZDSjcDrTj7CIg3Q=;
        b=ua2occSxmZ9pUaLq1SZ0Sz170vvJnrhM34LPqSndWBqBxPuodbAEB7iSwTWJz8SwYK
         aWF7e82VnwiJe+RSkTDh3XYbQGUk5DxCnqF7d5cPe4PJRgH4JaLfOh4RdmSdeX4dVHGg
         m3WN77Lm16C+0C7NrOcp7ngfZEA2WvSUG/eULV4sWMa1Hr1WIf87PaJaBMO9tYxeQQyd
         ASQrD9bcqa2i5Au7lg4W5kNtMXbx7/uiieipnmULzSWXFVbmamCdmSvuhcCNo3a4OG6h
         gKhrxD2DTjIv92/nGe8K1A5TVGPlDZwZ/grsfs8qjTiQzLlYg0IZc3xD/8MtfH21SOu6
         cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZs1wSdgL/SgoAFkReiUr/6KBmirZDSjcDrTj7CIg3Q=;
        b=FZkwpFeNAIrljisporOCUAIeHgzvm0+yDgiFJcyzEo3QE8Tc51QOTlIWIROr0IxuC6
         jneub6LjvQYHna+dybQwlVmDugNEVKwR4NiRwNCiD85BB+kVyrgBW/hm0YJB5cSoyA2r
         uIOOOJVv3ICeoGSD/mYLCv7+U9ik3EbdnfNqV0/MHQBi6s1dYaYGesJEIZBniB1MM/G2
         Z/VcURydCW1O1qIfXVyeMbb24Hn4SEmftpWcUSgQkBGnVCITc9Uw9FqF5Z1r/HJU5bbD
         SxFtUO96t0cOvkinilGZYpC8TCo8Bu4sdo9xF/xisGfPD8Nm9AU2T6NlJD2dDcj2i44e
         cMkg==
X-Gm-Message-State: AOAM532WMzXVgg3+BEzMuR/EXrgH1iiLtpLimz9bvq09iBGl3UU8oFCm
        dTAqAeOyS6Q3VXu/SEEbbcANB9S9CbbQ2vkYFaBc
X-Google-Smtp-Source: ABdhPJw+gZP/nDPCsSBenWAkB0SKtr5q8oled0F3cbjP7gQRq9BHgZ9B/kJBuy5LKnJX9UA8ax3dR7wXijdM4FThhI4=
X-Received: by 2002:a17:906:c28e:: with SMTP id r14mr7665056ejz.546.1613762241659;
 Fri, 19 Feb 2021 11:17:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
 <a38955de-1a71-ab0c-0cff-d63ea258ca81@schaufler-ca.com>
In-Reply-To: <a38955de-1a71-ab0c-0cff-d63ea258ca81@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Feb 2021 14:17:10 -0500
Message-ID: <CAHC9VhQcDbitpkWXoY5xU+Hmqv5PHKFS+An402gzDT71dUmPfA@mail.gmail.com>
Subject: Re: security_task_getsecid() and subjective vs objective task creds
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 18, 2021 at 4:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/18/2021 11:34 AM, Paul Moore wrote:

...

> > How do we want to fix this?  The obvious fix is to change the SELinux,
> > AppArmor, and Smack security_task_getsecid() implementations to return
> > the subjective security ID (->cred), and likely make a note in
> > lsm_hooks.h,
>
> That would be my choice.

As I've dug into this more, it does look like that is closest to being
correct, but there are still a few callers where it looks like the
objective creds are needed.  I think the correct thing to do is
convert the existing hook to use the subjective creds and add a
"_subj" at the end, while also creating a new
security_task_getsecid_obj() hook to return the objective cred and
updating those few callers that need it.

I'll see about making the associated changes to the Smack and AppArmor
code too, but that will obviously need some heavy review by you and
John.

--
paul moore
www.paul-moore.com
