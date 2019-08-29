Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E94C3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E5233FF
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 21:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="toqXzo9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfH2VLH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:11:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39881 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2VLH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 17:11:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so3714827oiq.6
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2019 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvgF5ukasw2+pf7aLn92xFBP8FamioK1eBfR4m64aE8=;
        b=toqXzo9KthPAYYbaTZYz/C9G8C41znFe/SuC+z5tu840nC7tiC8gwjoxISIZhQ+dLS
         C4ME8nAnzP2mhE3e4A6CPYVLxaOcSSuYdVuyLaoxBTE0qjJWF3WxkiFTsu2H8Ia/v+/q
         fmbwQQHnshNR8FU1pfGTVLfe4JOJklguTzjKDjFUimGAHfKd9OrS5BwhG9b+YHNNMesN
         Lz/6IDNKYNUihald1q6N7fQeEk7/tbwoF7yHW9Qt/EqHFtpCESRWwuokCEDEn/Uy6fpw
         CPsjYfN8Av/k0PPm7oxbe5p1Z3rTsPKiuETehDsqKwbEKKLOz9oADMatpAOCPPBiigdp
         AZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvgF5ukasw2+pf7aLn92xFBP8FamioK1eBfR4m64aE8=;
        b=ksFg/sRetUtlCbK8a2seIM45acANe4ebhmg88E2JIcGZl8OkIdV50ezKUVkzvWfmUi
         pnCSXQA9GbgzI+X0/cMJtXyC1GcHfAomRRTMn3dpNLTMERAT6Ict3o7m/nZ90PJCsleq
         pT0dzDzPVxwkrE/kD/ENRY9yO9BvhnvVEZNGXrWm2ZO37e/RKAQ3pHW0EllHI6MjSvzy
         bGbPufinyQHsnKbQmgntJz29Nl48hs7OSzQVg1UVqQ3fhVsMoWbmFUbee/NgT6HzcChU
         YewrOxtSMe6DXkgtonTmGfJGdCq6sAXmTxN48l+bjUezCougnFKDomRnZtS2dJwHDQaq
         z0eQ==
X-Gm-Message-State: APjAAAVpHC0V3mV7uNkxn0b6+pSTyCSivouu6REC53QpVmpYMzDd1BF7
        POfKGEF20DOTIulf+QAidbJAjog6Th5MLueTcx8LSw==
X-Google-Smtp-Source: APXvYqxUBtAccM1dceszM+S4cJ8q0oMyTHyuNvtL9CYSaYRi7PwIgFyUGCrDoBL0Ueiq+iw95abqa8+jjVMYHmU9GqY=
X-Received: by 2002:aca:360b:: with SMTP id d11mr7901128oia.179.1567113065035;
 Thu, 29 Aug 2019 14:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com> <bdab2922-a4e0-8d5b-514d-2874e0be1440@tycho.nsa.gov>
In-Reply-To: <bdab2922-a4e0-8d5b-514d-2874e0be1440@tycho.nsa.gov>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 29 Aug 2019 17:10:54 -0400
Message-ID: <CAGB+Vh4aKvx1PCUrVBFPJyTqCKuf8cS28LuvSc3vX1W=SRs+rg@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Chad Hanson <chanson@forcepoint.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 29, 2019 at 4:46 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 8/28/19 4:43 PM, Joshua Brindle wrote:
> > A policy developer can now specify glblub as a default_range default and
> > the computed transition will be the intersection of the mls range of
> > the two contexts.
> >
> > The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> > as the greater of the low sensitivities and the lower of the high sensitivities
> > and the and of each category bitmap.
> >
> > This can be used by MLS solution developers to compute a context that satisfies,
> > for example, the range of a network interface and the range of a user logging in.
> >
> > Some examples are:
> >
> > User Permitted Range | Network Device Label | Computed Label
> > ---------------------|----------------------|----------------
> > S0-S1:c0.c12         | S0                   | S0
> > S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> > S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> > S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> > S0-S4                | S2-S6                | S2-S4
> > S0-S4                | S5-S8                | INVALID
> > S5-S8                | S0-S4                | INVALID
> > S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
>
> I don't quite understand why it is an AND / intersection of the
> categories on both levels.  Normally lub would be an OR / union.
> Possibly it is just a terminology issue.  Is this "glblub" relation
> defined by anyone else, or used in any other MLS system?

I talked to the other MLS people about it during LSS. I may be
conflating things by combining the GLB and LUB into a single
transition but conceptually I think it is what we need.

The network interface range will always be what clearance and
categories that network is approved for, the user has their own set of
clearances and categories assigned to them. The idea is that you can
only access something that both the user has clearance to see and the
network is approved for.

>
> Also, I'm left wondering whether certain cases of differing category
> sets ought to yield an INVALID state.  What if the user's permitted
> range was s0:c0,c5-s15:c0,c5 and the network device label was s0:c13? Or
> take your last example - is it really correct to let the user login w/o c0?
>

In this example the user may be read into the c0 and c5 programs, but
the network is only authorized for the c13 program. This would
degenerate into only s0 information is available, which I believe is
correct since the user isn't read into c13 and the network is only
approved for that.

