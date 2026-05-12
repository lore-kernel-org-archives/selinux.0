Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41683EDE68
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609187; cv=pass; b=WUEu42YjCQYr+rwfqKdTPHUnMkMSe67I7lCrblNBSE7HAcr7k1AApF9WOFL1hKOoAm12pi4rUDx0Ayg7vNJ0eDv4kTsghmZ9l6dW/rC5j/gz3xackvuETn0+gbd2oRG+vDlvOU7s9umzuyHASYY4+JUt5t45c/Ibrq/7IXhuItw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609187; c=relaxed/simple;
	bh=DOGqpU+U6yn9yFezDB/pjTkLwbsezMB4lsCS8zTcSmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZoum/fjT90HSZm7sSx6WdBKQ44MOWyl/9vEMsVRAv6O+7y/nSizpmlwUbIllRLhyBJ1NvPX9iGtCD5OM+YfyqlaoSjZ10EJymsLRonL9yUdKA6dX1Xo4KysJThNIoA2Es3+8tBd5YY+HJoLFVA+p87qOaQ0Ff2OzOokbSsaP/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7hMP/dn; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7hMP/dn"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-394095009beso25610311fa.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609184; cv=none;
        d=google.com; s=arc-20240605;
        b=KpObktV1qtcMMbOagqLuO8XVm50yMmsIdQ9rCyitNCRt5SpNnOxvGl4QB+E7QAGcDf
         UhCYcuWqlHV1q1IwokXnmI2SfCmNUaPHvWLhEy1HZc21DeEf0RHd5lPqaP2LEQoqIsMt
         QzzrUi6l5LsCjxj8q0t9xcvMjI9tFGdh9xLC7HySpRpt0fsHd7tmp2U/vYqSMKYCa7tl
         SxFO+k15lkAHnPXW5IRD83ppPJbniHZkJK5cPND1czLTn3btpc3kERAILRAdUuB29yP6
         eWFRaJKHxALmMNGXId++fW+A6TP+Iaqe5+ANgIrD+3Dl7nLYDEqcK88LmP2AP4QgqoBx
         eFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pq0Db8IswKhWVxsUpPHom/KtbfcJVmBb/BSJZDubT/k=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=d/3EQRYCKFk/PMSwbCvdGACTwnPm23Soe9OllKKBiPVJ2M5MYoIqtrbg2SKxQGMRqn
         UNGQimoGV8GhzOKEH1oIQPWdchpBosNPkP6s8GtFMJz+nZIWdSZlDt++RS94uKfOerEv
         31/3/Pv0CVNhEQkV8ox5n7ehJQQeur8sS167q0T5NT+v0oGCD122II2XoCq/Bvzw79Ci
         onLBn4bacjBI7KqMIFYdV3fqk2RJs26fNQoD9n78/OJak+yQ5FmhL9BbknWONNl1Xf4p
         ClzLX8eTqM2+9SIjwLFF1k2do335wt/mtLltFGgvny8AUEjd7szdf0UJaCobTEiP4t3W
         cOzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609184; x=1779213984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq0Db8IswKhWVxsUpPHom/KtbfcJVmBb/BSJZDubT/k=;
        b=r7hMP/dnSB2Eo112qIR+TI/y6cPLUWSrA6YHVo+Wfy5kyU4H6TkYxStE6tJqqLdUAi
         08vzz5s7PzwVA979SHTYKR+3jwLU4XO1JFvfqg+0G4+wB2aVGE5qRugoEpMYl6Q+6rjC
         H1OYmCQv8IUMYUNzPZ3OUyzTrlloULo69CkVhkPjif2+wifZc+jTl/zEvkeUXBwdaoE2
         YUMW8qlF9ljAze7sNbxlA4d0bySbUWF4ywMPfNvgWLtAl3V1lkHhsxROZfW3e51QV28v
         cnVlQQk9TR6G3/VmRVIVwmwQBWORHySNAT39S5WVuLXgcUK7Xm4eWTXktZzzogsUz1Ev
         +dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609184; x=1779213984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq0Db8IswKhWVxsUpPHom/KtbfcJVmBb/BSJZDubT/k=;
        b=tTYdZfBaw3wxSPJBzTrhB+VH1ZDQjGgxUqplPjhydbI0uDRb++vWIa0jhUc6jyVDbg
         UO3f1ZbfP/o47cCjYKke5zTDVVjkExJqk8rQBP6bMurFCeBhCSuNdraSV1tEoBKIyDbM
         BCoVP4ess4Sz5QREaacE/OyYAzr60gV45RkofoVqUW085I5qdDtV/r80FFS9Kg7+n4+c
         UDPFtg465ndUYWqs8bRD3l/zDl1ov9Ol1BX0C2eT9Gb8+DLvyhcHTLgVTqSB5x7Hq1Zt
         fQYxs2izz030ISkInhPuWmpBcK/WJjLRa40gJEveW3ouzznC5bA8tX2yN3TYPRls9D7y
         CAiQ==
