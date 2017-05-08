Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48JNBSV021221
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:23:11 -0400
Received: by mail-qt0-f172.google.com with SMTP id m91so58487189qte.3
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:23:09 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <9CD79E56-C6FE-44F8-B81B-1155356E0874@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_E914717A-7E05-4BAC-9FBF-B456DDD9928A"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Mon, 8 May 2017 15:23:06 -0400
In-Reply-To: <20170507093921.GA22381@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <20170507093921.GA22381@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_E914717A-7E05-4BAC-9FBF-B456DDD9928A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 7, 2017, at 5:39 AM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
> On Sat, May 06, 2017 at 07:19:20PM +0200, Dominick Grift wrote:
>> On Sat, May 06, 2017 at 06:19:56PM +0200, Dominick Grift wrote:
>>> On Sat, May 06, 2017 at 04:03:58PM +0200, Dominick Grift wrote:

[snip]

>>>>=20
>>>> Nice! Unfornately i could not, which my limited capacity, get it to =
work. Here is what i tried:
>>>>=20
>>>> Fedora 26 (alpha):
>>>> sudo dnf install setools setools-console libselinux-python3 pandoc =
which
>>>> git clone https://github.com/quarcksecurity/span && cd span && pip3 =
install . --user
>>>> cd examples && jupyter-notebook
>>>>=20
>>>> As soon as i try to run any "cell" or do "restart kernel and run =
all cells" it throws stack traces about "ModuleNotFoundError" (import =
span as se" and "from sh import pandoc"=20
>>>>=20
>>>> All the stuff seems to be installed properly in =
~/.local/lib/python3.6/site-packages, and the stack traces do refer to =
the proper paths suchs as for example: =
"/home/joe/.local/lib/python3.6/site-packages/span/domain_summary_to_word.=
py in <module> ()"
>>>=20
>>> I dont know exactly what the issue is but after installing the =
following from the fedora repository i seem to have it working:
>>>=20
>>> python3-pypandoc
>>> python3-pandocfilters
>>> python3-sh
>>>=20
>>> So i suspect the "from sh import pandoc" was the issue because sh =
was not in the python_requirements.txt, but even after adding it there =
it still did not work
>>=20

I updated python_requirements.txt to include sh - thanks for that.

>> The idea is nice, unfortunately its inflexible and it has =
hard-references to reference policy all-over. It has potential but it is =
still rough.
>=20
>=20
> Turns out that Fedora provides all the dependencies (some just have =
different names)
>=20
> I have created a Fedora SPAN.spec:
>=20
> https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec =
<https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec>
>=20
>=20

Thanks for making the Fedora SPEC.=20

I know it=E2=80=99s a topic of great debate, but there are some nice =
things about just sticking with the Python tools for dependency =
management for upstream. Mainly because it=E2=80=99s portable and helps =
get the latest versions (which is nice for fast moving projects like =
Jupyter notebook and Pandas).

Karl


>>=20
>>>=20
>>>>=20
>>>> --=20
>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=

>>>> Dominick Grift
>>>=20
>>>=20
>>>=20
>>> --=20
>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=

>>> Dominick Grift
>>=20
>>=20
>>=20
>> --=20
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=

>> Dominick Grift
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B=
02 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>
> Dominick Grift


--Apple-Mail=_E914717A-7E05-4BAC-9FBF-B456DDD9928A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 7, 2017, at 5:39 AM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Sat, May 06, 2017 at =
07:19:20PM +0200, Dominick Grift wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">On Sat, May 06, 2017 at =
06:19:56PM +0200, Dominick Grift wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">On Sat, May 06, 2017 at 04:03:58PM +0200, =
Dominick Grift =
wrote:</blockquote></blockquote></div></blockquote><div><br =
class=3D""></div><div>[snip]</div><br class=3D""><blockquote type=3D"cite"=
 class=3D""><div class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Nice! Unfornately i could not, which my =
limited capacity, get it to work. Here is what i tried:<br class=3D""><br =
class=3D"">Fedora 26 (alpha):<br class=3D"">sudo dnf install setools =
setools-console libselinux-python3 pandoc which<br class=3D"">git clone =
<a href=3D"https://github.com/quarcksecurity/span" =
class=3D"">https://github.com/quarcksecurity/span</a> &amp;&amp; cd span =
&amp;&amp; pip3 install . --user<br class=3D"">cd examples &amp;&amp; =
jupyter-notebook<br class=3D""><br class=3D"">As soon as i try to run =
any "cell" or do "restart kernel and run all cells" it throws stack =
traces about "ModuleNotFoundError" (import span as se" and "from sh =
import pandoc"<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""><br class=3D"">All the stuff seems to be installed properly =
in ~/.local/lib/python3.6/site-packages, and the stack traces do refer =
to the proper paths suchs as for example: =
"/home/joe/.local/lib/python3.6/site-packages/span/domain_summary_to_word.=
py in &lt;module&gt; ()"<br class=3D""></blockquote><br class=3D"">I =
dont know exactly what the issue is but after installing the following =
from the fedora repository i seem to have it working:<br class=3D""><br =
class=3D"">python3-pypandoc<br class=3D"">python3-pandocfilters<br =
class=3D"">python3-sh<br class=3D""><br class=3D"">So i suspect the =
"from sh import pandoc" was the issue because sh was not in the =
python_requirements.txt, but even after adding it there it still did not =
work<br class=3D""></blockquote><br =
class=3D""></blockquote></div></blockquote><div><br =
class=3D""></div><div>I updated python_requirements.txt to include sh - =
thanks for that.</div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><blockquote type=3D"cite" style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">The idea is nice, =
unfortunately its inflexible and it has hard-references to reference =
policy all-over. It has potential but it is still rough.<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Turns out that Fedora provides =
all the dependencies (some just have different names)</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">I have created a Fedora SPAN.spec:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.spec=
" style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">https://github.com/DefenSec/selinux-rpm-spec/blob/master/SPAN.s=
pec</a><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>Thanks for =
making the Fedora SPEC.&nbsp;</div><div><br class=3D""></div><div>I know =
it=E2=80=99s a topic of great debate, but there are some nice things =
about just sticking with the Python tools for dependency management for =
upstream. Mainly because it=E2=80=99s portable and helps get the latest =
versions (which is nice for fast moving projects like Jupyter notebook =
and Pandas).</div><div><br class=3D""></div><div>Karl</div><div><br =
class=3D""></div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">Key =
fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C 5F1D 2C7B =
6B02<br class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><br class=3D"">Dominick Grift<br =
class=3D""></blockquote><br class=3D""><br class=3D""><br =
class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C =
5F1D 2C7B 6B02<br class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><br class=3D"">Dominick Grift<br =
class=3D""></blockquote><br class=3D""><br class=3D""><br =
class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C =
5F1D 2C7B 6B02<br class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><br class=3D"">Dominick Grift<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 =
&nbsp;02D5 3B6C 5F1D 2C7B 6B02</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Dominick =
Grift</span></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_E914717A-7E05-4BAC-9FBF-B456DDD9928A--
