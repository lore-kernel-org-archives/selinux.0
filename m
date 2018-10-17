Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF320ECDE3B
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC3208E4
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="chC9GGXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDC3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJRFQV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:16:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46345 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeJRFQV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 01:16:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id p143-v6so9915048lfp.13
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DUWPbK6CUUr8LIiyRX+PX5QZhRlB3ONCDFDjte6XYo=;
        b=chC9GGXhzOi21gDIxybDMrrfJj7NfT37BflNtBW/Fe3vlJ0ZF7ilbXOAaPhvYYwAJH
         ZTeGmKX6N8nibD2K8j2lYdvY8P0Sk3aJThyFAhBF/hwNIfEQy5R4mOYZKaaeCDCvJmPr
         pXH2rQTdvKKOo7zr1DEQ4kfw86JTz+1FvWSw/FGk1D7j7lWGnihdSx4VdmCmL9BOo27l
         OoWT02+G6nnR/1Av8tn1h/OI6qBvEEWXkYyxbjQlg/XySFDQttcdSbQhYqlA5gBNwIpm
         sjkYWyYrIdVMNEa920/k8XmKxgtlTdGEld1ibOQfZIIa41n4HFqQLgcjADnBWiE3Mh+h
         B5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DUWPbK6CUUr8LIiyRX+PX5QZhRlB3ONCDFDjte6XYo=;
        b=m7iJBzttbcfEpH140Xa2NVBSELHP5RQGD74HZdVG7qu59MWliqQQKKtikijHn/KZ+1
         cgeIkuiYiPc8SvH76MoMFmOJ8+4OOcG0c64wa1BzTmrrkdN3/0IJe5jpiMv27iD2N2uH
         wbj3z5fz0wXBPza9qY19oPVNSo2LB/QPbGiVVE5ymsJRdUt8RGef51yUAuF9p7VESoO6
         lku3CeIm2xPdylh0en3u4yN3ryY+NCxXlMrLOF7KHqdVfCyBTHNXuJkp1yNridzALCgR
         K+ArbUTG1rWfDM0sfmWDgUAoiryUxm8QGvwatC5gFXO9gPrh1X911YtR9aAtZF1WSu6Q
         9ueA==
X-Gm-Message-State: ABuFfojwM7tpXxzrskT9cwDD9mEAOCcfJdW3QjdyOZYXvmte4qmUkLxg
        +0YNtk0X0LK32wixvvPqEvGaL86H286+MN32AR2Q
X-Google-Smtp-Source: ACcGV63bPWYfVTwplSkYbJm65Pi2dJaTyP37M/Txe6IaE6rkz71fCpG5+EHuOdzNrUjkhBuep9tUjPZWB5hd1runHnI=
X-Received: by 2002:a19:5710:: with SMTP id l16-v6mr17815524lfb.71.1539811126301;
 Wed, 17 Oct 2018 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181017144659.10960-1-omosnace@redhat.com> <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
In-Reply-To: <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Oct 2018 17:18:35 -0400
Message-ID: <CAHC9VhT_npm4ix7kmN8GOOxUp8z7ySz0Z6LLKqd0VOMJPKcibA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     bill.c.roberts@gmail.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 17, 2018 at 12:07 PM William Roberts
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

If you can, give me a chance to look over the kernel changes first.  I
doubt I'll see anything objectionable given the review the patches
have already seen, but one never knows.

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
paul moore
www.paul-moore.com
