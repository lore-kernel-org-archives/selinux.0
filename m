Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82EDC433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 23:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiBVX3K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiBVX3K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 18:29:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA3A27B1
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:28:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a8so47744669ejc.8
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sDj0qMJJiN5G76triZ2YOQFF95CL0AvqXtgUFOJ/qk=;
        b=hPpp7SkwemAPoCxUmzJK8Z9jEuz2Ipp1/bHRj8z9satZdk6aNRAmEZ1xsvLdbSt7Fj
         CGTAEBI2ZwJ7tklGkS0Y4emJNlChkcpsrDDtHIIsI253bWpbBE3OtDR7USWHSUIlGxan
         IiyjiQCNYab6YGCbWjIPcp8tUsuN2Qc20uPWtpzA+syN1WUN6D1ogO/8Ca14REDOzxem
         cvHIcjGhdEQZvofhwdxgsOLguJF87p/WhFstfmPeTd5neXlk9uIKr6fiQQfaibKXN9X9
         nCc/y+Wuw6LOgyKv5lTFUaivLmqGa9C3z/T05HMWVWQbxdo7dUXWrw2l/ePGBVMj1sp6
         oUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sDj0qMJJiN5G76triZ2YOQFF95CL0AvqXtgUFOJ/qk=;
        b=aL1cfW/fI/TPxBvJ/lriyHvPYEioe9Kfp4JmXnutAZlEYwFe0CMc5NqvIWB8ZsCGIE
         GQzLPYhTG0bhomQZ+5hVCtreZF7GM6u4JhRnbAZcQw7EbQ/aH66yiGGGLFVpPdMPpErf
         legez8/8cBVo08qKHQEvyGVrYH857f+Q81BOTKhx66qy1nN9//T7bIJcayKBlRFj44Zl
         9R5v022lM/Jc3aDDEpKUTqvw9LzbcCVlHiqJMPNt1bVzDm5k3NqHsafjtyIDIOqes5I5
         EZ3H0Ag/d/n+jYxSzpEAih6q6KFQuzvKwLh7gqoUm49gv/FYaU6dE6FgzoLVvBb4daJZ
         KZ6A==
X-Gm-Message-State: AOAM532amDo9AyfYNleQ+X4JIfEcoHyx4x91WlmLAEzRJqy202JBuYLv
        18hBLUCeAVxO4tP8QVqbBVmd5yL6kw9G56rsA9zm
X-Google-Smtp-Source: ABdhPJy51IWDBSElZ4OCACw6vfJARdAcG+E2xuozKMf80uepmG8u0le8bdcjGxHhoQ2VySs/aduZM0VYpM77G+KdSJU=
X-Received: by 2002:a17:906:c318:b0:6cf:d118:59d8 with SMTP id
 s24-20020a170906c31800b006cfd11859d8mr20829134ejz.112.1645572522506; Tue, 22
 Feb 2022 15:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220221131533.74238-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Feb 2022 18:28:31 -0500
Message-ID: <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        demiobenour@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> descriptor being leaked to a process that should not have access to it.
>
> As this patch removes access controls, a policy capability needs to be
> enabled in policy to always allow these ioctls.
>
> Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change: Control via a policy capability. See this thread for discussion:
> https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
>
> With this patch and the polcap enabled, the selinux-testsuite will fail:
> ioctl/test at line 47 - Will need a fix.
>
>  security/selinux/hooks.c                   | 7 +++++++
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 3 ++-
>  security/selinux/include/security.h        | 7 +++++++
>  4 files changed, 17 insertions(+), 1 deletion(-)

Thanks Richard for putting together the v2 of this patch.

As far as the test is concerned, it seems like the quick-n-dirty fix
is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
everyone okay with that?  At least that is what I'm going to do with
my local copy that I use to validate the kernel-secnext builds unless
someone has a better patch :)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4f..030c41652 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>                                             CAP_OPT_NONE, true);
>                 break;
>
> +       case FIOCLEX:
> +       case FIONCLEX:
> +               /* Must always succeed if polcap set, else default: */
> +               if (selinux_policycap_ioctl_skip_cloexec())
> +                       break;
> +               fallthrough;
> +

The break/fallthrough looks like it might be a little more fragile
than necessary, how about something like this:

  case FIOCLEX:
  case FIONCLEX:
    if (!selinux_policycap_ioctl_skip_cloexec())
      error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
      break;

Yes, it does duplicate the default ioctl_has_perm() call, but since we
are effectively deprecating this and locking the FIOCLEX/FIONCLEX
behavior with this policy capability it seems okay to me (and
preferable to relying on the fallthrough).

Thoughts?

-- 
paul-moore.com
