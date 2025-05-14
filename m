Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4314AA9;
	Wed, 14 May 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232719; cv=none; b=esQehsC979m3UQoqoB/REaBMadRMU2lBMB5Wud/9Wzx1veOeGx9fVs0IWGSWA6c1N4Odv6ZUDRaJq5hZTh5W439+TIXyo5MT9wK1prJpV2YWfLTo1JwZUPRcE41PtvpUj2ugILu211AzR6NgW2KD48hFxJZPasdmhZ/9NmMx7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232719; c=relaxed/simple;
	bh=vN+fpwKSl41pqu9wRt03Wjfrb+jb619he3vmdlO6Itw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z10tdKZ69dIkFmyCb5IFJQlBZCt1Ft/of4S9VzDAL1g/bXn+CVhlD0WE1fEqTHfWNpXounjjMd/zslbHr1O7PbDw0zbHyNuC3jXuu4HyK+X61l/F7dMGHhuGqRVmmWb6kKY48noaLhC9Z5/ft031rSYnzG4nQpYacaGtqcru2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho/vw0MO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho/vw0MO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so5971526a12.3;
        Wed, 14 May 2025 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747232716; x=1747837516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptcvgW3+mwB58Hx6gjpxzMgi6+3PoMSTmnbrlBuO2tw=;
        b=Ho/vw0MOSuaqxjo9lkkdo6fhzwL+EccuuolO9K6Z829LN5aseAGo9hEu55NPyJQkfL
         fdOF2vTYnhmxvsoffJhNyHM+d3bqI75Dq1un8iEdVYs0bKxn17oeWt5g0vU9zwve3fvU
         YoZmBcYyxzlv2QiEAL6ofwcK+H58FfRz+bRHq70Hw2Nq/J9Lmk9+nSxne354XiRX/K7M
         OH6Y7Y8FRRxeBPFBHtyp2RX2ab7IWIoDSLHQoDbc9xGGxUMoDzY93q4f0h/21jb9xXmW
         eEH+R5fGnRzTPrgk5Xx0Y95cU7tSF2d5oOt3eo1UEiHNd3NjsFfiPkrqJ+5XITmX9WWA
         SrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232716; x=1747837516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptcvgW3+mwB58Hx6gjpxzMgi6+3PoMSTmnbrlBuO2tw=;
        b=VW4AuAdHzPniTll7Z5XyC/5PSYRwDkmwSHiORHMPa1CjLU2lBAKV3+pzWGgmoAJTRt
         xgdoOMhUZ1cq7lmMbVIWe00P19QADjDC9za52x6Lua4bWWNU1KZVvQrOckqajhD+E7jH
         c86gZdbqjM7v/OdsI6HY1tS+Q0T7txWOL8Jcj0+NteJOfuM+gzke0rf8PYkYOzmhiyEw
         nUdLTZeAWme6HF3Z7ywOIvpdkEH7Tpa7r/x/9/cIVynIuSMr9HxeWmio6xKRoJKRmmAr
         o+zzTJm7Ncp8sFMRRV/Ycpe0C8OhM6VPSWvCL1XaRVnSp5YT5uXC3IIZKf+QdOGOwjk5
         dvog==
X-Forwarded-Encrypted: i=1; AJvYcCWQGcw0eRcjaw/qtkOVi/XBUI64Cwek6SGCVgm55lhGeWaxEpx91BAJxm0OmWk9Ob1Hi8wMODcrWayNHw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6f9x+/ZHqfCf2MdZMSZ9tWxGx31lXHbr3ZLcnL3I5NAev8HX
	oboJx5FHrjMBLCXYtLrkk36u+dp5N9+E5bVNChN1700vxRd6Qjxvhtp/i6VbJ1nRdsw8KmbO4a9
	pvIMGMmJ24g7SwCzONvSPii9sUqA=
