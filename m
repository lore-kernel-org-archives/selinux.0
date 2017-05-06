Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46HJTTF026132
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 13:19:29 -0400
Received: by mail-wm0-f54.google.com with SMTP id u65so46897796wmu.1
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 10:19:24 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id h29sm5751260eda.45.2017.05.06.10.19.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 May 2017 10:19:22 -0700 (PDT)
Date: Sat, 6 May 2017 19:19:20 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170506171920.GB20145@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
In-Reply-To: <20170506161956.GA20145@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 06:19:56PM +0200, Dominick Grift wrote:
> On Sat, May 06, 2017 at 04:03:58PM +0200, Dominick Grift wrote:
> > On Fri, May 05, 2017 at 02:27:05PM -0400, Karl MacMillan wrote:
> > > I=E2=80=99d like to announce SPAN - SELinux Policy Analysis Notebook =
(https://github.com/QuarkSecurity/SPAN/ <https://github.com/QuarkSecurity/S=
PAN/>). This is a Jupyter notebook based environment for SELinux policy ana=
lysis that let=E2=80=99s you mix queries, Python code, and Markdown formatt=
ed notes into an executable document. It=E2=80=99s an extension of SETools =
4.
> > >=20
> > > Using SPAN within Jupyter notebook is an amazingly productive way to =
do policy analysis. I really think that this is the most productive environ=
ment that I=E2=80=99ve seen for real policy analysis (and I=E2=80=99ve been=
 working on SELinux policy analysis and tools for almost 15 years). The abi=
lity to quickly create custom tools to answer hard questions combined inlin=
e with well-formatted documentation makes a huge difference.
> > >=20
> > > SPAN has been used so far to analyze 3 large, complex, custom systems=
 with very large policies (hundreds of custom domains). The analysis was of=
 much better quality and it took much less time because of SPAN.
> > >=20
> > > If you just want to see what this looks like, you can see an example =
online (though the code is not executable):
> > >=20
> > > https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/ex=
amples/Span%20Example.ipynb# <https://nbviewer.jupyter.org/github/QuarkSecu=
rity/SPAN/blob/master/examples/Span%20Example.ipynb#>
> > >=20
> > > If you=E2=80=99ve not seen Jupyter notebooks, they are a very popular=
 tool for data science. Jupyter notebooks are an interactive environment th=
at let you write text (in Markdown) and code together. You can get a feel f=
or what's possible in this awesome notebook on Regex Golf from XKCD: http:/=
/nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb <http://nbviewe=
r.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb>. There is also the mor=
e official (and boring) introduction: https://jupyter-notebook-beginner-gui=
de.readthedocs.io/en/latest/ <https://jupyter-notebook-beginner-guide.readt=
hedocs.io/en/latest/>.
> > >=20
> > > SPAN was written by me (Karl MacMillan) along with Spencer Shimko and=
 Brandon Whalen from Quark Security. And, of course, this is built on SEToo=
ls 4 which is maintained by Chris PeBinito.
> > >=20
> > > Thanks - Karl
> >=20
> > Nice! Unfornately i could not, which my limited capacity, get it to wor=
k. Here is what i tried:
> >=20
> > Fedora 26 (alpha):
> > sudo dnf install setools setools-console libselinux-python3 pandoc which
> > git clone https://github.com/quarcksecurity/span && cd span && pip3 ins=
tall . --user
> > cd examples && jupyter-notebook
> >=20
> > As soon as i try to run any "cell" or do "restart kernel and run all ce=
lls" it throws stack traces about "ModuleNotFoundError" (import span as se"=
 and "from sh import pandoc"=20
> >=20
> > All the stuff seems to be installed properly in ~/.local/lib/python3.6/=
site-packages, and the stack traces do refer to the proper paths suchs as f=
or example: "/home/joe/.local/lib/python3.6/site-packages/span/domain_summa=
ry_to_word.py in <module> ()"
>=20
> I dont know exactly what the issue is but after installing the following =
=66rom the fedora repository i seem to have it working:
>=20
> python3-pypandoc
> python3-pandocfilters
> python3-sh
>=20
> So i suspect the "from sh import pandoc" was the issue because sh was not=
 in the python_requirements.txt, but even after adding it there it still di=
d not work

The idea is nice, unfortunately its inflexible and it has hard-references t=
o reference policy all-over. It has potential but it is still rough.

>=20
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

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkOBZQACgkQJXSOVTf5
R2lzVgwAizpWpm9g10jkhrG0jG/xThuYMacUekt9YZi0/1i5r5pat2OByM5alL5f
KcUkpUA/BkGyro6vFT3ODJR05XqRw51SzVeugf4NFLrikZ38M/JCVVnd5+Xf2LWO
+OMxWRpfrbjMGVHF2TApP8lJNv5ydwaJ03vrXwOSkO1hZOh0hllv2OfVmQiIYz0k
xPUE4O5m9fYFdhgQ/L+McdY+Ov3Rds8V/s1NecxGG24l0SZSC2XLGhEnV0kX0VYp
HfkjrZAGHwhFERWAdu6TpUQfOpVbcAbgBCxqWpsPXjT3KJ3ak2ohDK3smHqbVW/W
hrAI+pi9KRCgr7zqh10rzhCiIhXl+jiV8vNEA9Rc8q593ltA+LD/RAgYSeFoVfgP
uL3k6PDKBWKBgCGVcH+Hszp1zwybIqFG0e7y7NCDq7tglXkSsii0Wk2puT4H65xA
YHw7L72Lu8cxzL+XmrLdM88cin6IsF4Gu3VO9qRzULIlkIc6YTMNL5nZtI0TkuGn
IpXl8zjE
=Ecxb
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
