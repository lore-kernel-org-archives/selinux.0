Return-Path: <SRS0=DaVr=M6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A7C5ACCC
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B720869
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXO5b6Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3B720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJRXSG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:18:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33785 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeJRXSG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 19:18:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so30148607otd.0;
        Thu, 18 Oct 2018 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW1oQ98IsjQcRvXnmMcnplAppSPsYIr095OE1T7XHzE=;
        b=aXO5b6WbJqpQa9FjgpOmtt2kD/UVJ2BFlYDxDjoGHZVw3qneJuac9PbGCuGHHYMlBA
         fX7fBK4m4PNvlgRXV757Aa84ZuKNg7ugvksIwee8OsFOUJ3Tcy0nY5sUj8ZYN1QtsGHP
         bR4EeRsQxUIxvcjJ3b/M1UpUAUJjSoul/cPpqp0DKRyQAmsMH6D8pkfyzEvB7YPNhuMJ
         CMVBk2eGsO9GCGjcIsUTLXTDutc7bPZxWVuQK8GL3i9vA8Bzswax/vnwB2ex3/dai4Ct
         3nYSjkj4mDXG2oQzMN1iC0WGewBJPPIAf/EQeujI6v8C+EE83aMAqBsT7oloEXBtdxqh
         g80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW1oQ98IsjQcRvXnmMcnplAppSPsYIr095OE1T7XHzE=;
        b=htUlRdbD41mc9u7WTtvrVnqoqd6Mep26jZTWKWQp5lY+I05CwM/m9+wmo4rtIeIRoe
         cwA8UpvXFGB035pMFCI0KECfyXJEzZTWjVOmKHkbaTkyVRdHqchIOXOgHYvDfQKJkg0D
         18H0p9AvU+rVrhPXBT4pG+qIqTC6CGp3Z/ubHpL+5gu9mGqu3Ro3UMQDYJ4kQoAS9tmt
         OVw4ztBVOw+Azf8ztnRDSSSct7Ix4SUXY/RV9ySMWXaSWJbzEtjd268CFQcoi2p32VLR
         EfeJ0oHjkLgdoUcWqXknIwngniUJKb9pwMDrXZdLf/RrFfiVJr3LdyGIDZ3KK8BZnytV
         FYAA==
X-Gm-Message-State: ABuFfohZniTNDSOG+i/GdJqU9f6pDypDriLM1h/uc5nanpKfBqY3CNzS
        1JHqI0Hcjg2PH/duuIpgARu13J4gq52csRTWE0bLhw==
X-Google-Smtp-Source: ACcGV61Rn4VaGCcn5EpX+MCUz3ecyeExWWu4XguBN6/p+KnYdxHttLeQWHzLukwYJHmr7F0MhGilU/cAl2vFc/Nx88c=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr18325328otj.370.1539875797057;
 Thu, 18 Oct 2018 08:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181018074704.23835-1-omosnace@redhat.com>
In-Reply-To: <20181018074704.23835-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Oct 2018 08:16:25 -0700
Message-ID: <CAFftDdog9BsHE2pgPM5rba3ztTJ6QrruZUxh4au+mm0kyqQe8g@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: policydb - fix byte order and alignment issues
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        stable@vger.kernel.org, dledford@redhat.com,
        selinux <selinux@tycho.nsa.gov>, eli@mellanox.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 18, 2018 at 5:57 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Do the LE conversions before doing the Infiniband-related range checks.
