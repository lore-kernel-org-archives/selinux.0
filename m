Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC296FB1
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374213; cv=none; b=owcxiMhots/y52ZLtqqhd/9akfQ38dK8k1ZI5b8oEKUmaTDcqkMSQx+kTL9xtuSp3W9jWnAy5DFkh1tLPbmzQet/mv6ICWmPbm+pYsS7KxvDxIONNH9sICXkQ2NjxHJkB2/fAewUocvFGrOkyJEajeGV7cCZMwXcqvX5mw26W0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374213; c=relaxed/simple;
	bh=XFIMJa1G4vUTVJ7CW5wmOmJg23KH/igZWdZE2Y3QXJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvDb9hJkgcWOv6h3pasQ99u670AIuKdO5CrQIQ5PTF7d2SPhrmq0Vsw+0FiWI22P+wvHlgpqD+x6uY/I7Ul422xPIO647EBgo5SdzwaLsmpknWT0DrpgWh8UNOgHDSG0mL0fWUEQ7r+kmdCD1xSDhwL0h3xHJbY1Ho4Huog/yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5IJZK9Q; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5IJZK9Q"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d24a231342so845393b6e.1
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374210; x=1718979010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR1S00rLmo4qiA6mmDkawsxIbLPj8V+j1BOu4ZxxiAg=;
        b=W5IJZK9Q6ibXUD+LP8j2j6pa36GZKtvddumNrwi1CSsBt71OQXECcv6xtcHns4lEbF
         1zEceOyh5tXSG/3MCAmNQb2QG4n+QX6YGHEbPhOo2UIoj3ZeIoxGtfYS5Ckts9UEe1Yf
         By9QdNbwyL+gTX0pO9ThgUfdYjGIunE5JcelptVEfE4v4E+MJJUf78dSv8G5K8ovLlWQ
         QxVwS3zmDzcdjsNwRZDqX/omdVLJV34DC8Ny1dFQd6nwM4hYJ04NMJX0RY8HaBxzRVfF
         xtPW8yxxxa04yU1ia7lIAJ+03iGeOfSoOWGc/9ohJOoczwcR5lCsZJ0Q/P4saTxzAX6p
         JcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374210; x=1718979010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RR1S00rLmo4qiA6mmDkawsxIbLPj8V+j1BOu4ZxxiAg=;
        b=JtmloO1gOMjE0UlXdGKXrPMyNHdiRIEFkW+mjGzZtUu8VCrqG+NxQDR/XjaeFZxcX4
         FAtSHXbakx2uMeeP4dT32nn3VDNnKVhgwPcO/7ZXb6O5dwT2KG8ODWNqYpMOsA4Jc/48
         A+L22WvR+zfvdY0eToRUIiyn8/haBHyy0fO90aSBEjwKw5iy3zd7618hlRQndTnMs+eX
         ERtA5X3DBIcW578ueJzj+AVP/ut45/k10mYzdiCKQZvfpuV8UYAomkvQtWntEgD5O4HV
         Ss/T+tydUgpbJ7BfBTOBqV926ygJR+SQoJqJYaq/XfSmBJjKRXZbe0LBrNaSnQ/CodAo
         MHzA==
X-Gm-Message-State: AOJu0Yw0fQ/BLAZqOxtwy1AiHup0HQfrGoBl/Xtpvwma4jrQRe9uBgd1
	L1RMpSZWGj8UA8KbyHRH9nudkHuRGJgmC+HPOEYUbuplknk00cj9Kxi0slPa4QYxkasMRcEgLnp
	9ukGKJgQvEr4xhzX/D2TVEYUR1Un2kg==
X-Google-Smtp-Source: AGHT+IG9JU9RmO8MoDU47q8tcprjXk6/0FHHzRY8Al83I3aTq7+pfxgu/h70eQ7NHFzk0OqHluuej3zrey31xKb7riU=
X-Received: by 2002:a05:6808:1815:b0:3d2:17cd:5601 with SMTP id
 5614622812f47-3d24e8fb894mr2970129b6e.33.1718374210411; Fri, 14 Jun 2024
 07:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606095039.50456-1-lautrbach@redhat.com> <CAP+JOzQLqRBsnssdHwUJK8===J5sQ67hEpfE5i4z8BJCKgn65g@mail.gmail.com>
In-Reply-To: <CAP+JOzQLqRBsnssdHwUJK8===J5sQ67hEpfE5i4z8BJCKgn65g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:09:59 -0400
Message-ID: <CAP+JOzQ2m_L70yBsjobd9C=kg-tZCe5yqQ7G95uRGS2SWFe3rw@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: drop unnecessary \ line endings
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:14=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 6, 2024 at 5:51=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > See https://github.com/koalaman/shellcheck/issues/2769
> >
> > Fixes:
> >     $ shellcheck -S error fixfiles
> >
> >     In fixfiles line 189:
> >             # These two sorts need to be separate commands \
> >                                                             ^-- SC1143 =
(error): This backslash is part of a comment and does not continue the line=
.
> >
> >     For more information:
> >       https://www.shellcheck.net/wiki/SC1143 -- This backslash is part =
of a comme...
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/scripts/fixfiles | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index 166af6f360a2..cb50fef3ca65 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -173,10 +173,10 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> >         test -z "$TEMPFILE" && exit
> >         PREFCTEMPFILE=3D`mktemp ${PREFC}.XXXXXXXXXX`
> >         sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
> > -       sed -r -e 's,:s0, ,g' $FC | sort -u | \
> > -       /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> > -           grep '^[<>]'|cut -c3-| grep ^/ | \
> > -           grep -Ev '(^/home|^/root|^/tmp)' |\
> > +       sed -r -e 's,:s0, ,g' $FC | sort -u |
> > +       /usr/bin/diff -b ${PREFCTEMPFILE} - |
> > +           grep '^[<>]'|cut -c3-| grep ^/ |
> > +           grep -Ev '(^/home|^/root|^/tmp)' |
> >         sed -r -e 's,[[:blank:]].*,,g' \
> >                -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
> >                -e 's|([/[:alnum:]])\?|{\1,}|g' \
> > @@ -185,19 +185,19 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> >                -e 's|\(.*|*|g' \
> >                -e 's|\[.*|*|g' \
> >                -e 's|\.\*.*|*|g' \
> > -              -e 's|\.\+.*|*|g' | \
> > -           # These two sorts need to be separate commands \
> > -       sort -u | \
> > -       sort -d | \
> > -       while read pattern ; \
> > -           do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/nul=
l; then \
> > -                 echo "$pattern"; \
> > -                 case "$pattern" in *"*") \
> > +              -e 's|\.\+.*|*|g' |
> > +           # These two sorts need to be separate commands
> > +       sort -u |
> > +       sort -d |
> > +       while read pattern ;
> > +           do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/nul=
l; then
> > +                 echo "$pattern";
> > +                 case "$pattern" in *"*")
> >                        echo "$pattern" | sed -e 's,^,^,' -e 's,\*$,,g' =
>> ${TEMPFILE};;
> > -                 esac; \
> > -              fi; \
> > -           done | \
> > -       ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS}=
 $* -i -R -f -; \
> > +                 esac;
> > +              fi;
> > +           done |
> > +       ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS}=
 $* -i -R -f -;
> >         rm -f ${TEMPFILE} ${PREFCTEMPFILE}
> >  fi
> >  }
> > --
> > 2.45.2
> >
> >
