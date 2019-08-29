Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEBEC3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE9B22CEA
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="PhhzSpnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfH2T0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:26:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34640 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfH2T0A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 15:26:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id g128so3502193oib.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2019 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQaVQ/qTaInZdiHMHhEi+nPHvaVH+bYdyuiEJ/cz7kA=;
        b=PhhzSpnJSFJ1Y2RR+SL6MOx0XYG5AGgp1zQQ19+ga0LhtsEQX1RnnN4/il3Vg/ciD3
         zQESA/YWrbP2Ieq4e7oXFQS0jSmXUZnM4JYRRqULbUISvwJQ2ZjRxwFoJ9TVBT4Vrgyw
         KRNUatXyxYj7P9UWq6NAj4NhZXILk5WwBI7PDmPetV5Bg4YDrWUQgfhSWmAdrdEIu/LA
         PQxy1pxcsA51RVdNenfZBJWy/qqu4Xo6JdLld0Ae4Tqr4afnWHLwP9MZMgOVPK/n1R2X
         PwV/RK+vfiIIGcv4FNLQg4hnpUR1uZLEsR46V2TRwu9B4p/i4lhUwD9w5n4ws7BywPwx
         +whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQaVQ/qTaInZdiHMHhEi+nPHvaVH+bYdyuiEJ/cz7kA=;
        b=CoqDFLWI11Wojvt4MK4DSzwxTk2AUD1KecW6qSwKd9BgkO1SiM24I9muB3SJoYL0Ib
         xiao9NgtF18AoHu/g4eHFM+G7iDIWC2UMLGQwodpYqAEj4J67fbd4uSeAgm/pP8bvzhI
         y3mssYRAVUbvn39oKS8UGt63NgpiP6xYRdJR4ddcwYC2jSWyR76IaY6/4XAExzDG13aW
         /ZJu2LlLJ3G6LwvytZsPWxvXmQsAFmOzHcsOieZWqRZhXqtmUJeJtBcZkJXC5Y9ZKbWm
         qcsJOe/EgXtEyWPATKodn0WwQwndjaIYTyxOiaPuF6aIjSxp6eRnvwwM9hDVEUsVs4ov
         p/uw==
X-Gm-Message-State: APjAAAW8YFYPTSgZDeLnX7I4kbwCN1FCKBDUrIierULYZhYII5IDU5yR
        YPTYAVNdd2Nzal+aZHqOjPDWsSSEuO9LyNBKiNoQAyz2
X-Google-Smtp-Source: APXvYqymmLHCDHBCDcuO9yyx0KekKAlGqnEeYnrOpoh5WMeW+/X3exzP+XwGH1/1S4HZfhu4gd+7rIjNXUkHaTaoImk=
X-Received: by 2002:aca:360b:: with SMTP id d11mr7624495oia.179.1567106759486;
 Thu, 29 Aug 2019 12:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190826142009.2241-1-joshua.brindle@crunchydata.com> <d6b2555e-fbda-b3e2-d451-a6e9500e3646@tycho.nsa.gov>
In-Reply-To: <d6b2555e-fbda-b3e2-d451-a6e9500e3646@tycho.nsa.gov>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 29 Aug 2019 15:25:48 -0400
Message-ID: <CAGB+Vh41FrvMOs2MoONi23gmve0i3oz3m70Fbitkj629EiMBHg@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH] Add default_range glblub support
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Steve Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 29, 2019 at 3:12 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>
> On 8/26/19 10:20 AM, Joshua Brindle wrote:
> > Policy developers can set a default_range default to glblub and
> > computed contexts will be the intersection of the ranges of the
> > source and target contexts. For example, one can add a default with
> > this cil:
> >
> > (defaultrange db_table glblub);
> >
> > and then test using the compute_create utility:
> >
> > $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
> > system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
> >
>
> It would be nice to say what glblub means and to have an example for checkpolicy
> as well.
>

Can do.

<snip>
> > --- a/libsepol/cil/src/cil_policy.c
> > +++ b/libsepol/cil/src/cil_policy.c
> > @@ -834,6 +834,9 @@ static void cil_default_ranges_to_policy(FILE *out, struct cil_list *defaults)
> >               case CIL_DEFAULT_TARGET_LOW_HIGH:
> >                       fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW_HIGH);
> >                       break;
> > +             case CIL_DEFAULT_GLBLUB:
> > +                     fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_GLBLUB);
>
> I think you just want fprintf(out," %s", CIL_KEY_GLBLUB);

Yea, you are right. I wonder why this even works then?

<snip>

> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -673,6 +673,9 @@ static int write_default_range_to_conf(FILE *out, char *class_name, class_datum_
> >       case DEFAULT_TARGET_LOW_HIGH:
> >               dft = "target low-high";
> >               break;
> > +     case DEFAULT_GLBLUB:
> > +             dft = "glblub";
> > +             break;
> >       default:
> >               sepol_log_err("Unknown default type value: %i", class->default_range);
> >               return -1;
>
> You need to update kernel_to_cil.c as well.

Good catch. As a side note changing the policy has many more touch
points than it use to (this is my first time making an update that
include CIL). Is there some checklist or developer readme or something
available?

Also, it isn't clear how to test all the combinations. I did add:

Add via CIL module (which combos does that test?)
Add to exported CIL base (is that really the same as above?)
Add to .te base

What would I have needed to do to see that kernel_to_cil.c hadn't been updated?

<snip>

> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -46,6 +46,11 @@
> >   #include "private.h"
> >   #include "mls.h"
> >
> > +#define glblub_version ((p->policy_type == POLICY_KERN && \
> > +                  p->policyvers >= POLICYDB_VERSION_GLBLUB) || \
> > +                 (p->policy_type == POLICY_BASE && \
> > +                  p->policyvers >= MOD_POLICYDB_VERSION_GLBLUB))
> > +
> >   struct policy_data {
> >       struct policy_file *fp;
> >       struct policydb *p;
> > @@ -1034,6 +1039,13 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> >            p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
> >               buf[0] = cpu_to_le32(cladatum->default_user);
> >               buf[1] = cpu_to_le32(cladatum->default_role);
> > +             if (!glblub_version && cladatum->default_range == DEFAULT_GLBLUB) {
> > +                     WARN(fp->handle,
> > +                             "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
> > +                             p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
> > +                             p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> > +                        cladatum->default_range = 0;
> > +                }
> >               buf[2] = cpu_to_le32(cladatum->default_range);
> >               items = put_entry(buf, sizeof(uint32_t), 3, fp);
> >               if (items != 3)
> >
>
> Everything else looks ok, but I haven't tested it yet.

Thanks. You can test using the test suite as well, I'm impressed that
adding a bunch of sensitivities to an mcs policy works as well as it
does!
