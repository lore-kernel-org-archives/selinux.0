Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9626E17D
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311736; cv=none; b=jrv2Z+K5x5JjD753zNH+rfoBCajfHUdP2cx2iD1ere+bQEH5CDyVIPPNkwlDRT+eAvZjo2/KT8Oz6PU6/r2Q8sbTtzCOFGbZw4YIWDuq0L3BTj89EFvi7BAi+d6ctV3sFs5h6Q+jTKjvx8jJo4bHft19j7HT62FWxXaBcSWnPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311736; c=relaxed/simple;
	bh=sMebuIP3tHzTmFaUZ7PPOw2Valp/rAu5dIZM6eJtE5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFMZl2q2mdDBO2OOg9CQT6P03DGbX9fzeD2gSVI+JRqJSxWZQiUd/cLf589QJfit3ivEJ9TyhPm3i8H0nLRyxWl261b0YF44/LkIAWER6bMt/3PzrSIerEZtvFFpIfUlbOZGNMS3yg43yP+aiSUkEUCQQCTokRhOhx4L7g5C//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JspP43dr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JspP43dr"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso4099998a12.1
        for <selinux@vger.kernel.org>; Mon, 04 Aug 2025 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311735; x=1754916535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F05Y1QMC4YpOb/aWkWG6SrOJ0kIjkod+ub5AByhZsM=;
        b=JspP43druw+5NP231kr6V3OTOz5UqL70JrRq59ZNvu+PZFiJrtcJI/LkdP36p6wIGN
         M0HXxOsniEMniD7lBMnRuIlwmTtzwIWgU3DFQRIL1bJ3cE2FITMO9q7GRd7jQ8UbbTXQ
         PQWJVq0PZ/JWWHA3ahFxDVfpvYYBPjxUYgEROi7RtW4LicdX8x3AT/DCQLEhkTnAldpj
         BL0s3NcnbagqLnn1u06t+fpwcd1v8pxjCHX7LmDNumDuZ04grlhwWRXdYI/HGvy03zf8
         +4/fWaJ0W99EYGnl9/aNp0/ia58Q8IFT9z1TMFlcZw6VBYGX+6zaa87P2q+Z1LqkGfmV
         jADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311735; x=1754916535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F05Y1QMC4YpOb/aWkWG6SrOJ0kIjkod+ub5AByhZsM=;
        b=AxT+1S8Jko8VIweVM5NSQeD+938Yh/+jiObpKNdabcXb3CjAd2zWRsfmgDvawiqE1t
         8N/fng2z3VLCUFX9CtwMeUHMI5yiFU24ljJClw4c6MHpVBcfkQCkH42P3gKDli8rI/jY
         lnoW0LWHGZ/QTuTteGLDDL5dYrvZy4lIKcPDZKnr5bcMsn0us0nb5ONEYzbR6wK4JkNa
         xcYmDjvpXWC5PxpNvg/bwqC55tXwU0+k1CydP+ymWr2en0mJg+NZdfrLyGNOeuuIuy0M
         5kwlb+bm9VGsb88tVBvmolwQVZoOoMl/InzRnYLn0BjC4HiwKmb71YGGYN74AuGCZ4vH
         BF5Q==
X-Gm-Message-State: AOJu0YydKQV1Mz+6OROrU93Uj9YyKveQTQ5rYyCJdoiQL34EnJPANzfL
	urnupG0n/J3D2HuT9LpUotegYiLna4NpS7a8XmrjJRzmQCCRDaO39neI28jPzoJrlZLom8RnVFO
	dxAJdtQwTobRLzP7h5WnWSKDI5moqFTQ=
X-Gm-Gg: ASbGncsPrgQgkuIx7zXvmL1y6ZldjmcefOl88bnnjgWPQd3+EC+NE47l6ZvtHBRZOG3
	tb8bHJBkPPcol5JEr42HpM/fViCXXblPqRRZpNQ4N+tmaiWiALTHlNn0ZftM31DDuASsvJ5+5Jb
	lklKA3qbvp3taFHhqh/M44HuJOL30jrX1yrkH8q9sVrlyx3IIk4olzxGeIUmMSuk21g1sTJtcXe
	TRhexs=
X-Google-Smtp-Source: AGHT+IGtjgLMFiIKkcWtuvrHBWDm1FloP8Bsjw8FE0qkt46INDn4YsnZMlz8/FVyPst+qlxKJ2HpVovglsOoZOEX/gU=
X-Received: by 2002:a17:90b:540c:b0:312:e9d:3ffa with SMTP id
 98e67ed59e1d1-321162ccb3fmr12203771a91.31.1754311734702; Mon, 04 Aug 2025
 05:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723182550.1065144-2-stephen.smalley.work@gmail.com> <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
In-Reply-To: <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 4 Aug 2025 08:48:43 -0400
X-Gm-Features: Ac12FXwMAbYlnLa4NtjS8GArl_-5GJ9ARp7k1O1u7jkXbbwb7uQoC-3CF_tVqAg
Message-ID: <CAEjxPJ7SAJKdZDqdP4jj5i7wjNhJDjV0+8LyC3TQPVWNV4ZmQQ@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: add my email address and GPG key fingerprint
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Jul 23, 2025 at 2:27=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > This key can be downloaded from https://github.com/stephensmalley.gpg
> > or
> > https://keyserver.ubuntu.com/pks/lookup?op=3Dget&search=3D0x578c4211832=
f0a7ea2c5a7c221a46e603f744ecf
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  SECURITY.md | 2 ++
> >  1 file changed, 2 insertions(+)
>
> I have verified that the GPG key identified by the fingerprint in the
> patch belongs to Stephen.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Gentle nudge on this patch, since several others have verified and
signed my key, and I have uploaded the updated signed key to the
public key servers and to github.com/stephensmalley.gpg.
