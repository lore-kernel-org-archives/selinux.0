Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073F13A86C;
	Tue, 13 May 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165463; cv=none; b=J8EBRNyo7SbW8xeokGq5cDxnO7FdNSOeE3cKV6NKWAxuFsEXRnOAKV7d5yENT7o9YAeWmGGZ4mst3HcDVSTdbwJaE+RfGICgWsyCZqa47I2rCXAMwICHLGFxF9y3vJPQRb5rFJ8I9K185X18kj4ax5vZ8bclnGZDUZBnMMw5gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165463; c=relaxed/simple;
	bh=vKtLiWGwbn7nAe8oULmHJnBmom4HrX+li/knhuYgyY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E09T6gIrBFh/FMxh59N6p9EyMfxyQc5ZL0kXrDu3xytWWsy/X3T4W5q4CFK+/x5w/n0w7oGXvjX6ciTucq/n0Vrb6JXZKwJLfJ+L3Dt8vvtTxkeYwkCtJPABTrKS/RzclrooM2CJVnGXmWwfixJnW0VqKrZ2HlJY5B23WHLXkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjZwiG9C; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjZwiG9C"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-879d2e419b9so5544185a12.2;
        Tue, 13 May 2025 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747165461; x=1747770261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIOYTgks3VbF5UfnN+oirtX9UEo6L6jkp4e7idlKx8g=;
        b=ZjZwiG9Cb1v6gKjrVy8sSYHyECdM+VXn/wqloVCe+++niXzwFyW4RQXUa5ZA5kZtwV
         y7QtjuCQM8zvlcG52VkbBrhJOoQRrGVuk+dd3nzy/EBGHvzJlb2rOsWk043c20QfrXGU
         jFf8vy0KBZIib8rSsnqP0RIqmQDFRQ0VtZDexoUu2VctsEv+XEn/OW6yPCzBX4ioheqT
         EGbEHe1E/p381ldDcaXRi6eRaiPqiH9TESnrbIDRuT3DhTq2hIpdXDuuaRAZUh1QfC+K
         L3NXBldHTSk4Oh92anyO/SO3RxTppMbUQihD7Z95c5U4XlP+eL3Sd04auDv18E9wT7SW
         z54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165461; x=1747770261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIOYTgks3VbF5UfnN+oirtX9UEo6L6jkp4e7idlKx8g=;
        b=NUpiuHhh8wStcEHVOVgT2g0i/B5D5Cgv08lA2zwzEVC8sJr+H8Py5mpW2+Gh4BORdm
         //rPYLPexuv1JTF6v72IlNC0g3rYeb11u7/ZYpZRdx+lgnWNtmxgBAHf9AyfOXCgFhEG
         iJlW/4OnnQKs351azlkw0gxlgngZuh3Su0NWbaAez8eYuTTccoAA+8e1hcrbVfEsq2yh
         gXBnARxFFNZaP2ToZqRQhu12wRjXftxqqqbHGfbhih6ncOsofpQGIqTAKUd/xZ/SsnmU
         HR8MbfX+IKIsuLStyj8I8aKoOq7s51N7QB0NGLplMmVEAtv6jBvGn+xGx4OkgXfEQnZB
         0e6g==
X-Forwarded-Encrypted: i=1; AJvYcCUaqgbAklnGOA5IjNIX/zaEUMc31L435OIMLQgalOPzhmjsxDoh82x8LVmsu2kZWa55DmKey/bLbvrXZ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvNNPmDOG7cL5q9Sr3BbHSsA69icKDVLGVpHMXQvd6nex8Rei
	qU9Ef29MvtfEPGA5IXnjvcMaPumAPwUBEi1olIgKOWKJ4UGyXcTTBpz4FXmIoeAfaUw0r/i2ZIY
	D0CdK2JQ7KI0fl73hhC4GIeX5scAY7pCL
X-Gm-Gg: ASbGncsO5mwMJmJ2qocs44rl9R2MfOiE0NCHPdmo6c/GksGBX0Ut5v1ZyZAJLvsNL1w
	9Y6+18e7z/D42jl//mP7ehc5k0PwQ61b39Px1AceHQ2b73J5/ojKxsKzpWmPlNxTdZR7MaaRNQL
	0ha6L+BTOWI90xQC0Ix5hT+uNFuH3WvK0+