BTW this gets even more complicated for inverse bits, the network
would be connected to/approved for coalition partner A so that bit is
turned off in the inverse bit section so a US person logging in over
that network could only see data releasable to coalition partner A,
even though they are US, which also seems correct since otherwise
there would be potential to leak non-releasable info.

Another MLS person encouraged me to do this in userspace because the
kernel wouldn't know what a "valid" range is for a deployed system.
While mcstransd does some bit math on the ranges to me the kernel owns
this information. The resulting label can be passed onto mcstransd and
if it violates a constraint there we can deny the entire operation.

> >
> > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > ---
> >   security/selinux/include/security.h |  3 ++-
> >   security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
> >   security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
> >   security/selinux/ss/ebitmap.h       |  1 +
> >   security/selinux/ss/mls.c           |  2 ++
> >   security/selinux/ss/policydb.c      |  5 +++++
> >   security/selinux/ss/policydb.h      |  1 +
> >   7 files changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 111121281c47..ae840634e3c7 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -40,10 +40,11 @@
> >   #define POLICYDB_VERSION_CONSTRAINT_NAMES   29
> >   #define POLICYDB_VERSION_XPERMS_IOCTL       30
> >   #define POLICYDB_VERSION_INFINIBAND         31
> > +#define POLICYDB_VERSION_GLBLUB              32
> >
> >   /* Range of policy versions we understand*/
> >   #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> > -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
> > +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> >
> >   /* Mask for just the mount related flags */
> >   #define SE_MNTMASK  0x0f
> > diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> > index 2260c44a568c..0a0fbcc0d90c 100644
> > --- a/security/selinux/ss/context.h
> > +++ b/security/selinux/ss/context.h
> > @@ -95,6 +95,34 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
> >       return rc;
> >   }
> >
> > +
> > +static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
> > +{
> > +     struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
> > +     int rc = 0;
> > +
> > +     if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens)
> > +             /* These ranges have no common sensitivities */
> > +             return -1;
>
> This error will get propagate to userspace as an errno? So it should be
> -EINVAL?
>
> > +
> > +     // Take the greatest of the low
> > +     dr->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
> > +
> > +        // Take the least of the high
> > +     dr->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
> > +
> > +     rc = ebitmap_and(&dr->level[0].cat, &r1->level[0].cat, &r2->level[0].cat);
> > +     if (rc)
> > +             goto out;
> > +
> > +     rc = ebitmap_and(&dr->level[1].cat, &r1->level[1].cat, &r2->level[1].cat);
> > +     if (rc)
> > +             goto out;
> > +
> > +out:
> > +     return rc;
> > +}
> > +
> >   static inline int mls_context_cmp(struct context *c1, struct context *c2)
> >   {
> >       return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
> > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> > index 09929fc5ab47..c0a9f8ecffc3 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -77,6 +77,24 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
> >       return 0;
> >   }
> >
> > +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
> > +{
> > +     struct ebitmap_node *n;
> > +     int bit;
> > +
> > +     ebitmap_init(dst);
> > +
> > +     ebitmap_for_each_positive_bit(e1, n, bit) {
> > +             if (ebitmap_get_bit(e2, bit)) {
> > +                     int rc = ebitmap_set_bit(dst, bit, 1);
> > +                     if (rc < 0)
> > +                             return rc;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +
> >   #ifdef CONFIG_NETLABEL
> >   /**
> >    * ebitmap_netlbl_export - Export an ebitmap into a NetLabel category bitmap
> > diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> > index 6aa7cf6a2197..9a23b81b8832 100644
> > --- a/security/selinux/ss/ebitmap.h
> > +++ b/security/selinux/ss/ebitmap.h
> > @@ -124,6 +124,7 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
> >
> >   int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
> >   int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> > +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
> >   int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
> >   int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
> >   int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index 5e05f5b902d7..76c8ad014ac9 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -529,6 +529,8 @@ int mls_compute_sid(struct policydb *p,
> >                       return mls_context_cpy_high(newcontext, tcontext);
> >               case DEFAULT_TARGET_LOW_HIGH:
> >                       return mls_context_cpy(newcontext, tcontext);
> > +             case DEFAULT_GLBLUB:
> > +                     return mls_context_glblub(newcontext, scontext, tcontext);
> >               }
> >
> >               /* Fallthrough */
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index f8efaa9f647c..1b59f72effbb 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -160,6 +160,11 @@ static struct policydb_compat_info policydb_compat[] = {
> >               .sym_num        = SYM_NUM,
> >               .ocon_num       = OCON_NUM,
> >       },
> > +     {
> > +             .version        = POLICYDB_VERSION_GLBLUB,
> > +             .sym_num        = SYM_NUM,
> > +             .ocon_num       = OCON_NUM,
> > +     },
> >   };
> >
> >   static struct policydb_compat_info *policydb_lookup_compat(int version)
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> > index fcc6366b447f..0c41d0b4da96 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -69,6 +69,7 @@ struct class_datum {
> >   #define DEFAULT_TARGET_LOW     4
> >   #define DEFAULT_TARGET_HIGH    5
> >   #define DEFAULT_TARGET_LOW_HIGH        6
> > +#define DEFAULT_GLBLUB               7
> >       char default_range;
> >   };
> >
> >
>
