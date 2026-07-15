Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995223507B
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122515; cv=pass; b=TdcNfRaCkmpLKfBqUwGTelRw9nV7kWM/kESsAA175FdyjMUQOtJ1e1GTfnxcxmnHel+OeUbTApA8imxc5ZonopWSHOB1EgK4z2F5O1KDJmt6lY5tAGlC81ET2Xu5d2ob3eNUgzrC5SOD5WCSILmIefcIsPAcS9YTC9x3/WHp4S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122515; c=relaxed/simple;
	bh=XlKsTjbexrJqjvgc2P9dLexKeRkju4MLnTsLEQIzvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWOf8O3MzMd387K69Hxiqlq1HheKr3sR0jwcFkFoFnwUjF5fmFo3BToUpGx05CYYuVdfSwX2/V5kUDXnbx6DYaWG27Usd85Mgx+xr9HqGiGEQFL7cjrbK+aRzCwnRAwdB2FLqyhpQWpBAR0IZ3C0q8hsl8f/F55MBsSSutqtSBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfuEDMyJ; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfuEDMyJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39ca300db70so34245231fa.2
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 06:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122512; cv=none;
        d=google.com; s=arc-20260327;
        b=gz6c5C6YLZNNdm9HDCbII9270tsi2arENZGsf7/EXHqzMCIB+7QWTuvXrNXKBgCMFT
         SU+PrJpzrFeYWrjkLe9G5UkmwApVZkx+Xaw2h2UrPRag1tfQWbVxsJPZ6K7yGRNVW15t
         NS7lSowES3UVCQ9wAPnaMwMXV5JdBvhcVmjv1CRBfu83Kqux4o9mJGhrBer9HwxMmLhU
         xqL+VPCFrw4tcumK7JgJLJSBTEur7PlHlQSZNiaTbuzQkTs6ZUKGehZsT9b+QG1jfx06
         9BmWrhS0SQnHwE+I9B88CSDtlXhsNruzYeF0AGNlpIaO+sutV7ZhCgYeeIgtpU3t4qO5
         6bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8G8bBsYrTQb5lsTfKkpZhn4kYIWV7gLmaDWmvMSHA8s=;
        fh=pe13lwr1pAr85IdBxMlCdwuHRr224Lxk7IiqxVuoQ68=;
        b=RYahf2/3iJB429giDB8QWpUcJ7JU7fdfoDBkfADGzdD28+dgRQxOvFTlueD1ghcTan
         2GiaqPpS9c/klQGazAXJFo6rW4ipSf32zjkp668z8D5+U5eQFqRaN9LP6X+3rWyEE+0j
         1qFc8d/yqCPdgXbKGuJJ23Hi4XdDLL0Sxr5X2FLo5JF6yWz1rAmLtAbXfHp2ih7MIGQ6
         GonBsQ0sRoPdOY80ahNl1xvnBHTlnb4I8hmdfe6sKINEk0SXLKHzMWaAh4T98pe4q53b
         6Lw7Tr2Y+eSpTmFzmD62OuRTS291+1S8zvhpEEb0k7zejn+YYIhy5oisPzdPhsnBNiGX
         FbrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122512; x=1784727312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8G8bBsYrTQb5lsTfKkpZhn4kYIWV7gLmaDWmvMSHA8s=;
        b=hfuEDMyJCi4XiX5QCvXDoB7Sez39XKw7F5wA1znaZGQsy3xbxjgkdq0ZBHDUBC+X0m
         JFb9L2uPUzqWoJROf7BJZGI89Tto1v9TrF9PFKzanc933AwBmdTbAFCptVUNsN8Uw1ME
         v3qxciJEBQDBSvfcBTa8rCRy1FeIuV2RXR/sQ4tsPyhesGKO8xWOPrYnDDJIPxzYMFUw
         2c3yDovmWXUgC0Ow/PWeskXAo9yu09J/WibMRHx1HJo0eMx8lofbwTSHLDvAjT0TVSkG
         6ubshrzPgsbklmRwAJ6w4rynx7w0V8+iD3gHtag5c4P+05laSa1YCbpyI4MqCtLTPkPp
         vHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122512; x=1784727312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8G8bBsYrTQb5lsTfKkpZhn4kYIWV7gLmaDWmvMSHA8s=;
        b=RaFKacsYdXuLKA/qdSEgNvcpQbk8/4tEyFQyFUBKRJjf8vz/N2v909j3a063hwlr0e
         vPJBFLtGYYmldca+HZaY+KbsNcHdJyQ8RqMRtAW7Bp79IP6IiY54LTSpAMoKGXhWtLHe
         78s5erXBcE6eu/NPYx7E3C/Mr9corL4bDj5HLpYK0r27o5pz4T8BtXB6ZVdLp8kak0hj
         9uuVPHz/e8SUuQiBRJ5wAYMHkxXWIaUa+nkpi8ygYJCooXLQ07c0G9aJndt+wdPfG50I
         LJUDLFvdpUcA/WiTWa20ACbfdqYhA2fTjcE5RWyuqcxdJyMxjavcFOTEh0+lFbQiU+s3
         encA==
