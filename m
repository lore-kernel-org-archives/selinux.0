Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77012FBF6;
	Sat, 17 May 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747518839; cv=none; b=sjiEG5ctnlSeE70hVdRP7zpLYVOkcJqn8rQ+5WGoruZF5y0BSXaCY0ePAZHbYConNypgRhgzN4iTSC1vq5Ni+IuNfzu+GvXHAZ6tpVm+z49rkDrD70nYfbTXmhbEvKw4J85WutdzPaId/jwX1zrzlDlDH22zi5c/FQ7lDWE/fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747518839; c=relaxed/simple;
	bh=+4hZcFBaIFpB2tXunlWlqthHA9ZfZBxLR3xhWvq2BBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/+W8PJmGYP8F5Z+jNU7FL6JorCXbQNbFobJbWSiUPc9H96ZkKJTzQ2VqjoELy8UqQLw8WpE1xvto2+GXA6AU+YMJU4FR5z7TPAope75/NhkHxQkukHYk7KAEIvPzvEAd6WLgvMizaCZDjOL7st+Ho29vWs6O745LFmxMxrmUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFV5voAH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFV5voAH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso39212675e9.2;
        Sat, 17 May 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747518836; x=1748123636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz5kCdBpHuuY3FufaoWkwKcV3w4pPUgExEK9z7rog4g=;
        b=gFV5voAHt/fxS2DUayb8x0akCxVNWD8Ma45T9EjMH5iH0sPbjvRr0SPGK3phWVVUB+
         3rTUhpyMfImEauJAkXnv85z52rvENAQmTqudBA7Jnvc5QlBM0tIyC5cp+mcUlGJNsrt/
         V2qYAfDOAuspLGq6Z5Rt7/5AU/A1xd89xog3q1wxnxcva90W8o22g8OYi0Kgu4f/FaDW
         I9JJjyRTZH6Blhd03yoNtDxdxVHgacRUOP8ZbX/bH3Fol9cha/tEUNFjLphIhDZh6naP
         fgnWzvzhI6oX/5phedCOlIkEn5UVyM6wvWMxgdjiJRBPsQkhmaZrQQxsUzmxjJOVFzkz
         Dtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747518836; x=1748123636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vz5kCdBpHuuY3FufaoWkwKcV3w4pPUgExEK9z7rog4g=;
        b=Ohee2sCV9MCuyVRsUww8Rw4U0r7AMDDhNWJq64cWqcl29ER/7p3xAv1mQjnCHXcrZi
         kluqrDpAl6+dDlPdVYUoiGjnb1rYIG9otGPtjwEtJCEAJgTo4rhxqVteSPblE4kcwPZo
         6MVpg2OgXwtlNq55yN9ijPKl+gvXHKZnBCBlhzWNx7YqFLoq+lvSIAxLxZoa2G4UPxwz
         xsa6ihn0ynLInIeCQRmZC2Gb80EYQQnOxTy29l78jKYW3QPq7uPewHeldjJxyi50brJs
         Fne/nHDlt5ZPK72t7FpM81x0xKikQLI8bLyhWL+TNPT/8KOEKHQ9WinQcNFOOZoGPDO2
         GD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+P4xCKGj4VGlxwE9yhsxf8IQ/sNEdNyR3T9tpkiNx9BZS+GuDxfHMknhvxVzAjU/8hqIHrYIw1w==@vger.kernel.org, AJvYcCW1ZyjeBrn2tjSss3zX/8gsY4xEhKxdgWDAzBXHpbDljlZKnTWrdm+to8qDNnH74QMU2TUTeYbmjdutE/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCh8tRe8Ea4CLVOGwAB52p76xzW1+CwJg3WKZPt5Gb7MqJkobS
	alwGf9pmry1JZimoE1o6pu4Z1OpSsAnMxr8mtt/uQQD4luSgIOirsiS/
X-Gm-Gg: ASbGnctpxb45uq5CbxbOqQaEWZWbSSoefoOQgw1aZZFqLNAj+KkiNAsxbLpKVDMwBhR
	xKg9/+rEHrmMEn5sHrkpm2sTAeOWgSies/VbxgeicDIUMUJG8HGdVLT/ziPhT6MSBu/WUF9CZjH
	ZBzbZmz8XP/uwbb7BBLm6UB2Gp1q2SFoNR52K3OBIyWn83CP6/uAn3Giud8Y72jdjhymKrGQUKu
	YDvz3e/ruJPmzlO/5WYict+4IQGtGnkjG37qd3pkxRP4F0Qy7p95I88t7ngB80SWez/f0DTp8j5
	UKKroq4Z6g/RDl6/uj5w/2L6D5yOyYyKH+U3LTHN81Qfe2WCPlHheTfGyGNWZ1HGoUxWCVOroUF
	M1K/aFIu/z1cppQ==
X-Google-Smtp-Source: AGHT+IF6abgjT38mfZgZs0KcJtDmQ0SKJaiGKy+KxrbAQxoTE8XqwhbslYRllhf+8dDa29DpGAK/zw==
X-Received: by 2002:a05:6000:2484:b0:3a3:5c04:8b63 with SMTP id ffacd0b85a97d-3a35c84b4c2mr7475324f8f.42.1747518835504;
        Sat, 17 May 2025 14:53:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1f9sm7276833f8f.1.2025.05.17.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 14:53:55 -0700 (PDT)
