Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F38C05027
	for <selinux@archiver.kernel.org>; Fri, 17 Feb 2023 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBQQPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjBQQPJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Feb 2023 11:15:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585D6F7D6
        for <selinux@vger.kernel.org>; Fri, 17 Feb 2023 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=gVOlzoemAkJh1SvRpFQFK6110NR5uk/PUWYOD2fgXy2HxDq1MMaRCE98/UX3F3s1m9tqRz
        MfhsdXhNjUfnp86wQaSRHkMXy9qT8hgmxHMdE82CEjPaj3LlMa+46Mx0MM62UZbtB2hWvN
        RpOWHj0+Xl9qchNzkmgdmV47q11QMCo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-wW1vEZWiPFuIv8MyMJ6LXQ-1; Fri, 17 Feb 2023 11:14:19 -0500
X-MC-Unique: wW1vEZWiPFuIv8MyMJ6LXQ-1
Received: by mail-pf1-f199.google.com with SMTP id h11-20020a056a00230b00b005a8c5cd5ae9so972513pfh.22
        for <selinux@vger.kernel.org>; Fri, 17 Feb 2023 08:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=dOAhPbLn0ZAK2J2Tfqr7Nl16GTS1gyW3S4IXhyeW41xMkLQQRbCbrUdTRMXkO+JN5E
         9EgMbheGdKj7S3Ms+lyaOHXmKq6xLp7WUnBAIlMC2fOj7ty6RzGU+hnpoMtBRuA3j7jI
         esCX+vFV6afbHTnzd2G4gMBtFy6DgcIF5Q4KHXAogGkFpy1Zngm2EgmNx1xsnoLQehed
         7zMvn/RnbbUFn1A/8VLn64Yr0T5cDKP8ZsDE8odldWlnC+n2Du1wowkfHtuD+btsTZiP
         XCQqqKK6/ROhM9vqdcP8Z/81ffp3BUn2i6I2mjo39HBBfSvhKRzFSPdx+sXqjHxjkUHw
         Vc7g==
X-Gm-Message-State: AO0yUKVs9igG1si29muepB23JWF37Qw1Z1t6iKIDi/pP0CbjK3GbVrXi
        2uT3pi5xzk8yx7j9gZqIzf8oJUdOPVgkIVcBVCNbs2KUjk7sUVqU9gfhSrQzPmzPzji27AULBFa
        7mwcguQHE6HwHd/qpuXDSkKwp3JI9iWYBlw==
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id sj6-20020a17090b2d8600b0023120d902f7mr1654053pjb.109.1676650458682;
        Fri, 17 Feb 2023 08:14:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8tohgmQvChINWAF1kGtAV+Sq+F9YMF564KXupouv9JfMhUKwddcZOA0loNKhsyYDpLmFpTD2XWH016z1I4u04=
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id
 sj6-20020a17090b2d8600b0023120d902f7mr1654048pjb.109.1676650458370; Fri, 17
 Feb 2023 08:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20230215131807.293556-1-omosnace@redhat.com> <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
In-Reply-To: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Feb 2023 17:14:05 +0100
Message-ID: <CAFqZXNsP8zrQ=trMqLE09T5P-poeDPAVLj_YkTc1NpEDn4c_Sw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 15, 2023 at 9:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> > 1. First determine if CAP_SET[UG]ID is required and only then call
> >    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
>
> Can we please have more details on the selinux failures?  Under what
> circumstances?  What is the end-user impact?
>
> Because a fix for "bogus LSM (SELinux) denials" sounds like something
> which should be backported into earlier kernels, but there simply isn't
> sufficient information here for others to decide on this.

Fair point. I will send a v2 with a more detailed explanation.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

