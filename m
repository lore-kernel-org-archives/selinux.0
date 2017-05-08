Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48K9K65004764
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 16:09:20 -0400
Received: by mail-qk0-f181.google.com with SMTP id a72so45998885qkj.2
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 13:09:18 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1464EA85-F308-4313-BE14-30C11ECD8239"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Mon, 8 May 2017 16:09:16 -0400
In-Reply-To: <20170508194931.GB7367@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius> <590F78BA.5040800@quarksecurity.com>
 <20170508085555.GA3701@julius> <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_1464EA85-F308-4313-BE14-30C11ECD8239
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
> On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
>>=20
>>>=20
>>=20
>> I think it=E2=80=99s best to think of these as having three basic =
layers:
>>=20
>> 1. Basic tools for SELinux policy analysis in Jupyter - these are =
usable for any policy and make no assumptions about the presence of any =
types, attributes, object classes, or permissions. So things like the =
rule searching and information flow analysis fit into this group. This =
is a large part of the value of SPAN.
>>=20
>> 2. Higher-level policy analysis methods - these are things like the =
domain_types method and the domain / type summaries. These make some =
minimal assumptions about attributes like domain. I=E2=80=99ll just =
mention that these assumptions are very minimal and have been around for =
a _long_ time. Domain long pre-dates the reference policy, for example. =
More than attributes this layer is tied to the Linux object classes and =
permissions.
>>=20
>> 3. Example notebooks - the two example notebooks are just that - =
examples. They probably provide a useful starting point, but as Josh =
points out, should simply be modified for your specific use case.
>>=20
>> So the question, then, is should the second layer (the higher-level =
policy analysis methods) be made configurable. Honestly I think it would =
be more work than just creating your own versions for a policy that =
breaks the assumptions. To me, that=E2=80=99s the great advantage of =
this versus other analysis tools. It=E2=80=99s so simple to create quick =
tools that meet your needs. And given that the vast majority of Linux =
and Android systems meet the assumptions I think that this is a =
reasonable approach.
>=20
> I don't think it will work with android. Some of it maybe but not all =
of it. for example the source functionality appends "modules" to the =
search path. So i suspect that will break that functionality for =
Android.

We=E2=80=99ve not tested it for Android policies so I=E2=80=99m sure =
there will be some breakage. But I hope it will be fixed to work by us =
or someone soon.

> Thank you for giving me your opinion. At least now I know where I =
stand.

Where you stand? I=E2=80=99m not certain what you mean and was not =
trying to say something about you personally.

I was not familiar with DSSP before (I=E2=80=99ve not done much with =
SELinux for a while), but Josh pointed it out to me. =46rom looking at =
it very briefly and thinking through the assumptions in SPAN my guess is =
that it would take very few changes to make SPAN work with DSSP, even =
the source policy stuff (which, honestly, is just a very small part =
mainly useful for diffing constraints).

And as a side note - it=E2=80=99s nice to see someone trying to write a =
policy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D =
attribute or at least a similar concept?

> I will not be able to leverage this solution to any significant =
extend, and the notebook and its depenedencies are pretty expensive to =
have just for something that only works to some extent.

I=E2=80=99m curious what you mean by =E2=80=9Conly works to some =
extent=E2=80=9D. Any bug reports would be welcome.

And if you mean specifically in the context of DSSP, like I said I bet =
the changes would be minimal. So if you are interested in giving it a =
try I=E2=80=99ll be happy to look at the changes needed and give you a =
hand.

Thanks - Karl

> Atleast this inspired me to implement policy for pip and notebook in =
my personal security policy. So it was not all in vain.
>=20
>>=20
>> Thanks - Karl
>>=20
>>>=20
>>>>=20
>>>> --=20
>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>>>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=
 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2> =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>>
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


