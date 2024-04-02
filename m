Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC015D5C9
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089305; cv=none; b=X9dYoktHDMKVr7m6d/7yUqTd1kFnmqq/wQtvpe780DRVteiZroaPZuVI8HWym1AbOyGPBvUkek+iKvBX88W56/HJfDu2BM9/G9wrAhJQ540A0jVVA5JfsZJQheXARm1KgbcvilGFag6eswC3FSJuqAGAm3W3tsiTq7kwrdX0HgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089305; c=relaxed/simple;
	bh=IZIDwcfWCppF6kkZhViuuPmc3C/DYrOU15I4JqgUs/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KryWZRnhXS3UO6gUq2pSJ0lzH3Mc/ITL9JtJUrsfR+lvMhDrTw4FmmH9eg6mRxhbeWL/U5ZOOSL01Edcnv+3maqkHH21P1+Tf45gEMKAoT7OrlqluvWPQkDWXCDH1Jmc+XfOFMamLBAQ2QfK7rjuXLJeODV4ZKwvqf5CU0nI/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gfKmvRsX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gfKmvRsX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61495e769bdso23881187b3.0
        for <selinux@vger.kernel.org>; Tue, 02 Apr 2024 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089302; x=1712694102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1qhSOp2+13zuALIdBEDhoImynyxkU8w83XkU9dAVvU=;
        b=gfKmvRsXQGNMgItc9fcvRdopT4C4kgdIg1IlHDFU+In9D4fAjXPu/nTFJWEdJ5XzhU
         ReX5Xl2KQXoDyAyYnwyGlD33Vmj3OytbMMuvzatheKVVpfRJSn0D/ZHRuHBzZ6MYX3ox
         UvYIHzL+Hud3d4eyQX90Sz7otGC4xGRtXSC7CyCffaKKWhjBPDEvBW2WT33/KQdSBjzQ
         YpdhQtOhFDz7wescRqXpjpkdyQt6mL9W7COe2E0tSshQPoe8gtAoKzEjo0yVvqZ4Gzz0
         Lx9VssgCVkp5YJY6Sc48bglF2qpWZM/opTd4B33WYYU+hO3dbmd7kzTvTIyb9TNoPJKK
         5wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089302; x=1712694102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1qhSOp2+13zuALIdBEDhoImynyxkU8w83XkU9dAVvU=;
        b=PfiA2HOMrqiICjxicwJwMsSHmA+M6Z6QmZYOiSjgJSrPYgZP63PhWsga7DJ2oZSVdi
         FtQqJlR5xJTvZwPQ3zhCjtbQO7FYEat/74NgZbo7wA8095spWd6QmTTHcqFUpUbCCA4k
         MAHzfByKeYVaMC/80DLThPuKI1WCOCCTCShQhnRF9ekjbH7qXcDIc/3abZ+bfdzuPTSL
         WG/3mYxeBfFtSN9XtYEEH6aG9VVjH/2o+74xYx8wKRYHi4VyL7SFqyYSudxY3rQOc04B
         DR0SKM227XnIZJMcEtc1hR7pTxTAS8R5uHuxPTFOM6jf7Hxjvl6SdU98y8NUflxDA+D9
         3MgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9paAGnR/ExBBSrW6U5A9LdN5VNL+8kmFb7ouEcPgo6RdqUaBrBdvplEucfPCzfaJSgtQENGb/EGiUATlDUMJ6+BXcGmmNJw==
X-Gm-Message-State: AOJu0YyPLklHpo43gNOwB9cmuPzQ64uQkTj4McEflaXf074hhR3OfhTY
	qJt4FvdCSShMdIkaFxA03T0W1ZFvPGCOlMLofxQoLW4V7B6XbvixosNHDlHk5RxohY1gv9NA3qF
	9vDwfTrgb6XHiHnyuA9+/2AJ0ktpEFF4ooUxg
