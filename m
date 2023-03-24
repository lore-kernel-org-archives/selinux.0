Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5499C6FD20
	for <selinux@archiver.kernel.org>; Fri, 24 Mar 2023 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCXUU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjCXUU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Mar 2023 16:20:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2421ADEA
        for <selinux@vger.kernel.org>; Fri, 24 Mar 2023 13:20:15 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544b959a971so53865377b3.3
        for <selinux@vger.kernel.org>; Fri, 24 Mar 2023 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679689214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE3yJDI+pYJuCMQv+LbLHvHpakC5z20Q31kT7kG1Coo=;
        b=US49Rj0ujiV1sooDfFrHrBRZjgcRszsxXf3GeR9J081S3w7ZzTM6r5FO/PKKKbC4P7
         JqVFTPdgA8dXgaKVQId6RAB2A+fZiRtEXfRwOCBeFLdEBGoomLmHC8smJW9HgWuQFSzn
         o7BqQPMoH8a5waHthHsy0R/00uU769JgCEN6Wd0VaQl3gm2KkB4iwXIgolQz75n4PRZk
         Rh5A5mgeRFFnC5UumzUemh3zi7kEvN1ZIv1sDcX9/9BraIwygvvrfBYVpOOZHfxE+QQA
         xUrXbAfn7n9jpcTDrTbKgHCcjhonPev/X8vh9qvVQxXETWrlOsQfjcivSfReJHpLAS1K
         vs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE3yJDI+pYJuCMQv+LbLHvHpakC5z20Q31kT7kG1Coo=;
        b=O+owx7WqjXHbjrEZ8kBcVpQvM8CRc0ffsKxzvBOAf2s0QwFf3ZzdWOFPtcg0jQpcyZ
         7aIj5TYcbdHrFk43xFrsnazOq7OWNf8CSLAawKlXqoezBMJ+IVuThOhmc0LDYYnSL/Y/
         Lq9W9hk8JlyYxw2UB+PB5qm4/PP3SVStHNginze7e6JDGLfHOXo6xrLs9FdHnHl/4+uz
         m5cgAdFVY1cx4Ec8QcbkvtirCUkAqVLdBhxHSQjhImzwMTbjKyg37NTV8DztzdPLOY7x
         /jfirUKGinBEUCR0qhPIiQ7K18D/NnSAbJGYrf+1nWcirgsiUUd6lqMvliRXbBbkmagH
         B/zg==
X-Gm-Message-State: AAQBX9f57kuNfve2D1nSpyqjVIWdlnskd06FTSD+7/qAHSw70zwIWgKH
        8ClYPt3xtmjOY/IQDQZpxpAZpv9RJ1xslK4by6lmy7hKa89Z/2Y=
X-Google-Smtp-Source: AKy350aNTAC0qgpuAb8ntTTl8mLGMQTnxRclhRZIGJOBRGHivChNONp2c378J/aHROxYvUeUJPLKF0Ck6VdvcPwH4cE=
X-Received: by 2002:a81:af18:0:b0:541:7f7b:a2ff with SMTP id
 n24-20020a81af18000000b005417f7ba2ffmr1650801ywh.8.1679689214313; Fri, 24 Mar
 2023 13:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230324092114.13907-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230324092114.13907-1-lukas.bulwahn@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Mar 2023 16:20:03 -0400
Message-ID: <CAHC9VhT70JYNmE5ROhnYzqFv3UcYcP9mGdiD4X_kdiAspStr8A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: clean up dead code after removing runtime disable
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 24, 2023 at 5:23=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> Commit f22f9aaf6c3d ("selinux: remove the runtime disable functionality")
> removes the config SECURITY_SELINUX_DISABLE. This results in some dead co=
de
> in lsm_hooks.h.
>
> Remove this dead code.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  include/linux/lsm_hooks.h | 23 -----------------------
>  1 file changed, 23 deletions(-)

Thanks Lukas, this looks much better.  Merged into selinux/next.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2b04f94a31bd..ab2b2fafa4a4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -117,29 +117,6 @@ extern struct lsm_info __start_early_lsm_info[], __e=
nd_early_lsm_info[];
>                 __used __section(".early_lsm_info.init")                \
>                 __aligned(sizeof(unsigned long))
>
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -/*
> - * Assuring the safety of deleting a security module is up to
> - * the security module involved. This may entail ordering the
> - * module's hook list in a particular way, refusing to disable
> - * the module once a policy is loaded or any number of other
> - * actions better imagined than described.
> - *
> - * The name of the configuration option reflects the only module
> - * that currently uses the mechanism. Any developer who thinks
> - * disabling their module is a good idea needs to be at least as
> - * careful as the SELinux team.
> - */
> -static inline void security_delete_hooks(struct security_hook_list *hook=
s,
> -                                               int count)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < count; i++)
> -               hlist_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> -
>  extern int lsm_inode_alloc(struct inode *inode);
>
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> --
> 2.17.1

--=20
paul-moore.com
