Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B56C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E82F20705
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Je1bXqD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgAaMzz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:55:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46361 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgAaMzz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 07:55:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so7606837edi.13
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2020 04:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbaD30OhV748+1YHwxUQDOnzR5rNjTAvrfDF5+aexyQ=;
        b=Je1bXqD3EBIUj0MxZt2KvaqliAA/d+EPlobzsvBcwMmNSTAanQaGa20RewqqkdsrzL
         ruKZwzcYR2kVtTYL87y6nWaxrfRRu7N7TkBkMECzEErQmXPslZDqP6LLKYfIL7zMJReW
         jPSBH6wlhMnBfusc4QjbMABknMgpFAYh692nzFjeIhRLE2yUWYOI+Nxru/KRhbdP8Uir
         HAbSF6wnYylwJXQEtPdMRiBjS16xFtxpvnTuztUhK5rsq4lAfs6+mjyMzWAmNeRXVOwO
         U9BqyGKk9exISn/QfpKvB5kjMo/izUSrzay3ptR5wyYHmsbJgK6UACmedwDRHi9pP1vm
         8DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbaD30OhV748+1YHwxUQDOnzR5rNjTAvrfDF5+aexyQ=;
        b=EYgycwPT0vTwJAXYcytZZjSw7E/Nt9FFl6PVM04Mmd/iK9kFr1465fudMD5tFqCDZz
         43eEjD5PAt1NaV7JAq02hOR3oN2SfxbkMeTePI4VN1r/68LxSvKf15M4fRR6je/x3Y6V
         SSzQ5DNnIszwqkokuoMZ6Gi/8mKE1S1mYPv9xenEvHUDvZnYWBTF2zQT95R5AWrE44dD
         G5z1PFm4XBbaEK0cgiXDSTGhz5DwcHZnnQGUipIhscypG5QT9Wspx9pzAKBlL6mU8NCA
         Byq640E7wrnPtJVDZuxtIcNwRKBCK+FE8PKcMckM4oH46M3JKuEa4F3PZwH+PP7uhsBZ
         U1fA==
X-Gm-Message-State: APjAAAU1Wtva5bZrufZtmDzL+39RwRal5KzfTGeq2xkrAHvrEt9rTLjN
        QqlXS+xZ2wAQErl4t4V2WPBr+r/kAr5QnvkArU5KAaK7BDVs
X-Google-Smtp-Source: APXvYqwd3KUpi2gGZ7D82BlJk14YtXtk0bGDKexmH3h1dGzHGDI5lwKpWZcO2M746gdjc62t23u45zYGlAB0r6W6p8I=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr51928edv.135.1580475353590;
 Fri, 31 Jan 2020 04:55:53 -0800 (PST)
MIME-Version: 1.0
References: <dc87965f-e3e8-f9d0-ee1f-07ba14ac3575@virtuozzo.com>
In-Reply-To: <dc87965f-e3e8-f9d0-ee1f-07ba14ac3575@virtuozzo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 Jan 2020 07:55:42 -0500
Message-ID: <CAHC9VhR3oV=d7S+PELcCg+Qt7hjV_GJYGmqMdCNvsxAWCJYfHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sel_avc_get_stat_idx should increase position index
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 1:33 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  security/selinux/selinuxfs.c | 1 +
>  1 file changed, 1 insertion(+)

It would be very nice if you could update this patch similar to what
you did for the keys subsystem (archive link below).  You included
most of that information in your cover letter, but unfortunately cover
letters don't make their way into the git log, only the individual
commit descriptions.

https://lore.kernel.org/linux-security-module/af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com

Thank you.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ee94fa4..ad5530e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1504,6 +1504,7 @@ static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
>                 *idx = cpu + 1;
>                 return &per_cpu(avc_cache_stats, cpu);
>         }
> +       (*idx)++;
>         return NULL;
>  }
>
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
