Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9D7C433DB
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBBA2225C
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392299AbhARNqG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404775AbhARNpq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jan 2021 08:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDSHA5vOQeoMry92xiJQFYaDJd8UvMQ+txC8anbIe/A=;
        b=FMaOQsSZEPzz4FNAr9G+DWOB9ho9U0tLT0K02viHjXQWzg3z5l/f7zF96DPI9ihMbKsDQM
        fykIsjGOIaBvJBXje6k4yUJS3Evbw+5BICnEfVX6FLOWpd4pfpR7qEHHs2VvoYWaImu8Uf
        AdpTPZU4qqfxHOURTf8m/ijEttPdjGI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dD1u-qlROciAZKa0ktm5PA-1; Mon, 18 Jan 2021 08:44:15 -0500
X-MC-Unique: dD1u-qlROciAZKa0ktm5PA-1
Received: by mail-lj1-f200.google.com with SMTP id a2so4265745ljm.23
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 05:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QDSHA5vOQeoMry92xiJQFYaDJd8UvMQ+txC8anbIe/A=;
        b=s6oQJT60EFWSgpJMlw72nBXVoxyZp2ptAlzGCMmD9+qCDcYR4qEpKeIim+rC1z1Mi5
         9RhS6QBMQzXiAUuGlrd3sEHa57LWDnm/+wppVTdJgNr7pV8Vmpsz2eOblrHP7L0Y7/jy
         i/0Vwhp0LZkQ8v9iHgU+VsOBdK1qUR0KZW81yMNx8zJuPd7aFQy4kSNn3fsKNy1bjer2
         aQeyagk7LlXg0Ql/K+YP1Y4NI8c2qeJltURO7ND3A1B12rxm1s+wlNBjMLYSo+5LoBKQ
         ZAWCHAOxHADFXAmV36lYnaJ4cYCjpxJb8o9WKjv9SLNqkmTOd8BJQStHKpJzzlKqmM50
         OnJQ==
X-Gm-Message-State: AOAM5333yovkqEthHEtOG7kQX4s0Ce2rbmec43Qv2h53+zBd7ankE3kO
        ZsduGVmp/ufgaRyGm+LjHCrqN8P4BeXX12OM568KKibn1FTvsklF95pQUJQ2A+UNHBF2IbbD9Dk
        wETMRzMUxHCQq7zKo9naFp2gsnouiuqrclA==
X-Received: by 2002:a2e:6a1a:: with SMTP id f26mr10391359ljc.416.1610977453690;
        Mon, 18 Jan 2021 05:44:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVEzXaDZvdolq2yiixpy+FNu/Xu1T+yI0NURMpVkby4M22qhxjpbmZi4SUFBrm9gwsgDrEvnTgtI9uajhk3kU=
X-Received: by 2002:a2e:6a1a:: with SMTP id f26mr10391351ljc.416.1610977453464;
 Mon, 18 Jan 2021 05:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20210113101742.49397-1-omosnace@redhat.com>
In-Reply-To: <20210113101742.49397-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Jan 2021 14:44:02 +0100
Message-ID: <CAFqZXNuyM4hPrt__cWCMBmR-E1tCE6j-N6uJd_buaHQroHz29Q@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] perf_event: update perf_event test for the
 new CAP_PERFMON capability
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 11:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Only run the test if the new capability is defined in the policy and
> grant it to the test domains instead of CAP_SYS_ADMIN. Even though
> CAP_SYS_ADMIN should still allow everything that CAP_PERFMON allows,
> this backwards compat fallback might be dropped in the future, so let's
> use only CAP_PERFMON in the test.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: fix syntax check warning

Now applied
https://github.com/SELinuxProject/selinux-testsuite/commit/259751492b588193cd3a5a2f76ba5bd91b79df1f

