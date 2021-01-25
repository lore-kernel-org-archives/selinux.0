Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975DC433E0
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D59C22581
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbhAYV5q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732763AbhAYV53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 16:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611611758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7JEid6S68zMDqEGot5t3zdK6i9b3h5DDLLsv04EBlEs=;
        b=eDqb3j6FKsVH+Mn9j1zpCXEP1KzOWiDFxyHK9CxRzls2OhLmypg3VsLvLWygi1x+A5uKFM
        LDFPzhtG3VWaYDHOSZzxm5I6iS8vbMxhRbCODMQgHCXwx0yRyzfHpPGsH6ftyArXLhax6S
        DUJXKLM2nlxVQRS4OpSI8GX3l7BIS7o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-zCGEt34zPe6HhveGyL66zQ-1; Mon, 25 Jan 2021 16:55:56 -0500
X-MC-Unique: zCGEt34zPe6HhveGyL66zQ-1
Received: by mail-lj1-f200.google.com with SMTP id 2so6999797ljr.17
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 13:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JEid6S68zMDqEGot5t3zdK6i9b3h5DDLLsv04EBlEs=;
        b=h4fqgXDfXyBlo5UdSsNhaWU76BX2qh3hfsB3KTZsn1/3nqwa3F5eHEay3SDXY5zUYa
         7/v5ICU0pehFEvbeQ38FA329bBZjar7Cn9KcoRblNMlHySVSgUU/UqX25GFDyufaRfzm
         aHJ+k2AGFmYy+hp1ryC5gUDVa4qtEAdhruAftOu8rcPGZsM88tcRHWuX15ss1TeikxIS
         M1R0CyZLQ3AYLcON4UKzcp7Qb4HsIxdZEpnPDvwzduoouhxrzEECkXNR+DSDvEqMrmGX
         4Bhbl2FJoamZG45OyG1VWVgvBYWzldLl3mhuYISuMrOYoJScbHsGPUfVQtKMBsu14atQ
         vu9w==
X-Gm-Message-State: AOAM532lI2R1HxrIjXZ1pPYRcousOG/j9meItkJOk0zoaZjuyLJyUkqd
        1rUH4oR3qOqYZOElk1udJz4ubNlDG90S/HRZt60NV9rDqlj8ndzuxuIa/jDEPnU6bpDwSe0O9Vs
        WEEUYEp06C48iB2xq4rdJQLwPv5VLRyp6Qg==
X-Received: by 2002:a2e:6a1a:: with SMTP id f26mr1187268ljc.416.1611611755250;
        Mon, 25 Jan 2021 13:55:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSiAjY7kUv/03lOPE+qrOWAQc/+pxFrVMXeMOZUn+NEi99DPJ0kg4qXc2sWgqZR5m4t8BD9acIaakY16HgnBQ=
X-Received: by 2002:a2e:6a1a:: with SMTP id f26mr1187264ljc.416.1611611755050;
 Mon, 25 Jan 2021 13:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20210125075713.356704-1-omosnace@redhat.com> <CA+EESO6ptTAU4kuOsEzHXusAJEwWYs-Lt+wtYqMdOKqRHHk4yw@mail.gmail.com>
In-Reply-To: <CA+EESO6ptTAU4kuOsEzHXusAJEwWYs-Lt+wtYqMdOKqRHHk4yw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Jan 2021 22:55:44 +0100
Message-ID: <CAFqZXNt6VtCp-NwWgVhZpOhtQ_MihU4SrHg2VNnHKVmj=qja5g@mail.gmail.com>
Subject: Re: [PATCH testsuite] test_userfaultfd.te: grant test_uffd_domain CAP_SYS_PTRACE
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 25, 2021 at 7:33 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Sun, Jan 24, 2021 at 11:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > userfaultfd(2) requires the caller to have CAP_SYS_PTRACE if the
> > vm.unprivileged_userfaultfd sysctl is set to 0, so grant all userfaultfd
> > test domains the corresponding SELinux permission, otherwise the tests
> > will fail when the sysctl is set to 0 (e.g. Fedora 34+).
> >
> > While there, also remove a commented-out rule that doesn't need to be
> > there.
> >
> > Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
>
> Sorry for overlooking this earlier.

No worries, the behavior depends on sysctl configuration, so it was
easy to miss :) And part of the blame is on me for not re-testing the
patch on rawhide against a kernel with the related patches applied...

I'm going to merge the patch in a while, since it fixes a bug and is
fairly trivial.

> > ---
> >  policy/test_userfaultfd.te | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
> > index e29723d..f15ef89 100644
> > --- a/policy/test_userfaultfd.te
> > +++ b/policy/test_userfaultfd.te
> > @@ -44,8 +44,10 @@ userfaultfd_domain_type(test_noioctl_uffd_t)
> >  # Domain for process that cannot read from userfaultfd
> >  userfaultfd_domain_type(test_noread_uffd_t)
> >
> > +# userfaultfd(2) requires CAP_SYS_PTRACE
> > +allow test_uffd_domain self:capability { sys_ptrace };
> > +
> >  # Allow all of these domains to be executed
> > -#allow test_uffd_domain test_file_t:file { entrypoint map execute };
> >  miscfiles_domain_entry_test_files(test_uffd_domain)
> >  unconfined_runs_test(test_uffd_domain)
> >  userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
> > --
> > 2.29.2
> >
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