X-Forwarded-Encrypted: i=1; AHgh+RpTAwpv88SrCLc8j8HNwC8wotCpQHOZThPoKvNs874Lxo3MZx2FIG4Kj7N4OLZ0743XJhD9lhkr@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhpBZ8qZxBpBB+BgGL3R0zl/63WmO9wbHUZkEO2vIXoQn8jsA
	w4ak8uXiHTBnAo/VtbDbA/2V/1m2B96mUfqIeGaLmFFy3F9a5F5m5ldhrxPpNMyqZU4PDHD/PAZ
	1/NBi+cCEFYZXG32Ii8kJZhMpOeCrN3A=
X-Gm-Gg: AfdE7cmaSji68vN2k4bkp/D2Jw12iywDTDWqrw8SjMfcYq2Lr43jS5tFoA4/F0Y+DMU
	xfJyN5mhvUTL0XU+XXNYQiGlFea4589JqyWaRivdHc9kLtBB+2rlilqwssMdkkwEMm+roiBBhEy
	uLPlv6Fl7Qb3oorWH4tEMg5z0C3ubuziWIX+o2om1kg5L3yTLE4UZj5Zssit4vLcZAhBTsHKqc5
	L6AJUtq6XW222q1LBZVJz01kaIZbdsCcgo1StHzWzh/eNO+XHL+ist5qgzDDT3wpKQvEA==
X-Received: by 2002:a2e:a902:0:b0:39c:9aa0:799f with SMTP id
 38308e7fff4ca-39db6d92796mr7523741fa.33.1784122511472; Wed, 15 Jul 2026
 06:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710192953.2083527-1-md.shafiuzzaman.hira@gmail.com> <CAEjxPJ4jCHKWdKHLBUsAKbYbTRDWXVZWHY7qy0p3RKxog94g4Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4jCHKWdKHLBUsAKbYbTRDWXVZWHY7qy0p3RKxog94g4Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jul 2026 09:35:00 -0400
X-Gm-Features: AUfX_mydU7CU3PbjqxQlGWpeHXH88gL4aa-_g42lY_HAKdAfqAO6cjLPlPkrwjc
Message-ID: <CAP+JOzSe3bbNNhWNDdH48do0gXzFQZrrR2xh+SASxn3wynSBrA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix double free of fstype in define_genfs_context_helper
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: shafiuzzaman-md <md.shafiuzzaman.hira@gmail.com>, selinux@vger.kernel.org, 
	coms-vlab@ucsb.edu, Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 10, 2026 at 3:30=E2=80=AFPM shafiuzzaman-md
> <md.shafiuzzaman.hira@gmail.com> wrote:
> >
> > From: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
> >
> > When parsing a new filesystem type, define_genfs_context_helper() trans=
fers
> > ownership of fstype into a genfs struct linked into the policydb's genf=
s
> > list, but does not clear the local fstype. A later goto fail then frees=
 it,
> > leaving a dangling pointer that policydb_destroy() frees again.
> >
> > Clear fstype after the ownership transfer, mirroring the else branch.
> >
> > Reported-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
> > Signed-off-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

This has been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 982de3f..3015782 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -6054,6 +6054,8 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
> >                         return -1;
> >                 }
> >                 newgenfs->fstype =3D fstype;
> > +               /* ownership transferred into the genfs list; do not fr=
ee on error */
> > +               fstype =3D NULL;
> >                 newgenfs->next =3D genfs;
> >                 if (genfs_p)
> >                         genfs_p->next =3D newgenfs;
> > --
> > 2.54.0
> >
>
