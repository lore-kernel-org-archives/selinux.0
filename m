Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAA4AD7C7
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382131; cv=pass; b=rLRcwzTo04OBCFG3cQ6UqO0wG/tVHltb3/HFobBAznBIebsfm4UJFhaJyFqq1fkOhj6rGA8EU3FZx0dsC7sKZRJYqMRmuvIIOh2M+61GGPptfw1XQ19a2OxLEdRD3yR6pDhTMjmEm6XO4tjZDwLHgRq9uPPB8NL7rTa7SgORnyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382131; c=relaxed/simple;
	bh=eNWz/iLdOPfPl85RgRq02RBcv+nPjUrwuLn0gsokASU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsf97D08/Z8dfwPTjA9HJhyX8B+z7PUARxvaQAjQjzb1OHyusVro+MuakCM6PYcvpx2NS8xuQ8wE85UqjncY7y2YWDSQ5W8nMr11od2uH/c1T17F93tW65pcdgdSnalfUEaXuS1xGdOHtAfOAw37yFrTkTg4oItXo2J8EOcIpKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDoBBkFg; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDoBBkFg"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6756a01fa01so2144599d50.0
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 07:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791382125; cv=none;
        d=google.com; s=arc-20260327;
        b=IHVqF/U59Vt1oET+hmT3sq28rnGhCL7SeLU3TMI2vM5waUo0EMm+ikhK+PslagWDdL
         WRBVoAJW0mERqhmS8TYj4vYRezyzMR3D/7K1qYrTaXpbcnVa4Nhbfunu8gSjtMHcwAd5
         QSc2rOyqb53RBDWLFxboNH7+QM4LDSfxkPw2o2J113Voc1Pblvt6o/7PKdt7LZRGPasp
         pZ1UXCvLuLI49NoDWXCfizg6hZgSu6nrC9v5vkKa0DzDzGbgTJGbUJRLbPTJHp8kJ624
         0aPNXgKlUaWtCBtpCIxq1zvFVGMoIz9JteEelRGN1wHudOqXmzPtJTApy61CJdATkmQi
         cu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EyoUv8s04ANSbUjErTp9A6tkOakdDii1BuL2o60ZQn8=;
        fh=FABR+A9yU+fF5EUO2Xf05R8VywK3pPrdV7e9zia4618=;
        b=JhZ5N/z95G24KUXgMiCUSUghUFb2eTl8BlcteqM4V8iubxY0GOs1Bpg3DYPF7cLUkX
         v/2oerWff+KtAi2WMnVn6mFTSVa5o5LlH/0TwRb37ED6hxnS+Tb1IlyzD9FWxFPSdV9D
         fzHAXX6b+hHOTVnof+lNRkiWSKtnYcRNzP69L0jWJ4R5JolhPS6deY6xW9PCgxogVd3C
         zzwJKQowq6O4j941HFErjuCtQM/fPHGtdA7m8aDrPn/8Eyp3tcomiOVb8YlISG14IRNU
         mN1CnYulx769Zfro7KsKHEZD6kjvyUMRFS7dWPGPtopZtJ9Z4prbb8tTDEf4JuGRnTlV
         MMSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382125; x=1791986925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EyoUv8s04ANSbUjErTp9A6tkOakdDii1BuL2o60ZQn8=;
        b=eDoBBkFgYhLSiXXecNli+/0QB6JQ3e7NpUcMDzPIQnXShrgabhYOC6dCFKYGfOtwHf
         cX9Bzvnt6XelLwS9gvnZeyOzczwG8mtJdPtvIkYLVKTgSIXscVfAzllAMuGVKN8xtRM4
         RD/ldF9GLntONWGoGQQEWLCrDQ17JMwT4cQVosRPWTHrdUpLRkvkosnir3d+AnWG2t6W
         bXgelMeMn2gqMGhnQ2IwChQBDLESPaAS/6lg9XV2BMNnBpkXN8A3BarM1cBMRp5z8XJk
         zs/nXl5esXa2VMZzOu+FqQqIW0oMA3nnj6SSGT3Urh9KAJnVNp0b9U/4GYbEJf52OkI9
         uMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382125; x=1791986925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyoUv8s04ANSbUjErTp9A6tkOakdDii1BuL2o60ZQn8=;
        b=mVPmxK8gTF6+dqUxjafYHAVbcoKp7M4jaLGGanvxFGtSKHzlgBy4mJAmaOFOnR0xh3
         ILfyUN3moWSAohnI4EGbHwVJyX565PB/klO7tXvNjjatyYFHgM40xKyCWRPzSb3aatu5
         YtwSulORQ7L3+6niapfR03NonOcsCWDYHz3peZ3FBl205GFihhmLGPhPb2doUamRuPt2
         E8mJMK8bH6vWbfG3akAA1XVg54y1p2q3kMlBuxEIyX/UERx1VA8PMiJrhGdvUzv3P+mb
         LmgRTRUMCh22IyQB4BcCZg/Y89bnQ1ck8PgKa7pwg7Pk9R/ZBBQYXfM/IdEApbea0Xc+
         6Cbw==
X-Gm-Message-State: AFq9FYJoHx8V+ypATnHtFsfK+dUWdT4Fdfe1RoyE2p9IVzxO0ZMj9qIJ
	p+8XpYGy7wwQ32jacZqcKp9fB+IG7fsEcowRIhK9uFNG4xE9XptcaALlpHiLZ5xZ6KzbKObVI6e
	i26cZT/IxPIfiN7PQ3MHHdzwGyPfu6AI=
