Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE70C00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiG2M2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiG2M2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2170FBE3D
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659097679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuOIThWLHPQrIV9Xk3qs7WdEGfL6EXCSxRj75kPC1Yg=;
        b=BlkEq6UM5vWAF9BelzClMZRTFdz0qSOK1q5iBRC9ZMVdb+7DnnKKIZozVVSnk0KsFv5Skt
        gwyIWM9WMvtbONZV11fdkYvRPa2UHhyRwj1uh6L0zbt+f7+pMQS9Ay+J66R9/wLrxDisvn
        z6Ck6+sSpVvUH1gIGWvmp10194wNp+k=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-oPWcnYVxNhClrk7yPaq7Kg-1; Fri, 29 Jul 2022 08:27:50 -0400
X-MC-Unique: oPWcnYVxNhClrk7yPaq7Kg-1
Received: by mail-yb1-f200.google.com with SMTP id v19-20020a252f13000000b0067174f085e9so3773592ybv.1
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zuOIThWLHPQrIV9Xk3qs7WdEGfL6EXCSxRj75kPC1Yg=;
        b=wZ5ThB4nosLlwk5uNFYiSxO4e/ebiicJGwt4Fs2KSInEpAZpNKEsMmXiG83SZiurWA
         bPvs8HLd84QRyKjDfZKvC28j3+kK9uOfU64r63PFBebI+wvB5jNByauDK7hqzoNbWPKS
         cGUvmTtkRZMYgF9I48UYX7mAt8PhUakN/xEDbJqXt2w+fW3Wo0mcEQKsX948AMVD4ymN
         n2gHe52PhlpuRprpSfKm6MQWxwSHgP48DYTHqajsrqVJg6Uk4x5cpfYr1uC5ZsdnWjsF
         wwt+r1vYejNze9OEmxwtLKt4JrjLU6q1JxUKmn79+qO5fmKel4cOYBQeLjiEvRWCQ37e
         s1Pg==
X-Gm-Message-State: ACgBeo1H3jKf1LhDpibZPKTUbtZU7w50UlOxbfyGaSaXGtV20+9RUOV3
        wO1RO+fWCvBlghK9vUYssJG4bvgLnLAO0R6exe4oSjy8CPEGthVYdrnMF2kIJSO1MPf7CfD2Ajf
        +t4/65uqh5ajSaYgXIrE9sRJT4i9bTElvmw==
X-Received: by 2002:a81:844c:0:b0:322:b95f:5a35 with SMTP id u73-20020a81844c000000b00322b95f5a35mr2832989ywf.29.1659097670256;
        Fri, 29 Jul 2022 05:27:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR63SiRgClJDsYzTXax0tPSPMSEXeWbYkxO0cmEN5Sl4ff3LqIuBWD4NPnXfkSSjT6Ddx+VFLSA4qiF2ipOZPr0=
X-Received: by 2002:a81:844c:0:b0:322:b95f:5a35 with SMTP id
 u73-20020a81844c000000b00322b95f5a35mr2832979ywf.29.1659097670026; Fri, 29
 Jul 2022 05:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com>
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 29 Jul 2022 14:27:37 +0200
Message-ID: <CAFqZXNvZFeOcgRtVKG3JPCPMb2E42Ot-B+BxbnRxWF9Jz-TvhA@mail.gmail.com>
Subject: Re: [PATCH testsuite 00/24] Clean up testsuite policy and support
 running as sysadm_t
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 29, 2022 at 2:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series aim for two things:
> 1. Refactor the policy so that it is easier to work with.
> 2. Leverage the refactoring to fully support running the testsuite
>    as sysadm_u:sysadm_r:sysadm_t.
>
> The gist of this work lies in unifying how test domains are defined,
> deduplicating the various boilerplate spread out all across the
> individual files (and not even used consistently), and in abstracting
> the policy caller domain/role away from the individual test policies
> into test_general.te. Some tests also had to be massaged to not
> hard-code unconfined_* and be generic against the context of the
> testsuite caller.
>
> The series also extends the CI to test running the testsuite as sysadm_*
> and also verify that no unconfined_t/sysadm_t unexpected denials are
> produced (which would usually indicate a missing dontaudit rule in the
> testsuite policy).

Lol, I got a bounce for patches 4 and 5 because they are too long :D
Hopefully the list owners can approve them manually. If not, I'll
submit this series as a GitHub PR and post a link here.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

