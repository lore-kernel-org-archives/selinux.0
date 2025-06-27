Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E702D3207
	for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026393; cv=none; b=WgAyH1GdEwtgPbfMtC+sDIiuhLGv9mv0OesHrOvlxvzoyfeEv0mle9v/axnIaMuwsJdtRnz5HQBog6tVufVmauR+a+Jkh9tLNd4JOsJEMPEkj/9nqiRNF47C98YWVqFjM9e6h3Cfpnx3u5r4D8iOXGV8gEcePrbZQh6HOby5kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026393; c=relaxed/simple;
	bh=I0IydMOqWjoy6gJVO3ssyVrUT/32yleJypqy1TClcPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWxx+iipy6TDqqTFFQzv7OMmsKcx4QOITcA0YIyqqMYnFcUQ1tlWaCm1bpjkhKhxv63yHz57S5DNRUTRa+bxzEaM+LjvDafUJa2iRUdJKAJcdHrw1g65zcHSJ1k29zwdLzfH7sSLkRSgGSx/I5/Si2sniWISsR/lUpDSOUrlT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzDQUnbL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzDQUnbL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so1892363a91.1
        for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751026390; x=1751631190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn36ghHUWnf8O4bsX+u4V9ld6ziC1PIrwDC9BEFYAA4=;
        b=UzDQUnbLD6aJ1tWi0NEp+sscIrOh2IM61R5ZEp6YcBGnPCO6a8w1ENvJ6jrX0alLa9
         vx7zDrlrhuwbPZ8DhcJwBNlXBTd4dLL8tFdLAcgMNOv2v5gW43G/2/HhRSSnLOe6QlcP
         WrLZ7cmBMd0nv0grPM6looYUKARhlJoHxAZ5Xkvakfw/Vq1g/BHbcwyy8Bjf8B46dR5g
         L5AmVUOnUfi7jJlsaKLtoUulWjDIYrP8wG4SLJk0f2poaJELGoj8ZEX5jMyzWJ5p1VCp
         KnUbxNd9kgwjWcwqJ0kSDgR2n1gS5E7I1moLnP1J+jZ8TmW394xRd9ePa0uOXRQKJUkQ
         OQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026390; x=1751631190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn36ghHUWnf8O4bsX+u4V9ld6ziC1PIrwDC9BEFYAA4=;
        b=Pwi54nOqWb+SyDTpvF5Wl6Yt8Ur//ZbdYzBp2YaaqAlsOj0RxBJtd0+sMk/5mVmogK
         U/ItvP1D/RbOdXjRe1d9x8lM0R52t0QN8re7N3mPnyWkTEeXCaaMeBQVzggGqFC3BsM3
         ZddZE0NzKyfvng8NcLjgrvNsoBxqxeufwwmh+PkzoPRK7ezTokBLW0Q+jgUVG8NQU/4h
         WJtMx+BghXF9jzgvebxwkBB2vHEkBQmcTsjOsoZEvj+/F24KOE6lQVMLxVd/+r1eW4I4
         fnszhlGtlqH5BL1odqCaxUNz1Jx5F5LmfF/qHsnVkZVTa6StR0fW3Nd9aKsuSXf/PIvR
         cQqw==
X-Gm-Message-State: AOJu0YzbO8LVmlfHrsIAH+khwHOmk5a/RoqgiRchOtjPUZdi+1FDFx4W
	LedUy7OB6JnzMTpDX64WM0M2OnVXftBscgqD/8rn5y5HyrogkcDVYmRfWPV6qU9z3Db8Vjpx9lJ
	EpYidVecdUKRXMCXymhpCAKAhpDohypQ=
X-Gm-Gg: ASbGncuhMkZ/Q+OWboswWY6+KIDnwRrmDYd2uReQxSS7eUqc2A9jw5ZS0sT9mo4zDXo
	WuEkN9UwntdAkmKOdDNUEPJ9udIMu3Ci0RmjZ0uViScYFh3pVxKfiEqNvW6fZNCX6XXBQUGNt/z
	AMhjnEOf/I/xVamid/FmdfpTbt2ouiOkumzwn49AqpUDk=
X-Google-Smtp-Source: AGHT+IFfDobKXi1kXtHt7jPjyMrI3bzFPQ1sg4TE/JMxLmrzDnFsJQU9rjlQGBvOxBUSXDRzJBqSs6y+fPZjLFWZQak=
X-Received: by 2002:a17:90b:2c83:b0:312:1508:fb4d with SMTP id
 98e67ed59e1d1-318c931997emr5162586a91.33.1751026390026; Fri, 27 Jun 2025
 05:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626155755.21075-2-stephen.smalley.work@gmail.com> <CAHC9VhSMC1Kvj4RtNXUB-Yc87Vdifb-G1009LDhmy55hkW9Udw@mail.gmail.com>
In-Reply-To: <CAHC9VhSMC1Kvj4RtNXUB-Yc87Vdifb-G1009LDhmy55hkW9Udw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 27 Jun 2025 08:12:58 -0400
X-Gm-Features: Ac12FXzxA4kDy02usqEMxKNGmSIC8Y1nKIMmk9V2XSs0NcBLkUdnSyaoJZagX0s
Message-ID: <CAEjxPJ7V+HtHCX0dot7ZNKD+tC0a86OXuCezk6yMo4PvNRccSA@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 26, 2025 at 11:58=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > No hurry on this so feel free to wait until after final release if you =
like.
> >
> >  SECURITY.md | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > index 4f624f5d..2fee4927 100644
> > --- a/SECURITY.md
> > +++ b/SECURITY.md
> > @@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the disc=
losure window.
> >    *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 6=
2AE
> >  * Paul Moore, paul@paul-moore.com
> >    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7=
C8A
> > +* Stephen Smalley, stephen.smalley.work@gmail.com
> > +  *  (GPG fingerprint) 5073 3D29 EB3D 5CF7 17AB  32FE 100E 57E3 3B8B 5=
4F2
>
> I'm not in front of my system with my full GPG setup so I can't verify
> this, but we should verify this key to ensure that it has been signed
> by others that are trusted by the SELinux project.  We want to make
> sure that Stephen's shenanigans are actually his and not some other
> Stephen ;)

Happy to confirm this in some out-of-band way, maybe at our next
project meeting. Unfortunately couldn't do it in person at LSS-NA this
year ;(

>
> >  * Jason Zaman, perfinion@gentoo.org
> >    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0=
EAF
> >  * Steve Lawrence, slawrence@tresys.com
> > --
> > 2.49.0
>
> --
> paul-moore.com
