Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C34C4363D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8625F20708
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJBHBd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 03:01:33 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59566 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 03:01:33 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 03:01:31 EDT
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BEDEC564E65
        for <selinux@vger.kernel.org>; Fri,  2 Oct 2020 09:01:29 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id m128so338398oig.7
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2020 00:01:29 -0700 (PDT)
X-Gm-Message-State: AOAM532Mxx85VY5GbSUY7zGsEu7p+AmGYqDnl8vTb8QSYoGMwZLVq9O1
        vt3Zuz7vORHAD13DEv263ntdPYMmLusYzO088B0=
X-Google-Smtp-Source: ABdhPJz50gBkyhWoR4fZ4xuoLP9Y9PmCVolmcDXtyiol5HTig5lqOptwSQu9SoTZLJtlpfcchkFGlWeY5xwNQn5Tw/E=
X-Received: by 2002:aca:ac14:: with SMTP id v20mr483834oie.40.1601622088646;
 Fri, 02 Oct 2020 00:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200907174712.290567-1-dominick.grift@defensec.nl> <20200908085329.409762-1-dominick.grift@defensec.nl>
In-Reply-To: <20200908085329.409762-1-dominick.grift@defensec.nl>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 2 Oct 2020 09:01:17 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=khmKePn+=oA87mPXSZEgCiVzZ-3hJZZHF927a+=2R3TQ@mail.gmail.com>
Message-ID: <CAJfZ7=khmKePn+=oA87mPXSZEgCiVzZ-3hJZZHF927a+=2R3TQ@mail.gmail.com>
Subject: Re: [PATCH v2] cil_network_labeling_statements: fixes nodecon examples
To:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Oct  2 09:01:30 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 10:53 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> The order of the subnet and netmask is wrong and also the value of netmask is wrong for single address subnet
> Use an ipaddr reserved for documentation: https://tools.ietf.org/html/rfc5737
> Add ipv6 example: https://tools.ietf.org/html/rfc3849

It seems that this patch slipped through the review process, as there
could have been some confusion about the repository it was for. It
seems to me that it is for https://github.com/SELinuxProject/selinux,
and its contents looks good. Thanks!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody complains, I will apply this patch tonight.
Nicolas

> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> I added a ip6 example because the old style netmask makes that a bit unclear. I know I will appreciate such an example later on.
>
>  .../docs/cil_network_labeling_statements.md   | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
> index 49a836c1..60aec80d 100644
> --- a/secilc/docs/cil_network_labeling_statements.md
> +++ b/secilc/docs/cil_network_labeling_statements.md
> @@ -145,12 +145,21 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
>      (context context_1 (unconfined.user object_r unconfined.object low_low))
>      (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
>
> -    (ipaddr netmask_1 255.255.255.0)
> -    (ipaddr ipv4_1 192.168.1.64)
> +    (ipaddr netmask_1 255.255.255.255)
> +    (ipaddr ipv4_1 192.0.2.64)
> +
> +    (nodecon ipv4_1 netmask_1 context_2)
> +    (nodecon (192.0.2.64) (255.255.255.255) context_1)
> +    (nodecon (192.0.2.64) netmask_1 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
> +
> +    (context context_3 (sys.id sys.role my48prefix.node ((s0)(s0))))
> +
> +    (ipaddr netmask_2 ffff:ffff:ffff:0:0:0:0:0)
> +    (ipaddr ipv6_2  2001:db8:1:0:0:0:0:0)
>
> -    (nodecon netmask_1 ipv4_1 context_2)
> -    (nodecon (255.255.255.0) (192.168.1.64) context_1)
> -    (nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
> +    (nodecon ipv6_2 netmask_2 context_3)
> +    (nodecon (2001:db8:1:0:0:0:0:0) (ffff:ffff:ffff:0:0:0:0:0) context_3)
> +    (nodecon (2001:db8:1:0:0:0:0:0) netmask_2 (sys.id sys.role my48prefix.node ((s0)(s0))))
>
>  portcon
>  -------
> --
> 2.28.0
>

