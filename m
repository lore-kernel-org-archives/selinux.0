Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50760C433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEC52072E
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmRyoqoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFJWHF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWHE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 18:07:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8935C03E96B;
        Wed, 10 Jun 2020 15:07:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c194so3580403oig.5;
        Wed, 10 Jun 2020 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGYLQ72rVrPxc2DQ3sN7sMtcVrZrTtJZv9NCP3xDIqI=;
        b=lmRyoqoZS7XFqPMHbMA36tr1PwIivP1GxANDWKAtL/fE+lCI9YsNIOKilkwqJC9jMA
         /qqif1I2BgDVv6Ql6lyENPzOj9I1nwXHdfHCTVgld1ya964zJljfvnk4caZV41LMcKTQ
         qFtLNILtjwZkN9E05QxRyNOXna5dZHN9NoaJzbAgzcPTuNvmkxGzbDB41vqZqHIRZJiK
         UIdHivXcWi+mhIXmsKKsJ1ur7nAtxygHHnsdp4vYO6Ekkl/xsKHwYfk8ffI294M6o4m4
         YdjULcbgUqgxV48Ua+Sb382l0wKIhMWd9veger3OMHauT8JILe6d5jteq5WScbeV/H8i
         ciLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGYLQ72rVrPxc2DQ3sN7sMtcVrZrTtJZv9NCP3xDIqI=;
        b=IHjkisVwxroW6hQdMvecATHw9ZfUPrGGdK4PVrf8PLwTJFicY6/IkQ06b4xGAS/TCw
         z7dPeghBbyroLRSVm3iheeO7tNeTitMw9LMW9a9CLiGgcSRDiBbhY7/B6kzX+rXToh7O
         R4RHnOJqFq/yjDNPSXPJzy8hF+UJuJ98Sgrf155jur2XkupIVh4CKKVDy7SPJrCFzRu3
         AZz2/lk1iMudz29qVYrSxxl3h1QUnkYELoTRFnuoxKjZr4oObUL3Keg6pU7ZW4I7fYOB
         0OlPHsOFAry8r583UrR1HX7PmXNtUZAxLEtN1y/uod0jRrX8qMW2EvSkEc7lwGQQCcyD
         SehA==
X-Gm-Message-State: AOAM5316jmSLWLcwFtqcxM79WTntkKELpdavv+VMsg9ECDfNtvFUss+P
        ybHuAVLlKPvafx+rsDrCfxcapwVmSn+rmPgBKb4=
X-Google-Smtp-Source: ABdhPJze4Mhu/cpfEpf2Md7Ct2MDl1/HKyldmzbxnNg9hUT0hMlQvuUHpLc8IhDTdNo9p9oSi0C4a3weB5uS3vQc+NY=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr3982909oib.160.1591826821216;
 Wed, 10 Jun 2020 15:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200610215713.5319-1-trix@redhat.com> <20200610215713.5319-2-trix@redhat.com>
In-Reply-To: <20200610215713.5319-2-trix@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 18:06:50 -0400
Message-ID: <CAEjxPJ6O3HZ_xdGDvuvYiUNqiPxqvo37V7d5ckLpDM=qF426tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix double free
To:     trix@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>, rgb@redhat.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 5:57 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang's static analysis tool reports these double free memory errors.
>
> security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
>                         kfree(bnames[i]);
>                         ^~~~~~~~~~~~~~~~
> security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(bvalues);
>         ^~~~~~~~~~~~~~
>
> So improve the security_get_bools error handling by freeing these variables
> and setting their return pointers to NULL and the return len to 0
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
