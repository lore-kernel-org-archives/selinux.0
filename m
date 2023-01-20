Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A329FC05027
	for <selinux@archiver.kernel.org>; Fri, 20 Jan 2023 09:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjATJj2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Jan 2023 04:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjATJj2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Jan 2023 04:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3629573EFF
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674207509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4HXQn/VthSKK2dsGvLl4daAOZiR84aaBguTbqslFZI=;
        b=gWRbNIHapUAoM+A9WYKSR0MoC2k0JtkazuNTG+ZByo9JWzI9GM7kyRJByp8Hqk5IfpUZES
        O5A12vet3wd7KhGFh4kLk2CC7JitRFhbRBjASnMvy/dO8QCyopb/OrPkWKPE1q2DlrOgxJ
        nNpvNBnGHtSUy8VdSPkpWkGqtGFFjHE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-hR5JOz0bOVakaZ09c0djeg-1; Fri, 20 Jan 2023 04:38:27 -0500
X-MC-Unique: hR5JOz0bOVakaZ09c0djeg-1
Received: by mail-pf1-f198.google.com with SMTP id v23-20020aa78097000000b005748c087db1so2222727pff.2
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 01:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4HXQn/VthSKK2dsGvLl4daAOZiR84aaBguTbqslFZI=;
        b=qGyZgN0FpkybGtOh0n0di2Q06rTOvdd+lgow1Ct3bm7Z95jkm0DZT3DfOlX+/5m6sS
         yAMKYOM4yCh1xLzyxNsMJC+LNgZ0Afk31tia59wBdrY5mnsAGxbGGF1PlAN+OTf1Rw4Y
         uLOIRPm1ng1Wb7O2+wFYLd3ZE8zpdFeXHmDDgzTEAUwNEz27aory7XjYR4r0Kzpbc0UZ
         v0e+78cAvFlHgkclsJSMRMMYkt/6TZUt3wC/B+Izk2m5FnraiNZIe2C6lXMpoumsUtiz
         ANe5rW0jwPU1HWMmgz2GUBWS+hdxmqLWyEXGixyVia3geEp+WnyOsW5vFrAQ+h4T4j93
         kP3g==
X-Gm-Message-State: AFqh2kqDSsjdjocQP8X6OeLPLczfY6czitT5i6S3hYWL4Ybbo7GQdlUV
        uw9pRamynPo2g4sTt2CdbWMvuFV8RTqMZQGHAR5j7uMJAaJEsAgF9M1LIgGPVDQnpMsy02Q9Jgo
        9Jqj41yb97HOlkNb5EGAzDNIKy1vMhCS0Lw==
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id t1-20020a17090a1c8100b00229f07b07aemr705667pjt.239.1674207506228;
        Fri, 20 Jan 2023 01:38:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXulDXfqvYIDSuPyaU8xaeuBKtJ1L+YYIz1vH102WvnCO5tj2tytgPDFBmd0OnKMG/1FLwez1ncKyrmViUyCcBg=
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id
 t1-20020a17090a1c8100b00229f07b07aemr705664pjt.239.1674207505986; Fri, 20 Jan
 2023 01:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20230116214626.28955-1-cgzones@googlemail.com> <20230117170933.16807-1-cgzones@googlemail.com>
In-Reply-To: <20230117170933.16807-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Jan 2023 10:38:14 +0100
Message-ID: <CAFqZXNsSfLtTTDMzc3kgRJ9pspO_Z0T8pLtibAacW7y-5__K5g@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH v2] policy: handle files_list_pids() renaming in Refpolicy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 17, 2023 at 6:14 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> files_list_pids() has been superseded and marked deprecated in the
> Reference Policy since Jun 2020[1].  In the latest release it has been
> completely removed[2].
>
> Call both the old and replacement interface conditionally to support
> recent Refpolicy versions as well as old ones.
>
> [1]: https://github.com/SELinuxProject/refpolicy/commit/be04bb3e7e63671ed=
8a3c501a2ee76e11c3b92bb
> [2]: https://github.com/SELinuxProject/refpolicy/commit/3ca0cd59d7a9b531d=
d3620a02940396343fe2ed5
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    call both interfaces conditionally
> ---
>  policy/test_global.te | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/policy/test_global.te b/policy/test_global.te
> index e95102a..052c7dd 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -121,7 +121,6 @@ allow testsuite_domain proc_t:file { getattr read ope=
n };
>  files_list_var(testsuite_domain)
>  files_list_home(testsuite_domain)
>  dev_read_rand(testsuite_domain)
> -files_list_pids(testsuite_domain)
>  require {
>         type root_t;
>         type etc_t;
> @@ -154,6 +153,14 @@ selinux_compute_create_context(testsuite_domain)
>  selinux_compute_relabel_context(testsuite_domain)
>  selinux_compute_user_contexts(testsuite_domain)
>
> +# Reference policy renamed files_list_pids() to files_list_runtime()
> +ifdef(`files_list_pids', `
> +    files_list_pids(testsuite_domain)
> +')
> +ifdef(`files_list_runtime', `
> +    files_list_runtime(testsuite_domain)
> +')
> +
>  ifdef(`distro_redhat', `
>      ifdef(`auth_read_passwd', `
>          auth_read_passwd(testsuite_domain)
> --
> 2.39.0

Thanks! Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/ebda879d7b6a7369=
fafc980b0bc223792d7bd5ab

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