X-Gm-Message-State: AOJu0Yzk9tGb5Z59opTmqIP2u6WhUPulbPs6ZgNRrYDkZRW97ttS2mvr
	030tPk+KeaceiE0NjBUMXdmxCCuo0qiM6biNud103P6m9u94bBoWhiGAoZ69E5szXaMIrZlyJsr
	g68IoaTFGFW34Vr0sKaCIEqeavu6WcDwGRQ==
X-Gm-Gg: Acq92OGUllZBLaqOQ6Tn0Sg5jGT863SJhnN9bNDCNACDSIjIdsZStMzKkmWbWEvO6qN
	YRxoRn6BxWMsd8OMuzD4paAlFa3rXXZNyamKqk1fgyL0HyCsxFEHl9oPqtW8FQaHe7Xv9HlhZmi
	x1fE6w2nh7MLpJ4jWPWyRLl5L9AdGjdew3o14Bmj1EwmaGv765YWfl3jjawStmFQ3zF0i4jIKma
	RU0zuZz+40bj9mUtypUsuZkwm06JjyGTgEKtnvsTWXfbfyPGQLWPXsS3J3g6j9bAZMlEmI6XdL9
	zMJmyCn20Q9x0zQ=
X-Received: by 2002:a2e:bc03:0:b0:394:1e7:6448 with SMTP id
 38308e7fff4ca-3943ce74fecmr14909191fa.29.1778609183880; Tue, 12 May 2026
 11:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309165432.3137132-1-lautrbach@redhat.com> <CAP+JOzTPFyYRK40QFfS2Yur3r0ZnGy05zH1BDU8fQzo2hUpm9Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTPFyYRK40QFfS2Yur3r0ZnGy05zH1BDU8fQzo2hUpm9Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 14:06:12 -0400
X-Gm-Features: AVHnY4JULAQOSgH87nZkwvfTAfBZGCbtt_SF1eRATwQD_XEEe41L1-DAVIcWvt4
Message-ID: <CAP+JOzQscTzkaxx66C6b6d+t-9vzgbNenQm_2rY-zXV_CCRmFw@mail.gmail.com>
Subject: Re: [PATCH v2] semanage-fcontext(8): improve -e documentation
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:47=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Mar 9, 2026 at 1:02=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Document that substitution based on another substitution does not work
> > in semanage-fcontext(8) man page
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/semanage/semanage-fcontext.8 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/sema=
nage-fcontext.8
> > index a29b74994763..b037491e3394 100644
> > --- a/python/semanage/semanage-fcontext.8
> > +++ b/python/semanage/semanage-fcontext.8
> > @@ -67,7 +67,7 @@ Extract customizable commands, for use within a trans=
action
> >  Remove all local customizations
> >  .TP
> >  .I   \-e TARGET_PATH, \-\-equal TARGET_PATH
> > -Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is u=
sed with fcontext. Requires source and target path arguments to be path pre=
fixes and does not support regular expressions. The context labeling for th=
e target subtree is made equivalent to that defined for the source.
> > +Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is u=
sed with fcontext. Requires source and target path arguments to be path pre=
fixes and does not support regular expressions. The context labeling for th=
e target subtree is made equivalent to that defined for the source. Note th=
at substitution based on another substitution does not work.
> >  .TP
> >  .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
> >  File Type. This is used with fcontext. Requires a file type as shown i=
n the mode field by ls, e.g. use 'd' to match only directories or 'f' to ma=
tch only regular files. The following file type options can be passed: f (r=
egular file),d (directory),c (character device), b (block device),s (socket=
),l (symbolic link),p (named pipe).  If you do not specify a file type, the=
 file type will default to "all files".
> > @@ -94,6 +94,10 @@ i.e. label everything under /home1 the same way /hom=
e is labeled
> >  # semanage fcontext \-a \-e /home /home1
> >  # restorecon \-R \-v /home1
> >
> > +If you substitute /home2 with /home1 from the example above it will no=
t work. You must use direct substitution
> > +# semanage fcontext \-a \-e /home /home2
> > +# restorecon \-R \-v /home2
> > +
> >  For home directories under top level directory, for example /disk6/hom=
e,
> >  execute the following commands.
> >  # semanage fcontext \-a \-t home_root_t "/disk6"
> > --
> > 2.53.0
> >
> >
