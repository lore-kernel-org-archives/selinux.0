Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3DC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BDA20645
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wf+87+EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfDSS7m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34130 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfDSS7l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 14:59:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id j89so5398221ljb.1
        for <selinux@vger.kernel.org>; Fri, 19 Apr 2019 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z76qy/WYscT8yTKM3EVAchBs4dSJCLcS1D6tVIKxsTY=;
        b=wf+87+EIb4rIEjz9uA3YYlHwFC3NCiKJzU1g3OwuHSDIOFGIJAlWBstHMWhRp7nkIS
         zCy5nf6ld0NM/LDfTksi/wCqE0+6If9RD16LFxinXexEd7E7T8KXK+QjVPjz5F8wSVdM
         BXEZSpPUgmrKZeL0N3GbAqToD6N+V+zdTxthwVitP1WmLdHBzCzOu3pQUdeLXJqZ94uw
         ni4k51U+rpsJlGbmX6yHGaW6WAyp6MIN4FaQpw3hbEv9Aee9i9+BFBl/g/YX6iL6XbtO
         W5y9uFJWkWqpIGsdxPu2z1BJxM7Cere3gvBR46oLWGfcxcFXfoRt9lb6Msos5GHuEBze
         ZiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z76qy/WYscT8yTKM3EVAchBs4dSJCLcS1D6tVIKxsTY=;
        b=ihADVRFbzGgY19nino+NKGxFI1EJrhVPyPYOv4JJtGXNfzvIpTLl9mfX+vjtciQIzY
         9xJg1JVYBEuB6a/wcGxiuBHBT+kLojCXnZkeUSX5jQEecrraXdYMlSImmaCjz0We2TNW
         CEyOAWDSzg7OM61GPqez4MrA5zJ7luYXX7yYe68GRV76EFWHxmOmI9ak5J6RIWTrZlVD
         3oVvEvolipGgAuHXwLS/vAWSTHtib4YKrrQQHzljzPuWU2bWz00Rwe64oIHeKJPryS5c
         XpS3ILlzZsWBX65PN6BV/XdlakiBkpjG+ZAe1T2c9UenfNeNKYTYVXdj+Gn+YcTPWhPA
         1KFA==
X-Gm-Message-State: APjAAAU9+MdHRu81ok5RWKelpjoSY8zZwF36cmHkCEgiSYs/E3jSAjx8
        ilHUNeSl0nBIo8rLahEsfZfVXqAx1YPsdxALCycf
X-Google-Smtp-Source: APXvYqxD7fUYbYeicEBXyFM/4ELy//HHhu/G6PToGa+1DO64dMOqfSBCIafdH7SlNyjg0wLa2bPphC8ua/9dXY5ljrA=
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr3090917ljk.38.1555700379256;
 Fri, 19 Apr 2019 11:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <155570011247.27135.12509150054846153288.stgit@chester>
In-Reply-To: <155570011247.27135.12509150054846153288.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Apr 2019 14:59:28 -0400
Message-ID: <CAHC9VhQKE3Rnbz8qxm0UKNB=GT6xPu-Le=ZZM0_XisOS+v3jKg@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent changes to overridden credentials
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, cj.chengjian@huawei.com,
        john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 19, 2019 at 2:55 PM Paul Moore <paul@paul-moore.com> wrote:
> Prevent userspace from changing the the /proc/PID/attr values if the
> task's credentials are currently overriden.  This not only makes sense
> conceptually, it also prevents some really bizarre error cases caused
> when trying to commit credentials to a task with overridden
> credentials.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/proc/base.c |    5 +++++
>  1 file changed, 5 insertions(+)

I sent this to the LSM list as I figure it should probably go via
James' linux-security tree since it is cross-LSM and doesn't really
contain any LSM specific code.  That said, if you don't want this
James let me know and I'll send it via the SELinux tree assuming I can
get ACKs from John and Casey (this should only affect SELinux,
AppArmor, and Smack).

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..87ba007b86db 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2539,6 +2539,11 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>                 rcu_read_unlock();
>                 return -EACCES;
>         }
> +       /* Prevent changes to overridden credentials. */
> +       if (current_cred() != current_real_cred()) {
> +               rcu_read_unlock();
> +               return -EBUSY;
> +       }
>         rcu_read_unlock();
>
>         if (count > PAGE_SIZE)
>

-- 
paul moore
www.paul-moore.com
