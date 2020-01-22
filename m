Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B4C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824FA206A2
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cuerz6vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgAVQLQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:11:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725827AbgAVQLQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579709475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWbRKXJtGqqKFzsIXxKdeZ5nRlHUs8ymlLAzphEQQNg=;
        b=Cuerz6vORFptfLzXJsZSRHueCXXeMcaMbyxlwysm/Y/JQhxDnPIkpsU7WCIjEj4Z+gzkig
        YdSZ8o+0fds/ICK59bv5OgsbHdJePcTvnCVDi5EQp+RqF4WRlNKZJ0bbSCC4gAzICh7HmG
        fLXuCe3fHXGp5CxGmeir3z/L0dx0D08=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-SkEcZkCpOG2MIvSmx_3wNQ-1; Wed, 22 Jan 2020 11:11:11 -0500
X-MC-Unique: SkEcZkCpOG2MIvSmx_3wNQ-1
Received: by mail-oi1-f197.google.com with SMTP id c73so2835086oig.21
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2020 08:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oWbRKXJtGqqKFzsIXxKdeZ5nRlHUs8ymlLAzphEQQNg=;
        b=HQpXExOnyRBx8Vvylo+xB/y6AemvelzQDMgm6KuYp7TG8Sw72gAYSv+SvAKKeRbzNJ
         k2fiJf9nulydAKCTNr3tXD4/kBcsPeuw6qJD2MWmeh75S/vjLra7RvYIigejKUXWmHLD
         fe4M4OTrjPmD6N3A5JW01vFg9djeaqZ42usCLfKEhArArqF838kuOnloLB2Mp4hUSEDt
         b/AcOssA03YmfhmbH+2XDWEqCROFA7H13Pt1YYgtqe6EBgIEnVpE63r9rWyBNykjpRMX
         GpSsclEsiPPPVGQTUF8T5snes8mEpPSOfEGcsUD5Z082kbpIIwofc+1J9oIa4+u1RMgw
         Pw/w==
X-Gm-Message-State: APjAAAVfwoUI51Sxr2elOYnZTp0lZ6qPlg4hbTLt0sRmjpDnjvUM3ChG
        ATUZTCqYRBCEH+iWLFcu2CsFohXGSJqNCQQo4ZqGfyz7mlDdK9eF6LSgQU19wz3kGbPskTZ3R3g
        kcd/yuR8+aUOclWiWU2I3HOHmaCIlyxt4UQ==
X-Received: by 2002:aca:f507:: with SMTP id t7mr7305332oih.156.1579709470422;
        Wed, 22 Jan 2020 08:11:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyixyXOg4hw+YC//Q2NunXtPpHzYTPx+BvYCCzPZEV8+QgMcafq3rvwfOTJ1+7ZV0fDtWkHNG6saYEzGDwTuSQ=
X-Received: by 2002:aca:f507:: with SMTP id t7mr7305314oih.156.1579709470112;
 Wed, 22 Jan 2020 08:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20200122154655.257233-1-omosnace@redhat.com> <20200122154655.257233-4-omosnace@redhat.com>
In-Reply-To: <20200122154655.257233-4-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 22 Jan 2020 17:10:59 +0100
Message-ID: <CAFqZXNvBgn9LK4GU4=dNF9YXSdPCxNUQQPZ9dPB5e6NVQnm8rw@mail.gmail.com>
Subject: Re: [PATCH userspace 3/4] checkpolicy: remove unused te_assertions
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 22, 2020 at 4:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This variable is declared in a header file, but never defined or used.
> Remove it.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  checkpolicy/checkpolicy.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.h b/checkpolicy/checkpolicy.h
> index 3868f1fa..8fbc1b7d 100644
> --- a/checkpolicy/checkpolicy.h
> +++ b/checkpolicy/checkpolicy.h
> @@ -13,8 +13,6 @@ typedef struct te_assert {
>         struct te_assert *next;
>  } te_assert_t;

Actually, it looks like this whole struct definition can go as well.
I'll post a v2 later.

>
> -te_assert_t *te_assertions;
> -
>  extern unsigned int policyvers;
>
>  #endif
> --
> 2.24.1
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

