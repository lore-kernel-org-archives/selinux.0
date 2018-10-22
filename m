Return-Path: <SRS0=10e4=NC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A5C004D3
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DA720645
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 14:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtPNZe9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DA720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJVXH5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:07:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39203 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeJVXH5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Oct 2018 19:07:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id l58so40302296otd.6
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77T/GCOOQnzPb8Ff6Zgd2rGAJL0AYjMwo+94Pufqp+M=;
        b=GtPNZe9Rm63oJd5LPW9l7c1+0mV67VKLolD9BDfToR+qncyueXgYutMyY652laeMuf
         e7nBLbigAcCOUensxZoFQtXXNdVr8/8U76q1D2oy0n5oCrbENmojb1FbI1hoCu3xhCKp
         gLdQAPCrSFIQ6yX0FUo4WTWExUCybegQHTWE15tLMJNfCRVppNhQ74itk42PvMUfW14q
         E2q+NMqV5FqM0NXmKyaDqm/5l3uScYYWIINpzUr3drVPFdM20F6j40Wr9mcX2GzaUXoj
         N6IEu/jga7zOded7pvBQbZzmkbok0qwEapYrzGeCtpQBcJwnJCmnYwoFUG+AG1N1hHRk
         T7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77T/GCOOQnzPb8Ff6Zgd2rGAJL0AYjMwo+94Pufqp+M=;
        b=VpV/fK360jqzyMe5grXQZRY8b3kgTNEqLxjYH0yspnHZmzRaxt8KFTw2TdXQlakUaa
         PQ5WkyTUwESYeN3GSMamk/YRP9M6ag+PCPZENlnNqGKtbP6kVTyKVOLimhk494c9Zm0u
         RuK4gWlbSczDJGSysMkU7w91Vgr74pcxXywh2jDxaUC+12NKJ8oB2UHvOY+dWzgbFzzi
         T1rq3Z6Thuw+HnCcg9qanHKmTc6D+2yyq3CWbVgbyc3enMCiCtexUOtXqG1MB+uwSGri
         HpGxZWT2J3Sg097Uw/EkpQzwXQ/7fikD+xAO8RvHh+/S+CC+JRiv2RkEdRyeRqQ+Z7We
         aANw==
X-Gm-Message-State: ABuFfohUQwcDZJvZg8Kj2zU89+nB9gg0nkUlNIBnYqI0GoBYlPULlkR5
        Y86coFhJTJt4mkjSvTcPmr4uS4MM4SP3UyWfMdA=
X-Google-Smtp-Source: ACcGV617l7bB87pgdTDNPd1OJjU0N82wXEBqoBUTVS07388mGuoLjrWzo6bwcoQp8uiaSoBaROzrEGT6UP+BssrJ860=
X-Received: by 2002:a9d:7692:: with SMTP id j18mr11570078otl.217.1540219744714;
 Mon, 22 Oct 2018 07:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181022081807.5018-1-omosnace@redhat.com>
In-Reply-To: <20181022081807.5018-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 22 Oct 2018 07:48:52 -0700
Message-ID: <CAFftDdpav=0ggUZE_N9Jt2QTU0CNkyu9rNAfRB_d3=R9vEfApg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add missing ibendport port validity check
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 22, 2018 at 1:18 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The kernel checks if the port is in the range 1-255 when loading an
> ibenportcon rule. Add the same check to libsepol.
>
> Fixes: 118c0cd1038e ("libsepol: Add ibendport ocontext handling")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/src/policydb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index db6765ba..e2808b2d 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2854,7 +2854,9 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>                                         return -1;
>                                 break;
>                         }
> -                       case OCON_IBENDPORT:
> +                       case OCON_IBENDPORT: {
> +                               uint32_t port;
> +
>                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
>                                 if (rc < 0)
>                                         return -1;
> @@ -2862,6 +2864,10 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>                                 if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
>                                         return -1;
>
> +                               port = le32_to_cpu(buf[1]);
> +                               if (port > 0xff || port == 0)
> +                                       return -1;

You switched the other code to using UINT16_MAX, should probably use
UINT8_MAX here.

> +
>                                 c->u.ibendport.dev_name = malloc(len + 1);
>                                 if (!c->u.ibendport.dev_name)
>                                         return -1;
> @@ -2869,11 +2875,12 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 c->u.ibendport.dev_name[len] = 0;
> -                               c->u.ibendport.port = le32_to_cpu(buf[1]);
> +                               c->u.ibendport.port = port;
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
>                                         return -1;
>                                 break;
> +                       }
>                         case OCON_PORT:
>                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
>                                 if (rc < 0)
> --
> 2.17.2
>
