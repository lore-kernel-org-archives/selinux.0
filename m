Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D2FC46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438FC205F4
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 06:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438FC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJWPQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:16:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44197 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWPQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 11:16:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so222664oia.11
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 23:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/j6byON2eBTgrFnqQlxnvdrkBMhXKqqJxFYtseifiU=;
        b=hlFVYwJnNaZEYeV2NhDENZ7zAtg7PI1DmcYa4r45j3FSE3TyQ2hLLeiPuX1i/oWql7
         lgXE84JH0+gkpBNGs/8+EvOQIH1xyH4ekvM0PkM0oaa7x/cCxzJkt3Rd2NcBQT/jBzks
         kay0wyELzy+wY/0x3JFL0bI8chczkc0HH+uGOBTAv4y4J+fDmDarLSu5yyb43HXUL9yj
         sfkG1K5YxfAgnj7tzWOEmji7Agdx4mV5DTOjmO/r+Et0ohvaZuuq/XpU3DuAn2jIOG4L
         0gwy5jHBxubYvPfyfRzMjL6YV1PYWIqPyG8gHaEOrtjeSxtpxupIN+JUQckifJQyHC1y
         5qEA==
X-Gm-Message-State: AGRZ1gLcNqUlKqXAaSBEksTvrb1W8It3qY8zFxFIrLUjdzPL71QpEKgl
        5LRfuke52/I/z1mBLHT0s8+elUPY9thqIytfMnUfAg==
X-Google-Smtp-Source: AJdET5dN9JFillUjhXub75wBgnUvCMLXB/IoSR+dkXDWrgIPHJVXt691q0GUjhnFXOE7nc2WEngHHWGVvF5A68jKlb0=
X-Received: by 2002:a54:4585:: with SMTP id z5-v6mr143646oib.297.1540277681431;
 Mon, 22 Oct 2018 23:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181022081807.5018-1-omosnace@redhat.com> <CAFftDdpav=0ggUZE_N9Jt2QTU0CNkyu9rNAfRB_d3=R9vEfApg@mail.gmail.com>
In-Reply-To: <CAFftDdpav=0ggUZE_N9Jt2QTU0CNkyu9rNAfRB_d3=R9vEfApg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Oct 2018 08:54:30 +0200
Message-ID: <CAFqZXNtAanWb8Cs7VOn=Nm9Q02Egevu_iKDHTvvw4JsFdfj1AA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add missing ibendport port validity check
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux@vger.kernel.org, SElinux list <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel Jurgens <danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 22, 2018 at 4:49 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Mon, Oct 22, 2018 at 1:18 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The kernel checks if the port is in the range 1-255 when loading an
> > ibenportcon rule. Add the same check to libsepol.
> >
> > Fixes: 118c0cd1038e ("libsepol: Add ibendport ocontext handling")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  libsepol/src/policydb.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index db6765ba..e2808b2d 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2854,7 +2854,9 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                         return -1;
> >                                 break;
> >                         }
> > -                       case OCON_IBENDPORT:
> > +                       case OCON_IBENDPORT: {
> > +                               uint32_t port;
> > +
> >                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> >                                 if (rc < 0)
> >                                         return -1;
> > @@ -2862,6 +2864,10 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                 if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
> >                                         return -1;
> >
> > +                               port = le32_to_cpu(buf[1]);
> > +                               if (port > 0xff || port == 0)
> > +                                       return -1;
>
> You switched the other code to using UINT16_MAX, should probably use
> UINT8_MAX here.

Good point. I'll need to update the kernel patch as well.

Thanks,

>
> > +
> >                                 c->u.ibendport.dev_name = malloc(len + 1);
> >                                 if (!c->u.ibendport.dev_name)
> >                                         return -1;
> > @@ -2869,11 +2875,12 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                 if (rc < 0)
> >                                         return -1;
> >                                 c->u.ibendport.dev_name[len] = 0;
> > -                               c->u.ibendport.port = le32_to_cpu(buf[1]);
> > +                               c->u.ibendport.port = port;
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> >                                 break;
> > +                       }
> >                         case OCON_PORT:
> >                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
> >                                 if (rc < 0)
> > --
> > 2.17.2
> >

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
