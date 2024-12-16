Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3097DA9F;
	Mon, 16 Dec 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364990; cv=none; b=O3JhGU7XuFIV9i2Kc54/1cTFubp+hG7THKaQWYrFYo+reHAWtKlI6I0DCjjASfWfhNONEodW/1QIoYL3efHlAI03aICeDr6VLKKxn73lS66ZQXoQWpvTSnNLPbxxeNk0C/N/trr+bqi2RRg+VjzJm37u9la6HNSPlk/fR9kOIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364990; c=relaxed/simple;
	bh=2+zBhDI2kjUm13LwOzDAJbnWrtFqlqZ6/8Bkh+U0AfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuJdy5Z5jzSe66DAAx/CATf/e1gPx4k8PqX/kAlLs+HL7LS2YpJidZdPF0RKJvs883ofMkeYhwxNOm7hELT1EP7BT9ChU54vR6WN/BjZuQbWByeSYD2Ik5KDlJ4MquyYG9ojHzI5191S2qFKxhct91FKcg71hBzBaudNqhMUG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CKn24FC+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CKn24FC+"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f29aa612fbso11511247b3.0;
        Mon, 16 Dec 2024 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734364987; x=1734969787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqM3ARuECeF9HdWS9Q2UBn+rfYGURXflJMW1XUOWLPc=;
        b=CKn24FC+CPhWxALKu1olu7JihF6J0JJr+CI/4hee+QzPPq/BMk4+lDbpeQSORVYgH4
         OZSNf1FJ9g77Y2ErUL3v86rSuo7aSerV6knEtO/PuprlPa1EL+gf3EGe+3yAAIkK9JPz
         moSGy1m+u91K1FO0cUAwlNFp080ZeEsCYloZrmt9Yi4x/RVxBwxO/qjfu+PHrGnZK4KF
         41W4j4uA3jBWphfdM2K2uoTYV+P/QXNTFILtLKbEl5xTauWQeIzlEDHC/YiIRDaT/UjF
         AYmhNnZH/ksS10vf3SBLRVCw1mkigNtTvJ38H2eBLfOjgk+t8mT3rdL6lgW57TTSVIDk
         jU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364987; x=1734969787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqM3ARuECeF9HdWS9Q2UBn+rfYGURXflJMW1XUOWLPc=;
        b=xSPHeqVcrJYqy1j5frL/Rs6k9jqamSUWQMvLuS9WdKI3wdQqBYstgOf1tnINkdvuQt
         zMWQ/DFilrW6zdPdFNi0idEu33a0MDXhmllJ6PJ4szb/u3oRrX6jPt0bdjwvrC1QrV18
         eX3sy+dSasch4f6KZ/4d3QANT9IidAD5QCeRk+cOYmKxDOr626AvoFyDq9Pyt0Pw1k8d
         cqGZKpArpUMmmi2C5en6MU5OskX+u17A/lmjjKkabbl2pWn8u7U+k9WXVn6JXF/NfWzC
         9iVe5XjIz+QskxnXSMXYbzRqxhoI4m0eyAAdEiBG1LslrYmCfNrpUXHOReD7cJ/qDNKj
         CcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLFy/K4+fdcCav5eqNrEG0TTzYwK0w+Fc9rYfuNQ5D6FA5r385SwGxxzeDrb+/lXv5dr9EADx2wmudFYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL/InIE8rJzkohzu2aoV7Cw6mlyYIvWVsjZBIogh5c9T15Ma8
	LAkt6tRw93o8kdlPBlagYBg0WqJzBTYLwQJOoa1qzdnkD8eQvt/M6IxevKxtSa7GpjxiG7SHOWi
	HfKmrZwTSoqfE468VPP9rZ91Duik=
X-Gm-Gg: ASbGncslz2cHkjM4omk0MC/8/av3FNzKH9BMrtZrI6qxvzflue8L4DLSHozyLbJTqXk
	aWKP860CopuE4xjbCLd1svhd/RuoScv1IMM+q
X-Google-Smtp-Source: AGHT+IG8BV0i8N/JTpbCBcMUIyNm3MRdLr4r0Y2Bze16a0HgV01c7aVvRZTqaENKTpgpJWD1B/90u+FEty0j/m4oZNk=
X-Received: by 2002:a05:690c:8599:b0:6f2:8e62:d8b2 with SMTP id
 00721157ae682-6f28e62e52bmr43632077b3.29.1734364987387; Mon, 16 Dec 2024
 08:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-22-cgoettsche@seltendoof.de> <c4416dfa-ed1c-479d-9558-252775f3b8b6@linux.microsoft.com>
