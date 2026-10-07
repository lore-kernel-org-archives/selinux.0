Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018432D2381
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403615; cv=pass; b=UPremiWXzf+ec2ypws9pGRmwIuhDAdZIFSWzk4B/YYmvyShY8+o39Ku2Xox2+qhdHTPBDEHGoWb4S/XboZxutOW5TA6zJWP++lXys+w3jUuhS84l8XVnW/DlhgffQAWpLgVHDOxJOSSGJAXxX0DqDP3vhMuop86E9ICdtKkclCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403615; c=relaxed/simple;
	bh=yE4ABThWVBNCVS7FzFUPf0Sbm6dqhDFLrbsjE8h3l1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZHQBjt2BumxKnVLdFgvX14oOYi1+FUkH2PkAJoF2uud+OYygT8RDvMuPIhJdDd48ch8w4AEh+8atAAEfwfP6nj0LlFf7N7wNFoAZ/iMSPA5a/7ZlO4syA+DNl8ZUGB3yCRQjnJf3rvKICczHaqGsPi9mWOKUNpR3eqYnhnWq4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj8DTXJS; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj8DTXJS"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677cc343120so4516311d50.0
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 13:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791403613; cv=none;
        d=google.com; s=arc-20260327;
        b=Ae+OTUHpZOBJ94J3qDrjdXpCyaZVSyAP5apRrLJwkazGBURiJSr15Dtdc37YOivW+F
         g/0NIeuwqzNjka1vQCRcrZQSmNPPwGkUA+yLav/1JC72MKyOPfW+R9PNYhhcfVI5z7+N
         +DaQ7+beWdIe14hthSkRej3FdsP4LrBwlRGv4vIJKr+6eFqpGDBlK4N814vtLsnqShbm
         Wn/JGPQq9VBcQrbbHcqKEZzh7dOJIuGA4uU2OYZK6EDWeCBjs5DsDfnpuMZF59HZ4k46
         YgZnTvZhvz6sgwvutVYaQK1I8yDhth4hFWJVPVpm1Prp6uUHERGcu3/yRN9cAbXy+N0W
         /NiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IsUGgkKMJWbRleN+p3ZvgZy3ZOjtdECZ1I4oUq7bUI=;
        fh=2l94eviRgWluv8ZsHF0iP/9Nklou1gUggUsUJ5BRhxs=;
        b=UwRc4p3EbjEHwQ2nTBQCk0ksQOLZ0v25LqQOqTCZD1tkreMdVj5JUv23X9NhksC8fX
         nznt1lSzshgppsa9LTToLnJ1tJMExckHPcYQBtDKd/E/ftgEBrDyKUDLWIKQPeoAnU/k
         H+94ZrU8Nshn5tFd1mxUKCq85pjSJAGRVpYjo8ls7hU8VizzfFcgC8ExK/mfrt62ewNg
         CMBwJUE5pF21JT86g7X2/IQCFMrM9qFGD9wp/PgmK5aRPg/k9MgyUSeRfKJuOit9ar45
         E3SNrh/GlvUaPpyzOs/Bk+t2ZOy1ugp8iSlEir3ALmZ0dsXh/MUu8gaL1YX8UX7Zt5+u
         59aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791403613; x=1792008413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6IsUGgkKMJWbRleN+p3ZvgZy3ZOjtdECZ1I4oUq7bUI=;
        b=jj8DTXJSK/qr+AZLWIwRRld2c/TnpNIsTz1ScP1+b+r+EdfhWxTpd0WGBD0zbHVaUt
         CylSO7Nl2Pn9ahPZkxCz+CW0rticKQ9b5/jz5KHTeIE1/XgWnDnw9ShAdJ3AnYeZp5uO
         D8GLBDPrLMpWaJDk/pG2/v430CYtWDoAVfeZzgQsruKkTL/uBp7ktaTjXK4JV92N5HJd
         uXiIMI0pH6IriWo/H8G6WrhMJ78PP0/MD370cNYbjItByNIrEP97pnfQl08aZYnHOIJN
         l5IOGh18YGijSszbTM0hztuDxjv8mlpebyAn+aDGli08dAEPJ1YO+3mHVpbwWGja/uFN
         mBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403613; x=1792008413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IsUGgkKMJWbRleN+p3ZvgZy3ZOjtdECZ1I4oUq7bUI=;
        b=eMh5iUxQZ61qCUNtjI2cDNtYR0PWBPKzVWO1UVKKYR3+apNf1Ur2mdUfzSfRhOBLB3
         6AMWhoel0DgHARCMaxQCcUsIzXyE82NGWugi3ObrkLq+zg0hUOukZju8L5nqvRmrZL2L
         wG8OiWze54Dpl7kI21rEEbw4WKbav1phIVQVUcP5CbinsalPbmVwstq9pznCJm23Wf+y
         HYGq/fT1MykhaD3bPlEgGjbPHYqltKUpL3utHfxzsfUKgHXK8x0DIWDJ7K/i0/fB9/Wo
         qTrzgupGI014oFwyDGE+ZguHkFq5yH2yl4Qq74rr3PWDIeWJoRs16EZX7Cg2Sb+XOF3w
         IBZA==
