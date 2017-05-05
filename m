Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45IRAc5026513
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 14:27:10 -0400
Received: by mail-qt0-f176.google.com with SMTP id m91so11778938qte.3
 for <selinux@tycho.nsa.gov>; Fri, 05 May 2017 11:27:07 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_8B270DE7-CC5C-44AA-9D2D-318AA7961F98"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Announcing SPAN: SELinux Policy Analysis Notebook
Message-Id: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
Date: Fri, 5 May 2017 14:27:05 -0400
Cc: Brandon Whalen <brandon@quarksecurity.com>,
 Spencer Shimko <spencer@quarksecurity.com>,
 Chris PeBenito <pebenito78@gmail.com>, dac <dac@tresys.com>
To: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_8B270DE7-CC5C-44AA-9D2D-318AA7961F98
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I=E2=80=99d like to announce SPAN - SELinux Policy Analysis Notebook =
(https://github.com/QuarkSecurity/SPAN/ =
<https://github.com/QuarkSecurity/SPAN/>). This is a Jupyter notebook =
based environment for SELinux policy analysis that let=E2=80=99s you mix =
queries, Python code, and Markdown formatted notes into an executable =
document. It=E2=80=99s an extension of SETools 4.

Using SPAN within Jupyter notebook is an amazingly productive way to do =
policy analysis. I really think that this is the most productive =
environment that I=E2=80=99ve seen for real policy analysis (and I=E2=80=99=
ve been working on SELinux policy analysis and tools for almost 15 =
years). The ability to quickly create custom tools to answer hard =
questions combined inline with well-formatted documentation makes a huge =
difference.

SPAN has been used so far to analyze 3 large, complex, custom systems =
with very large policies (hundreds of custom domains). The analysis was =
of much better quality and it took much less time because of SPAN.

If you just want to see what this looks like, you can see an example =
online (though the code is not executable):

=
https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/example=
s/Span%20Example.ipynb# =
<https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master/exampl=
es/Span%20Example.ipynb#>

If you=E2=80=99ve not seen Jupyter notebooks, they are a very popular =
tool for data science. Jupyter notebooks are an interactive environment =
that let you write text (in Markdown) and code together. You can get a =
feel for what's possible in this awesome notebook on Regex Golf from =
XKCD: http://nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb =
<http://nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb>. =
There is also the more official (and boring) introduction: =
https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/ =
<https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/>.

SPAN was written by me (Karl MacMillan) along with Spencer Shimko and =
Brandon Whalen from Quark Security. And, of course, this is built on =
SETools 4 which is maintained by Chris PeBinito.

Thanks - Karl=

--Apple-Mail=_8B270DE7-CC5C-44AA-9D2D-318AA7961F98
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">I=E2=80=99d like to announce SPAN - SELinux Policy Analysis =
Notebook (<a href=3D"https://github.com/QuarkSecurity/SPAN/" =
class=3D"">https://github.com/QuarkSecurity/SPAN/</a>). This is a =
Jupyter notebook based environment for SELinux policy analysis that =
let=E2=80=99s you mix queries, Python code, and Markdown formatted notes =
into an executable document. It=E2=80=99s an extension of SETools 4.<div =
class=3D""><br class=3D""></div><div class=3D"">Using SPAN within =
Jupyter notebook is an amazingly productive way to do policy analysis. I =
really think that this is the most productive environment that I=E2=80=99v=
e seen for real policy analysis (and I=E2=80=99ve been working on =
SELinux policy analysis and tools for almost 15 years). The ability to =
quickly create custom tools to answer hard questions combined inline =
with well-formatted documentation makes a huge difference.</div><div =
class=3D""><br class=3D""></div><div class=3D"">SPAN has been used so =
far to analyze 3 large, complex, custom systems with very large policies =
(hundreds of custom domains). The analysis was of much better quality =
and it took much less time because of SPAN.</div><div class=3D""><br =
class=3D""></div><div class=3D"">If you just want to see what this looks =
like, you can see an example online (though the code is not =
executable):<br class=3D""><br class=3D""><a =
href=3D"https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/master=
/examples/Span Example.ipynb#" =
class=3D"">https://nbviewer.jupyter.org/github/QuarkSecurity/SPAN/blob/mas=
ter/examples/Span%20Example.ipynb#</a><br class=3D""><br class=3D"">If =
you=E2=80=99ve not seen Jupyter notebooks, they are a very popular tool =
for data science. Jupyter notebooks are an interactive environment that =
let you write text (in Markdown) and code together. You can get a feel =
for what's possible in this awesome notebook on Regex Golf from =
XKCD:&nbsp;<a =
href=3D"http://nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipynb"=
 =
class=3D"">http://nbviewer.jupyter.org/url/norvig.com/ipython/xkcd1313.ipy=
nb</a>. There is also the more official (and boring) =
introduction:&nbsp;<a =
href=3D"https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/"=
 =
class=3D"">https://jupyter-notebook-beginner-guide.readthedocs.io/en/lates=
t/</a>.<br class=3D""><br class=3D"">SPAN was written by me (Karl =
MacMillan) along with Spencer Shimko and Brandon Whalen from Quark =
Security. And, of course, this is built on SETools 4 which is maintained =
by Chris PeBinito.<br class=3D""><br class=3D"">Thanks - =
Karl</div></body></html>=

--Apple-Mail=_8B270DE7-CC5C-44AA-9D2D-318AA7961F98--
