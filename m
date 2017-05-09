Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49FPm7E015981
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 11:25:48 -0400
Received: by mail-qt0-f178.google.com with SMTP id n4so3728416qte.2
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 08:25:46 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <84F6F2D5-393C-4313-A88D-02E596729B8A@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_80D3D97B-6538-446C-B32C-11421B9F6EAB"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Tue, 9 May 2017 11:25:44 -0400
In-Reply-To: <20170508214714.GD7367@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius> <590F78BA.5040800@quarksecurity.com>
 <20170508085555.GA3701@julius> <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius> <20170508214714.GD7367@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_80D3D97B-6538-446C-B32C-11421B9F6EAB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 8, 2017, at 5:47 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
> On Mon, May 08, 2017 at 10:40:53PM +0200, Dominick Grift wrote:
>> On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
>>>=20
>>>> On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
>>>>=20
>>=20
>>>=20
>>> And if you mean specifically in the context of DSSP, like I said I =
bet the changes would be minimal. So if you are interested in giving it =
a try I=E2=80=99ll be happy to look at the changes needed and give you a =
hand.
>>=20
>> I agree, and ive said that when I said: "a few rough edges" Its close =
the usable with DSSP. It just needs to deal with some of the current =
assumptions:
>>=20
>> ill point out some:
>>=20
>> 1. return self.grep(name, "*.te", self.modules_path) # what about =
.cil suffixed files?
>=20
> We should make this customizable something like: source_policy_suffix =
=3D
>=20
> Because we would need to catch *.conf , *.te , *.cil and any future =
high level source policy files that leverage cil
>=20

Like I said, I just renamed the PolicySource object to reflect that =
it=E2=80=99s specific to reference policy. Feel free to send a patch =
adding a DSSP object that implements the changes that you think are =
needed.

[deleted many similar requests]

>=20
>> 5. any references to type attributes should be customizable: ie. =
process_types =3D ... filesystem_types =3D ... etc
>=20
> I do not consider Linux access vectors to be customizable, unlike =
types ,attributes, booleans, tunables etc)
>=20

I know what you mean, but I have to point out that the domain attribute =
has been much more stable across many different operating systems than =
the object classes and access vectors.=20

Thanks - Karl



--Apple-Mail=_80D3D97B-6538-446C-B32C-11421B9F6EAB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 8, 2017, at 5:47 PM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Mon, May 08, 2017 at =
10:40:53PM +0200, Dominick Grift wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">On Mon, May 08, 2017 at =
04:09:16PM -0400, Karl MacMillan wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">On May 8, 2017, at 3:49 PM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""></blockquote></blockquote><br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D"">And if you mean specifically in =
the context of DSSP, like I said I bet the changes would be minimal. So =
if you are interested in giving it a try I=E2=80=99ll be happy to look =
at the changes needed and give you a hand.<br class=3D""></blockquote><br =
class=3D"">I agree, and ive said that when I said: "a few rough edges" =
Its close the usable with DSSP. It just needs to deal with some of the =
current assumptions:<br class=3D""><br class=3D"">ill point out some:<br =
class=3D""><br class=3D"">1. return self.grep(name, "*.te", =
self.modules_path) # what about .cil suffixed files?<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">We should make this customizable =
something like: source_policy_suffix =3D</span><br style=3D"font-family: =
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
!important;" class=3D"">Because we would need to catch *.conf , *.te , =
*.cil and any future high level source policy files that leverage =
cil</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>Like I =
said, I just renamed the PolicySource object to reflect that it=E2=80=99s =
specific to reference policy. Feel free to send a patch adding a DSSP =
object that implements the changes that you think are =
needed.</div><div><br class=3D""></div><div>[deleted many similar =
requests]</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">5. any references to type attributes should be customizable: =
ie. process_types =3D ... filesystem_types =3D ... etc<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">I do not consider Linux access vectors to =
be customizable, unlike types ,attributes, booleans, tunables =
etc)</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>I know what =
you mean, but I have to point out that the domain attribute has been =
much more stable across many different operating systems than the object =
classes and access vectors.&nbsp;</div><div><br =
class=3D""></div><div>Thanks - Karl</div><br class=3D""></div><br =
class=3D""></body></html>=

--Apple-Mail=_80D3D97B-6538-446C-B32C-11421B9F6EAB--
