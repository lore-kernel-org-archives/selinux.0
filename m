Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46GK4PW012652
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 12:20:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id b84so16172844wmh.0
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 09:20:00 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id i28sm2582098ede.38.2017.05.06.09.19.58
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 May 2017 09:19:58 -0700 (PDT)
Date: Sat, 6 May 2017 18:19:56 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170506161956.GA20145@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <20170506140358.GA21008@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 04:03:58PM +0200, Dominick Grift wrote:
> On Fri, May 05, 2017 at 02:27:05PM -0400, Karl MacMillan wrote:
> > I=E2=80=99d like to announce SPAN - SELinux Policy Analysis Notebook (h=
ttps://github.com/QuarkSecurity/SPAN/ <https://github.com/QuarkSecurity/SPA=
N/>). This is a Jupyter notebook based environment for SELinux policy analy=
sis that let=E2=80=99s you mix queries, Python code, and Markdown formatted=
 notes into an executable document. It=E2=80=99s an extension of SETools 4.
> >=20
> > Using SPAN within Jupyter notebook is an amazingly productive way to do=
 policy analysis. I really think that this is the most productive environme=
nt that I=E2=80=99ve seen for real policy analysis (and I=E2=80=99ve been w=
orking on SELinux policy analysis and tools for almost 15 years). The abili=
ty to quickly create custom tools to answer hard questions combined inline =
with well-formatted documentation makes a huge difference.
> >=20
> > SPAN has been used so far to analyze 3 large, complex, custom systems w=
ith very large policies (hundreds of custom domains). The analysis was of m=
uch better quality and it took much less time because of SPAN.
> >=20
> > If you just want to see what this looks like, you can see an example on=
line (though the code is not executable):
> >=20
> > https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/exam=
ples/Span%20Example.ipynb# <https://nbviewer.jupyter.org/github/QuarkSecuri=
ty/SPAN/blob/master/examples/Span%20Example.ipynb#>
> >=20
> > If you=E2=80=99ve not seen Jupyter notebooks, they are a very popular t=
ool for data science. Jupyter notebooks are an interactive environment that=
 let you write text (in Markdown) and code together. You can get a feel for=
 what's possible in this awesome notebook on Regex Golf from XKCD: http://n=
bviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb <http://nbviewer.=
jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb>. There is also the more =
official (and boring) introduction: https://jupyter-notebook-beginner-guide=
=2Ereadthedocs.io/en/latest/ <https://jupyter-notebook-beginner-guide.readt=
hedocs.io/en/latest/>.
> >=20
> > SPAN was written by me (Karl MacMillan) along with Spencer Shimko and B=
randon Whalen from Quark Security. And, of course, this is built on SETools=
 4 which is maintained by Chris PeBinito.
> >=20
> > Thanks - Karl
>=20
> Nice! Unfornately i could not, which my limited capacity, get it to work.=
 Here is what i tried:
>=20
> Fedora 26 (alpha):
> sudo dnf install setools setools-console libselinux-python3 pandoc which
> git clone https://github.com/quarcksecurity/span && cd span && pip3 insta=
ll . --user
> cd examples && jupyter-notebook
>=20
> As soon as i try to run any "cell" or do "restart kernel and run all cell=
s" it throws stack traces about "ModuleNotFoundError" (import span as se" a=
nd "from sh import pandoc"=20
>=20
> All the stuff seems to be installed properly in ~/.local/lib/python3.6/si=
te-packages, and the stack traces do refer to the proper paths suchs as for=
 example: "/home/joe/.local/lib/python3.6/site-packages/span/domain_summary=
_to_word.py in <module> ()"

I dont know exactly what the issue is but after installing the following fr=
om the fedora repository i seem to have it working:

python3-pypandoc
python3-pandocfilters
python3-sh

So i suspect the "from sh import pandoc" was the issue because sh was not i=
n the python_requirements.txt, but even after adding it there it still did =
not work

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkN96gACgkQJXSOVTf5
R2lqqAwAjisx8T0PDm6q5WOnkoOi5GsmU1NXAFGgo4xDI+ah8KOPBho/jvBl//pF
IMqnilraRCq1/UgZY30TELCjo9ulw4+5W+Ecq7eJ+St+VzJs9eaPDaISAc3iS/QM
748nm8/s5TOhzB4kqZ5UskFRPF62uHbU3VeINbx1edM48fu6fdew8i7EHmcD7JTg
HJPmZJ9/yVuR8fVi3v5FnVHnY9hV5uj6rHwGUjHM0q1nNcNi035mOwG5VmhK8Wp2
e7AQzXS6d1e4wOtNx+V+zEvTeDgasMKZ2ZvX7DXJCVJjWrs7CUVgP6gXhB3550zR
rImYvZIr1+v543Ub8m1HIEx7D/gCPOL1nuuJlz/PUqbIPtXs56WZvEE1MI7UNhCX
yTLmeJ94POPSypYmNpTMtfckwOAaeHi3gD5wcuh8RRe/+moPaPuf6SlvHWW77Pn5
U18b8paVySlLKPm4tLIMBrFCE1IDtlBqfnMZ48wjCszznUNk9BdYqesdMzb7mTx9
TgSyAo9G
=nobM
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
