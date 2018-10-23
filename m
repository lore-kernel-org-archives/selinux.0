Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F878C46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547572075D
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2sbsk/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547572075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeJXByD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:54:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37663 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXByD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 21:54:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so1792978oib.4
        for <selinux@vger.kernel.org>; Tue, 23 Oct 2018 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5R6QS3prDXeB/duK3wj+SGbN12ZRJi3ip1yORdWuEU=;
        b=e2sbsk/t0W4Td+flRLLgJ6nc1USHPOpPxwnziimqdMA4YqrZpiALqgLKAGmlWBvotH
         9j2B1y+h/7P7wH6VDds189HX7Ww4DE6MPOnX/0GV4oXPWDPfQM4xX9rj05S38yW+/3o5
         CWcJjnoRIHWFVN0iL5PhOsHHaGWZWcCybidksMpO8ie6p5K3xYEkDxjY7eSzQA0HcfbI
         GloNgBHucxjAxfG9V8roM5qhL8jLxUQQwyFwP7le9q97AXBmtqjrbPaBYPWfz9LTaQRQ
         XefVVkGrflbeIyO2E5RXFllrn9y19Mels3zwzVQi/eQKeNKZE5GMUfD5csbAC8OXgAOp
         4iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5R6QS3prDXeB/duK3wj+SGbN12ZRJi3ip1yORdWuEU=;
        b=lhRnnCRHLMJ399QOMs2a0s3SMZaFz3xjcS2Te88YbyyjZTwiMNjWWIhc1rIB4scpb0
         y8ntW6Pc3PA8c7ckKIP0dR14XuPwkM3zHxFxPW7IgBkV3jB1s+1jrlhyrPKEetkBX9k1
         R9RXaNBwLOP9rWeI+rZfpISjcozLfDAlRz7Eb1KfEDOufcHjX89D+Chcq6hNwkhV095m
         CbmAiJGUd0VSxHxYsFJurZYjClG4/ZMIPqV3UIl/NqVGo0+BO/G9UWek9Aqz3Q0KLNQ0
         jUiYnn6a37KcGRb83AP+Al9KykY1VDY7iXXtT21HTN/yeSyh6fTuQVeuzTURyqKjZ4MH
         wTPg==
X-Gm-Message-State: ABuFfohDFZA1kktpZhoBWw+hWRKpnyKiBbHuN7ZMcs84ZkF8L3pKIIDI
        P/0Ydz7p1Vs1fEAtJB9pRUHxi7Ri81+Mm3/S430=
X-Google-Smtp-Source: ACcGV62RZccAJOZ6kaiTgAavv7Pi3295HsWrmTcQ+mh6TnjzXgFLTRzzl2Y7BIIe3TLh+MWXYpytWf+lv2Q/HIcLx7I=
X-Received: by 2002:aca:59c4:: with SMTP id n187-v6mr3657853oib.279.1540315783537;
 Tue, 23 Oct 2018 10:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181023065757.16784-1-omosnace@redhat.com>
In-Reply-To: <20181023065757.16784-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 23 Oct 2018 10:29:30 -0700
Message-ID: <CAFftDdr9s72BPz+j1GhFXS_DWpo0ucehv=jHJkOcZc=yzwAhAg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add missing ibendport port validity check
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 22, 2018 at 11:58 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> Changes in v2:
>  - use UINT8_MAX as the limit for ibendport.port value to emphasize that
>    it is an 8-bit value
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index db6765ba..96176d80 100644
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
> +                               if (port > UINT8_MAX || port == 0)
> +                                       return -1;
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

ack. I dropped it on top of https://github.com/SELinuxProject/selinux/pull/105

Thanks
