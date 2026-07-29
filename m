Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8047ACED
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330628; cv=pass; b=prZo/lCINe/JZA8pnHJoJatgc6iC20RPFbfxYVSOEumB9E8fC+uOqFPpoQQf4cQcTLEqduBYeThUj8KLAUXerILnDV2UcpAZKxoAzi0XDkyy0GykguvYzhB7C4Y+Co6zB1tsTRPecMgtOXp22VL/mZ/lMv8bYMTMekFEz8enGBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330628; c=relaxed/simple;
	bh=IEx/0JevipfkxAfSVrxErPSo31dpxJbEZDSGYvH9W3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE4QY2f7U5ooLe0JG7zE4m76OBpR1RxXvUJqzDiV6tJWjjc/txNpZlCLv/zngnAx+S+kviBFNxjhv5QlLsOcAsJbwKY4an8lMJt8NWhJeoqdU+Q961Nt88YeQwwO+S4k0Let8Xwcn6nv6ftl+2jnQiK2b7blbkdJSqQ2pADptYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw/3/CDT; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw/3/CDT"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cd237446cso545301fac.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330626; cv=none;
        d=google.com; s=arc-20260327;
        b=JBOVo/4ndM7jlnbU9qERaM4YDeNNq0+AjDsfCR4If+EhB2YRwE42Mtx36/JXo18UUd
         Q10xkUF5mj3oMzwUhPNjpmL9BeH78FoYAr9etkc1ketAelIeFTg3XX7J4ExxsvgeRh4c
         vrvQKftwBxDCCQRqeJ1YALVsdlbcF5Ew2TBd2nyUuhyYytMyKg/JCASzsIcP4Tf7qUzk
         Ee2xmZvoQrTNX5kTVmf28XuT9ulCNGzo0NMd2g4qTjbN+vnOoVjC+4sVFaZFt2Eyu0uO
         rLaGa3HIMIz28MGjy08y5t89a3PMbAwZnuvtSkk2Q6N7EYIgDwgnqlU2M4YlGCoc+Cj7
         UmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xh5mPcf6pEYPXWC0V3rBxhy+aifKst7wfHksPNi0g5E=;
        fh=GeJFfy1mgA0CYqJkxNBhbqhh0dQWMteeu5mXSYbSZds=;
        b=bXZx9VdzeKJiNgauyFoa6GDMeHeiWva5TdwGMMQ9UmQHs6EOZmi3lLXf/+EegINHXY
         sypkEYBKerBjRieTYQoAQc+Yw3zqSXuKNd7kQ03BnCnlLCvyznWO42WY5eWiK56AXrW8
         FPOSEnP9+hNGXgo2jO2dKmgt2JSs4g73EfMqoq12GitEs8lLoafA/S88TCzLECrrvn66
         0UAyKc3N7MlJ8tzHRl5trSQdYSR6+iAadEbdWUQCM2H2DRtgHUR4REw9lRAHfm1K5SNx
         uO0iei4eFx+kCTWrlkhTj1Z7IDR6NgPgm8Fs4X+nRI2jJxD06lIhUhEWqor4M83dqA4q
         fHnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330626; x=1785935426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xh5mPcf6pEYPXWC0V3rBxhy+aifKst7wfHksPNi0g5E=;
        b=jw/3/CDTJTIIpPq7CVKo+IV/ZBplxFVJGrUlSkgqAazIRDRKokLZqijPUGxqkcPqlq
         Cp65DGpV6JMlrqL/xyFICtIjz80De/NQTyDKmEO5d9nNbdoQ4mwA8o2Y/2CiYrjnegr1
         ZOKwsrH77/88X/Vd19bD1mx0j9FbL1d079AflsxVm/RFKlTtLc6e809JxFXCxzgnUU5f
         4xoTml+cZUfuYGlpjO/vHbwAB65rItpHIzMTL20XsIWU1SvzH2K/iUR2NL3OBxB175I4
         ZQ5buJ/3A6EAPI7cfP4jKMkIQaf/ElU4t+QXHQ9shWAHohzevH2MMMSaG/xXTQ2rL8py
         Oykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330626; x=1785935426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xh5mPcf6pEYPXWC0V3rBxhy+aifKst7wfHksPNi0g5E=;
        b=DM2sDurbf1l4FCHGEm18oM3hs/aEaMUZHFNB++HS+vnVLowBKAErHiDE9F54tGnop5
         OX2SBx2gTBLy+9djKe8fv0fnUsrZYVuGgOe1al0RdfQHIerTcyuzZRIGUvx2KhdFoOT0
         K6EfIPR7kkyyH8LZJXDV6jEAGdvXFCgl29bWDpZeuKjPNHL2/6xvzSM1YpgIFhZXZjvc
         NOoB5EJcQKixpjYwJD+9u7AVUBHpzwBtmX5PVfS8XmlqlXQUfIZOpLZUSQXoWWm8KQZy
         GFnVU0H+sD0IHvRZD1/L8Lk/A/VDZ+m9Uv6jQ9oy8qJxa/vUURnWuECSVDECF22Bt0ab
         zvuw==
