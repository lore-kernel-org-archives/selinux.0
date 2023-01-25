Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE5C54E94
	for <selinux@archiver.kernel.org>; Wed, 25 Jan 2023 09:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjAYJWP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Jan 2023 04:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAYJWO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Jan 2023 04:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3286CA11
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674638485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IiOKLXi1Wlh/PIZKw9+p/dGUPlSWbiQwTbLayhlOgd0=;
        b=S/kisReUia4hflws562p8PwgzuHJCUpwrM97Df1imDDV4mlFOMLRQ1HduWv2l0XjFOjPnA
        nVSzVCNLRB5b1pAVp5lyUC+UaZ9yJABwRKhDORey8RMJKPOQe7H5RhmHJ7P7IheW/xcZup
        vNHMRS/IxcEGJ9LSDbGOF04+tr2zqy4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-TMb1QzgvPQyqpcVPNbXKsw-1; Wed, 25 Jan 2023 04:21:24 -0500
X-MC-Unique: TMb1QzgvPQyqpcVPNbXKsw-1
Received: by mail-pj1-f70.google.com with SMTP id x12-20020a17090abc8c00b0022bfadb3a4dso796186pjr.0
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 01:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiOKLXi1Wlh/PIZKw9+p/dGUPlSWbiQwTbLayhlOgd0=;
        b=CchjNMEb4FgTHlUeo/jBHmplLQI8Bf8dFy6u1Md/I5LKVKw31TEgbrZuXITnFFkimz
         bnVIL6llhfNLt3CLkWvC9nL/3wq2FDuR4pVRH0oi8xsJSbLlM/FfaiFDTinBra5a390y
         GkWCi2P0tmBTrnPrAyxJexF3P4G70v5M5LcGJT+pu0s+ZcwOl7i04piwnvqJiwO9214V
         7O93leGgo2ehGl0i1nKZZqK4moOn2Zf6Dv/q0+vS/iy4OrqmDB67jG3Sqifb4H6ky5NF
         azMbhFCLO8/gpXvDKFy/enRk50CFNAqp1KaRWZws44M0dJnvqAifwPUDr1xNMM90eTu1
         NQ4w==
X-Gm-Message-State: AFqh2kpWkCvdYogJJSqGJO5ZPtxx/41vC5FBGqcqEbQGi53GwL1nBD6D
        J4N6+yTKf2m0+GFmLJA4LkTYzYYV7JBgExIuaso3C2qGZNpLNcP+nQIv5ThfgQ+5Dz1dnZH3atJ
        oR1YEWc1b0DkH9+Ry/F9lLOsL3y3p1xj01Q==
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id t1-20020a17090a1c8100b00229f07b07aemr3803499pjt.239.1674638482891;
        Wed, 25 Jan 2023 01:21:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtagn+NQP8TP4aQzHUMzvDKj8U8snaLrbcm9PUhS8bNck87SXzg09eiT4rN7I1G2wY43cQ2dU9y0nSZyiU1QvU=
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id
 t1-20020a17090a1c8100b00229f07b07aemr3803495pjt.239.1674638482583; Wed, 25
 Jan 2023 01:21:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS1tSbP8s4QzVPB42O6_3wGX47=9HXBSyqwnHrW47965w@mail.gmail.com>
In-Reply-To: <CAHC9VhS1tSbP8s4QzVPB42O6_3wGX47=9HXBSyqwnHrW47965w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 25 Jan 2023 10:21:11 +0100
Message-ID: <CAFqZXNvAsNBjACaoaH48wDEgKV-aKM1G9dwuozfhYvYmwCNcyQ@mail.gmail.com>
Subject: Re: selinux-testsuite broken pipe noise
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 24, 2023 at 8:39 PM Paul Moore <paul@paul-moore.com> wrote:
> When running the selinux-testsuite manually today I noticed the
> following noise in the filesystem tests:
>
> % make test
> ...
> chmod +x */test
> chcon -R -t test_file_t .
> Running as user root with context unconfined_u:unconfined_r:unconfined_t
>
> domain_trans/test ........... ok
> entrypoint/test ............. ok
> ...
> perf_event/test ............. ok
> filesystem/ext4/test ........ 1/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 14/76 yes: standard output: Broken pipe
> filesystem/ext4/test ........ 20/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 22/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 24/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 30/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 34/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 40/76 yes: standard output: Broken pipe
> filesystem/ext4/test ........ 43/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 49/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 55/76 yes: standard output: Broken pipe
> yes: standard output: Broken pipe
> filesystem/ext4/test ........ 64/76 yes: standard output: Broken pipe
> filesystem/ext4/test ........ ok
>
> The test system was an updated Rawhide system with the following details:
>
> % uname -r
> 6.2.0-0.rc5.20230123git2475bf02.38.1.secnext.fc38.x86_64
> % rpm -q selinux-policy
> selinux-policy-38.5-1.fc38.noarch
>
> ... and my selinux-testsuite build should be current:
>
> % git log --oneline | head -n 1
> 2cc067f ci: limit VM reboot time to 5 minutes

Yep, some change in Rawhide seems to have triggered this... The most
straightforward solution seems to be to just silence the errors. As it
is a trivial change, I have pushed it to the master branch:

https://github.com/SELinuxProject/selinux-testsuite/commit/909f3aea627300a7e5ad2bc724d12c3560d34515

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

