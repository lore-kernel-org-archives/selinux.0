Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8978FECDE32
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413B42150F
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGdmYJWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413B42150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJQXAz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:00:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39787 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJQXAz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 19:00:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so21335572oia.6
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0wyftkybGMiqtv00vq8Ux1b04jEYatlNO87eKDeqBE=;
        b=TGdmYJWnb3GQ9VG/UU9tDh594xSdYLtkUW10+ouLDK61iR+fVXt/uICmgEW6MJTooy
         htwb+VU2DLlY4VylLhkH/ggi1nrva28oAP7VB/1KxCRuvQF7/Nk6XlrgK0twZIDXqzM6
         yBCwjAecUCeHK0Cg6GEm3lUVmf+iyb4iFnz8zLhNqGAJr1Qb2kOeP1iKD9WnWsrdiRr0
         HHO7CgQcpG58s33YzbNN+hApih3Qqu2QFsjJUBrHdN7ua2yIwXV7B9zUaBr57A2e5kqb
         e4dYU7qYs70UrUwGzZhTtr7GDninFRiMvz9Nqe0S6Ze91EPiDK3xcsx0q/NpvfdoT+3z
         YmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0wyftkybGMiqtv00vq8Ux1b04jEYatlNO87eKDeqBE=;
        b=REQsfF2E+PH+YEhwTkLc8tMwvZydlMuM7hVpM0B0BT12bnK9NcN5zCP0Wi4YFJSA28
         QQ0/YjHq13xlMnBMTqgxnD1qNmtuHKHT9aIDqb8enq3mlxY7an4o1O/4N6ogFeROjMQU
         rX8XpYRs+GCZbmNERIm5Va8rIX1iHZWJGa0bN8XAhj/Owl+0APYWDnF9w6QIo2ZpVjL3
         9tl+RaklXxyqMaSI6pUth3SdY98aUgIczNuO8e++ZT2fGxH+Ql749U7fbL8AtUF5Ig7W
         ClE2mlcOHMLOmYmjhAqjftWDenTzzX7SXD+/A55VWPVXJaa+FHFVmo7Gk8vspiHbYViP
         ad6w==
X-Gm-Message-State: ABuFfoil4ML5eJQ/xLlnvXlWpp/Szt3f+sAp7d9k47sBX4e0e2Hn+x1g
        r4oIfeJnAfvn5o9jiO4thtSZ9Sie24a4BUdrTDI=
X-Google-Smtp-Source: ACcGV637W+XjgK6maMPnwq4Gx5oNH4AaSJEZUDUIxGJ8D9iqSAoQs+wpD2bhAkom1r+GvLHnWOMyiyt5e9HxusLmKgA=
X-Received: by 2002:aca:f341:: with SMTP id r62-v6mr14995628oih.230.1539788688357;
 Wed, 17 Oct 2018 08:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com>
In-Reply-To: <20181017144659.10960-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 17 Oct 2018 08:04:37 -0700
Message-ID: <CAFftDdpduWSh3y+5Y9tY71NHiZUqxejb6TA=b3cxfzaYs=NGFA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 7:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We need to convert from little-endian before dong range checks on the
> ibpkey port numbers, otherwise we would be checking a wrong value.
>
> Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/src/policydb.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index a6d76ca3..dc201e2f 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>                                 break;
>                         case OCON_IBPKEY:
>                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> -                               if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> +                               if (rc < 0)
>                                         return -1;
>
> +                               c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
> +                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> +
> +                               if (c->u.ibpkey.low_pkey  > 0xffff ||
> +                                   c->u.ibpkey.high_pkey > 0xffff)
> +                                       return -1;
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
> --
> 2.17.2

This seems to line up with what I have been following on the kernel
side. But since Stephen
committed the patch this fixes up and is way more involved, ill defer
to him. Soft ack from me,
but I would imagine we would want to see an ack on the kernel side
before pulling this in.

>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