X-Gm-Message-State: AOJu0Yw7idXbSbdOaur2GfjAROGx2B2o4fZhfoKsEVC1JlxNbl1jO0j9
	d3158Af+Es28eUdtzIPLjfXDW6onfsMU9X4l7xbx7SngE49ZdHcmMWlp3sEIwpra4AzwRT8E9h0
	pDuvnSwxVt7T57cCLjsgLDZoAEcvqBUCXcQ==
X-Gm-Gg: AR+sD11tZkXmmvyxkhi07qy0WFzF/B/Wzpsn5uC6va5sfCQd2srJUq05+EPGrXIZUMX
	Ne1tPLbwwnupzZhTLjUZP3YQ56vERe0dkhYie+f+6CbZReoxgdXZ4Sagk/j1p+QupBJGwolLExw
	PRX8glp2rdr0RVMulou9ZVCKaI3rxLAlTw/ukr+0LVsIlLK6nOvaeVHXnIYsJqdgReP/sfQVH3C
	4D05EJ2zUWki2leB8E0vkshfTcmDCHiNnbeIq0NmNn6+noOIpgBRi4LP6xJUyPQNW2kMZgF7CKQ
	nYfVE7vmLcScCQsRt0VW2sySJErZ1+nop3HrV6WzgQGP
X-Received: by 2002:a05:6871:780d:b0:453:9b2b:f3f1 with SMTP id
 586e51a60fabf-4586cc30650mr3561609fac.5.1785330625932; Wed, 29 Jul 2026
 06:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
 <20260724175059.18960-5-stephen.smalley.work@gmail.com> <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
