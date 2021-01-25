Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D3C433E0
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0FD22D58
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 18:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbhAYSgE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAYSeD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 13:34:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E13C06174A
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 10:33:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c2so16410284edr.11
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LoTLBQeo0cvRum59l9NRIOUS5IcCmDfx5dlFsyvM+s=;
        b=pdVVosMpylrP9cR6DmtM3Rkrlc/NeVMChHtIkcJhxa3+YEv7n0rjorXCk6j2rsdkGM
         TDwF7cdWqI/p4AT92sOPeXEIg6yA36BPUsaImX378oafdmQiJTUX6lM/f+rLS2JjakQO
         e3yg8KHMKiSgP0b7abpGpkwV9hGuMvW06wmLR4y//4e7/D3Psc3hmMO0jcaqwzBEdvd4
         fc7emk8BaHJN1rQet2e8SgEZzq8ye6bPEvdyKd5tHGR6hW+u77zEvrWUGCZZ+aOZ8cBx
         VZHo6BP7JUO0tpPfzjjZc3mXyPs7z5nyVfJaedamLpPX40cUBmbQfZYhvFt8jd4ZRd/R
         KMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LoTLBQeo0cvRum59l9NRIOUS5IcCmDfx5dlFsyvM+s=;
        b=fRtmwLhj944FtbbckYnitH3iGoxaQrwpr21DMw/6aLmTnT0E/t4j8RHnH4BRWgq7pj
         FqT3Nt/k7qENOtNFeKGSA6dM/SShnipDP9HnWosNfAQnUcj+eKF/H1EgyZ/MlFhIXGnZ
         UN8jGtvWSSBoRvgU74qfEgK3rdDEmZlmjIl6IK6e90ZGqgAPRnZPsexxG3F/pQ7im2ho
         40vfSuJk16nkDAWxrDp39Z8r3hqIOERpgbuUHmy/MZB5+uowXm5d5RJUTeOikB9OiHyW
         VnvEGUKjp+w26hJLwYlPD8+KQWxKgC5lTCQTkxdzmjOSm3ge4cfQQjfMxMiRKK2uLpF7
         gyFA==
X-Gm-Message-State: AOAM530B+7LGRuswYbX5sT+jx8JGXcrCQG8xBIKLEbmHXM6r6DHgV4mL
        GAYxaVoCFqsvg9SY7GVbFBh1EydP//6SXCNdJ2iLHA==
X-Google-Smtp-Source: ABdhPJzAtGvsv9G82M9FKtH0pxdUIPcllFNnaJ+xoYxH181v4CFsScdkuuXL6P9AlS3SwaD+Bsnj5nlzyRyk/8H9gBM=
X-Received: by 2002:a50:fe85:: with SMTP id d5mr1684107edt.140.1611599601502;
 Mon, 25 Jan 2021 10:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20210125075713.356704-1-omosnace@redhat.com>
In-Reply-To: <20210125075713.356704-1-omosnace@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 25 Jan 2021 10:33:10 -0800
Message-ID: <CA+EESO6ptTAU4kuOsEzHXusAJEwWYs-Lt+wtYqMdOKqRHHk4yw@mail.gmail.com>
Subject: Re: [PATCH testsuite] test_userfaultfd.te: grant test_uffd_domain CAP_SYS_PTRACE
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 24, 2021 at 11:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> userfaultfd(2) requires the caller to have CAP_SYS_PTRACE if the
> vm.unprivileged_userfaultfd sysctl is set to 0, so grant all userfaultfd
> test domains the corresponding SELinux permission, otherwise the tests
> will fail when the sysctl is set to 0 (e.g. Fedora 34+).
>
> While there, also remove a commented-out rule that doesn't need to be
> there.
>
> Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>

Sorry for overlooking this earlier.
> ---
>  policy/test_userfaultfd.te | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
> index e29723d..f15ef89 100644
> --- a/policy/test_userfaultfd.te
> +++ b/policy/test_userfaultfd.te
> @@ -44,8 +44,10 @@ userfaultfd_domain_type(test_noioctl_uffd_t)
>  # Domain for process that cannot read from userfaultfd
>  userfaultfd_domain_type(test_noread_uffd_t)
>
> +# userfaultfd(2) requires CAP_SYS_PTRACE
> +allow test_uffd_domain self:capability { sys_ptrace };
> +
>  # Allow all of these domains to be executed
> -#allow test_uffd_domain test_file_t:file { entrypoint map execute };
>  miscfiles_domain_entry_test_files(test_uffd_domain)
>  unconfined_runs_test(test_uffd_domain)
>  userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
> --
> 2.29.2
>