--Apple-Mail=_1464EA85-F308-4313-BE14-30C11ECD8239
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 8, 2017, at 3:49 PM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Mon, May 08, 2017 at =
03:36:21PM -0400, Karl MacMillan wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D""></blockquote><br class=3D"">I =
think it=E2=80=99s best to think of these as having three basic =
layers:<br class=3D""><br class=3D"">1. Basic tools for SELinux policy =
analysis in Jupyter - these are usable for any policy and make no =
assumptions about the presence of any types, attributes, object classes, =
or permissions. So things like the rule searching and information flow =
analysis fit into this group. This is a large part of the value of =
SPAN.<br class=3D""><br class=3D"">2. Higher-level policy analysis =
methods - these are things like the domain_types method and the domain / =
type summaries. These make some minimal assumptions about attributes =
like domain. I=E2=80=99ll just mention that these assumptions are very =
minimal and have been around for a _long_ time. Domain long pre-dates =
the reference policy, for example. More than attributes this layer is =
tied to the Linux object classes and permissions.<br class=3D""><br =
class=3D"">3. Example notebooks - the two example notebooks are just =
that - examples. They probably provide a useful starting point, but as =
Josh points out, should simply be modified for your specific use =
case.<br class=3D""><br class=3D"">So the question, then, is should the =
second layer (the higher-level policy analysis methods) be made =
configurable. Honestly I think it would be more work than just creating =
your own versions for a policy that breaks the assumptions. To me, =
that=E2=80=99s the great advantage of this versus other analysis tools. =
It=E2=80=99s so simple to create quick tools that meet your needs. And =
given that the vast majority of Linux and Android systems meet the =
assumptions I think that this is a reasonable approach.<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">I don't think it will work with android. =
Some of it maybe but not all of it. for example the source functionality =
appends "modules" to the search path. So i suspect that will break that =
functionality for Android.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>We=E2=80=99ve=
 not tested it for Android policies so I=E2=80=99m sure there will be =
some breakage. But I hope it will be fixed to work by us or someone =
soon.</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thank you for giving me your opinion. At least =
now I know where I stand.</span></div></blockquote><div><br =
class=3D""></div><div>Where you stand? I=E2=80=99m not certain what you =
mean and was not trying to say something about you =
personally.</div><div><br class=3D""></div><div>I was not familiar with =
DSSP before (I=E2=80=99ve not done much with SELinux for a while), but =
Josh pointed it out to me. =46rom looking at it very briefly and =
thinking through the assumptions in SPAN my guess is that it would take =
very few changes to make SPAN work with DSSP, even the source policy =
stuff (which, honestly, is just a very small part mainly useful for =
diffing constraints).</div><div><br class=3D""></div><div>And as a side =
note - it=E2=80=99s nice to see someone trying to write a policy from =
scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D attribute or at =
least a similar concept?</div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""> I will not be able to leverage this =
solution to any significant extend, and the notebook and its =
depenedencies are pretty expensive to have just for something that only =
works to some extent.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>I=E2=80=99m =
curious what you mean by =E2=80=9Conly works to some extent=E2=80=9D. =
Any bug reports would be welcome.</div><div><br class=3D""></div><div>And =
if you mean specifically in the context of DSSP, like I said I bet the =
changes would be minimal. So if you are interested in giving it a try =
I=E2=80=99ll be happy to look at the changes needed and give you a =
hand.</div><div><br class=3D""></div><div>Thanks - Karl</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Atleast this inspired me to =
implement policy for pip and notebook in my personal security policy. So =
it was not all in vain.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Thanks - =
Karl<br class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><br=
 class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">Key =
fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C 5F1D 2C7B =
6B02<br class=3D""><a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a><span =
class=3D"Apple-converted-space">&nbsp;</span>&lt;<a =
href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C=
5F1D2C7B6B02" =
class=3D"">https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3=
B6C5F1D2C7B6B02</a>&gt;<br class=3D"">Dominick Grift<br =
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

--Apple-Mail=_1464EA85-F308-4313-BE14-30C11ECD8239--
