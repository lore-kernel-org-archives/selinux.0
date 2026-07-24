Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECD41D200
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904266; cv=pass; b=VRRc83sleyg/Rf0uIClEmcjL09LDK8OaLoVqXs246r1zQxgtIq7RkktXd2pcV+e1THpFR+CNs+DRdB+gYIAnlW/Uyjs6MWxuboSWLMHzos0aqpVGmp13CR6zJESBWLQH1uvq7s/liDXiBhNdxN8fXi4ESxu2xxEUva71tC1HBIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904266; c=relaxed/simple;
	bh=C6g+QBonlPmEb9poLGtggy9MXVnxrYjWSfkf/U0LUsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxsqPzUvfQtrdREXpBt0054/8bC9eRSTjMit5VSAuMtPip7OHwyjVpFI11mGIsBFL+K7xYoYDuk7Z2hUugY2WzsVh7g4ZtZS9Q004tWh9jluttw48i0PcQyD9TH22fNosln1YdlNyvsGm41FZnai1k5kBHp94+t0BRfu2QVhDRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJGu45mE; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJGu45mE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfa429aa6so14521851cf.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904259; cv=none;
        d=google.com; s=arc-20260327;
        b=SnoDy2RAROeDnCZ/QbpTdaBnyXvh4sXjhRxCGSoVMhTkbLb6m1ucj21SYbyRUyCLAN
         Nc3LlBprqkplAWEYjGWwSAPzzNO1XFMEj73feJ+V0wlCqDHcgf1nmR92Uevtxqa+V5AV
         P7pAzdEtH5eQPFz5uqgoOuPz5Lkf9iAeVmuV4jreVgpxacH6ADST8QI5N5a6/BHoXCRF
         gz5m9UOqzhBgm9jBKvHDMVyN9kyjOLRchLY8rL5eIuTCBZBGEFo7QS1HyXKrwrS8zhyB
         Xe581vgdFzF0JwSQND3XB5HBoAohTfCEbQFbRrKdxXKB+sqGlpJUEabR2kgQ8i/fQhwi
         X1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3gvMx1VdO3DNH74GSGJe2Z2kaa2qOe36getPRx6q8c=;
        fh=GeJFfy1mgA0CYqJkxNBhbqhh0dQWMteeu5mXSYbSZds=;
        b=MvKLyn5swAAfEZoyF+LPp/XKeFKa0bkQTZuetWhd4gu5oIC2wfFVupudq1RYUQpKCz
         iUqlOHzl4Q5S7OmW09aRAXFPu5MrQUIpcpObSaRCfmWB940PrLZzcaOv1yl5qLXW9U1e
         fIjYLu67UuBBP7v1qdqZu9/Qe+USQa66mmqw6fL7z3PWquwyLgEXgEVhotVd/WSQjRB3
         uhxZUr55vAYTZb5lSbao82nw5Op6wwpxhSGyS3ioHfRQ2a7eNDqV3AVt11bd3gjxvjCx
         Ee2/RkkQWTWaYoBO+YZSHB9BMOvfSVeqJOfro8OeNQcy1mpdtB2BYLWNKy37bG8AFstB
         CcBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784904259; x=1785509059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3gvMx1VdO3DNH74GSGJe2Z2kaa2qOe36getPRx6q8c=;
        b=hJGu45mEExQp1D91SuWVZxOXnAdpcnKFU5UVDG6ixj19QoyUuM/FWrQRFB22seh3Sl
         X6QV1DdMwfKp8HD6V3+e+PsTHTwcIaiVMQEyGB+fmqQo1ZDhPAU1oL/l/D9K+NeHZFr5
         Ci/KvzgSu7Vf+caPNmohj2Dav7eTKwhfly8HcJxcmmS+IW6Bw6zaHg4ANN2DdVYD7aPr
         /GyALUReJlB7iGvaMdfTLRgRG/3K1KzxoPJNSKso6X/zJyMNfE9CcnD+1fXL5QSeRA8w
         yCGusLgCwADjWGEGX9gQzIMqRdBqzKiQYUageB6vc68cGv7zPeCUaR1FkWQc/V/1oqCw
         L1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904259; x=1785509059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3gvMx1VdO3DNH74GSGJe2Z2kaa2qOe36getPRx6q8c=;
        b=lq8vacKpMrZAuWVmXtteOcHP3M6fMzZ6r3kxwXCBhm48pfRLb+J48QaXVmm+f8zSeo
         GQYrqYm19Lj3AVatsBrSjddU1Am39HEJEmpQ4lj/6LuJFdVXoggkCkIvn03FDrZ6A5OE
         JD25CF+6/JycOE57CJj/bTjUSpD938TW0aSJSeTfkK+6RXrVHfY70WySJbk6nkeTOfXx
         +a1HsIhg/AErt9W74218eb3YdHdwQ7xcwN8T/M7qnzJi/x0pqLEsquGa/0kmERSqlI//
         wyqgAmihF9WinIBcawPL44ZzXcgDnK8LUtB6GLJ5jBybSPLWaBDNwCNdGFSCwEHFic44
         e/Lw==