Date: Sat, 17 May 2025 22:53:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org, Paul Moore
 <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 linux-kernel@vger.kernel.org, =?UTF-8?B?VGhpw6liYXVk?= Weksteen
 <tweek@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo
 <guocanfeng@uniontech.com>, Takaya Saeki <takayas@chromium.org>
Subject: Re: [PATCH v3 02/14] selinux: use u16 for security classes
Message-ID: <20250517225354.18d186d9@pumpkin>
In-Reply-To: <CAEjxPJ59T-cpTcBjqSj_POtXFcxiMP1UQE+1eejTkAN6FMWGsg@mail.gmail.com>
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
	<20250511173055.406906-2-cgoettsche@seltendoof.de>
	<CAEjxPJ59T-cpTcBjqSj_POtXFcxiMP1UQE+1eejTkAN6FMWGsg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2025 15:44:09 -0400
Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Security class identifiers are limited to 2^16, thus use the appropriate
> > type u16 consistently.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com> =20
>=20
> Historical footnote: originally security classes were _not_ limited to
> 2^16 but a later memory optimization of the avtab rendered them so.

The fact that the value is limited to 2^16 doesn't mean that the type
can't be larger.
You won't save anything by using u16 instead of u32, if anything the
code will get larger and there can be subtle changes because u16 gets
promoted to 'signed int' before being used.

	David

>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20
> > ---
> > v3: only change type, move the validation (> U16_MAX) to the subsequent
> >     patch
> > ---
> >  security/selinux/ss/policydb.c |  5 +++--
> >  security/selinux/ss/policydb.h | 10 +++++-----
> >  security/selinux/ss/services.c |  2 +-
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index dc701a7f8652..f490556ddb5c 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -927,7 +927,7 @@ int policydb_load_isids(struct policydb *p, struct =
sidtab *s)
> >         return 0;
> >  }
> >
> > -int policydb_class_isvalid(struct policydb *p, unsigned int class)
> > +int policydb_class_isvalid(struct policydb *p, u16 class)
> >  {
> >         if (!class || class > p->p_classes.nprim)
> >                 return 0;
> > @@ -2003,7 +2003,8 @@ static int filename_trans_read_helper(struct poli=
cydb *p, struct policy_file *fp
> >         struct filename_trans_key *ft =3D NULL;
> >         struct filename_trans_datum **dst, *datum, *first =3D NULL;
> >         char *name =3D NULL;
> > -       u32 len, ttype, tclass, ndatum, i;
> > +       u32 len, ttype, ndatum, i;
> > +       u16 tclass;
> >         __le32 buf[3];
> >         int rc;
> >
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/polic=
ydb.h
> > index 25650224b6e7..0c423ad77fd9 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -48,7 +48,7 @@ struct common_datum {
> >
> >  /* Class attributes */
> >  struct class_datum {
> > -       u32 value; /* class value */
> > +       u16 value; /* class value */
> >         char *comkey; /* common name */
> >         struct common_datum *comdatum; /* common datum */
> >         struct symtab permissions; /* class-specific permission symbol =
table */
> > @@ -82,7 +82,7 @@ struct role_datum {
> >  struct role_trans_key {
> >         u32 role; /* current role */
> >         u32 type; /* program executable type, or new object type */
> > -       u32 tclass; /* process class, or new object class */
> > +       u16 tclass; /* process class, or new object class */
> >  };
> >
> >  struct role_trans_datum {
> > @@ -139,7 +139,7 @@ struct cat_datum {
> >  struct range_trans {
> >         u32 source_type;
> >         u32 target_type;
> > -       u32 target_class;
> > +       u16 target_class;
> >  };
> >
> >  /* Boolean data type */
> > @@ -195,7 +195,7 @@ struct ocontext {
> >                 } ibendport;
> >         } u;
> >         union {
> > -               u32 sclass; /* security class for genfs */
> > +               u16 sclass; /* security class for genfs */
> >                 u32 behavior; /* labeling behavior for fs_use */
> >         } v;
> >         struct context context[2]; /* security context(s) */
> > @@ -320,7 +320,7 @@ struct policy_file {
> >  extern void policydb_destroy(struct policydb *p);
> >  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
> >  extern int policydb_context_isvalid(struct policydb *p, struct context=
 *c);
> > -extern int policydb_class_isvalid(struct policydb *p, unsigned int cla=
ss);
> > +extern int policydb_class_isvalid(struct policydb *p, u16 class);
> >  extern int policydb_type_isvalid(struct policydb *p, unsigned int type=
);
> >  extern int policydb_role_isvalid(struct policydb *p, unsigned int role=
);
> >  extern int policydb_read(struct policydb *p, struct policy_file *fp);
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 7becf3808818..a2dd42e750fe 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3387,7 +3387,7 @@ static int get_classes_callback(void *k, void *d,=
 void *args)
> >  {
> >         struct class_datum *datum =3D d;
> >         char *name =3D k, **classes =3D args;
> > -       u32 value =3D datum->value - 1;
> > +       u16 value =3D datum->value - 1;
> >
> >         classes[value] =3D kstrdup(name, GFP_ATOMIC);
> >         if (!classes[value])
> > --
> > 2.49.0
> > =20
>=20

