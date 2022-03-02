Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95181C4332F
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiCBQVE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbiCBQVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 11:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 238369E9E6
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646238019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mi9d0z3hlNmZs4DgmsD1Q0TBGhS/Q0z0n6CA72h9+tw=;
        b=ELocfUTBVet7wrl/juRs+6h54L5l7WXqw6nP9wDPcYOpsv9LBtCAcbRKiHKJFYtmWQgLVd
        NFE1xHF1mXS6/yhY60C1+O44JpxwLB9/+V7oG1ZM08X0Dwjp6DPNxhJzOzWqAOKqOkx0sG
        UW+KWy+ZNBaRwa/Oa5rWMXU/rP6d3q4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-e1GODSiVPs-MmuqYba77FA-1; Wed, 02 Mar 2022 11:20:18 -0500
X-MC-Unique: e1GODSiVPs-MmuqYba77FA-1
Received: by mail-yb1-f198.google.com with SMTP id g2-20020a5b0242000000b0062892750241so1111530ybp.23
        for <selinux@vger.kernel.org>; Wed, 02 Mar 2022 08:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi9d0z3hlNmZs4DgmsD1Q0TBGhS/Q0z0n6CA72h9+tw=;
        b=Qo1hmu0ruFdvzro4wnG+8Kp8myHWCK1ngtZv0woqUOYvoJw6lL0Lo1qpeoQurRfSJk
         jfINxLJk0gpCdcOGqbd4pe+ZUT/BVJ3AKX/KcgeoDSlFXEmKB25QHoPBCU5xF65DawcI
         huZtuTKiFxRqgjXraTG+XwnsCcBOvZ6ZjdRe7XQEYFUvHu/tfjXsiA4rCGybNIZvaYMp
         r5xBzwTkdj0Y+GYkT3xBbA7IktXwtl5djl/L9liJU3IBX+hjNLtLGlqgkyPMYFaV61Tx
         GVxts+yZp7vwfNYIR3hpj1FropAwRd5RGwfKvim43N7L9yeFPmQNN6afKclStI6jp37N
         +LAg==
X-Gm-Message-State: AOAM533pneODcrfqIshPUCVBpqHO+LaA36SbbxSlTKVoIvtdnCK1BDHV
        TpqLFZVnMJP23txM+dLHmJrzc1JuJtQwwzRLsACJSbgERq2p3IEfGHijA/wn0K6Mqa8PwFMM2d2
        +BGI2eUTZfJmT77o/uVbq8nOjNUs/iyTDSg==
X-Received: by 2002:a81:b549:0:b0:2db:c2a8:3689 with SMTP id c9-20020a81b549000000b002dbc2a83689mr11528608ywk.247.1646238017293;
        Wed, 02 Mar 2022 08:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxETP3iiAa71nOOhMVsmAuWiBSkipltxJjgjnpbe/r2yxWZm4ZVLweG554AaMM3rdsF19s/qvXdx7oZTXXyGTk=
X-Received: by 2002:a81:b549:0:b0:2db:c2a8:3689 with SMTP id
 c9-20020a81b549000000b002dbc2a83689mr11528576ywk.247.1646238016922; Wed, 02
 Mar 2022 08:20:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtBmoVppmhgrxfzuZrQ+oksWeSHH_x7ZgG4Wa6VO05Dsw@mail.gmail.com>
 <20220218092057.394337-1-plautrba@redhat.com>
In-Reply-To: <20220218092057.394337-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 2 Mar 2022 17:20:05 +0100
Message-ID: <CAFqZXNvk3QZZChy7Uasp2E4FjQj4yUBmSCq_bVvFacZtPv=xJg@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils/fixfiles: Use parallel relabeling
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 10:21 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> Commit 93902fc8340f ("setfiles/restorecon: support parallel relabeling")
> implemented support for parallel relabeling in setfiles. This is
> available for fixfiles now.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> - fixed echo commands for onboot
>
> policycoreutils/scripts/fixfiles   | 35 +++++++++++++++++-------------
>  policycoreutils/scripts/fixfiles.8 | 17 ++++++++++-----
>  2 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 6fb12e0451a9..1ff4d9bdf04e 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
[...]
> @@ -342,17 +344,17 @@ esac
>  }
>  usage() {
>         echo $"""
> -Usage: $0 [-v] [-F] [-M] [-f] relabel
> +Usage: $0 [-v] [-F] [-M] [-f] [-T nthreads] relabel
>  or
> -Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | verify }
> +Usage: $0 [-v] [-F] [-B | -N time ]  [-T nthreads] { check | restore | verify }

There is an extra space added here, but that can be fixed up when applying.

>  or
> -Usage: $0 [-v] [-F] { check | restore | verify } dir/file ...
> +Usage: $0 [-v] [-F] [-T nthreads] { check | restore | verify } dir/file ...
>  or
> -Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
> +Usage: $0 [-v] [-F] [-T nthreads] -R rpmpackage[,rpmpackage...] { check | restore | verify }
>  or
> -Usage: $0 [-v] [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
> +Usage: $0 [-v] [-F] [-T nthreads] -C PREVIOUS_FILECONTEXT { check | restore | verify }
>  or
> -Usage: $0 [-F] [-M] [-B] onboot
> +Usage: $0 [-F] [-M] [-B] [-T nthreads] onboot
>  """
>  }
>
[...]

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