X-Gm-Message-State: AOJu0YxYbsAVfruF35Gj4+evqBOlZo5KoKBiyCusU6gnxapJjfAfqw0W
	FngJO3unY0xhGNkZirx+FYoKGSB1nJSc01O3I7m3oIpsr7UKc/+rhPqzcMv8ZHRntUNZu7rR+Wt
	CDuUKn9iwPgFPgB/+xSe3ga4RIARr8Yo=
X-Gm-Gg: AR+sD10WIh2pDmsHgChVbg8sA80+HP5/DvTd9cI5EPnzKFhAfDKnx2rejGL/2i+aDOG
	iFYPUKFzlGVPERIkOsqbNpwuUAk+aqAoWEUse1FB3aqREdDsLQWgKnDVgokxRDoK4kkSsm4H8Gh
	z0emabFM8+psum4WdAdzA4X21H40tXSUuR95Wj92F/UhSfoncfdEXsqMGjkFCsATF+mSupJXOFI
	r9pZUKcllDtsDNQ+kC5hyOG2is5OCg3/pDz2tFvpXcKuZNXTIW+lJo0Jn6SGhuNSaUZa49B
X-Received: by 2002:a05:622a:2290:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-5295d270a1fmr9819181cf.2.1784904259260; Fri, 24 Jul 2026
 07:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com> <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
 <CAEjxPJ6pKtPU7ozYg6D_OaVe7gLPnjT+Azw+gZygNT6Tj+W5Cw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6pKtPU7ozYg6D_OaVe7gLPnjT+Azw+gZygNT6Tj+W5Cw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:44:07 -0400
X-Gm-Features: AUfX_mzqkTRPOTj9xJ7bhKnmCejjzxXJvD6cjBlz4ne2N8FgR7oy4o_1dgEbj50
Message-ID: <CAEjxPJ6Ca5L0tHesizLcK3ouy2p-t9U1-CV=TXyAPUfztx36rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 6:20=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > On 7/21/26 8:53 PM, Stephen Smalley wrote:
> > > Add a pyproject.toml file for the sepolicy python module.  This
> > > required also updating setup.py to avoid defining author outside of
> > > pyproject.toml, and I further updated the authors to refer to the lis=
t
> > > like libselinux since Dan is enjoying retirement.
> > >
> > > Fixes: https://github.com/SELinuxProject/selinux/issues/505
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >   python/sepolicy/pyproject.toml | 19 +++++++++++++++++++
> > >   python/sepolicy/setup.py       |  2 --
> > >   2 files changed, 19 insertions(+), 2 deletions(-)
> > >   create mode 100644 python/sepolicy/pyproject.toml
> > >
> > > diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproje=
ct.toml
> > > new file mode 100644
> > > index 00000000..472faf7a
> > > --- /dev/null
> > > +++ b/python/sepolicy/pyproject.toml
> > > @@ -0,0 +1,19 @@
> > > +[build-system]
> > > +requires =3D ["setuptools", "wheel"]
> > > +build-backend =3D "setuptools.build_meta"
> > > +
> > > +[project]
> > > +name =3D "sepolicy"
> > > +version =3D "3.11"
> > > +description =3D "Python tools for SELinux policy analysis (sepolicy,=
 sepolgen)"
> > > +license =3D "GPL-2.0-or-later"
> > > +authors =3D [
> > > +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org=
" }
> > > +]
> > > +dependencies =3D [
> > > +    "libselinux-python",
> > > +    "libsemanage-python",
> > > +]
> > > +
> > > +[project.scripts]
> > > +sepolicy =3D "sepolicy.__main__:main"
> > > diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> > > index ca0396b5..5c4f2e5d 100644
> > > --- a/python/sepolicy/setup.py
> > > +++ b/python/sepolicy/setup.py
> > > @@ -8,8 +8,6 @@ setup(
> > >       name=3D"sepolicy",
> > >       version=3D"3.11",
> > >       description=3D"Python SELinux Policy Analyses bindings",
> > > -    author=3D"Daniel Walsh",
> > > -    author_email=3D"dwalsh@redhat.com",
> > >       packages=3D[
> > >           "sepolicy",
> > >           "sepolicy.templates",
> >
> > lgtm, or at least i don't see the warning anymore in the build system
>
> Thanks, both merged.

And both reverted since they broke the testfarm build.
Will defer to someone better versed in this area to fix this.
