Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48Jg2rS027731
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:42:02 -0400
Received: by mail-qk0-f178.google.com with SMTP id u75so61404465qka.3
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:42:00 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <CE85AA9A-CF2D-4AC9-AB0B-E9CD703666DB@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_BADE1643-8300-416F-B392-6762F3D47C72"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Mon, 8 May 2017 15:41:58 -0400
In-Reply-To: <20170507195338.GC31890@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius> <590F78BA.5040800@quarksecurity.com>
 <20170507195338.GC31890@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_BADE1643-8300-416F-B392-6762F3D47C72
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 7, 2017, at 3:53 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
>=20
> Python is not really my thing so i will have to get used to it and =
explore my options
>=20
> Its a cool module, has a few rough edges (but thats to be expected =
from v0.0.0)
>=20

So far I=E2=80=99ve seen your concerns over installation and reference =
policy assumptions. Any other =E2=80=9Crough edges=E2=80=9D that =
you=E2=80=99ve seen?

Thanks - Karl

>>> Also with regard to hardcoding the refpolicy file system =
(ps.load_policy_source). I mean if youre just going to `grep -r` then =
why do we have to assume anything there and hard code file suffixed, =
directory structures etc etc?
>>=20
>>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B=
02 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>
> Dominick Grift


--Apple-Mail=_BADE1643-8300-416F-B392-6762F3D47C72
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 7, 2017, at 3:53 PM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Python is not really my thing so i will have to =
get used to it and explore my options</span><br style=3D"font-family: =
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
!important;" class=3D"">Its a cool module, has a few rough edges (but =
thats to be expected from v0.0.0)</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>So far =
I=E2=80=99ve seen your concerns over installation and reference policy =
assumptions. Any other =E2=80=9Crough edges=E2=80=9D that you=E2=80=99ve =
seen?</div><div><br class=3D""></div><div>Thanks - Karl</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D"">Also with regard to hardcoding the refpolicy file system =
(ps.load_policy_source). I mean if youre just going to `grep -r` then =
why do we have to assume anything there and hard code file suffixed, =
directory structures etc etc?<br class=3D""></blockquote><br =
class=3D""><br class=3D""></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">--<span =
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

--Apple-Mail=_BADE1643-8300-416F-B392-6762F3D47C72--
