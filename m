Return-Path: <SRS0=DaVr=M6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA93C5ACCC
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E03208E4
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzQnGAx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E03208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJSARX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:17:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38989 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJSARX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 20:17:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so24477834oia.6
        for <selinux@vger.kernel.org>; Thu, 18 Oct 2018 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37Hn9nDkWAPRxKmXHyjzEB5zQX2N15q/KfCY6nCpeGI=;
        b=lzQnGAx9RGk5IOIk7s5OnNqEhlhEti40LRAXH0Z/vfhcGh//BVWODaxXGWX3beOg/n
         1/58FXjk6QaBsYnMWXQpkFidAJGk4TNsDBC18WDbdYcVZ0tXhVXOOo+uW8QKgON5oqHC
         l3Wpua8Q8mvJ8Uch9JIMhUliSIECozUJ+b1WRgtPuNSM9HQ53wpF52xHAZz/9nXTTkAK
         cA294x3q95OkrGru6u0UGRCbHXiXmquy3GaO2RLzsRcZF9YKWfaofoWWRd73hPgi8Czh
         yrHx50y6xgwzg6M8oq7U5Q4hvuiBt2E/P1Rzo/ilWDNm4jEG8BIW4BFsoKL3gUlbxkqj
         oiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37Hn9nDkWAPRxKmXHyjzEB5zQX2N15q/KfCY6nCpeGI=;
        b=HWWTfdLeqPUffMRnAbP7OjByiSqtOadYjB+0Cu8LghsGQ3l9SBcuhWYH+4+PYhfRAA
         Iegi63LDFAGXGm87w3O5QmzFUgwE/0YfcfxpFptYrdMcN/zHFlP3gTl+j1+lk1gV3spO
         GSsaftg18N9FHKUqlWKthvs5u6BLshCKukbh0HEhJxGoe9XA1O/5GqMwHiCLEXcNmgqG
         ym4eZbAqVPUF4OMAogydzPK6gcQtCRu8esIPbgOhyYvaAJ29TpmvQisCcWJ6gs8J0Jma
         fQ2F9x4QollcvYKu9bNqjADmCHgXQP8bBGrwka9P4JcgtmH0wJO3NFYAuZOEVa/vhoHQ
         JApQ==
X-Gm-Message-State: ABuFfohBBGir+GorW240TgYJBK44leMXhtPg16FTmD1PMRsFtQX2LE+8
        rN880AAmcnkXseHJDlsd5F384NGGzykUrFCcz20=
X-Google-Smtp-Source: ACcGV62b5MEomWkRJ5Wg92D5CJ3GSiK9Ju/mZOmvW0qKIN8sZyFfN1ExI/z/YWX/SYIDSwCPVI9yXuaT+yt3hF+o8SM=
X-Received: by 2002:aca:d651:: with SMTP id n78-v6mr16004605oig.287.1539879341133;
 Thu, 18 Oct 2018 09:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181018074957.24080-1-omosnace@redhat.com>
In-Reply-To: <20181018074957.24080-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Oct 2018 09:15:29 -0700
Message-ID: <CAFftDdorbUSccjDjTFfgB8F3JX9GJpgjUoi1J94xWDiJNOd=5g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: fix endianity in ibpkey range checks
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 18, 2018 at 12:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We need to convert from little-endian before dong range checks on the
> ibpkey port numbers, otherwise we would be checking a wrong value on
> big-endian systems.
>
> Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/src/policydb.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> Changes in v2:
>  - defer assignment to 16-bit struct fields to after the range check
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index a6d76ca3..db6765ba 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2828,21 +2828,32 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>                                     (&c->context[1], p, fp))
>                                         return -1;
>                                 break;
> -                       case OCON_IBPKEY:
> +                       case OCON_IBPKEY: {
> +                               uint32_t pkey_lo, pkey_hi;
> +
>                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> -                               if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> +                               if (rc < 0)
> +                                       return -1;
> +
> +                               pkey_lo = le32_to_cpu(buf[2]);
> +                               pkey_hi = le32_to_cpu(buf[3]);
> +
> +                               if (pkey_lo > UINT16_MAX || pkey_hi > UINT16_MAX)
>                                         return -1;
>
> +                               c->u.ibpkey.low_pkey  = pkey_lo;
> +                               c->u.ibpkey.high_pkey = pkey_hi;
> +
> +                               /* we want c->u.ibpkey.subnet_prefix in network
> +                                * (big-endian) order, just memcpy it */
>                                 memcpy(&c->u.ibpkey.subnet_prefix, buf,
>                                        sizeof(c->u.ibpkey.subnet_prefix));
>
> -                               c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> -                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> -
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
>                                         return -1;
>                                 break;
> +                       }
>                         case OCON_IBENDPORT:
>                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
>                                 if (rc < 0)
> --
> 2.17.2
>

Acked-by: William Roberts william.c.roberts@intel.com
