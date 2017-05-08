Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48Je4FC027161
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:40:07 -0400
Received: by mail-qk0-f172.google.com with SMTP id y201so28950419qka.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:40:06 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <918A6F86-3082-4755-84D9-E9C87D9E4F97@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_48A7D293-1423-4591-B16D-1B465351208D"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Mon, 8 May 2017 15:40:04 -0400
In-Reply-To: <20170508193220.GA7367@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <20170507093921.GA22381@julius>
 <9CD79E56-C6FE-44F8-B81B-1155356E0874@gmail.com>
 <20170508193220.GA7367@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_48A7D293-1423-4591-B16D-1B465351208D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 8, 2017, at 3:32 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
> On Mon, May 08, 2017 at 03:23:06PM -0400, Karl MacMillan wrote:
>>>=20
>>=20
>> Thanks for making the Fedora SPEC.=20
>>=20
>> I know it=E2=80=99s a topic of great debate, but there are some nice =
things about just sticking with the Python tools for dependency =
management for upstream. Mainly because it=E2=80=99s portable and helps =
get the latest versions (which is nice for fast moving projects like =
Jupyter notebook and Pandas).
>=20
> Yes it is pretty cool (pip) and this event actually prompted me to =
make pip work in my environment. However for me in this case it is =
really not an option. Its nice for simple python modules but python =
programs such as notebook need permissions that i do not associate will =
login users shells, and i dont support confining applications installed =
to $HOME. notebook needs permissions like execmem, needs network =
connectivity and a few other things that i do not allow my user login =
shells. So I have to make this work system-wide and I wanted the benefit =
of being able to manage/keep track off what i install system-wide
>=20

Interesting. I=E2=80=99ll just note that it=E2=80=99s perfectly possible =
to run Jupyter Notebook as a server and connect to it via a web-browser. =
So it would be simple to run Jupyter in a container or VM, which might =
make containing it easier. Personally, I just run this on a development =
system that=E2=80=99s not so locked down.

Karl

>>=20
>> Karl
>>=20
>>=20
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> --=20
>>>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>>>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=

>>>>>> Dominick Grift
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> --=20
>>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=

>>>>> Dominick Grift
>>>>=20
>>>>=20
>>>>=20
>>>> --=20
>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=
 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>
>>>> Dominick Grift
>>>=20
>>>=20
>>>=20
>>> --=20
>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=
 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2> =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>>
>>> Dominick Grift
>>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B=
02 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>
> Dominick Grift


--Apple-Mail=_48A7D293-1423-4591-B16D-1B465351208D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 8, 2017, at 3:32 PM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Mon, May 08, 2017 at =
03:23:06PM -0400, Karl MacMillan wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D""></blockquote><br class=3D"">Thanks for making =
the Fedora SPEC.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""><br class=3D"">I know it=E2=80=99s a topic of great debate, =
but there are some nice things about just sticking with the Python tools =
for dependency management for upstream. Mainly because it=E2=80=99s =
portable and helps get the latest versions (which is nice for fast =
moving projects like Jupyter notebook and Pandas).<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Yes it is pretty cool (pip) and this =
event actually prompted me to make pip work in my environment. However =
for me in this case it is really not an option. Its nice for simple =
python modules but python programs such as notebook need permissions =
that i do not associate will login users shells, and i dont support =
confining applications installed to $HOME. notebook needs permissions =
like execmem, needs network connectivity and a few other things that i =
do not allow my user login shells. So I have to make this work =
system-wide and I wanted the benefit of being able to manage/keep track =
off what i install system-wide</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>Interesting. =
I=E2=80=99ll just note that it=E2=80=99s perfectly possible to run =
Jupyter Notebook as a server and connect to it via a web-browser. So it =
would be simple to run Jupyter in a container or VM, which might make =
containing it easier. Personally, I just run this on a development =
system that=E2=80=99s not so locked down.</div><div><br =
class=3D""></div><div>Karl</div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><blockquote type=3D"cite" style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Karl<br =
class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D""><blockquote=
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
class=3D""></blockquote><br class=3D""><br class=3D""><br =
class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C =
5F1D 2C7B 6B02<br class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><span =
class=3D"Apple-converted-space">&nbsp;</span>&lt;<a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a>&gt;<br class=3D"">Dominick Grift<br =
class=3D""></blockquote><br class=3D""></blockquote><br =
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

--Apple-Mail=_48A7D293-1423-4591-B16D-1B465351208D--
