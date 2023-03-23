Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB38C76196
	for <selinux@archiver.kernel.org>; Thu, 23 Mar 2023 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCWOzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjCWOzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Mar 2023 10:55:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FEC1A95D
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 07:55:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x198so15456070ybe.9
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679583312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy7FFNSqm+7qYrseWG2QC5VYof+XLe7436xAkIcWYeQ=;
        b=M40xzl8c+0MhuyYwNiU0o2bU6jntsFNDRQ9QAyLcljW/DYOysaJEYllZYOw5l1FuI7
         2S+SDEYNza+/tLyZPAyZ6mdHPyz0WELslxJFRivKSE8ybZQCE0Fz6tLKX9lxZT8ult7G
         Px98EB6t+qFNyxNXi8LbrBDpOr7CCUHO0raw2W+Po86WeAErVdRUlwCZ91SNtLjnHuQK
         aHQ0hOHi9gmjHLCtTznYUTMZ5doiVVOyXitUDRn6+Gq6r/WHz4dinjpkf658JmOmjVys
         gbUrxBGkHYHuG390a3tTxy7xnmXcjNf41sb3EcHqbzjQX5ov9aObcq62bcvIBcQg0S8K
         rHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679583312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy7FFNSqm+7qYrseWG2QC5VYof+XLe7436xAkIcWYeQ=;
        b=MZQMcaVVTj+BHK93MZSB/tZzf5PY3lqqVh3j6Deoa0Li3aUItwHHHP9UppbdCPChjd
         w1pkVTfLh2DHLEsY9iIgJzszD57CMhmvvMkc4OT7mNLhWKINMrRojQpOqhD6Yyr9INpW
         GslYnKOlbw5mqBxFGZDAr7pY4uAFYwF8rRSlyS2IUxkHmXofEePR1WoQY9D0LJOPoQAV
         TQXCMA8yubCB2jRMSXGZPmmI2HjUUftAi/CBTCd2AznlPdF+C6wqC67VQc9bOnu/xTy4
         mqh9VO15pQ3bevmGs/mQKUmkuoZA1pgamPT7izCOQvxW+rRyq6xLkM4FRfkkgna6L2yS
         eJRQ==
X-Gm-Message-State: AAQBX9f5nHVJpT+NzjWvuctLDSoTz8JC8jlFiQCQ8xfNwbQIlHlr+Bz0
        EKBpxlymx+y0jir2FHHnoSwKLMemgmhUUe6Adwtl
X-Google-Smtp-Source: AKy350bJt5bMNPC0Xm+1IPMpOTEb2k1V4CfVzwTo1AvCxyUv7/kT2W5I1z7yBE+7demo9K6RS3MhizAampSlgqdSnww=
X-Received: by 2002:a05:6902:1895:b0:b69:bf76:2243 with SMTP id
 cj21-20020a056902189500b00b69bf762243mr2423097ybb.3.1679583311921; Thu, 23
 Mar 2023 07:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230323051241.24841-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230323051241.24841-1-lukas.bulwahn@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 10:55:01 -0400
Message-ID: <CAHC9VhQ7O-qSb18HeG3wjeYC97sQNd1dSYHqTncAcZK3mSPGrQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up dead code after removing runtime disable
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 23, 2023 at 1:12=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> Commit f22f9aaf6c3d ("selinux: remove the runtime disable functionality")
> removes the config SECURITY_SELINUX_DISABLE. This results in some dead co=
de
> in lsm_hooks.h and a reference in the ABI documentation leading nowhere a=
s
> the help text is simply gone.
>
> Remove the dead code and dead reference.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Paul, please pick this minor cleanup patch on top of your commit above.

Hi Lukas, thanks for catching this and sending a patch!  For future
reference, you don't need to add a note asking me to pick up this
patch, as long as you send it to the right mailing list - you did -
I'll see it and you'll either get a quick reply when I merge it or a
longer reply with comments/feedback.

One comment below ...

> diff --git a/Documentation/ABI/removed/sysfs-selinux-disable b/Documentat=
ion/ABI/removed/sysfs-selinux-disable
> index cb783c64cab3..1ae9587231e1 100644
> --- a/Documentation/ABI/removed/sysfs-selinux-disable
> +++ b/Documentation/ABI/removed/sysfs-selinux-disable
> @@ -24,6 +24,3 @@ Description:
>         SELinux at runtime.  Fedora is in the process of removing the
>         selinuxfs "disable" node and once that is complete we will start =
the
>         slow process of removing this code from the kernel.
> -
> -       More information on /sys/fs/selinux/disable can be found under th=
e
> -       CONFIG_SECURITY_SELINUX_DISABLE Kconfig option.

When I moved the deprecation notice from the "obsolete" to the
"removed" directory I added a note at the top which read:

  "REMOVAL UPDATE: The SELinux checkreqprot functionality was
   removed in March 2023, the original deprecation notice is
   shown below."

My goal was to preserve the original notice as much as possible,
including the references to the now defunct Kconfig option, to help
people who are trying to understand how things worked prior to the
removal.

If you can remove this part of your patch and resubmit I'll happily
merge it into the selinux/next tree.

Thanks!

--=20
paul-moore.com
