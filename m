Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5DFECDE32
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 22:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D2F20645
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 22:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvLpQoAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D2F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJRGHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:07:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42638 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeJRGHq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 02:07:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id c23so26034742otl.9;
        Wed, 17 Oct 2018 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EH6i72BY4iyNFJdTQj9yc4hNslJHNDH2mGxlmF5FJys=;
        b=NvLpQoAAx0JNPfr3Q5D9QJVqwJErM1Bp0eypsgZbat1v9zVvfBEUGZr9ZHfg8Q3Ji/
         wNVcTwiHr5EfaZN2M7HgaMV7lwhFiIc2fBVc/m0GQHO2+nEfI5uSCLQcNR/qLm7tcQSa
         NTULO3e1wKCyo1F1zSkk2+ON+ndpMCJlJkIC7VstbwPxh2D8f2U0tIwMxAaAi+iCk7+G
         wn4g3Hio25yMZgUG2IK6JUipcciu08z0n4Y1JN4AsOTSsn5u8c2SftyDOGOHHwO3+33Z
         /IyxnoXMch+MhF2UbaURjY8tBS4Ab/kV4qQrqnqZAIsV2xefxhCp3Hij9JBQhAxSHqep
         dRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EH6i72BY4iyNFJdTQj9yc4hNslJHNDH2mGxlmF5FJys=;
        b=oXtLk3Hz7aXY8zRQlmKBgdAfGrYwX4m8zqJPa0g9can5rgQX1cGikTay7aXtF6iBSW
         oe7yMfZsCSCPf1UTAYGQn4IxJGFAEJMPgqPegEPhHF1UAJ49Bb9uRNSbhm43XW0oKugC
         Ba4Ory/yNWbjWAMMSYSwpbFftjt7LZvFtussa45VE1tSyvYzAokch15exbn9cGl09H/U
         7dwsLP3toRrShXyQmv0WfIt8COG6CEJ835N4z6sojBR7R2+ssXefk2wVd68vy5CFFS2l
         u18fdfUmOdk/52BpkhbPNiu5D+v6L7kWFyBxps+7Bv/KYoqTEv8SUVZLoU5JNMYgPFR1
         AFcA==
X-Gm-Message-State: ABuFfogvJ68dsdZGdrzZ/8pzMTN0QACQ3bmW2V8k7THVpwkQ1PJWeCfv
        lUkwxH8eSOzBkG88MOcasarfoBzcnFJV0JXlD9s=
X-Google-Smtp-Source: ACcGV61mzFybjy2PDviMbSJyNHzQM5ZGjuP3HoLHQH/8MeQf52wxdQZCibFXfihTmXQLM7wJEtuquY6LRaeNqpx44sw=
X-Received: by 2002:a9d:26f9:: with SMTP id i54mr18595765otd.142.1539814202954;
 Wed, 17 Oct 2018 15:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181017141512.4866-1-omosnace@redhat.com>
In-Reply-To: <20181017141512.4866-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 17 Oct 2018 15:09:52 -0700
Message-ID: <CAFftDdoF8yo5psEzqnneav0y0jDB8V9a9PZ1pS3kktwAGwPU2A@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: policydb - fix byte order and alignment issues
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        stable@vger.kernel.org, dledford@redhat.com,
        selinux <selinux@tycho.nsa.gov>, eli@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 7:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
>  security/selinux/ss/policydb.c | 41 ++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
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
> index f4eadd3f7350..b9029491869b 100644
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
> @@ -2218,21 +2219,26 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                 break;
>                         }
>                         case OCON_IBPKEY:
> -                               rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> +                               rc = next_entry(prefixbuf, fp, sizeof(u64));
>                                 if (rc)
>                                         goto out;
>
> -                               c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +                               /* we need to have subnet_prefix in CPU order */
> +                               c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
>
> -                               if (nodebuf[2] > 0xffff ||
> -                                   nodebuf[3] > 0xffff) {
> +                               rc = next_entry(buf, fp, sizeof(u32) * 2);
> +                               if (rc)
> +                                       goto out;
> +
> +                               c->u.ibpkey.low_pkey  = le32_to_cpu(buf[0]);
> +                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[1]);

We noticed this in the coresponding user space patch. Assigning 32 to
16 truncates the values and thus
the conditionals below are always false.

struct {
  u64 subnet_prefix;
  u16 low_pkey;   <-- u16
  u16 high_pkey;  <-- u16
} ibpkey;

I figured I would comment just to make sure folks following one patch
and not the other are
informed. You'll need to respin a v4 and asign to a u32 intermediate,
range check and the assign.

> +
> +                               if (c->u.ibpkey.low_pkey  > 0xffff ||
> +                                   c->u.ibpkey.high_pkey > 0xffff) {
>                                         rc = -EINVAL;
>                                         goto out;
>                                 }
>
> -                               c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> -                               c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> -
>                                 rc = context_read_and_validate(&c->context[0],
>                                                                p,
>                                                                fp);
> @@ -2249,13 +2255,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
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
> @@ -3105,6 +3112,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>  {
>         unsigned int i, j, rc;
>         size_t nel, len;
> +       __be64 prefixbuf[1];
>         __le32 buf[3];
>         u32 nodebuf[8];
>         struct ocontext *c;
> @@ -3192,12 +3200,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
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
> +
> +                               buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
> +                               buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
>
> -                               rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> +                               rc = put_entry(buf, sizeof(u32), 2, fp);
>                                 if (rc)
>                                         return rc;
>                                 rc = context_write(p, &c->context[0], fp);
> --
> 2.17.2
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