In-Reply-To: <c4416dfa-ed1c-479d-9558-252775f3b8b6@linux.microsoft.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 16 Dec 2024 17:02:56 +0100
Message-ID: <CAJ2a_DfhjT16U=wavqPQH67HsJTKKHfPpCA736VrCge5AWhsuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 22/22] selinux: restrict policy strings
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Dec 2024 at 23:14, Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 11/15/2024 8:35 AM, Christian G=C3=B6ttsche wrote:
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Validate the characters and the lengths of strings parsed from binary
> > policies.
> >
> >    * Disallow control characters
> >    * Limit characters of identifiers to alphanumeric, underscore, dash,
> >      and dot
> >    * Limit identifiers in length to 128, expect types to 1024 and
> >      categories to 32, characters (excluding NUL-terminator)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >   security/selinux/ss/conditional.c |  2 +-
> >   security/selinux/ss/policydb.c    | 60 ++++++++++++++++++++----------=
-
> >   security/selinux/ss/policydb.h    |  5 ++-
> >   3 files changed, 44 insertions(+), 23 deletions(-)
> >
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/co=
nditional.c
> > index d37b4bdf6ba9..346102417cbf 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -280,7 +280,7 @@ int cond_read_bool(struct policydb *p, struct symta=
b *s, struct policy_file *fp)
> >
> >       len =3D le32_to_cpu(buf[2]);
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto err;
> >
>
> It would be nice if these limits were named constants instead of magic
> numbers.  Right now it's hard to tell if all the "128"s are essentially
> the same limit referenced in different places, or if they could (in
> theory) be changed independently.
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 917b468c5144..d98dfa6c3f30 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1221,8 +1221,9 @@ static int context_read_and_validate(struct conte=
xt *c, struct policydb *p,
> >    * binary representation file.
> >    */
> >
> > -int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len=
)
> > +int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len=
, int kind, u32 max_len)
> >   {
> > +     u32 i;
> >       int rc;
> >       char *str;
> >
> > @@ -1232,19 +1233,35 @@ int str_read(char **strp, gfp_t flags, struct p=
olicy_file *fp, u32 len)
> >       if (oom_check(sizeof(char), len, fp))
> >               return -EINVAL;
> >
> > +     if (max_len !=3D 0 && len > max_len)
> > +             return -EINVAL;
> > +
> >       str =3D kmalloc(len + 1, flags | __GFP_NOWARN);
> >       if (!str)
> >               return -ENOMEM;
> >
> >       rc =3D next_entry(str, fp, len);
> > -     if (rc) {
> > -             kfree(str);
> > -             return rc;
> > +     if (rc)
> > +             goto bad_str;
> > +
> > +     rc =3D -EINVAL;
> > +     for (i =3D 0; i < len; i++) {
> > +             if (iscntrl(str[i]))
> > +                     goto bad_str;
> > +
> > +             if (kind =3D=3D STR_IDENTIFIER &&
> > +                 !(isalnum(str[i]) || str[i] =3D=3D '_' || str[i] =3D=
=3D '-' || str[i] =3D=3D '.'))
> > +                     goto bad_str;
> > +
> >       }
> >
> >       str[len] =3D '\0';
> >       *strp =3D str;
> >       return 0;
> > +
> > +bad_str:
> > +     kfree(str);
> > +     return rc;
> >   }
> >
> >   static int perm_read(struct policydb *p, struct symtab *s, struct pol=
icy_file *fp)
> > @@ -1269,7 +1286,7 @@ static int perm_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >       if (perdatum->value < 1 || perdatum->value > 32)
> >               goto bad;
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1315,7 +1332,7 @@ static int common_read(struct policydb *p, struct=
 symtab *s, struct policy_file
> >               goto bad;
> >       comdatum->permissions.nprim =3D le32_to_cpu(buf[2]);
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1552,12 +1569,12 @@ static int class_read(struct policydb *p, struc=
t symtab *s, struct policy_file *
> >
> >       ncons =3D le32_to_cpu(buf[5]);
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> >       if (len2) {
> > -             rc =3D str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
> > +             rc =3D str_read(&cladatum->comkey, GFP_KERNEL, fp, len2, =
STR_IDENTIFIER, 128);
> >               if (rc)
> >                       goto bad;
> >
> > @@ -1691,7 +1708,7 @@ static int role_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >       if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
> >               role->bounds =3D le32_to_cpu(buf[2]);
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1758,7 +1775,7 @@ static int type_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >               typdatum->primary =3D le32_to_cpu(buf[2]);
> >       }
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 1024);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1822,7 +1839,7 @@ static int user_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >       if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
> >               usrdatum->bounds =3D le32_to_cpu(buf[2]);
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1871,7 +1888,7 @@ static int sens_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >               goto bad;
> >       levdatum->isalias =3D val;
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
> >       if (rc)
> >               goto bad;
> >
> > @@ -1914,7 +1931,7 @@ static int cat_read(struct policydb *p, struct sy=
mtab *s, struct policy_file *fp
> >               goto bad;
> >       catdatum->isalias =3D val;
> >
> > -     rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +     rc =3D str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 32);
> >       if (rc)
> >               goto bad;
>
> The category restriction is more tight than the sensitivity one because
> a context may have many categories?  I guess that makes sense, but it
> feels counterintuitive from a user perspective, because I feel like
> users tend to think of categories and sensitivities as essentially the
> same thing.  Would dropping the sensitivity limit to 32 to match the
> category limit make sense?

Yes, I'll change the limit for sensitivities to 32 in v2.

> Is there a more strict limit on the number of categories a context can
> have than the U32_MAX from symtab.nprim?  Because that will allow
> exceeding the page size using too many categories regardless of length
> distinctions, which is a concern if the motivation here is about
> potential future untrusted policy loaders in a namespaced environment.

It seems the limit of categories a context can have in the total
number of categories defined in the policy, which seems to be U32_MAX
(or one or two less).
But even today in the common policies on can reach this limit, e.g. via

    $ for ((j=3D1; j<1000; j++)); do echo "limit $j";
ctx=3Dsystem_u:system_r:init_t:s0:c0; for ((i=3D1; i<j; i++)); do
ctx+=3D,c$i; done; echo -n $ctx > /sys/fs/selinux/context || j=3D1000;
done;

For me with more than 834 categories (which have a maximum identifier
length of 4 (c833)) the context hits the page size limit.
So the maximum length of 32 is an attempt to minimize the practical likelih=
ood.

> -Daniel
>
