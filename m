Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48JaQDC025668
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 15:36:26 -0400
Received: by mail-qt0-f170.google.com with SMTP id m91so58802065qte.3
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 12:36:24 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
Message-Id: <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_BA47C1C6-D30A-4668-BC9B-813F3298A8C0"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Date: Mon, 8 May 2017 15:36:21 -0400
In-Reply-To: <20170508093229.GB3701@julius>
Cc: selinux@tycho.nsa.gov
To: Dominick Grift <dac.override@gmail.com>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius> <590F78BA.5040800@quarksecurity.com>
 <20170508085555.GA3701@julius> <20170508093229.GB3701@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_BA47C1C6-D30A-4668-BC9B-813F3298A8C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 8, 2017, at 5:32 AM, Dominick Grift <dac.override@gmail.com> =
wrote:
>=20
> On Mon, May 08, 2017 at 10:55:55AM +0200, Dominick Grift wrote:
>> On Sun, May 07, 2017 at 03:42:50PM -0400, Joshua Brindle wrote:
>>> Dominick Grift wrote:
>>>> On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:the
>>>>> Dominick Grift wrote:
>>>>> <snip>
>>>>>=20
>>>>>> The idea is nice, unfortunately its inflexible and it has =
hard-references to reference policy all-over. It has potential but it is =
still rough.
>>>>>>=20
>>>>> Of course, it is an analysis of a refpolicy-based policy. If you =
want to
>>>>> analyze a different policy (e.g., Android or home-rolled) you will =
have to
>>>>> change out all of the type sets, etc.
>>>>>=20
>>>>> You can't make a magic generic analysis script without knowing how =
key parts
>>>>> of the system work and what types are associated with those =
components.
>>>>=20
>>>> What do you mean? that for example that hard-coded array of =
"trusted" types. Is that not just redundant.
>>>>=20
>>>=20
>>> you mean the example trusted types? I'm not sure I understand your =
concern.
>>>=20
>>>> Can't i just create that array myself and use it to exlude rules =
with types in that array? That was one does not have to hard-code it.
>>>>=20
>>>=20
>>> It is python, you can do anything you want. The example notebook is =
a
>>> starting point, anyone doing an analysis would probably make major =
changes
>>> for their analysis, which is the point. You modify the notebook to =
build a
>>> usable analysis between the starting policy and the policy you are
>>> analyzing.
>>>=20
>>> I've thought about trying this on an Android policy but haven't made =
it a
>>> priority.
>>>=20
>>>> Also with regard to hardcoding the refpolicy file system =
(ps.load_policy_source). I mean if youre just going to `grep -r` then =
why do we have to assume anything there and hard code file suffixed, =
directory structures etc etc?
>>>=20
>>>=20
>>=20
>> ahh.. sorry. I just noticed that it can be overriden:
>>=20
>> p, ps, bp, bps =3D =
se.load_policies_from_config("policy_paths.config")
>>=20
>> so i suppose i should be able to add that file to the notebook dir =
and specify my own paths.
>>=20
>> although that still doesnt deal with any file suffixes? (.cil)
>=20
>=20
> take for example: =
https://github.com/QuarkSecurity/SPAN/blob/master/span/span.py#L331 =
<https://github.com/QuarkSecurity/SPAN/blob/master/span/span.py#L331>
>=20
> "domain" is a reference policy type attribute
>=20
> One should expand on the "policy_paths.config" concept and allow us, =
via configuration files, to override all the variables (attributes, =
suffixes, paths, identifiers, etc)
>=20
> So that the variables can we adjusted without the need to =
reinstall/recompile a modified SPAN
>=20
> Or just rename to RPAN (reference policy analysis notebook)

I think it=E2=80=99s best to think of these as having three basic =
layers:

1. Basic tools for SELinux policy analysis in Jupyter - these are usable =
for any policy and make no assumptions about the presence of any types, =
attributes, object classes, or permissions. So things like the rule =
searching and information flow analysis fit into this group. This is a =
large part of the value of SPAN.

2. Higher-level policy analysis methods - these are things like the =
domain_types method and the domain / type summaries. These make some =
minimal assumptions about attributes like domain. I=E2=80=99ll just =
mention that these assumptions are very minimal and have been around for =
a _long_ time. Domain long pre-dates the reference policy, for example. =
More than attributes this layer is tied to the Linux object classes and =
permissions.

3. Example notebooks - the two example notebooks are just that - =
examples. They probably provide a useful starting point, but as Josh =
points out, should simply be modified for your specific use case.

So the question, then, is should the second layer (the higher-level =
policy analysis methods) be made configurable. Honestly I think it would =
be more work than just creating your own versions for a policy that =
breaks the assumptions. To me, that=E2=80=99s the great advantage of =
this versus other analysis tools. It=E2=80=99s so simple to create quick =
tools that meet your needs. And given that the vast majority of Linux =
and Android systems meet the assumptions I think that this is a =
reasonable approach.

Thanks - Karl

>=20
>>=20
>> --=20
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
>> =
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02=
 =
<https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2>
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