X-Google-Smtp-Source: AGHT+IHXLQH0aIHnSidxi1fpeDAS1mgaCXB9btrUX8/PTIbQhJ4V8YENVs07wOD06ctY0KhZ6Qr/6vvK/ph00/95dSM=
X-Received: by 2002:a81:6c0b:0:b0:615:1a0:78ea with SMTP id
 h11-20020a816c0b000000b0061501a078eamr4719313ywc.34.1712089301854; Tue, 02
 Apr 2024 13:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305170501.2185811-1-juraj@jurajmarcin.com>
 <486c37d889583bb7351dba9793a2e709@paul-moore.com> <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01>
In-Reply-To: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:21:30 -0400
Message-ID: <CAHC9VhQF+-y+Fy_RS250sbo3-R+eKKc0Q5kSiUnUaSfGBMA0dA@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type transitions
To: Juraj Marcin <juraj@jurajmarcin.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:35=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Hi Paul
>
> Thank you for your feedback!

Thank you for the patch :)

> On 2024-03-27 21:22, Paul Moore wrote:
> > On Mar  5, 2024 Juraj Marcin <juraj@jurajmarcin.com> wrote:

...

> > >    | Mem   | Binary | Policy  | Create    | osbench [2]
> > >    | Usage | policy | load    | tty [1]   | create
> > >    |       | size   | time    |           | files
> > >    | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
> > > ---+-------+--------+---------+-----------+-----------
> > >  1 |   430 |   3682 |  46.930 |    2.4569 |   43.4431
> > >    | sd=3D 8 |        | sd=3D0.25 |  sd=3D0.043 |  sd=3D0.434
> > >  2 |   410 |   3682 |  46.829 |    2.4623 |   43.4112
> > >    | sd=3D20 |        | sd=3D0.27 |  sd=3D0.053 |  sd=3D0.442
> > >  3 |   419 |   3682 |  46.823 |    2.4257 |   43.0575
> > >    | sd=3D14 |        | sd=3D0.18 |  sd=3D0.057 |  sd=3D0.416
> > >  4 |   420 |   2585 |  42.044 |    2.5028 |   43.7907
> > >    | sd=3D10 |        | sd=3D0.19 |  sd=3D0.067 |  sd=3D0.382
> >
> > Thanks for the updated patchset :)
> >
> > I like the improvements in #2 and #3, with only one test being slightly
> > worse than #1, I think we're okay there.  However, it looks like there
> > has been a regression in #4 in terms of runtime performance ... hmmm.
>
> It might look like a regression but there is some variance between runs,
> even though I ran single benchmark many times and cases right after the
> previous one. There is a similar difference but in the other direction
> between #2 and #3 even though they both run with the same kernel and
> basically the same policy (the only difference being explicit zero
> counts of prefix and suffix rules in the policy file for #3).
>
> I ran the whole benchmark suite again 2 times with the same reference
> and patched kernels and got the following results:
>
>    | Mem   | Binary | Policy  | Create    | osbench [2]
>    | Usage | policy | load    | tty [1]   | create
>    |       | size   | time    |           | files
>    | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
> ---+-------+--------+---------+-----------+-----------
>  1 |   436 |   3682 |  48.955 |    2.5037 |   43.7484
>    | sd=3D20 |        | sd=3D0.25 |  sd=3D0.048 |  sd=3D0.445
>  2 |   434 |   3682 |  48.331 |    2.4314 |   43.6714
>    | sd=3D16 |        | sd=3D0.25 |  sd=3D0.044 |  sd=3D0.422
>  3 |   421 |   3682 |  47.592 |    2.4633 |   43.5746
>    | sd=3D19 |        | sd=3D0.28 |  sd=3D0.056 |  sd=3D0.375
>  4 |   413 |   2585 |  41.895 |    2.4608 |   43.7485
>    | sd=3D13 |        | sd=3D0.19 |  sd=3D0.063 |  sd=3D0.378
>
>    | Mem   | Binary | Policy  | Create    | osbench [2]
>    | Usage | policy | load    | tty [1]   | create
>    |       | size   | time    |           | files
>    | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
> ---+-------+--------+---------+-----------+-----------
>  1 |   442 |   3682 |  48.639 |    2.4741 |   43.4764
>    | sd=3D23 |        | sd=3D0.21 |  sd=3D0.059 |  sd=3D0.487
>  2 |   422 |   3682 |  48.305 |    2.4191 |   43.6313
>    | sd=3D10 |        | sd=3D0.21 |  sd=3D0.064 |  sd=3D0.460
>  3 |   427 |   3682 |  47.524 |    2.4798 |   43.7239
>    | sd=3D21 |        | sd=3D0.17 |  sd=3D0.055 |  sd=3D0.590
>  4 |   416 |   2585 |  41.764 |    2.4272 |   43.6712
>    | sd=3D 8 |        | sd=3D0.20 |  sd=3D0.052 |  sd=3D0.376
>
> As can be seen, sometimes one case is the fastest one for the given test
> by a few tenths of a millisecond/microsecond, sometimes it is the other
> way around. Regression in one test case would result in it being slower
> consistently between runs.

In all three reported results, test #4 is slower than test #1 in every
case, although it is within 0.001 in one result.  While I agree there
does appear to be variation in the tests, the fact that none of the
results show #4 as being faster than #1 does seem to indicate a
performance regression in test #4.

> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/pol=
icydb.c
> > > index 3d22d5baa829b..5de22ba840673 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -429,7 +434,11 @@ static int filenametr_cmp(const void *k1, const =
void *k2)
> > >     if (v)
> > >             return v;
> > >
> > > -   return strcmp(ft1->name, ft2->name);
> > > +   v =3D strncmp(ft1->name, ft2->name, min(ft1->name_len, ft2->name_=
len));
> > > +   if (ft1->name_len =3D=3D ft2->name_len || v)
> > > +           return v;
> > > +   /* if one name is prefix of the other, the longer is greater */
> > > +   return (int)ft1->name_len - (int)ft2->name_len;
> > >  }
> >
> > I'm probably missing some subtlety in the code above, but I think we
> > might be able to optimize this a bit more:
> >
> >   if (ft1->name_len !=3D ft2->name_len)
> >     return (int)ft1->name_len - (int)ft2->name_len;
> >   return strcmp(ft1->name, ft2->name);
> >
> > I expect being able to avoid a string comparison in some cases should
> > result in a small performance bump.
>
> That optimization would lead to a different ordering than before with
> the plain `strcmp()` - it would sort the strings by length first and
> only then alphabetically. In fact, the `name_len` comparison could be
> removed from the condition entirely without changing the ordering. This
> could make it more clear.
>
> However, this change in ordering might not matter as it is only a key
> comparator function for the hash table and items from the policy are
> inserted one by one. I will also ask Ondrej about this.