X-Forwarded-Encrypted: i=1; AKwUvBxzzj+H6rYtS/Zdu80e8Fhf0ou7x5JM+vPlHxewOqkm5bsDSfBoKFxaT+eI/etHOMLqd1y7YBgL@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2UbY8vlddVgGzQJVrtH7nrTSR5f2bN5u4LggHaSDCttbdh2Hd
	dk/Ap/vZ/bFKmVeV1EaYzhXAX9sC6Liqp9FbJVHPOg5EvNBlqZhcxfd8iClQ5A1IIyqsx18sSNv
	VlWhfuYWzvqFoIopXxr9jxC7iONSyp38=
X-Gm-Gg: AYBFou040TBkGVSgWyCi3q1mGh3HFDOg+KJdt2t8voYkRjQ3dzwPOGyHyvWCzsYSo7V
	nv18PgYZhcbrzDG27K2ygdGoNkqdYGbRGp7gkJQz6zQ6fz/nR2lQO1G64msS1LcaQSnb5dzxo4m
	Nmr8wRWBVuXcFY0SZ2kx8JBQAHU6Hn+EXnllBtfTegfeafR/g1kmuBq2AMBxb41u1sGVHBuDUsa
	qqNrDxk/eX31Gmd3Xhin621vYJR2OkeStE8+t9CA0LjfEnOZW+p6N+xoegicyflhxPfhCSwMRLF
	8VmsFtRxdQxGjvHfYpnYXngC0khDN9QlG/DBXwxK8YDiWwavtRDjqvQ=
X-Received: by 2002:a05:690e:484e:b0:675:3f33:b183 with SMTP id
 956f58d0204a3-6790a3ba2cdmr1392711d50.24.1791403612620; Wed, 07 Oct 2026
 13:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com> <20261006130215.128405-10-jjanasek@redhat.com>
 <37badcb1-92f7-4289-a965-5fccec5638c4@ieee.org>
In-Reply-To: <37badcb1-92f7-4289-a965-5fccec5638c4@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Oct 2026 16:06:39 -0400
X-Gm-Features: AclHuK-m93JHlBQztiagN3xnM2uC1Ajpws7TmPkQj5Bb1BVjhxD9jKRabaUFgJc
Message-ID: <CAEjxPJ7b78wW3aE5w-pB-Da6RGXAy=CoHvkOQjumbt6jhdy+jA@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 09/17] libsepol: add policy properties API
 and public constants
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: jan janasek <jjanasek@redhat.com>, selinux@vger.kernel.org, 
	Juraj Marcin <juraj@jurajmarcin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:16=E2=80=AFAM Christopher J. PeBenito
