Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46E48AD014310
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 10:04:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id b84so14562891wmh.0
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 07:04:01 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id n55sm4463582edd.65.2017.05.06.07.03.59
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 May 2017 07:03:59 -0700 (PDT)
Date: Sat, 6 May 2017 16:03:58 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170506140358.GA21008@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
In-Reply-To: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 02:27:05PM -0400, Karl MacMillan wrote:
> I=E2=80=99d like to announce SPAN - SELinux Policy Analysis Notebook (htt=
ps://github.com/QuarkSecurity/SPAN/ <https://github.com/QuarkSecurity/SPAN/=
>). This is a Jupyter notebook based environment for SELinux policy analysi=
s that let=E2=80=99s you mix queries, Python code, and Markdown formatted n=
otes into an executable document. It=E2=80=99s an extension of SETools 4.
>=20
> Using SPAN within Jupyter notebook is an amazingly productive way to do p=
olicy analysis. I really think that this is the most productive environment=
 that I=E2=80=99ve seen for real policy analysis (and I=E2=80=99ve been wor=
king on SELinux policy analysis and tools for almost 15 years). The ability=
 to quickly create custom tools to answer hard questions combined inline wi=
th well-formatted documentation makes a huge difference.
>=20
> SPAN has been used so far to analyze 3 large, complex, custom systems wit=
h very large policies (hundreds of custom domains). The analysis was of muc=
h better quality and it took much less time because of SPAN.
>=20
> If you just want to see what this looks like, you can see an example onli=
ne (though the code is not executable):
>=20
> https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/exampl=
es/Span%20Example.ipynb# <https://nbviewer.jupyter.org/github/QuarkSecurity=
/SPAN/blob/master/examples/Span%20Example.ipynb#>
>=20
> If you=E2=80=99ve not seen Jupyter notebooks, they are a very popular too=
l for data science. Jupyter notebooks are an interactive environment that l=
et you write text (in Markdown) and code together. You can get a feel for w=
hat's possible in this awesome notebook on Regex Golf from XKCD: http://nbv=
iewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb <http://nbviewer.ju=
pyter.org/url/norvig.com/ipython/xkcd1313.ipynb>. There is also the more of=
ficial (and boring) introduction: https://jupyter-notebook-beginner-guide.r=
eadthedocs.io/en/latest/ <https://jupyter-notebook-beginner-guide.readthedo=
cs.io/en/latest/>.
>=20
> SPAN was written by me (Karl MacMillan) along with Spencer Shimko and Bra=
ndon Whalen from Quark Security. And, of course, this is built on SETools 4=
 which is maintained by Chris PeBinito.
>=20
> Thanks - Karl

Nice! Unfornately i could not, which my limited capacity, get it to work. H=
ere is what i tried:

Fedora 26 (alpha):
sudo dnf install setools setools-console libselinux-python3 pandoc which
git clone https://github.com/quarcksecurity/span && cd span && pip3 install=
 . --user
cd examples && jupyter-notebook

As soon as i try to run any "cell" or do "restart kernel and run all cells"=
 it throws stack traces about "ModuleNotFoundError" (import span as se" and=
 "from sh import pandoc"=20

All the stuff seems to be installed properly in ~/.local/lib/python3.6/site=
-packages, and the stack traces do refer to the proper paths suchs as for e=
xample: "/home/joe/.local/lib/python3.6/site-packages/span/domain_summary_t=
o_word.py in <module> ()"

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkN18kACgkQJXSOVTf5
R2mlAQv/au3k06ge1VmnMZKcA9Yonpr+a5G9gMbiUIa9AqCLox0PGmUCQASEirse
4oZWnzqahxJHoT2Cn61Abe6v5Yr01hmqPrBJWQ1YIPQevudNOFO4goWKGgy9+V/j
9Uz/o5KUlk4jEFSQRp0G2TW+tjG+VhSlNZv/7y1bsfI1qbbyUtraggPrADH9c4Ia
AHg6vPq+k15+YN76W48XUIpyeq+F85LMXo0pgXXSS49QmdEs8anJ8vL3Ujdm+pbu
THM8/xNz1xX/efxOLQxDw8chE5VJk2FuEP4CS5JdS6CN0bnYa5S6zGh5BfwLFGRD
rOwWGhTJAkUxJBE3I9Fq4kUnFYBSV2uqsb/OUrmh3CqJth7+WjST0dpWde9eKXf8
e1M+HHRqjjZ7sZ94y2h0mY8VR0vULs/gd5skFuZK2kA9BxHAWxU6Tjj38590SOUX
8AbsnZhmIg/8qKC1PqeTID0JvuYUcrwW+HWwYc3uJE4NXwk8NZ7re2HjgBmrPCCl
miTVsAh5
=riKy
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
