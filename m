Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v479dSV5005356
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 05:39:28 -0400
Received: by mail-wm0-f46.google.com with SMTP id b84so25381606wmh.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 02:39:25 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id a56sm3481100eda.3.2017.05.07.02.39.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 May 2017 02:39:23 -0700 (PDT)
Date: Sun, 7 May 2017 11:39:21 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170507093921.GA22381@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <20170506171920.GB20145@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 07:19:20PM +0200, Dominick Grift wrote:
> On Sat, May 06, 2017 at 06:19:56PM +0200, Dominick Grift wrote:
> > On Sat, May 06, 2017 at 04:03:58PM +0200, Dominick Grift wrote:
> > > On Fri, May 05, 2017 at 02:27:05PM -0400, Karl MacMillan wrote:
> > > > I=E2=80=99d like to announce SPAN - SELinux Policy Analysis Noteboo=
k (https://github.com/QuarkSecurity/SPAN/ <https://github.com/QuarkSecurity=
/SPAN/>). This is a Jupyter notebook based environment for SELinux policy a=
nalysis that let=E2=80=99s you mix queries, Python code, and Markdown forma=
tted notes into an executable document. It=E2=80=99s an extension of SETool=
s 4.
> > > >=20
> > > > Using SPAN within Jupyter notebook is an amazingly productive way t=
o do policy analysis. I really think that this is the most productive envir=
onment that I=E2=80=99ve seen for real policy analysis (and I=E2=80=99ve be=
en working on SELinux policy analysis and tools for almost 15 years). The a=
bility to quickly create custom tools to answer hard questions combined inl=
ine with well-formatted documentation makes a huge difference.
> > > >=20
> > > > SPAN has been used so far to analyze 3 large, complex, custom syste=
ms with very large policies (hundreds of custom domains). The analysis was =
of much better quality and it took much less time because of SPAN.
> > > >=20
> > > > If you just want to see what this looks like, you can see an exampl=
e online (though the code is not executable):
> > > >=20
> > > > https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/=
examples/Span%20Example.ipynb# <https://nbviewer.jupyter.org/github/QuarkSe=
curity/SPAN/blob/master/examples/Span%20Example.ipynb#>
> > > >=20
> > > > If you=E2=80=99ve not seen Jupyter notebooks, they are a very popul=
ar tool for data science. Jupyter notebooks are an interactive environment =
that let you write text (in Markdown) and code together. You can get a feel=
 for what's possible in this awesome notebook on Regex Golf from XKCD: http=
://nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb <http://nbvie=
wer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb>. There is also the m=
ore official (and boring) introduction: https://jupyter-notebook-beginner-g=
uide.readthedocs.io/en/latest/ <https://jupyter-notebook-beginner-guide.rea=
dthedocs.io/en/latest/>.
> > > >=20
> > > > SPAN was written by me (Karl MacMillan) along with Spencer Shimko a=
nd Brandon Whalen from Quark Security. And, of course, this is built on SET=
ools 4 which is maintained by Chris PeBinito.
> > > >=20
> > > > Thanks - Karl
> > >=20
> > > Nice! Unfornately i could not, which my limited capacity, get it to w=
ork. Here is what i tried:
> > >=20
> > > Fedora 26 (alpha):
> > > sudo dnf install setools setools-console libselinux-python3 pandoc wh=
ich
> > > git clone https://github.com/quarcksecurity/span && cd span && pip3 i=
nstall . --user
> > > cd examples && jupyter-notebook
> > >=20
> > > As soon as i try to run any "cell" or do "restart kernel and run all =
cells" it throws stack traces about "ModuleNotFoundError" (import span as s=
e" and "from sh import pandoc"=20
> > >=20
> > > All the stuff seems to be installed properly in ~/.local/lib/python3.=
6/site-packages, and the stack traces do refer to the proper paths suchs as=
 for example: "/home/joe/.local/lib/python3.6/site-packages/span/domain_sum=
mary_to_word.py in <module> ()"
> >=20
> > I dont know exactly what the issue is but after installing the followin=
g from the fedora repository i seem to have it working:
> >=20
> > python3-pypandoc
> > python3-pandocfilters
> > python3-sh
> >=20
> > So i suspect the "from sh import pandoc" was the issue because sh was n=
ot in the python_requirements.txt, but even after adding it there it still =
did not work
>=20
> The idea is nice, unfortunately its inflexible and it has hard-references=
 to reference policy all-over. It has potential but it is still rough.


Turns out that Fedora provides all the dependencies (some just have differe=
nt names)

I have created a Fedora SPAN.spec:

https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec


>=20
> >=20
> > >=20
> > > --=20
> > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02
> > > Dominick Grift
> >=20
> >=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkO60QACgkQJXSOVTf5
R2nGRAv+I1yM6ZadbObj3IEARV/MH4TiTEaevx14RpDfzxcX9qKSuzf6/dQiZ0w0
dfRm1pmKEiqcs+hHVaNoGd2LHRGi+gFiDvnR6PJiFJDALlqBzsR2gj7XSi/NZzND
ovmVmCwbVNOPPjHPIj+eMlqb5tWgYmGsbdq9wmEQ5g2q/CnIgCETdx+/BlE2WFAe
SRqL27QLCRqPISH15KCDUcpczhUct2LtD1CbHq5lmSCc3b456rX16spu3dhxfl1V
V4FATi+WQMeaGgHs1t5PgJKDFKZx85XmWUOpGAmDbf29JWOD/4hzklccvpAahjkY
r2VO3wjY8WdO0N1zaPOV7UcFz2hFn0xIazdyUAVPYXU649aqwxIhBuqG8ukVL5cO
1mh5mFqCyxz+8bA4P9RyESUkkN2pL1lSvnZ2LuFIrILHc5Frul98pNT282hf6zx2
6yBRypcPmXUKrVclhEmxcR07aIXSkNkutnxp3+gAv+IPY+bXtEogzii9TnFInvIe
bllb9TFC
=OXaW
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