X-Gm-Gg: ASbGnct6wh3M5AgAIyZZJ8G2D0kam+ywkLqy5BH3FthwQ+m/oarKCiJFPt5ybBtxxfU
	brG/1gvsr5+aJ8omdPYhkcNzo0Bxp+wNQo7J2MusJsFroTUZCeY0gHOm8VBIRQR2UuVL7ZWGh23
	OQwbK2K3ynhnoSCUare/dVdGltjAnUir6H
X-Google-Smtp-Source: AGHT+IGce9wuRwhkUtZbC/bkWhZl38M3GUwqmBpbZ1s1ISducfr2XH2vOQrS98kpW3I/pj2e12WRWCx6mMF4biRUzrg=
X-Received: by 2002:a17:90b:6c6:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-30e2e5b947emr6163792a91.10.1747232715615; Wed, 14 May 2025
 07:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
 <20250511173055.406906-3-cgoettsche@seltendoof.de> <CAEjxPJ5y70ncKXw-_noNumz=miCB0U+3c3KnXFwrV=eQ1gwhKQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5y70ncKXw-_noNumz=miCB0U+3c3KnXFwrV=eQ1gwhKQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 10:25:03 -0400
X-Gm-Features: AX0GCFvR4Ns48Tx_M0OPsq_wdB0MG6gPKe7BKKvKPcOhCD4vsSdf5Hc4MpFypXw
Message-ID: <CAEjxPJ6F-=oYosd6JQ_emPeE8C_K1RCnu4d+MTr--XJDNef8Jg@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] selinux: more strict policy parsing
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 10:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Be more strict during parsing of policies and reject invalid values.
> >
> > Add some error messages in the case of policy parse failures, to
> > enhance debugging, either on a malformed policy or a too strict check.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > ---
> > v3:
> >   - incorporate the overflow checks on security classes from the
> >     previous patch, and permit U16_MAX as class ID
> >   - minimize the usage of magic values, by using macros or trivial
> >     helper functions
> > v2:
> >   accept unknown xperm specifiers to support backwards compatibility fo=
r
> >   future ones, suggested by Thi=C3=A9baud
> > ---
> >  security/selinux/include/security.h |   1 +
> >  security/selinux/ss/avtab.c         |  35 ++++-
> >  security/selinux/ss/avtab.h         |  13 ++
> >  security/selinux/ss/conditional.c   |  18 +--
> >  security/selinux/ss/constraint.h    |   1 +
> >  security/selinux/ss/policydb.c      | 196 +++++++++++++++++++++++-----
> >  security/selinux/ss/policydb.h      |  23 +++-
> >  security/selinux/ss/services.c      |   6 +-
> >  8 files changed, 233 insertions(+), 60 deletions(-)
> >
>
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/polic=
ydb.h
> > index 0c423ad77fd9..9b3cc393a979 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -386,9 +387,23 @@ static inline char *sym_name(struct policydb *p, u=
nsigned int sym_num,
> >         return p->sym_val_to_name[sym_num][element_nr];
> >  }
> >
> > +static inline bool val_is_boolean(u32 value)
> > +{
> > +       return value =3D=3D 0 || value =3D=3D 1;
> > +}
> > +
> >  extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, =
u32 len);
> >
> >  extern u16 string_to_security_class(struct policydb *p, const char *na=
me);
> >  extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const cha=
r *name);
> >
> > +#define pr_warn_once_policyload(policy, fmt, ...)                     =
   \
> > +       do {                                                           =
  \
> > +               static const void *prev_policy__;                      =
  \
> > +               if (prev_policy__ !=3D policy) {                       =
    \
> > +                       printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)=
; \
> > +                       prev_policy__ =3D policy;                      =
    \
> > +               }                                                      =
  \
> > +       } while (0)
> > +
> >  #endif /* _SS_POLICYDB_H_ */

checkpatch.pl warning:
WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then
dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...
#718: FILE: security/selinux/ss/policydb.h:404:
+ printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__); \
