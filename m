Return-Path: <SRS0=DaVr=M6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE0C5ACCC
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5812083E
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5812083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeJRPTu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:19:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36009 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJRPTu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 11:19:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so27381277otg.3
        for <selinux@vger.kernel.org>; Thu, 18 Oct 2018 00:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ou6t38pVzb5iHXXbrB0wGbhVS5/MDODcgk1V4ZykEGE=;
        b=qPpL6sco8foI6G64KYwv1bqQd5DsUMWjnUl8KoyM1vms53ey5pAQt1r3pbG9uXpXII
         Vvl0iTHbb9jMW3Me+w02//mlTaG+0BZXl+VajWsrfiWprvGcsCJKK7IVSXiaT3CQep8u
         1osNB7G9RN7vNZF635Z6KFWuKvvFIKHTosIXYmLjP7k69/fU8uedldKyNyIeUn5yk01j
         iF57Yzkzlc9z9ojhFjhyI00ZOVlotmZsUjqK4qHPJdj558ZpQhU87mydXrY5SukC47fY
         hi0/xrqp0zdIg51fOYhQ+rahaqu1snZJ5am1GFe672tPeRAbcbgiI55h7q2eHINLFFUS
         6lag==
X-Gm-Message-State: ABuFfohfOivlP97TZKXEE8OGLss/+Qx+L8MuGX28kG399yOSTd0Vq0W5
        dxXuOPTg5sybwA/aLX2mRfJW+CmMul/sE6VAjH5qpQ==
X-Google-Smtp-Source: ACcGV63Ci1yDA8tLw3cjebzdNp3l+CVgYdaGkdA5HlFBLKUFI/d1ues1y3NlKKswkuDZkUAqG1xcLumx6E2KD3F3J30=
X-Received: by 2002:a9d:3dc9:: with SMTP id l67mr17555450otc.209.1539847212909;
 Thu, 18 Oct 2018 00:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com> <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
In-Reply-To: <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Oct 2018 09:20:01 +0200
Message-ID: <CAFqZXNvqYb+_yNL_0tTnYAO=KSEWbRfSSbxwKv-0U76HiLRfgw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 6:07 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Wed, Oct 17, 2018 at 7:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > We need to convert from little-endian before dong range checks on the
> > ibpkey port numbers, otherwise we would be checking a wrong value.
> >
> > Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  libsepol/src/policydb.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index a6d76ca3..dc201e2f 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                 break;
> >                         case OCON_IBPKEY:
> >                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> > -                               if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> > +                               if (rc < 0)
> >                                         return -1;
> >
> > +                               c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
> > +                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
>
> Ahh you're assigning a 32 bit value to a 16 bit variable low|high_pkey. I think
> you need to assign them to a uint32_t if you want to actually range check them.

Oh right, I didn't realize those fields are 16-bit... Let me fix it and re-spin.

>
> > +
> > +                               if (c->u.ibpkey.low_pkey  > 0xffff ||
> > +                                   c->u.ibpkey.high_pkey > 0xffff)
> > +                                       return -1;
> > +
> > +                               /* we want c->u.ibpkey.subnet_prefix in network
> > +                                * (big-endian) order, just memcpy it */
> >                                 memcpy(&c->u.ibpkey.subnet_prefix, buf,
> >                                        sizeof(c->u.ibpkey.subnet_prefix));
> >
> > -                               c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> > -                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> > -
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> > --
> > 2.17.2
> >
> See job: https://travis-ci.org/SELinuxProject/selinux/jobs/442750208
>
> Build fail with gcc:
>
> policydb.c:2839:31: error: comparison is always false due to limited
> range of data type [-Werror=type-limits]
>      if (c->u.ibpkey.low_pkey  > 0xffff ||
>                                ^
> policydb.c:2840:31: error: comparison is always false due to limited
> range of data type [-Werror=type-limits]
>          c->u.ibpkey.high_pkey > 0xffff)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
