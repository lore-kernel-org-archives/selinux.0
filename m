Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818BC19F2A
	for <selinux@archiver.kernel.org>; Thu, 11 Aug 2022 11:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiHKL2b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiHKL2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Aug 2022 07:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0621D65806
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660217308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2TTr33P0XnB+gewUY2NLBlibKa6M5dUmUHESaONqtE=;
        b=Yoxe93YbOFy/RYqtHcAXMRWFgA/8K1ho4BWjoCfIm9zy8ef60bOj/5/ldQhXBclmZ3IPyg
        AKr721vd2wztqHhPG6wXqDG6mGIMqnkfzFjuB3F1D1lHDJEUJHOTMA6K0KCXFR8h8Hq0ve
        0vUt3oM7aVJhxgMdZ97x9WMu2GFyhvM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-iEq386B0OS20BWiYMxTPyQ-1; Thu, 11 Aug 2022 07:28:26 -0400
X-MC-Unique: iEq386B0OS20BWiYMxTPyQ-1
Received: by mail-yb1-f200.google.com with SMTP id j130-20020a252388000000b0067c1f731317so6410674ybj.5
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 04:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=n2TTr33P0XnB+gewUY2NLBlibKa6M5dUmUHESaONqtE=;
        b=krH5GQnFY59Vszt+ouxfPybDku0904qRjM42t8tuXXzr9dZBX9FELeGcbDjU2sGNkM
         AjElbT+gye0xdAOwAEigTznqAAdoQkhJO5liHlgE+czuBdf04mHtfoBsFoNo/o247kMH
         0/UJGejGIqSYyNcw9f9lGYBP345hlxIekx6eLUsdYIwr81OA4hoo6abL4nIqPSaiZ02a
         IQLDH7RZ6qPBAAgrdRWrWd+V+J99P+8iSae0V+JdyenyRi92y7qZYNNMQ5hDHr0kt6R2
         GiIuJcYz34Te35aHIss6uOgr41sqdK3Yv5g1Z6czq3VRZ91VPDBC8h5YLg44MABcLkwl
         ypew==
X-Gm-Message-State: ACgBeo3DzK5SQdXwiwWrbHvWKCpw9KmolS+jKL5AsMJfNpwkv4TOJcTg
        Aimye20EFPIw4tVCLWnSRN6KtkQo8icK1h5nxJg8Pi0disvErGMMdIi/nGSViOSJYzMaznruZYH
        yOouR/GASYyu+fftsjF6cfJIF+eV+9jBh/w==
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id d18-20020a258892000000b0066efe435aa0mr27854076ybl.445.1660217306156;
        Thu, 11 Aug 2022 04:28:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZuHN6ki2emRUwMe4o1vrhIXfH0ziBUqUlOOBL4poD1vdN45JFyALnO9vT/qFVk/I+uwqMPEdCxGNz7ghRuCU=
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id
 d18-20020a258892000000b0066efe435aa0mr27854067ybl.445.1660217305919; Thu, 11
 Aug 2022 04:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <CAFqZXNvZFeOcgRtVKG3JPCPMb2E42Ot-B+BxbnRxWF9Jz-TvhA@mail.gmail.com>
 <CAFqZXNuBBOVWC6eZxK=-AK36OhS3xDDniOmhJc0N4ujOYpmPLw@mail.gmail.com>
In-Reply-To: <CAFqZXNuBBOVWC6eZxK=-AK36OhS3xDDniOmhJc0N4ujOYpmPLw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Aug 2022 13:28:14 +0200
Message-ID: <CAFqZXNs9tQ4Bib-ymypsC55nx=RgDhHPpM=SJLknKR6DO0STaQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 00/24] Clean up testsuite policy and support
 running as sysadm_t
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 1, 2022 at 10:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jul 29, 2022 at 2:27 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Jul 29, 2022 at 2:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This series aim for two things:
> > > 1. Refactor the policy so that it is easier to work with.
> > > 2. Leverage the refactoring to fully support running the testsuite
> > >    as sysadm_u:sysadm_r:sysadm_t.
> > >
> > > The gist of this work lies in unifying how test domains are defined,
> > > deduplicating the various boilerplate spread out all across the
> > > individual files (and not even used consistently), and in abstracting
> > > the policy caller domain/role away from the individual test policies
> > > into test_general.te. Some tests also had to be massaged to not
> > > hard-code unconfined_* and be generic against the context of the
> > > testsuite caller.
> > >
> > > The series also extends the CI to test running the testsuite as sysadm_*
> > > and also verify that no unconfined_t/sysadm_t unexpected denials are
> > > produced (which would usually indicate a missing dontaudit rule in the
> > > testsuite policy).
> >
> > Lol, I got a bounce for patches 4 and 5 because they are too long :D
> > Hopefully the list owners can approve them manually. If not, I'll
> > submit this series as a GitHub PR and post a link here.
>
> The patches are still not there, so opened a pull request:
> https://github.com/SELinuxProject/selinux-testsuite/pull/82
>
> One can fetch the contents of the PR in the git-format-patch format
> through the following URL:
> https://github.com/SELinuxProject/selinux-testsuite/pull/82.patch

This is just a note that I have merged the PR now.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