>
>  policy/Makefile           |  2 ++
>  policy/test_perf_event.te | 28 ++++++++++++++--------------
>  tests/Makefile            |  2 ++
>  tests/perf_event/test     |  3 +--
>  4 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/policy/Makefile b/policy/Makefile
> index 6c49091..fb16a35 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -126,8 +126,10 @@ TARGETS += test_tun_tap.te
>  endif
>
>  ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q perfmon $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  TARGETS += test_perf_event.te
>  endif
> +endif
>
>  ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  TARGETS += test_lockdown.te
> diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
> index 275cebf..fb05120 100644
> --- a/policy/test_perf_event.te
> +++ b/policy/test_perf_event.te
> @@ -10,18 +10,18 @@ unconfined_runs_test(test_perf_t)
>  typeattribute test_perf_t testdomain;
>  typeattribute test_perf_t perfdomain;
>
> -allow test_perf_t self:capability { sys_admin };
> +allow test_perf_t self:capability2 { perfmon };
>  allow test_perf_t self:perf_event { open cpu kernel tracepoint read write };
>  allow_lockdown_confidentiality(test_perf_t)
>
> -################# Deny capability { sys_admin } ##########################
> -type test_perf_no_admin_t;
> -domain_type(test_perf_no_admin_t)
> -unconfined_runs_test(test_perf_no_admin_t)
> -typeattribute test_perf_no_admin_t testdomain;
> -typeattribute test_perf_no_admin_t perfdomain;
> +################# Deny capability2 { perfmon } ##########################
> +type test_perf_no_cap_t;
> +domain_type(test_perf_no_cap_t)
> +unconfined_runs_test(test_perf_no_cap_t)
> +typeattribute test_perf_no_cap_t testdomain;
> +typeattribute test_perf_no_cap_t perfdomain;
>
> -allow test_perf_no_admin_t self:perf_event { open cpu kernel tracepoint read write };
> +allow test_perf_no_cap_t self:perf_event { open cpu kernel tracepoint read write };
>
>  ################# Deny perf_event { open } ##########################
>  type test_perf_no_open_t;
> @@ -30,7 +30,7 @@ unconfined_runs_test(test_perf_no_open_t)
>  typeattribute test_perf_no_open_t testdomain;
>  typeattribute test_perf_no_open_t perfdomain;
>
> -allow test_perf_no_open_t self:capability { sys_admin };
> +allow test_perf_no_open_t self:capability2 { perfmon };
>  allow test_perf_no_open_t self:perf_event { cpu kernel tracepoint read write };
>
>  ################# Deny perf_event { cpu } ##########################
> @@ -40,7 +40,7 @@ unconfined_runs_test(test_perf_no_cpu_t)
>  typeattribute test_perf_no_cpu_t testdomain;
>  typeattribute test_perf_no_cpu_t perfdomain;
>
> -allow test_perf_no_cpu_t self:capability { sys_admin };
> +allow test_perf_no_cpu_t self:capability2 { perfmon };
>  allow test_perf_no_cpu_t self:perf_event { open kernel tracepoint read write };
>  allow_lockdown_confidentiality(test_perf_no_cpu_t)
>
> @@ -51,7 +51,7 @@ unconfined_runs_test(test_perf_no_kernel_t)
>  typeattribute test_perf_no_kernel_t testdomain;
>  typeattribute test_perf_no_kernel_t perfdomain;
>
> -allow test_perf_no_kernel_t self:capability { sys_admin };
> +allow test_perf_no_kernel_t self:capability2 { perfmon };
>  allow test_perf_no_kernel_t self:perf_event { open cpu tracepoint read write };
>
>  ################# Deny perf_event { tracepoint } ##########################
> @@ -61,7 +61,7 @@ unconfined_runs_test(test_perf_no_tracepoint_t)
>  typeattribute test_perf_no_tracepoint_t testdomain;
>  typeattribute test_perf_no_tracepoint_t perfdomain;
>
> -allow test_perf_no_tracepoint_t self:capability { sys_admin };
> +allow test_perf_no_tracepoint_t self:capability2 { perfmon };
>  allow test_perf_no_tracepoint_t self:perf_event { open cpu kernel read write };
>  allow_lockdown_confidentiality(test_perf_no_tracepoint_t)
>
> @@ -72,7 +72,7 @@ unconfined_runs_test(test_perf_no_read_t)
>  typeattribute test_perf_no_read_t testdomain;
>  typeattribute test_perf_no_read_t perfdomain;
>
> -allow test_perf_no_read_t self:capability { sys_admin };
> +allow test_perf_no_read_t self:capability2 { perfmon };
>  allow test_perf_no_read_t self:perf_event { open cpu kernel tracepoint write };
>  allow_lockdown_confidentiality(test_perf_no_read_t)
>
> @@ -83,7 +83,7 @@ unconfined_runs_test(test_perf_no_write_t)
>  typeattribute test_perf_no_write_t testdomain;
>  typeattribute test_perf_no_write_t perfdomain;
>
> -allow test_perf_no_write_t self:capability { sys_admin };
> +allow test_perf_no_write_t self:capability2 { perfmon };
>  allow test_perf_no_write_t self:perf_event { open cpu kernel tracepoint read };
>  allow_lockdown_confidentiality(test_perf_no_write_t)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 4c00b5f..4484f10 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -107,8 +107,10 @@ SUBDIRS += tun_tap
>  endif
>
>  ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q perfmon $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  SUBDIRS += perf_event
>  endif
> +endif
>
>  ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  SUBDIRS += lockdown
> diff --git a/tests/perf_event/test b/tests/perf_event/test
> index 1c2e4a9..1d337e9 100755
> --- a/tests/perf_event/test
> +++ b/tests/perf_event/test
> @@ -56,8 +56,7 @@ ok( $result eq 0 );
>  if ($sys_admin) {
>
>      # Deny capability { sys_admin } - EACCES perf_event_open(2)
> -    $result =
> -      system "runcon -t test_perf_no_admin_t $basedir/perf_event $v 2>&1";
> +    $result = system "runcon -t test_perf_no_cap_t $basedir/perf_event $v 2>&1";
>      ok( $result >> 8 eq 1 );
>  }
>
> --
> 2.29.2
>


-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

