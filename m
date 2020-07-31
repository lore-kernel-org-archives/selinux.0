Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B3C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CE62083B
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzOVMSum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgGaODt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:03:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730170AbgGaODs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 10:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596204227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=f/fqUynkd4cB8IiSurBnrNL7KHOju7BY2dLsLrBCl9c=;
        b=LzOVMSumlCiLREnSM44jLpA2sXnAbLJJysXDtQpJDLqhFD2TOxIjfdZZDmj4lQsuv55io+
        +GyFzdeO4z4FBi/q1G/UIiVv7igQ6fFx4RuyDrgqwvQIBDSdeLFA5qOGnqfRkX1vWXpB90
        aeYkVzmtZdbOVOJ0JeAwYWI00IeDksA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-k2eXBGuPMDqe7GOXSqfqAA-1; Fri, 31 Jul 2020 10:03:45 -0400
X-MC-Unique: k2eXBGuPMDqe7GOXSqfqAA-1
Received: by mail-lf1-f71.google.com with SMTP id j22so6215150lfg.21
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 07:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f/fqUynkd4cB8IiSurBnrNL7KHOju7BY2dLsLrBCl9c=;
        b=PlCUuVzcYimGG1FUFTd3I+pdH43bBuZeD2MDyOqwMVXRzU0DM18XMzOuu4fCXR65tk
         reemUb39rReMtgv9ASWwVmVcE110QeJqXNsTcMxa9T/pEy+G7O04Q6sRgxC0IvaLFUA9
         ZCGLMbr+NGoLDNBolkvGxY/nIbBaxMo4t1KkDHOsrm2t3eM+qjD1Eunf3pCOTw4n6Cza
         NMwEDVZSMrOfq1i93MA0+IlBQ4Y8RjbfKLB/PRdP4+X3vSsqBWaHwvqZnFoxOroE0zmz
         yHYKKvUeoojv37TJrSl/ZiDggUe2n8mMdvNwNZk4lRiGdCUnk7Cfi13N71kAju1JXhgX
         o4fg==
X-Gm-Message-State: AOAM533QP9iWwq+leKof1DgSKh3It+4M3zc7P7F1mT6aRHGmmwCXBhO8
        +z8QHAOzMgJXjqazHzWp+uLL8/Zkp14IlYTI4C5eS1NQynsu9zpBxZc0BCUv5e/yu6IPyUTyXH7
        pKDrAcSgSELcPo7vhEy7TCbtWmU6vzYYP8g==
X-Received: by 2002:a19:c68b:: with SMTP id w133mr2076083lff.189.1596204223817;
        Fri, 31 Jul 2020 07:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpG8o2OWdc5PQKFg4tBUbWCRdIEx9QjkDyogtj0FgFGDn4PM8PLvsnkqIYxt2aD3cZ1XtVvWsDWeHLFGHInx4=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr2076075lff.189.1596204223605;
 Fri, 31 Jul 2020 07:03:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 31 Jul 2020 16:03:32 +0200
Message-ID: <CAFqZXNv2zwKc7XPuDM-L8NkNB=DUAcuhVktRPsOp+K0j-wvQtA@mail.gmail.com>
Subject: License of userspace CI scripts?
To:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

I started working on converting the selinux-testsuite Travis CI to run
the testsuite in a Fedora VM as is currently being done for SELinux
userspace thanks to William. In my current working version I basically
just copy-pasted William's scripts from scripts/ci/... and made minor
adjustments, so I have a slight concern over licensing - the scripts
currently don't have any license headers and there is no
LICENSE/COPYING file in a parent directory that could implicitly apply
to them. William, would you mind adding some explicit GPLv2-compatible
license headers there so I can legally copy the code over to
selinux-testsuite? :)

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

