Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48JWQAs024525
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:32:26 -0400
Received: by mail-wm0-f51.google.com with SMTP id n198so19632536wmg.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:32:24 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id h29sm8571561eda.45.2017.05.08.12.32.21
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 12:32:22 -0700 (PDT)
Date: Mon, 8 May 2017 21:32:20 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508193220.GA7367@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <20170507093921.GA22381@julius>
 <9CD79E56-C6FE-44F8-B81B-1155356E0874@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <9CD79E56-C6FE-44F8-B81B-1155356E0874@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 03:23:06PM -0400, Karl MacMillan wrote:
>=20
> > On May 7, 2017, at 5:39 AM, Dominick Grift <dac.override@gmail.com> wro=
te:
> >=20
> > On Sat, May 06, 2017 at 07:19:20PM +0200, Dominick Grift wrote:
> >> On Sat, May 06, 2017 at 06:19:56PM +0200, Dominick Grift wrote:
> >>> On Sat, May 06, 2017 at 04:03:58PM +0200, Dominick Grift wrote:
>=20
> [snip]
>=20
> >>>>=20
> >>>> Nice! Unfornately i could not, which my limited capacity, get it to =
work. Here is what i tried:
> >>>>=20
> >>>> Fedora 26 (alpha):
> >>>> sudo dnf install setools setools-console libselinux-python3 pandoc w=
hich
> >>>> git clone https://github.com/quarcksecurity/span && cd span && pip3 =
install . --user
> >>>> cd examples && jupyter-notebook
> >>>>=20
> >>>> As soon as i try to run any "cell" or do "restart kernel and run all=
 cells" it throws stack traces about "ModuleNotFoundError" (import span as =
se" and "from sh import pandoc"=20
> >>>>=20
> >>>> All the stuff seems to be installed properly in ~/.local/lib/python3=
=2E6/site-packages, and the stack traces do refer to the proper paths suchs=
 as for example: "/home/joe/.local/lib/python3.6/site-packages/span/domain_=
summary_to_word.py in <module> ()"
> >>>=20
> >>> I dont know exactly what the issue is but after installing the follow=
ing from the fedora repository i seem to have it working:
> >>>=20
> >>> python3-pypandoc
> >>> python3-pandocfilters
> >>> python3-sh
> >>>=20
> >>> So i suspect the "from sh import pandoc" was the issue because sh was=
 not in the python_requirements.txt, but even after adding it there it stil=
l did not work
> >>=20
>=20
> I updated python_requirements.txt to include sh - thanks for that.
>=20
> >> The idea is nice, unfortunately its inflexible and it has hard-referen=
ces to reference policy all-over. It has potential but it is still rough.
> >=20
> >=20
> > Turns out that Fedora provides all the dependencies (some just have dif=
ferent names)
> >=20
> > I have created a Fedora SPAN.spec:
> >=20
> > https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec <htt=
ps://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec>
> >=20
> >=20
>=20
> Thanks for making the Fedora SPEC.=20
>=20
> I know it=E2=80=99s a topic of great debate, but there are some nice thin=
gs about just sticking with the Python tools for dependency management for =
upstream. Mainly because it=E2=80=99s portable and helps get the latest ver=
sions (which is nice for fast moving projects like Jupyter notebook and Pan=
das).

Yes it is pretty cool (pip) and this event actually prompted me to make pip=
 work in my environment. However for me in this case it is really not an op=
tion. Its nice for simple python modules but python programs such as notebo=
ok need permissions that i do not associate will login users shells, and i =
dont support confining applications installed to $HOME. notebook needs perm=
issions like execmem, needs network connectivity and a few other things tha=
t i do not allow my user login shells. So I have to make this work system-w=
ide and I wanted the benefit of being able to manage/keep track off what i =
install system-wide

>=20
> Karl
>=20
>=20
> >>=20
> >>>=20
> >>>>=20
> >>>> --=20
> >>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B=
02
> >>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02
> >>>> Dominick Grift
> >>>=20
> >>>=20
> >>>=20
> >>> --=20
> >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02
> >>> Dominick Grift
> >>=20
> >>=20
> >>=20
> >> --=20
> >> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
> >> Dominick Grift
> >=20
> >=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02>
> > Dominick Grift
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQx8AACgkQJXSOVTf5
R2lzZQv+LTtgmoFK5I11LY8HEO7Vu8YiZMLlqmx1i0i2GH8WnSGFYsK7JkuZNXQg
E8P6Fo9b5aAlJhhDeRzZSekXqUvwTJYNVZiDiGykd1jVMUthHv4vZz23rZMnoRvr
Vr6O5QnnoiJWcwPtVVCHFsei0XwPBjduG/1ZhPcixXNnUIMxbNpVuuY97JNKxXGt
4BIfolAx0WeZCJdUGeja6dc390h0q69nEVZjfJy6UVkFevdIevNKNO/TDvIwH3KP
9uyDr5GojISlHD5LID+J2oAb87fc7MSu5G8buhu0ys4Issd5f25dwhmoaHTPK+YY
B9Z017vAz23Oot0nN0hYNANyuiQ39gAniV+Mh4XPOND9puCVWvb4+ZiuEbcsHFZS
SNal9aF7WnD1FZUxR7BEIU5uXrU34vDd0RppzOxJ6yRZ+DZ32Ry8a6DzrTvoGeTf
ANrQnx3BiXl5YAP+fhgiXKK+RpkbO8xpBfiK2YVhzRCkIMHXujrv4uguQgnHpkP5
p2ed5kOn
=OEQh
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
