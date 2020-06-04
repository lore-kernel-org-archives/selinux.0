Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07AC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BDC2075B
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0pPnxk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgFDUv0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:51:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729348AbgFDUvZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591303882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oau1bsTpFW9qOxymOGV9qimyTo+0WuWRTp6K8PiHYqA=;
        b=N0pPnxk+1Jw+xmo1U8pLIiIo7SmFIVWiHx4MakkKnYZ0xJATYoK5lhbjG6ny7at5BpA6JD
        OtE+53Sc33BVM9Jszynu8Up1UgnZdR07xJFek9b4Ms4R+UIDY0GYtY3Q43B1nK0ci2N18R
        iQkeLGyVqupXWJ5HeCrGkHhGpgg4MLI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-8sdthLg8OUi9BN1-1tPtUw-1; Thu, 04 Jun 2020 16:51:20 -0400
X-MC-Unique: 8sdthLg8OUi9BN1-1tPtUw-1
Received: by mail-pf1-f200.google.com with SMTP id c7so5682036pfi.21
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oau1bsTpFW9qOxymOGV9qimyTo+0WuWRTp6K8PiHYqA=;
        b=V1oEuP3qYThpvXRDhLoe/YQjC0Tckeae0eefxEC+wLlx8fLqb24Kji6C/LnMe161Yp
         i5SQOGkk3JPa4YhDn/66qiUNJ1HcHqX7TpjJULpo0R2kAjfKeyhYIjqJv+lvx50bbu6r
         BltrjW6MOR1NCsFCjJ8PXu/l3/l18Sb+wk3RxkXdxAkW1/XSz3T7Fxgat0T6GxakVAjM
         7+u5F7fTDbDLFKDjkxf+nbFVX1d2AG4wGxlyeZqkwiCnNUhJryph4LpHePnRIykH4dRu
         fIKEDU7tuAurW4Q1A2C8LwCIwyT/0XJBufXo2SPZ5G7kkXsqJwnd8T8LkVGWFXTwOEWf
         ZzDA==
X-Gm-Message-State: AOAM5308dorpIkfP16KZfLf3vCv6X7lEHbhHV/VP4060EweCG6C+CpYK
        5SR1TQPvSlrbyCrq3VTvsmVza3YkyJtnWeb7DdQ+JExaQ2HevpsTv+rQphKMhpSZg9v+KN4tyHD
        wrNAvp6ZRXdsA2thPf5YrjbhE9w82JVwWnA==
X-Received: by 2002:a62:6042:: with SMTP id u63mr6457994pfb.79.1591303879553;
        Thu, 04 Jun 2020 13:51:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlh1wATLjnOR5GDnKmqMBvyN3hKOWTl7li6hHT8e/QO5mjXQrv1z9HAbY//MYDfUF5t4Y5VvHhSinrZwfmgjw=
X-Received: by 2002:a62:6042:: with SMTP id u63mr6457977pfb.79.1591303879320;
 Thu, 04 Jun 2020 13:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Thu, 4 Jun 2020 16:51:07 -0400
Message-ID: <CACpbjYrJGwJcWBoaWP6zkcHfuVRL50_35JkH+O-=1=iRwjFAgg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_restorecon() statfs bug
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patch looks good to me, and I can confirm that it fixes the reported
problem upstream.

Tested-by: Jonathan Lebon <jlebon@redhat.com>