<pebenito@ieee.org> wrote:
>
> On 10/6/26 9:02 AM, jan janasek wrote:
> > Add sepol/constants.h re-exporting AVTAB_*, OCON_*,
> > SECURITY_FS_USE_*, and related policydb constants under an SEPOL_
> > namespace (with unprefixed aliases guarded to avoid redefinition
> > conflicts for callers that also include internal headers), so
> > consumers no longer need policydb/avtab.h or policydb/services.h just
> > for these values.
> >
> > Add opaque-policydb properties: sepol_policydb_mls_enabled(),
> > sepol_policydb_compat_net(), sepol_policydb_set_permissive_flags(),
> > and sepol_policydb_rebuild_attr_map() for maintaining the type
> > attribute map after modifying type/attribute membership.
> >
> > Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > Assisted-by: LLM Cursor
> > Signed-off-by: Jan Janasek <jjanasek@redhat.com>
> > ---
> >   libsepol/include/sepol/constants.h         | 231 ++++++++++++++++++++=
+
> >   libsepol/include/sepol/policydb.h          |  29 +++
> >   libsepol/include/sepol/policydb/avtab.h    |  33 +--
> >   libsepol/include/sepol/policydb/policydb.h |  68 +-----
> >   libsepol/include/sepol/policydb/services.h |  19 +-
> >   libsepol/src/policydb_public.c             | 203 ++++++++++++++++++
> >   6 files changed, 486 insertions(+), 97 deletions(-)
> >   create mode 100644 libsepol/include/sepol/constants.h
> [...]
> > diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol=
/policydb.h
> > index 98357ee4..967bce3d 100644
> > --- a/libsepol/include/sepol/policydb.h
> > +++ b/libsepol/include/sepol/policydb.h
> > @@ -87,6 +87,11 @@ extern int sepol_policydb_set_typevers(sepol_policyd=
b_t *p, unsigned int type);
> >    */
> >   extern int sepol_policydb_set_vers(sepol_policydb_t *p, unsigned int =
vers);
> >
> > +/*
> > + * Get the policy version.
> > + */
> > +extern unsigned int sepol_policydb_get_vers(const sepol_policydb_t *p)=
;
> > +
> >   /* Set how to handle unknown class/perms. */
> >   #define SEPOL_DENY_UNKNOWN 0
> >   #define SEPOL_REJECT_UNKNOWN 2
> > @@ -94,12 +99,19 @@ extern int sepol_policydb_set_vers(sepol_policydb_t=
 *p, unsigned int vers);
> >   extern int sepol_policydb_set_handle_unknown(sepol_policydb_t *p,
> >                                            unsigned int handle_unknown)=
;
> >
> > +/* Get how to handle unknown class/perms. */
> > +extern unsigned int
> > +sepol_policydb_get_handle_unknown(const sepol_policydb_t *p);
> > +
> >   /* Set the target platform */
> >   #define SEPOL_TARGET_SELINUX 0
> >   #define SEPOL_TARGET_XEN 1
> >   extern int sepol_policydb_set_target_platform(sepol_policydb_t *p,
> >                                             int target_platform);
> >
> > +/* Get the target platform. */
> > +extern int sepol_policydb_get_target_platform(const sepol_policydb_t *=
p);
> > +
> >   /*
> >    * Optimize the policy by removing redundant rules.
> >    */
> > @@ -148,6 +160,23 @@ extern int sepol_policydb_mls_enabled(const sepol_=
policydb_t *p);
> >    */
> >   extern int sepol_policydb_compat_net(const sepol_policydb_t *p);
> >
> > +/*
> > + * Set permissive flags on types marked as permissive in the policy.
> > + * Must be called after policy load to enable permissive type enforcem=
ent.
> > + */
> > +extern int sepol_policydb_set_permissive_flags(sepol_handle_t *handle,
> > +                                            sepol_policydb_t *p);
> > +
> > +/*
> > + * Rebuild the type attribute mapping. Call after modifying type attri=
butes
> > + * to ensure consistency.
> > + *
> > + * On out-of-memory, returns -1; the map may be only partially rebuilt=
 in
> > + * that case, but the policydb is left in a self-consistent, usable st=
ate.
> > + */
> > +extern int sepol_policydb_rebuild_attr_map(sepol_handle_t *handle,
> > +                                        sepol_policydb_t *p);
> > +
>
> I'd suggest a single public function that calls functions like these
> two, e.g. a function to initialize policy queries. Otherwise it exposes
> internal details that users don't need to be aware of.

Agreed; see also my comments on the cover-letter for this one, and I
spell xperm_* UINT32_C(1) as 1U usually.