With hashtab_search() exiting early on a negative result from
filenametr_cmp() it may look like the ordering within the bucket
matters, but so long as we use the same sorting order when
accessing/inserting entries it shouldn't matter.  The important thing
is that we can search through the bucket entries as fast as possible,
and performing integer comparisons/math is going to be a lot faster
than performing a string comparison.

> > > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/pol=
icydb.h
> > > index 4bba386264a3d..78abb959e7205 100644
> > > --- a/security/selinux/ss/policydb.h
> > > +++ b/security/selinux/ss/policydb.h
> > > @@ -232,6 +233,11 @@ struct genfs {
> > >  #define OCON_IBENDPORT 8 /* Infiniband end ports */
> > >  #define OCON_NUM       9
> > >
> > > +#define FILENAME_TRANS_MATCH_EXACT 0
> > > +#define FILENAME_TRANS_MATCH_PREFIX 1
> > > +#define FILENAME_TRANS_MATCH_SUFFIX 2
> > > +#define FILENAME_TRANS_MATCH_NUM 3
> >
> > I think we should probably tweak things to help indicate that the last
> > macro/define above is not a usable value, how about this renaming it to
> > FILENAME_TRANS_MATCH_MAX?  I'm open to other suggestions too ...
>
> I thought being consistent with other array indices (`SYM_*`, `OCON_*`)
> would be better, but I am also open to change the suffix to `_MAX` if
> there are no objections.

Ugh, yes, you're right.  We should change those other #defines, but
let's leave that for another time.  Stick with _NUM.

> Then possibly update also `SYM_NUM` and `OCON_NUM` defines in another
> patch.

Yes, that's the right approach as far as I'm concerned, but that's
something for later.

--=20
paul-moore.com