In-Reply-To: <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 09:10:14 -0400
X-Gm-Features: AUfX_mzWv703XNBgdjUn7TZwuL5czZca8zBXjmUIJjYpMkeh3n1TdET3gPayvdw
Message-ID: <CAEjxPJ6na3q8JMrCRmyfs6vLyGRO54CR_=35hQjeNKVBDs1-pw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:39=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> On 7/24/26 7:51 PM, Stephen Smalley wrote:
> > Add a pyproject.toml file for the sepolicy python module.  This
> > required also updating setup.py to avoid defining author outside of
> > pyproject.toml, and I further updated the authors to refer to the list
> > like libselinux since Dan is enjoying retirement.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/505
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 drops the dependencies since those were breaking, presumably
> > because the libselinux python module is just called "selinux"?
> > I remain unsure as to the correctness/completeness of these but
> > they did pass the CI fully.
>
> I think dropping the dependencies is fine ATM, as setup.py also did not a=
dd those dependencies.
>
> The testing farm (https://github.com/SELinuxProject/selinux/actions/runs/=
30099962012/job/89503238013) failed i think because:
> $ python3 -m pip install --no-build-isolation --force-reinstall --prefix=
=3D/usr `test -n "" && echo --root  --ignore-installed --no-deps` dist/*.wh=
l
>
> and test -n "" is false (should be DESTDIR), so --no-deps is not used and=
 the dependency section is checked.
>
> In our build DESTDIR is set to the BUILDROOT so it was not checking the d=
ependency section anyway.
>
> >
> >   python/sepolicy/pyproject.toml | 15 +++++++++++++++
> >   python/sepolicy/setup.py       |  2 --
> >   2 files changed, 15 insertions(+), 2 deletions(-)
> >   create mode 100644 python/sepolicy/pyproject.toml
> >
> > diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject=
.toml
> > new file mode 100644
> > index 00000000..d33e78c8
> > --- /dev/null
> > +++ b/python/sepolicy/pyproject.toml
> > @@ -0,0 +1,15 @@
> > +[build-system]
> > +requires =3D ["setuptools", "wheel"]
> > +build-backend =3D "setuptools.build_meta"
> > +
> > +[project]
> > +name =3D "sepolicy"
> > +version =3D "3.11"
> > +description =3D "Python tools for SELinux policy analysis (sepolicy, s=
epolgen)"
> > +license =3D "GPL-2.0-or-later"
> > +authors =3D [
> > +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org" =
}
> > +]
> > +
>
>
> > +[project.scripts]
> > +sepolicy =3D "sepolicy.__main__:main"
>
> I had a deeper look and I am not sure if this scripts part is needed.
>
> Because sepolicy will throw an error when installed with pip only:
>
> $ cd python/sepolicy
> $ python3 -m venv --system-site-packages env
> $ source env/bin/activate
> $ pip install .
> $ sepolicy --help
> ModuleNotFoundError: No module named 'sepolicy.__main__'
>
> Because by adding the [project.scripts] tag, setuptools writes this into =
env/bin/sepolicy:
>
> import sys
> from sepolicy.__main__ import main
> if __name__ =3D=3D '__main__':
>      sys.argv[0] =3D sys.argv[0].removesuffix('.exe')
>      sys.exit(main())
>
> But __main__.py and main() does not exist, so it won't work I think.
>
> Probably this part is not needed in this case anyway because sepolicy.py =
gets installed "manually" here IIUC:
>
> https://github.com/SELinuxProject/selinux/blob/ad7efacea997ebad8c14b6472c=
ca58993a35d2d2/python/sepolicy/Makefile#L31-L32
>
> So might make sense to delete the scripts section.
>
> > diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> > index ca0396b5..5c4f2e5d 100644
> > --- a/python/sepolicy/setup.py
> > +++ b/python/sepolicy/setup.py
> > @@ -8,8 +8,6 @@ setup(
> >       name=3D"sepolicy",
> >       version=3D"3.11",
> >       description=3D"Python SELinux Policy Analyses bindings",
> > -    author=3D"Daniel Walsh",
> > -    author_email=3D"dwalsh@redhat.com",
> >       packages=3D[
> >           "sepolicy",
> >           "sepolicy.templates",
>
> I thought maybe the duplicate definitions (name, version,...) in setup.py=
 could be dropped,
> but I tested it and the (gcc,pypy3.7) runner [0] still takes the definiti=
ons from setup.py
> even though pyproject.toml exists because setuptools-47.1.0 < 61.0.0.
>
> Which means, it can not find the definitions when setup.py was dropped.
>  From the runner (https://github.com/ca-hu/selinux/commit/3a0836b98f846af=
3981081b87ab73e5f5ed3f97b):
> > Test .gitignore and make clean distclean
>    error: missing .gitignore entry for libselinux/src/UNKNOWN.egg-info/
>    error: missing .gitignore entry for python/sepolicy/UNKNOWN.egg-info/
>
> ^ see UNKNOWN instead of the package name
>
> Which makes me wonder if the author+author_email needs to be kept in the =
setup.py as well if setuptools < 61.0.0 is still supported
> and it needs to be backwards compatible.
>
> In case setuptools < 61.0.0 is not supported anymore by the selinux toolc=
hain (it is at least not by setuptools upstream), it might be possible to d=
rop the setup.py entirely for sepolicy and rely on pyproject.toml alone.
> Example:
> https://github.com/ca-hu/selinux/commit/3a0836b98f846af3981081b87ab73e5f5=
ed3f97b
>
> At least on the openSUSE/SUSE SLES side, iiuc we have setuptools >=3D 61.=
0.0 for all supported versions, but I don't know about other distributions.
>
>
> But feel free to disregard my review and merge it, it is building fine as=
 is on our end.

Could you create and submit a v3 of these patches after testing on
your end? I'm basically operating blind with these since I am not
familiar with pyproject.toml or setup.py.
