Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C760C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 20:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED23420896
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hMdU1A7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFLUMC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:12:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43479 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfFLUMC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 16:12:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so13172369lfk.10
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qR9NCJHXPeOLqllt60ol5cNxVhV78ySl74/XzNJHKA=;
        b=hMdU1A7IdUvxxy6H/bgsv5M7AUbQYYCht1RC+rjsLO18vkp6cwpc9OA0XpycS/kjvB
         vp+sfarLJNhHKAGHwIQplUexfHPWQ5cNshr5uyk2X7o96nh/upseCDySjlm3PqcGRT30
         +18vqQMFb01TVqzy6oRKV7TSXouzbYCzWNqyNL4jzcPITnM8lvzZ1c/B+tXrOt6rIoKh
         RDsX1gGWRi4+zMK39Fyhfng78RNg8tC0ciGapPTbXKzvJTFpltQuPa0yhr9fJYe3HKTN
         hx+Vf1g1aqWqEkX/moUco6JliXr3iT44atU09at9exmoiS7j3Q38pw+kLkoMpV7sAR33
         hf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qR9NCJHXPeOLqllt60ol5cNxVhV78ySl74/XzNJHKA=;
        b=q7d7xdnNlDMItqI3aJwPD7SA4HiOQti+p4VYK8Ui3tCG68KlgZxk+24EKNrJ6reZd5
         5Aq2bbgLFCpNp3+eLboTnoPS9HfAgAzy41BeJ3Jc/QdziNN9D15y8/G3SctqzKW8SiEq
         BgP6NZJQ//nL1kwDV6KfdRYLR4m8bq6wYCFb2rcESFJ2h+8WCm01+D+SlnkMTuK06JfE
         PUNQtWaUAC1MEXE7Aqm2+NU3Mlmz69ZLQM14FzpPfOErPPU3m61irj8xEBX8QLhM2k4x
         jIKkQ6z1r2eY4nVN6JrzaLPpVrUNrVaDZPxvumw+CWkCb7h5W8yGr7GJZeFCnTKOoIIL
         f02g==
X-Gm-Message-State: APjAAAVKIkypFgg1ghbjrCeHtieovEsH9R6p8ZU6jt5PJGGbCA8/L95/
        0CktuFbaYSvARxtmvNf/uFFnnSPWosG+j3YHyOP4
X-Google-Smtp-Source: APXvYqxiMOhEvfpNpRBx8HIJxfrFG04qEyy3fNrpX6CDm+i+cbXF2ogCiyIv67xW7R5NIOEoGS3MK+5eVydQkAHdAfI=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr41936942lfh.119.1560370320040;
 Wed, 12 Jun 2019 13:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190612081226.21004-1-omosnace@redhat.com>
In-Reply-To: <20190612081226.21004-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 16:11:48 -0400
Message-ID: <CAHC9VhRwKjp9qwqMB3p7intdpxFT1oYVOUKmoEcwZcN1VAC-UA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix empty write to keycreate file
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Daniel Walsh <dwalsh@redhat.com>,
        Kir Kolyshkin <kir@sacred.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 12, 2019 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When sid == 0 (we are resetting keycreate_sid to the default value), we
> should skip the KEY__CREATE check.
>
> Before this patch, doing a zero-sized write to /proc/self/keycreate
> would check if the current task can create unlabeled keys (which would
> usually fail with -EACCESS and generate an AVC). Now it skips the check
> and correctly sets the task's keycreate_sid to 0.
>
> Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=1719067
>
> Tested using the reproducer from the report above.
>
> Fixes: 4eb582cf1fbd ("[PATCH] keys: add a way to store the appropriate context for newly-created keys")
> Reported-by: Kir Kolyshkin <kir@sacred.ru>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Looks good to me, I just merged it into selinux/next.

Continuing on our best practices trend this week ... While I like
seeing links to publicly accessible bug trackers in patches, it is
important to remember that the patch description should contain all
the important information.  In other words, one should be able to look
at the git log on a island in the middle of the ocean - no network
connectivity - and make sense of the commit.  It isn't a big deal for
this patch, both because you explained the problem and the patch
itself if trivial, but it is something to keep in mind when linking to
external issue trackers.

I've never rejected a patch because the description was too long ;)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..f77b314d0575 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6331,11 +6331,12 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>         } else if (!strcmp(name, "fscreate")) {
>                 tsec->create_sid = sid;
>         } else if (!strcmp(name, "keycreate")) {
> -               error = avc_has_perm(&selinux_state,
> -                                    mysid, sid, SECCLASS_KEY, KEY__CREATE,
> -                                    NULL);
> -               if (error)
> -                       goto abort_change;
> +               if (sid) {
> +                       error = avc_has_perm(&selinux_state, mysid, sid,
> +                                            SECCLASS_KEY, KEY__CREATE, NULL);
> +                       if (error)
> +                               goto abort_change;
> +               }
>                 tsec->keycreate_sid = sid;
>         } else if (!strcmp(name, "sockcreate")) {
>                 tsec->sockcreate_sid = sid;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