> The incorrect checks are otherwise causing a failure to load any policy
> with an ibendportcon rule on BE systems. This can be reproduced by
> running (on e.g. ppc64):
>
> cat >my_module.cil <<EOF
> (type test_ibendport_t)
> (roletype object_r test_ibendport_t)
> (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> EOF
> semodule -i my_module.cil
>
> Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
> use a correctly aligned buffer.
>
> Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
> should be used instead.
>
> Tested internally on a ppc64 machine with a RHEL 7 kernel with this
> patch applied.
>
> Cc: Daniel Jurgens <danielj@mellanox.com>
> Cc: Eli Cohen <eli@mellanox.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: <stable@vger.kernel.org> # 4.13+
> Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 46 +++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 14 deletions(-)
>
> Changes in v4:
>  - defer assignment to 16-bit struct fields to after the range check
>
> Changes in v3:
>  - use separate buffer for the 64-bit subnet_prefix
>  - add comments on the byte ordering of subnet_prefix
>  - deduplicate the le32_to_cpu() calls from checks
>
> Changes in v2:
>  - add reproducer to commit message
>  - update e-mail address of James Morris
>  - better Cc also the old SELinux ML
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f4eadd3f7350..d50668006a52 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2108,6 +2108,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  {
>         int i, j, rc;
>         u32 nel, len;
> +       __be64 prefixbuf[1];
>         __le32 buf[3];
>         struct ocontext *l, *c;
>         u32 nodebuf[8];
> @@ -2217,21 +2218,30 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                         goto out;
>                                 break;
>                         }
> -                       case OCON_IBPKEY:
> -                               rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> +                       case OCON_IBPKEY: {
> +                               u32 pkey_lo, pkey_hi;
> +
> +                               rc = next_entry(prefixbuf, fp, sizeof(u64));
> +                               if (rc)
> +                                       goto out;
> +
> +                               /* we need to have subnet_prefix in CPU order */
> +                               c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
> +
> +                               rc = next_entry(buf, fp, sizeof(u32) * 2);
>                                 if (rc)
>                                         goto out;
>
> -                               c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +                               pkey_lo = le32_to_cpu(buf[0]);
> +                               pkey_hi = le32_to_cpu(buf[1]);
>
> -                               if (nodebuf[2] > 0xffff ||
> -                                   nodebuf[3] > 0xffff) {
> +                               if (pkey_lo > U16_MAX || pkey_hi > U16_MAX) {
>                                         rc = -EINVAL;
>                                         goto out;
>                                 }
>
> -                               c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> -                               c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> +                               c->u.ibpkey.low_pkey  = pkey_lo;
> +                               c->u.ibpkey.high_pkey = pkey_hi;
>
>                                 rc = context_read_and_validate(&c->context[0],
>                                                                p,
> @@ -2239,6 +2249,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                 if (rc)
>                                         goto out;
>                                 break;
> +                       }
>                         case OCON_IBENDPORT:
>                                 rc = next_entry(buf, fp, sizeof(u32) * 2);
>                                 if (rc)
> @@ -2249,13 +2260,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                 if (rc)
>                                         goto out;
>
> -                               if (buf[1] > 0xff || buf[1] == 0) {
> +                               c->u.ibendport.port = le32_to_cpu(buf[1]);
> +
> +                               if (c->u.ibendport.port > 0xff ||
> +                                   c->u.ibendport.port == 0) {
>                                         rc = -EINVAL;
>                                         goto out;
>                                 }
>
> -                               c->u.ibendport.port = le32_to_cpu(buf[1]);
> -
>                                 rc = context_read_and_validate(&c->context[0],
>                                                                p,
>                                                                fp);
> @@ -3105,6 +3117,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>  {
>         unsigned int i, j, rc;
>         size_t nel, len;
> +       __be64 prefixbuf[1];
>         __le32 buf[3];
>         u32 nodebuf[8];
>         struct ocontext *c;
> @@ -3192,12 +3205,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>                                         return rc;
>                                 break;
>                         case OCON_IBPKEY:
> -                               *((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> +                               /* subnet_prefix is in CPU order */
> +                               prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
>
> -                               nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> -                               nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> +                               rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
> +                               if (rc)
> +                                       return rc;
>
> -                               rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> +                               buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
> +                               buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
> +
> +                               rc = put_entry(buf, sizeof(u32), 2, fp);
>                                 if (rc)
>                                         return rc;
>                                 rc = context_write(p, &c->context[0], fp);
> --
> 2.17.2
>

LGTM
