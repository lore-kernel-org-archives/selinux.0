Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC05C433F5
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 00:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiBYAfE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBYAfE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 19:35:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCB24FA2A
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 16:34:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h15so5209519edv.7
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 16:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7JZLiTaaSBR+Poz7SRaGfgsdoBr6p+bG2YMfUy3Slw=;
        b=kg2PGF0EVFDRcG1mIXlLVEv5Ej1ZhQ7nNfe4zx5FcXv2Z07350v9XCQ87Fy0kkQMHj
         12qdDKOYqzndeSrhOXAjHk39Xowv3LtN14PQ+2zqEkoxbWdoS3L+Yr3ILhg0aV9jDzMU
         nEzwTLq7qo/OpikrpjRdL66whBt4gns2ydEz4+42D0JFsDsm/IbcmPypfgIfrEZmJNUr
         RLah9HnZHqHB+yIswc5D04W2DJkHzdtkGYTr8FQ9sAbu7v2boYFMPMIrRbbjWepcwFTG
         9+Opr8Zt6xNA9iQcdK5rGvdkIOl3piw5hI7REcbQGJsvH9Kg77wOhUda1JHAhW/BMzVF
         DcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7JZLiTaaSBR+Poz7SRaGfgsdoBr6p+bG2YMfUy3Slw=;
        b=obbwZto9MkfDJE3HaEtlw5wBreteo+pHQziNnvgm6Xrm9rTN8Lctj6Ui/aRUlTwd0n
         cE7E0/8Mk+2kcl+qbSme1iUzU+WyppSSZbZQ7dn8olkldYEX6Gmp9bm/pfAL7Dc/P0YP
         Ju6kK8wuzbbksQ2BJhvsMYniXB7zjPAhMieQAcb5SG4bR2URO95jtJCTTapYhRUAzs4u
         OzBAzznCFLrERFavmDl4230DwZNx9hkPp/d9M1hI7zpbyev3jLLEv5EwBqfK3lsmVPwW
         nTlpSDBNVibXNohMw7eJMcmXhZCwRGAVfZxxaeotDxkYFuMyhDeuz6xwu2uZllnV+Bkt
         6/lQ==
X-Gm-Message-State: AOAM532GDh0g2S+JYcoN9NvD2W/07TKdwV3FWfvF1b2us7VKIRWuQKOt
        9GHhxG/I88IzAaAvEQRA8SJKeDYypEX+wlt9GAbl
X-Google-Smtp-Source: ABdhPJw1CgqWyynCBf+FLm6LEHLJR8C5F5nAupSJMqeBc+oQWEUfQtfsZ/DTgiH22ChcD6v/sqSjwhOyjeyeCGJXlDQ=
X-Received: by 2002:a50:e004:0:b0:410:a39b:e30c with SMTP id
 e4-20020a50e004000000b00410a39be30cmr4645925edl.198.1645749271746; Thu, 24
 Feb 2022 16:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20220224102417.42268-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220224102417.42268-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Feb 2022 19:34:20 -0500
Message-ID: <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com>
Subject: Re: [PATCH V3] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        demiobenour@gmail.com, linux-kernel@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 24, 2022 at 5:24 AM Richard Haines
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
> V2 Change: Control via a policy capability.
> V3 Change: Update switch check.
>
>  security/selinux/hooks.c                   | 6 ++++++
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 3 ++-
>  security/selinux/include/security.h        | 7 +++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)

This looks good to me, but before I merge this are the SELinux
userspace folks okay with the policy capability's name and enum value?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4f..d369c2d82 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3745,6 +3745,12 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>                                             CAP_OPT_NONE, true);
>                 break;
>
> +       case FIOCLEX:
> +       case FIONCLEX:
> +               if (!selinux_policycap_ioctl_skip_cloexec())
> +                       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> +               break;
> +
>         /* default case assumes that the command will go
>          * to the file's ioctl() function.
>          */
> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
> index 2ec038efb..44d73dc32 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -11,6 +11,7 @@ enum {
>         POLICYDB_CAPABILITY_CGROUPSECLABEL,
>         POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>         POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAPABILITY_IOCTL_CLOEXEC,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
> index b89289f09..ebd64afe1 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>         "always_check_network",
>         "cgroup_seclabel",
>         "nnp_nosuid_transition",
> -       "genfs_seclabel_symlinks"
> +       "genfs_seclabel_symlinks",
> +       "ioctl_skip_cloexec"
>  };
>
>  #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ac0ece013..8a789c22b 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -219,6 +219,13 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>         return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
>  }
>
> +static inline bool selinux_policycap_ioctl_skip_cloexec(void)
> +{
> +       struct selinux_state *state = &selinux_state;
> +
> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_IOCTL_CLOEXEC]);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.35.1

-- 
paul-moore.com