X-Google-Smtp-Source: AGHT+IH21RQJnid/OTRVYXrIiH4NFpH3LFB629RPNgqariPIkRCoOdKe7vkXf8d6fEkoM51/1aX1VV+BrOrPNZYgUIg=
X-Received: by 2002:a17:90b:180b:b0:2fe:8902:9ecd with SMTP id
 98e67ed59e1d1-30e2e5d6393mr1007359a91.1.1747165461341; Tue, 13 May 2025
 12:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 13 May 2025 15:44:09 -0400
X-Gm-Features: AX0GCFsxfH4iQ0hD3_IlX7RqjSqRhHISleqe25AfqTPeEFqaXKTKW6XJ3Ce8htI
Message-ID: <CAEjxPJ59T-cpTcBjqSj_POtXFcxiMP1UQE+1eejTkAN6FMWGsg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] selinux: use u16 for security classes
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, 
	Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Security class identifiers are limited to 2^16, thus use the appropriate
> type u16 consistently.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Historical footnote: originally security classes were _not_ limited to
2^16 but a later memory optimization of the avtab rendered them so.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: only change type, move the validation (> U16_MAX) to the subsequent
>     patch
> ---
>  security/selinux/ss/policydb.c |  5 +++--
>  security/selinux/ss/policydb.h | 10 +++++-----
>  security/selinux/ss/services.c |  2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index dc701a7f8652..f490556ddb5c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -927,7 +927,7 @@ int policydb_load_isids(struct policydb *p, struct si=
dtab *s)
>         return 0;
>  }
>
> -int policydb_class_isvalid(struct policydb *p, unsigned int class)
> +int policydb_class_isvalid(struct policydb *p, u16 class)
>  {
>         if (!class || class > p->p_classes.nprim)
>                 return 0;
> @@ -2003,7 +2003,8 @@ static int filename_trans_read_helper(struct policy=
db *p, struct policy_file *fp
>         struct filename_trans_key *ft =3D NULL;
>         struct filename_trans_datum **dst, *datum, *first =3D NULL;
>         char *name =3D NULL;
> -       u32 len, ttype, tclass, ndatum, i;
> +       u32 len, ttype, ndatum, i;
> +       u16 tclass;
>         __le32 buf[3];
>         int rc;
>
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index 25650224b6e7..0c423ad77fd9 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -48,7 +48,7 @@ struct common_datum {
>
>  /* Class attributes */
>  struct class_datum {
> -       u32 value; /* class value */
> +       u16 value; /* class value */
>         char *comkey; /* common name */
>         struct common_datum *comdatum; /* common datum */
>         struct symtab permissions; /* class-specific permission symbol ta=
ble */
> @@ -82,7 +82,7 @@ struct role_datum {
>  struct role_trans_key {
>         u32 role; /* current role */
>         u32 type; /* program executable type, or new object type */
> -       u32 tclass; /* process class, or new object class */
> +       u16 tclass; /* process class, or new object class */
>  };
>
>  struct role_trans_datum {
> @@ -139,7 +139,7 @@ struct cat_datum {
>  struct range_trans {
>         u32 source_type;
>         u32 target_type;
> -       u32 target_class;
> +       u16 target_class;
>  };
>
>  /* Boolean data type */
> @@ -195,7 +195,7 @@ struct ocontext {
>                 } ibendport;
>         } u;
>         union {
> -               u32 sclass; /* security class for genfs */
> +               u16 sclass; /* security class for genfs */
>                 u32 behavior; /* labeling behavior for fs_use */
>         } v;
>         struct context context[2]; /* security context(s) */
> @@ -320,7 +320,7 @@ struct policy_file {
>  extern void policydb_destroy(struct policydb *p);
>  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
>  extern int policydb_context_isvalid(struct policydb *p, struct context *=
c);
> -extern int policydb_class_isvalid(struct policydb *p, unsigned int class=
);
> +extern int policydb_class_isvalid(struct policydb *p, u16 class);
>  extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
>  extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
>  extern int policydb_read(struct policydb *p, struct policy_file *fp);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 7becf3808818..a2dd42e750fe 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3387,7 +3387,7 @@ static int get_classes_callback(void *k, void *d, v=
oid *args)
>  {
>         struct class_datum *datum =3D d;
>         char *name =3D k, **classes =3D args;
> -       u32 value =3D datum->value - 1;
> +       u16 value =3D datum->value - 1;
>
>         classes[value] =3D kstrdup(name, GFP_ATOMIC);
>         if (!classes[value])
> --
> 2.49.0
>
