Return-Path: <SRS0=943q=YY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115C6CA9EC3
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 09:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D760F20873
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Cyy5/rCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJaJ7O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:59:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34934 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJ7O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Oct 2019 05:59:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so5960278lji.2
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2019 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEJbU2rgApYQsP5oc1fUoEtG5MBRfvJu486+wqYqYYA=;
        b=Cyy5/rCIFY5f7Z2VhGXr0q68qkjYNadSA+vy4jIBaBdaXgujIRyZVcGBy5UcW9FbyS
         QfX5ByTZrFrB6qDu0/JwSerxpAYbxvTdp43OGgikn7HVFN3Z1ZMdW9CUJi2SZ80U/yGd
         mhOvV1GaFXnNgEgJ/qB+babZIEskYGtanDUtfbX8SsYjuC9AmmMlVZrfCKKaLrwX2Blv
         H4IJDTGozKPg1aj9aNzVfp6RxZ5bwDBAVY939KzhO3L0MunyYnVqOw0AY8nuSzm8jfBz
         3Wi0hOV6E+gJzefyNuu2Rqto0SygVdp/FIDOe1nwXN5Jv1yJ/F7Pf1J9EdmC+SrvBj3u
         wkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEJbU2rgApYQsP5oc1fUoEtG5MBRfvJu486+wqYqYYA=;
        b=bLFonDqdgafkXYlV68b0JCSkye70rM8LTfOLb2HJbXGEEgWLlB2w9nC8nC/Dwy8hFz
         DwGg3mj9AqWuy0sg2kM0DABq35SoewhhH89kd3g5udkm6iOlrzChQTp1MOAUI+gRW0W3
         HbHpehCjivvHNqJGEp71jWRzF/hUs0P51oXoMLT3oHorFZ7fwv39elON7m98HMVZHwMT
         nPuoBIo+u/EjlQ97P+oCHGOpBwK2Y/hD0rbnnQQI8UJIY5IkieAJPKgXEFSJfD7ptqBG
         jWkcrcJCnCXSBbz11A1sLDNXfUE+qoWjkjWruhqt2SMcMhEKyDh5o+Bc8ufY3sM91Gsh
         9gYA==
X-Gm-Message-State: APjAAAU8pmlTkvDUYDtxaKVEOdyHnUlYaFL/XvUWXsTMBBFELZx9H8cE
        Ozdsfb5zr8hRhflW9NHQab36DHuoU1kUjU+7zPsmYseGuQ==
X-Google-Smtp-Source: APXvYqwqjn0N6pSHz+WSSCakyVXvNFOS45EHhReg7fl3V97iPusfeIv8jbpW6b7JTxbAqjC3rhOdvZVHRbE9gLfRgew=
X-Received: by 2002:a2e:3016:: with SMTP id w22mr3539261ljw.117.1572515951902;
 Thu, 31 Oct 2019 02:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131633.9356-1-sds@tycho.nsa.gov>
In-Reply-To: <20191030131633.9356-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Oct 2019 05:59:00 -0400
Message-ID: <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and confidentiality
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 30, 2019 at 9:16 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Add SELinux access control hooks for lockdown integrity and
> confidentiality. This effectively mimics the current implementation of
> lockdown (caveat noted below). If lockdown is enabled alongside SELinux,
> then the lockdown access control will take precedence over the SELinux
> lockdown implementation.
>
> Note that this SELinux implementation allows the integrity and
> confidentiality reasons to be controlled independently from one another.
> Thus, in an SELinux policy, one could allow integrity operations while
> blocking confidentiality operations.
>
> (original patch authored by an intern who wishes to remain anonymous;
> I am signing off on his behalf)
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 36e531b91df2..6722c6b4ae74 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -91,6 +91,7 @@
>  #include <uapi/linux/mount.h>
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
> +#include <linux/security.h>
>
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6799,6 +6800,25 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  }
>  #endif
>
> +static int selinux_lockdown(enum lockdown_reason what)
> +{
> +       u32 sid = current_sid();
> +
> +       if (what <= LOCKDOWN_INTEGRITY_MAX)
> +               return avc_has_perm(&selinux_state,
> +                               sid, sid,
> +                               SECCLASS_LOCKDOWN, LOCKDOWN__INTEGRITY, NULL);
> +       else if (what <= LOCKDOWN_CONFIDENTIALITY_MAX)
> +               return avc_has_perm(&selinux_state,
> +                               sid, sid,
> +                               SECCLASS_LOCKDOWN, LOCKDOWN__CONFIDENTIALITY,
> +                               NULL);
> +
> +       /* invalid reason */
> +       pr_warn("SELinux: invalid lockdown reason\n");
> +       return -EPERM;
> +}

I don't have any objections to adding a hook to control access to the
lockdown functionality (I think it's a good idea), but I am a little
nervous about the granularity of the control.  Sticking with just an
integrity and a confidentiality permission seems okay, but I worry
about adding additional permissions until we have a better idea of how
the lockdown functionality is adopted by developers and we see how the
lockdown_reason evolves.

-- 
paul moore
www.paul-moore.com
