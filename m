Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB93ECDE32
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 16:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C32150D
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRn8v5Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C32150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJRAD0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:03:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38288 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRAD0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 20:03:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id l1so26710942otj.5
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYaJE70JWEpW5TBnnGI7YAwXvwO8mzNX6chEigaYwNk=;
        b=hRn8v5RgWk/rGW3bK21wxuuYltZXHwfg2VT1mlZpVw1Grvr4DhzBvWbEM6Kd3mQcwf
         d0/5N96Wktr0eBeT1nvK3YpBkVPv4fE+Nhr6RxtAGniz1iLFW3QOUGTDn7Uu5HqPb1Wr
         gJawhbhZnRv7W5ci2MYoyhuGkoNxyOO40hhmun2hJlNogDf31v/7Tlucux34s0cpCYKw
         MGyzpx2p6hnqvzPH4keqz98tOJTaqoHceS3wcWy/PN/b7DCtauyqeQc5+HNxOuQhtVF4
         3gQLHQ5pV1vcs7RtS7xoNc5gjb3RMVSCevT5WhP6hoRdymbuhIQ7CiG64Sk0yRjRg8em
         eGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYaJE70JWEpW5TBnnGI7YAwXvwO8mzNX6chEigaYwNk=;
        b=VxeUJvAQTmZ+ZPKnVBKw4/c8KEsYwYJTcQHdetpn2+aHfEZ1Ml3u+NbXGwulCup6bF
         ozGtwMXIRMmBQGd41HQNqISdAkZHJljr1IiEikwCDL26NIqSDpFS09hlH/c2aVd6Ik7f
         cLm8QLhycD255khNg80w3fWM492hY9XJ+hVUxgV/XsACyXe9knqiuwt05vnIpTFZ8rwg
         7VDEUBrRI9Pl9X/hYJSoypoIJcac/I5s7b9deYwzd28+u86Ma6S8w0kTdF7Gl/bYqSEC
         cHQFbDhX0U6zqhjb6mykxxnCQBrOx3E7ExF88Hdnxl7BmFWzxm3jSQvftfeaTvunLS/4
         ZGtQ==
X-Gm-Message-State: ABuFfohKURY8pz0/VKqAmv6y++zcOVoDmqZglzPwSEco+Ez/xY25wUkN
        BTX3dx9AiqBMTlr8+V8iMIaHaOu5Lu83PIf08uM=
X-Google-Smtp-Source: ACcGV61fIBYfw6EXk5FPw2CK1PVerYYVewWSAtdKp9X6TMHw+3YWSkQNxxeVzPyeW356m4BqXzbVUMPtgwPd9zpKvI4=
X-Received: by 2002:a9d:2832:: with SMTP id m47mr16432508otb.109.1539792422640;
 Wed, 17 Oct 2018 09:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com>
In-Reply-To: <20181017144659.10960-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 17 Oct 2018 09:06:51 -0700
Message-ID: <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
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

Ahh you're assigning a 32 bit value to a 16 bit variable low|high_pkey. I think
you need to assign them to a uint32_t if you want to actually range check them.

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
>
See job: https://travis-ci.org/SELinuxProject/selinux/jobs/442750208

Build fail with gcc:

policydb.c:2839:31: error: comparison is always false due to limited
range of data type [-Werror=type-limits]
     if (c->u.ibpkey.low_pkey  > 0xffff ||
                               ^
policydb.c:2840:31: error: comparison is always false due to limited
range of data type [-Werror=type-limits]
         c->u.ibpkey.high_pkey > 0xffff)
