Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B5C433F5
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 21:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiB1VoM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiB1VoK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 16:44:10 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468CB7DA
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:43:31 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 40-20020a9d032b000000b005b02923e2e6so1310163otv.1
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9KWvyq1VgLKANMJP9UcbsXFBf40giEElJapTOS1xIY=;
        b=Aet1/Tuq7Df4QdKHO6uflsTjS1KuqEt8r/O1bZANOYmFCJ/DgmhKSB4NWZCVvGxEeL
         FRpssWiFONxuDeNpJKNtHsfNWlgSVdY/SMUCMaNRF47EtlipIelqlWwvW2YAWJXbwATc
         zrm3vAlQaGWXdOv8t5ZLxWw48dstyUhgf8Ca/aX+KoybYf7j9GyV4vEMJljXnKttf7Iw
         2hrYWXjWgc07CVG4wznB2Z0xJXi/pqXWSN+heK/oxQHTWUjgTTSh2AN3G+nTlhRCLY+W
         UQ7fhMI6mzW663l7XtN9hT8xQtJhbWo+i4Out4K2TRGH+cPF6jIZj7cfsasVvwDCzEs8
         TnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9KWvyq1VgLKANMJP9UcbsXFBf40giEElJapTOS1xIY=;
        b=4C7hBuO7+1vMNy3MwKWVMI6N59+RUNV4v2LEz7DpCnezmqEeOAqdx+Ws+eyIhvAs3C
         8aFWk/WO39Cw+SCFId5DKQMcR1ad+aaQbReDWUYw22o9Fx5uCtb+R+cgV5n0HYDEBajg
         aGV1TciFJ1mVrTPzXI87VwGDOJj7iKrVKUe/DxkuZttV0tBaymfeXe5Xbg5OaHX1k0Yv
         z1iKMvp3UgHCt8g9qFKuxCavsZeFF/hdduWcxh+yywjh7tlcIQAvDHm1bSn9hC0Y2Wob
         X3doOASVdQp8IWYd95XwfKmptL2FrqZ7q83Vn24C5HhORLWKJ4Bh+QDiH9XoTRbiJEjp
         gT8A==
X-Gm-Message-State: AOAM532KJr75EM8t5J3jhebjcNKlhj6AWlfm+Y9vKzMtLmAYTTdylk/D
        P7tjJtFVYA+mYupGZKRVkPrvW+tNUK7AVU+dqRg=
X-Google-Smtp-Source: ABdhPJzWXv1Nn0J6biLI6EEmHHteMUQfFuk0nPZEi80ju2XgEEk83OSsEQMtjdG9hiHdp9CC1fuwVeKkk/kQnS4FvtE=
X-Received: by 2002:a05:6830:2390:b0:5ac:19a3:4888 with SMTP id
 l16-20020a056830239000b005ac19a34888mr10538103ots.53.1646084610795; Mon, 28
 Feb 2022 13:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20220225175549.302386-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220225175549.302386-1-richard_c_haines@btinternet.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 16:43:20 -0500
Message-ID: <CAP+JOzR0=zN-dpe=iL+MMxjD9WHvZPmECDo+56skwwGTy5NFNQ@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol: Add 'ioctl_skip_cloexec' policy capability
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 25, 2022 at 4:38 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> If 'ioctl_skip_cloexec' set, kernel will always allow FIOCLEX and FIONCLEX
> ioctls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> V2 Change: Use POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC
>
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index 40669fb5..39c99839 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -14,6 +14,7 @@ enum {
>         POLICYDB_CAPABILITY_CGROUPSECLABEL,
>         POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>         POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 6a74ec7d..a5e515f2 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -13,6 +13,7 @@ static const char * const polcap_names[] = {
>         "cgroup_seclabel",              /* POLICYDB_CAPABILITY_SECLABEL */
>         "nnp_nosuid_transition",        /* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
>         "genfs_seclabel_symlinks",      /* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
> +       "ioctl_skip_cloexec",           /* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
>         NULL
>  };
>
> --
> 2.35.1
>
