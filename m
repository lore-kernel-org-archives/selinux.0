Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F71C433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 12:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiDTMZ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiDTMZ6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 08:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B03063BFB0
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650457391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCow4UcYifhaHYNfFDSqCTjSrVT+QYM18k/S2zQ5WXo=;
        b=N/5jPSQA39JdXeRXwo3aYkDG5GTxeCZA5B+3pBXiHKVFSFLbMqvhOwVuGNuB1cTMBJHJcS
        fMBMxIysnIq+ghxCtgh3Le82i/fK7/1+OyIdjMYnDEpjyu41ybeuXwwXgM6+k4OZuP+9ln
        mSOs7XYUi1XfsihWBg5Yc11pNk+2WCk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-yotS9qfFMWijgrabYWjyeQ-1; Wed, 20 Apr 2022 08:23:10 -0400
X-MC-Unique: yotS9qfFMWijgrabYWjyeQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2ec12272fb2so13840667b3.6
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 05:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCow4UcYifhaHYNfFDSqCTjSrVT+QYM18k/S2zQ5WXo=;
        b=5orN1g7/irrD0lXG9A3xL4A+mPGA+n1iu8vLoEf8wIEpGjPLiNTPAeCaCbHx6XdEsn
         wiGz9ezHZuSg/emkIZLazV1OmvoW3pBbsqz/9F/i0Yr/DqN1T85hlgTUvZ6UWO6J9tmC
         epx6vnqp074jiJO2kCAy+h0VcKwN/AJ+k6mlOHfEObju96A316tjjRsMvtjkWMj/ywNu
         ZGGbr1ld0EcBU6PV1rx5QPMzbfbPxfLNaZsln7+BwMOXWksNaIz6VDwmO0UI6Y19EtCM
         1ufAGYI+YWQv751aGl2BjC7INwPyWBhZVYLj1owwrY1THhx4qO0m2v+bMgTpqdvAMpcp
         P/sQ==
X-Gm-Message-State: AOAM530Ct9g33qIs6eGHrr6DdzPbKlaxnL2GIpHHvdpuHDWX7gdg3+cz
        plKH9F4fu4TVWblXWvnq7jsJxkYYhcdQfsLe9EPrUyFdNqzHiK9R+eNb3og8QxKZnc/rjctRYLa
        RI+dl7F99ZI46BLbQP4CD0d/l6VJqmJq5ig==
X-Received: by 2002:a25:d686:0:b0:63e:ae2d:9e63 with SMTP id n128-20020a25d686000000b0063eae2d9e63mr18909867ybg.240.1650457389604;
        Wed, 20 Apr 2022 05:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFklSQ/XxXFAWvCz27sEml1J9Dv+XCbGD4PIDj54qQrKHnlWvDDCMrPS+aV04+XGZlO2MS2V4g+wDBLXbbb6U=
X-Received: by 2002:a25:d686:0:b0:63e:ae2d:9e63 with SMTP id
 n128-20020a25d686000000b0063eae2d9e63mr18909854ybg.240.1650457389438; Wed, 20
 Apr 2022 05:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220224124227.44146-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220224124227.44146-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 Apr 2022 14:22:58 +0200
Message-ID: <CAFqZXNsS40T8rRjJOKWVTTJjfEvQOr_MnEYFzsKhT8kUu+BHhw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/ioctl: Update ioctl tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 24, 2022 at 1:43 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> This change replaces the ioctl check FIOCLEX with FIOQSIZE as the
> kernel will always allow FIOCLEX if policy capability 'ioctl_skip_cloexec'
> is set true.
>
> Also updated policy to test xperm ioctl FIOQSIZE.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policy/test_ioctl_xperms.te | 7 ++++---
>  tests/ioctl/test_ioctl.c    | 4 ++--
>  tests/ioctl/test_noioctl.c  | 4 ++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/policy/test_ioctl_xperms.te b/policy/test_ioctl_xperms.te
> index f9bc8d5..5f570c3 100644
> --- a/policy/test_ioctl_xperms.te
> +++ b/policy/test_ioctl_xperms.te
> @@ -1,4 +1,4 @@
> -define(`FIOCLEX', `{ 0x00006601 0x00005451 }')
> +define(`FIOQSIZE', `{ 0x00005460 }')
>
>  # Domain for process that is allowed the required ioctl xperms.
>  type test_ioctl_xperm_t;
> @@ -7,7 +7,7 @@ unconfined_runs_test(test_ioctl_xperm_t)
>  typeattribute test_ioctl_xperm_t ioctldomain;
>  typeattribute test_ioctl_xperm_t testdomain;
>  allow test_ioctl_xperm_t test_ioctl_file_t:file { open read write ioctl getattr setattr };
> -allowxperm test_ioctl_xperm_t test_ioctl_file_t:file ioctl FIOCLEX;
> +allowxperm test_ioctl_xperm_t test_ioctl_file_t:file ioctl FIOQSIZE;
>
>  # Domain for process that is not allowed the required ioctl xperms.
>  type test_ioctl_noxperm_t;
> @@ -15,4 +15,5 @@ domain_type(test_ioctl_noxperm_t)
>  unconfined_runs_test(test_ioctl_noxperm_t)
>  typeattribute test_ioctl_noxperm_t ioctldomain;
>  typeattribute test_ioctl_noxperm_t testdomain;
> -allowxperm test_ioctl_noxperm_t test_ioctl_file_t:file ioctl ~FIOCLEX;
> +allow test_ioctl_noxperm_t test_ioctl_file_t:file { open read getattr setattr ioctl };
> +allowxperm test_ioctl_noxperm_t test_ioctl_file_t:file ioctl ~FIOQSIZE;
> diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
> index 366d09c..6fff2d0 100644
> --- a/tests/ioctl/test_ioctl.c
> +++ b/tests/ioctl/test_ioctl.c
> @@ -35,9 +35,9 @@ int main(int argc, char **argv)
>         }
>
>         /* This one should hit the FILE__IOCTL test */
> -       rc = ioctl(fd, FIOCLEX);
> +       rc = ioctl(fd, FIOQSIZE, &val);
>         if( rc < 0 ) {
> -               perror("test_ioctl:FIOCLEX");
> +               perror("test_ioctl:FIOQSIZE");
>                 exit(1);
>         }
>
> diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
> index ddce457..4b67e9a 100644
> --- a/tests/ioctl/test_noioctl.c
> +++ b/tests/ioctl/test_noioctl.c
> @@ -51,9 +51,9 @@ int main(int argc, char **argv)
>         }
>
>         /* This one should hit the FILE__IOCTL test and fail. */
> -       rc = ioctl(fd, FIOCLEX);
> +       rc = ioctl(fd, FIOQSIZE, &val);
>         if( rc == 0 ) {
> -               printf("test_noioctl:FIOCLEX");
> +               printf("test_noioctl:FIOQSIZE");
>                 exit(1);
>         }
>
> --
> 2.35.1
>

Thanks, I merged this with some minor commit message edits:
https://github.com/SELinuxProject/selinux-testsuite/commit/b11701a55614eeb20e85fee9829d1699cc13c39a

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