X-Gm-Gg: AYBFou3HU+1hqLCovfM9ybrJPa5YNur/gC5w3cQdhUaNwoMAd0VBYpujze8q16A31cJ
	7TkfmA0zBqH0ynPp5NqfKiKQT62JESMkV3CrGX0I9J6xe2KIHESLnBZPrFXbE3lnm0X7G8+OR+r
	KFHzBGeVG3negayrxKUehlpAgYeZp9ZzJix0cE78c7FJfSAQdr8LDRlR0IfMgFvxpm7IyjZRe2T
	UwQV09hVGIIPj3a4rAOb26ygoLQocHVDzaczW38u9rORCCBSiWYPESINE4XmkuMw43TUeFvKbiI
	K7R9dR6A0fuDyBqp/fcq7JRJVdU9N337DSvsxI8WQKkHohrdw5t6+UQ=
X-Received: by 2002:a05:690e:43c5:b0:677:c014:29c9 with SMTP id
 956f58d0204a3-6790a3bca06mr855975d50.19.1791382124863; Wed, 07 Oct 2026
 07:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Oct 2026 10:08:34 -0400
X-Gm-Features: AclHuK_9kg881e3KUTO8XhqnWdrNeA-haI1qJNAvra_ou2CwCAV8jwtUQMcZj2k
Message-ID: <CAEjxPJ539cmKPenoFnbmqrPVUPxeWudonm5Hb6b5WpUYaAu3Cg@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 00/17] libsepol: add public API for policy introspection
To: jan janasek <jjanasek@redhat.com>, Chris PeBenito <pebenito@ieee.org>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:08=E2=80=AFAM jan janasek <jjanasek@redhat.com> wr=
ote:
>
> Hi all,
>
> This series adds a public, stable libsepol API for read-only
> introspection of a loaded/compiled policydb: iterators and
> accessors for types, roles, users, classes/permissions, booleans,
> conditionals, AV rules, MLS/category sets, contexts, ocontexts
> (initial SIDs, fs/port/node/... contexts), filename transitions,
> range transitions, role rules, permissive types and policy
> capabilities, plus a small "record" layer that snapshots the above
> into owned, independently-freeable structures.
>
> This is the first time this series is posted to the list; it was
> developed and self-reviewed out-of-tree against an older base and
> has just been rebased onto current upstream/main before this
> posting (see "Testing" below for what that rebase involved).
>
> Posting this as RFC because it adds a sizeable new public ABI
> surface and I would like design-level feedback before going through
> a full review cycle. Specifically:
>
>  - Is libsepol the right place for this, or would a separate
>    library be preferable?

libsepol is the right place, thanks for doing this!

>  - Does the record/iterator split (snapshot "record" structs vs.
>    zero-copy iterators) make sense as a general shape for this kind
>    of API, and are the naming conventions reasonable?

In general, yes.

>  - Is the libsepol.map.in symbol-versioning approach in patch 17
>    acceptable for a surface this size?

IMHO, yes.

>  - Is landing this as one 17-patch series reasonable, or would
>    maintainers prefer it split into smaller, independently
>    mergeable increments (e.g. per policy-object family)?

No objection to doing it all in one go.

Some general comments:

1. NULL handle. Essentially every new _create() function rejects a
NULL sepol_handle_t, whereas none of the existing public API does
that; they all accept handle =3D=3D NULL and ERR() falls back to
sepol_compat_handle. I'd drop the !handle checks across the series.
2. constants.h and the public namespace. As written, sepol/constants.h
is included from sepol/sepol.h, so a public API only consumer that
includes sepol.h now gets AVTAB_ALLOWED, OCON_FS, ... defined. Move
the unprefixed #ifndef blocks back into the sepol/policydb/ headers so
sepol/constants.h exports only SEPOL_* and the compat spellings stay
confined to code that is already including internal headers anyway.
3. Exhaustion error reporting. There are three conventions in flight:
*name =3D=3D NULL, *value =3D=3D 0, int *has_next. For the uint32_t-value
iterators, 0 happens to be an impossible value in every current case
but I'd rather not bake that into the contract. A has_next
out-parameter or returning >0/=3D=3D0/<0 would be future-proof and
uniform. If that's too much churn at least documenting the convention
once in each header may suffice - right now cat_set.h says the first
_next() "reports no values" without saying how.
4. Record iterators and ownership/cost. sepol_type_iter_next() et al
hand back a freshly-allocated, caller-owned sepol_type_t. Two things:
The headers don't say so, and on a real policy, type_datum_to_record()
will string_list_add() every member of attr_type_map[v-1] /
type_attr_map[v-1], which for refpolicy is ~5k types x tens of
attributes each - a lot of strdup churn to walk the type table once.
That's consistent with the existing sepol_user_iterate() shape so this
may not be a blocker but a setools migration may want a cheap "name +
value + flavor" variant that doesn't materialize the subtype list.
5. KERN-only iterators. sepol_avtab_iter, sepol_cond_iter, ... read
the kernel-format tables (te_avtab, cond_list, ...). On a
POLICY_BASE/MOD policydb those are empty - the data lives on per-decl
avrule_block lists instead - so these iterators silently yield
nothing. types.h already has a nice KERN-vs-source paragraph; the rule
iterators should carry an equivalent note (or the create() could ERR
on policy_type !=3D POLICY_KERN the same way the Xen icon iters ERR on
target_platform).
6. sepol_policydb_rebuild_attr_map. I can't construct a public-API
call sequence that needs this: sepol_type_modify() refuses
POLICY_KERN, and rebuild_attr_map() early-returns on !attr_type_map
(i.e. anything that isn't KERN). So the only mutator and the only
rebuilder are mutually exclusive on policy_type. If there is a future
API coming that will use it, that's fine, but then that should go in
this series too (or drop this interface until that one is ready).
7. Patch 05 is a real bug fix independent of the API. I'd be happy to
see that one split out and sent on its own ahead of this RFC.

More specific notes to come on the individual patches.