--Apple-Mail=_BA47C1C6-D30A-4668-BC9B-813F3298A8C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 8, 2017, at 5:32 AM, Dominick Grift &lt;<a =
href=3D"mailto:dac.override@gmail.com" =
class=3D"">dac.override@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Mon, May 08, 2017 at =
10:55:55AM +0200, Dominick Grift wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">On Sun, May 07, 2017 at =
03:42:50PM -0400, Joshua Brindle wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">Dominick Grift wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">On Sun, May 07, 2017 at 11:22:00AM -0400, =
Joshua Brindle wrote:the<br class=3D""><blockquote type=3D"cite" =
class=3D"">Dominick Grift wrote:<br class=3D"">&lt;snip&gt;<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">The idea =
is nice, unfortunately its inflexible and it has hard-references to =
reference policy all-over. It has potential but it is still rough.<br =
class=3D""><br class=3D""></blockquote>Of course, it is an analysis of a =
refpolicy-based policy. If you want to<br class=3D"">analyze a different =
policy (e.g., Android or home-rolled) you will have to<br =
class=3D"">change out all of the type sets, etc.<br class=3D""><br =
class=3D"">You can't make a magic generic analysis script without =
knowing how key parts<br class=3D"">of the system work and what types =
are associated with those components.<br class=3D""></blockquote><br =
class=3D"">What do you mean? that for example that hard-coded array of =
"trusted" types. Is that not just redundant.<br class=3D""><br =
class=3D""></blockquote><br class=3D"">you mean the example trusted =
types? I'm not sure I understand your concern.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Can't i just create that =
array myself and use it to exlude rules with types in that array? That =
was one does not have to hard-code it.<br class=3D""><br =
class=3D""></blockquote><br class=3D"">It is python, you can do anything =
you want. The example notebook is a<br class=3D"">starting point, anyone =
doing an analysis would probably make major changes<br class=3D"">for =
their analysis, which is the point. You modify the notebook to build =
a<br class=3D"">usable analysis between the starting policy and the =
policy you are<br class=3D"">analyzing.<br class=3D""><br class=3D"">I've =
thought about trying this on an Android policy but haven't made it a<br =
class=3D"">priority.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">Also with regard to hardcoding the refpolicy =
file system (ps.load_policy_source). I mean if youre just going to `grep =
-r` then why do we have to assume anything there and hard code file =
suffixed, directory structures etc etc?<br class=3D""></blockquote><br =
class=3D""><br class=3D""></blockquote><br class=3D"">ahh.. sorry. I =
just noticed that it can be overriden:<br class=3D""><br class=3D"">p, =
ps, bp, bps =3D se.load_policies_from_config("policy_paths.config")<br =
class=3D""><br class=3D"">so i suppose i should be able to add that file =
to the notebook dir and specify my own paths.<br class=3D""><br =
class=3D"">although that still doesnt deal with any file suffixes? =
(.cil)<br class=3D""></blockquote><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
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
!important;" class=3D"">take for example:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://github.com/QuarkSecurity/SPAN/blob/master/span/span.py#L33=
1" style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">https://github.com/QuarkSecurity/SPAN/blob/master/span/span.py#=
L331</a><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
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
display: inline !important;" class=3D"">"domain" is a reference policy =
type attribute</span><br style=3D"font-family: Helvetica; font-size: =
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
display: inline !important;" class=3D"">One should expand on the =
"policy_paths.config" concept and allow us, via configuration files, to =
override all the variables (attributes, suffixes, paths, identifiers, =
etc)</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
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
display: inline !important;" class=3D"">So that the variables can we =
adjusted without the need to reinstall/recompile a modified =
SPAN</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
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
display: inline !important;" class=3D"">Or just rename to RPAN =
(reference policy analysis notebook)</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>I think =
it=E2=80=99s best to think of these as having three basic =
layers:</div><div><br class=3D""></div><div>1. Basic tools for SELinux =
policy analysis in Jupyter - these are usable for any policy and make no =
assumptions about the presence of any types, attributes, object classes, =
or permissions. So things like the rule searching and information flow =
analysis fit into this group. This is a large part of the value of =
SPAN.</div><div><br class=3D""></div><div>2. Higher-level policy =
analysis methods - these are things like the domain_types method and the =
domain / type summaries. These make some minimal assumptions about =
attributes like domain. I=E2=80=99ll just mention that these assumptions =
are very minimal and have been around for a _long_ time. Domain long =
pre-dates the reference policy, for example. More than attributes this =
layer is tied to the Linux object classes and permissions.</div><div><br =
class=3D""></div><div>3. Example notebooks - the two example notebooks =
are just that - examples. They probably provide a useful starting point, =
but as Josh points out, should simply be modified for your specific use =
case.</div><div><br class=3D""></div><div>So the question, then, is =
should the second layer (the higher-level policy analysis methods) be =
made configurable. Honestly I think it would be more work than just =
creating your own versions for a policy that breaks the assumptions. To =
me, that=E2=80=99s the great advantage of this versus other analysis =
tools. It=E2=80=99s so simple to create quick tools that meet your =
needs. And given that the vast majority of Linux and Android systems =
meet the assumptions I think that this is a reasonable =
approach.</div><div><br class=3D""></div><div>Thanks - Karl</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">Key =
fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 &nbsp;02D5 3B6C 5F1D 2C7B =
6B02<br class=3D""><a =
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

--Apple-Mail=_BA47C1C6-D30A-4668-BC9B-813F3298A8C0--
