Message-ID: <58e7e264.8893620a.b74b6.74d3@mx.google.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Nick Kralevich <nnk@google.com>
From: <thomasclinganjones@gmail.com>
Subject: RE: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
Date: Fri, 7 Apr 2017 12:03:01 -0700
In-Reply-To: <CAFftDdob8RRzPoUP--wyywH1xOLwt+iYTOKN49XZUr48Cag9aQ@mail.gmail.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
 <CAK2Cwb50YuP=3aMvYHWofF-=KEdKyPuiCzrp4Cb4sVbjcHuB+A@mail.gmail.com>
 <CAFftDdo6uqR3DGwZ8jALYf6k_Cb+-0PPgKr3pgCCQSX28jC87Q@mail.gmail.com>
 <CAK2Cwb7fk65zr9ouBvayFOBZyWmhvGi8piLNfoaYOdcb93U5vA@mail.gmail.com>
 <CAFftDdob8RRzPoUP--wyywH1xOLwt+iYTOKN49XZUr48Cag9aQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="_6B637D42-8D8C-477D-9622-F73F3F9DA0C0_"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_6B637D42-8D8C-477D-9622-F73F3F9DA0C0_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

I think you misunderstand the threat. As we found from boot loader and firm=
ware update attacks, the ways to subvert policy are manifold. How can I tel=
l who the =E2=80=9Cmanufacturer=E2=80=9D of my android phone that sets the =
policy really is and do I trust Android to maintain that trust.

thx ..tom

From: William Roberts
Sent: Friday, April 7, 2017 11:59 AM
To: Tom Jones
Cc: seandroid-list@tycho.nsa.gov; selinux@tycho.nsa.gov; Nick Kralevich
Subject: Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE



On Apr 7, 2017 11:44, "Tom Jones" <thomasclinganjones@gmail.com> wrote:
I am highly skeptical of policy setting and the supply chain. In the threat=
 models I create, the supply chain is always the weak, open threat. I could=
 not begin to guess who the manufacturer of a device is. Android, Samsung, =
Verizon or the US Gov't. Is there a threat model for SE Android, or whateve=
r it is called now?

Well SE Android is fully integrated into Android. Vendors create the policy=
 that ends up the boot image, which is typically signature verified at boot=
. If your supply chain is compromised, the selinux policy is your least con=
cern. Under treble it ends up in different DM verity protected images.



I looked at the other site and decided it was looking at the technical prob=
lem and not the policy problem at all.

On Fri, Apr 7, 2017 at 11:23 AM, William Roberts <bill.c.roberts@gmail.com>=
 wrote:


On Fri, Apr 7, 2017 at 11:02 AM, Tom Jones <thomasclinganjones@gmail.com> w=
rote:
I like that, but I wonder at its scope. Would an update to the OS be allowe=
d to update the policy? For example, Microsoft ships updates to the Windows=
 O/S 2 times (at least) per month. Would=C2=A0that type of=C2=A0update to A=
ndroid allow policy updates?

Part of Android's updates include the policy that is loaded, so the update =
mechanism is in place.
=C2=A0

Another question involves the list of authoritative CSPs. That can now be u=
pdated in most O/S available on the market. Is that still allowed to be upd=
ated, or is that already=C2=A0allowed by policy?
..tom

The policy is updated, currently, as part of the root file system. In a fea=
ture in progress, TREBLE (FULL_PRODUCT_TREBLE =3D=3D true), two files, one =
from vendor and one from google are used to
generate the policy.=C2=A0

essentially, the policy only comes from those making the device, theirs no =
random folks adding/removing policy.
=C2=A0

On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich <nnk@google.com> wrote:
I wanted to draw people's attention to the following proposed change:

=C2=A0=C2=A0https://android-review.googlesource.com/367695

In the case of Android, it's common for security policy to be loaded once, =
and never reloaded again. In that case, the locking / unlocking surrounding=
 the in-kernel policy is unnecessary and can be avoided. The patch above tu=
rns the locks into no-ops and ensures that the kernel cannot load a policy =
more than once. End result is that locking and preemption overhead is avoid=
ed and there's less attack surface / code compiled into the kernel.

I would appreciate comments on the change. This feels like a worthwhile cha=
nge for the entire SELinux community.

-- Nick

--=20
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

_______________________________________________
Seandroid-list mailing list
Seandroid-list@tycho.nsa.gov
To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Seandroid-list-request@tych=
o.nsa.gov.



--=20
..tom

_______________________________________________
Seandroid-list mailing list
Seandroid-list@tycho.nsa.gov
To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Seandroid-list-request@tych=
o.nsa.gov.




--=20
Respectfully,

William C Roberts



--=20
..tom



--_6B637D42-8D8C-477D-9622-F73F3F9DA0C0_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.m113729561397367759m-8435650962555701363m2483744922763063904hoenzb
	{mso-style-name:m_113729561397367759m_-8435650962555701363m_24837449227630=
63904hoenzb;}
span.m113729561397367759m-8435650962555701363hoenzb
	{mso-style-name:m_113729561397367759m_-8435650962555701363hoenzb;}
span.m113729561397367759hoenzb
	{mso-style-name:m_113729561397367759hoenzb;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal>I think you misunderstand the threat=
. As we found from boot loader and firmware update attacks, the ways to sub=
vert policy are manifold. How can I tell who the =E2=80=9Cmanufacturer=E2=
=80=9D of my android phone that sets the policy really is and do I trust An=
droid to maintain that trust.</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p>=
<p class=3DMsoNormal>thx ..tom</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p=
><div style=3D'mso-element:para-border-div;border:none;border-top:solid #E1=
E1E1 1.0pt;padding:3.0pt 0in 0in 0in'><p class=3DMsoNormal style=3D'border:=
none;padding:0in'><b>From: </b><a href=3D"mailto:bill.c.roberts@gmail.com">=
William Roberts</a><br><b>Sent: </b>Friday, April 7, 2017 11:59 AM<br><b>To=
: </b><a href=3D"mailto:thomasclinganjones@gmail.com">Tom Jones</a><br><b>C=
c: </b><a href=3D"mailto:seandroid-list@tycho.nsa.gov">seandroid-list@tycho=
.nsa.gov</a>; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.go=
v</a>; <a href=3D"mailto:nnk@google.com">Nick Kralevich</a><br><b>Subject: =
</b>Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE</p></div><p class=3DMsoNormal=
><o:p>&nbsp;</o:p></p><div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><=
div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=3DMsoNormal>On =
Apr 7, 2017 11:44, &quot;Tom Jones&quot; &lt;<a href=3D"mailto:thomasclinga=
njones@gmail.com">thomasclinganjones@gmail.com</a>&gt; wrote:</p><blockquot=
e style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in =
6.0pt;margin-left:4.8pt;margin-right:0in'><div><div><p class=3DMsoNormal>I =
am highly skeptical of policy setting and the supply chain. In the threat m=
odels I create, the supply chain is always the weak, open threat. I could n=
ot begin to guess who the manufacturer of a device is. Android, Samsung, Ve=
rizon or the US Gov't. Is there a threat model for SE Android, or whatever =
it is called now?</p></div></div></blockquote></div></div></div><div><p cla=
ss=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Well SE=
 Android is fully integrated into Android. Vendors create the policy that e=
nds up the boot image, which is typically signature verified at boot. If yo=
ur supply chain is compromised, the selinux policy is your least concern. U=
nder treble it ends up in different DM verity protected images.</p></div><d=
iv><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNorma=
l><o:p>&nbsp;</o:p></p></div><div><div><div><blockquote style=3D'border:non=
e;border-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8=
pt;margin-right:0in'><div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></=
div><div><p class=3DMsoNormal>I looked at the other site and decided it was=
 looking at the technical problem and not the policy problem at all.</p></d=
iv></div><div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=
=3DMsoNormal>On Fri, Apr 7, 2017 at 11:23 AM, William Roberts &lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail=
.com</a>&gt; wrote:</p><blockquote style=3D'border:none;border-left:solid #=
CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in'>=
<div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=3DMsoNormal><o=
:p>&nbsp;</o:p></p><div><p class=3DMsoNormal>On Fri, Apr 7, 2017 at 11:02 A=
M, Tom Jones &lt;<a href=3D"mailto:thomasclinganjones@gmail.com" target=3D"=
_blank">thomasclinganjones@gmail.com</a>&gt; wrote:</p><blockquote style=3D=
'border:none;border-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;marg=
in-left:4.8pt;margin-right:0in'><div><div><p class=3DMsoNormal>I like that,=
 but I wonder at its scope. Would an update to the OS be allowed to update =
the policy? For example, Microsoft ships updates to the Windows O/S 2 times=
 (at least) per month. Would&nbsp;that type of&nbsp;update to Android allow=
 policy updates?</p></div></div></blockquote><div><p class=3DMsoNormal><o:p=
>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Part of Android's updates =
include the policy that is loaded, so the update mechanism is in place.</p>=
</div><div><p class=3DMsoNormal>&nbsp;</p></div><blockquote style=3D'border=
:none;border-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left=
:4.8pt;margin-right:0in'><div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></=
p></div><div><p class=3DMsoNormal>Another question involves the list of aut=
horitative CSPs. That can now be updated in most O/S available on the marke=
t. Is that still allowed to be updated, or is that already&nbsp;allowed by =
policy?</p></div><div><p class=3DMsoNormal>..tom</p></div></div></blockquot=
e><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoN=
ormal>The policy is updated, currently, as part of the root file system. In=
 a feature in progress, TREBLE (FULL_PRODUCT_TREBLE =3D=3D true), two files=
, one from vendor and one from google are used to<br>generate the policy.&n=
bsp;</p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>essentially, the policy only comes from those making the =
device, theirs no random folks adding/removing policy.</p></div><div><p cla=
ss=3DMsoNormal>&nbsp;</p></div><blockquote style=3D'border:none;border-left=
:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-rig=
ht:0in'><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><div><p cl=
ass=3DMsoNormal>On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich &lt;<a href=
=3D"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>&gt; wrote:<=
/p></div></div><blockquote style=3D'border:none;border-left:solid #CCCCCC 1=
.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in'><div><di=
v><div><div><p class=3DMsoNormal>I wanted to draw people's attention to the=
 following proposed change:</p></div><div><p class=3DMsoNormal><o:p>&nbsp;<=
/o:p></p></div><div><p class=3DMsoNormal>&nbsp;&nbsp;<a href=3D"https://and=
roid-review.googlesource.com/367695" target=3D"_blank">https://android-revi=
ew.googlesource.com/367695</a></p></div><div><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p></div><div><p class=3DMsoNormal>In the case of Android, it's co=
mmon for security policy to be loaded once, and never reloaded again. In th=
at case, the locking / unlocking surrounding the in-kernel policy is unnece=
ssary and can be avoided. The patch above turns the locks into no-ops and e=
nsures that the kernel cannot load a policy more than once. End result is t=
hat locking and preemption overhead is avoided and there's less attack surf=
ace / code compiled into the kernel.</p></div><div><p class=3DMsoNormal><o:=
p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>I would appreciate commen=
ts on the change. This feels like a worthwhile change for the entire SELinu=
x community.</p></div><div><p class=3DMsoNormal><span style=3D'color:#88888=
8'><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span style=
=3D'color:#888888'>-- Nick<o:p></o:p></span></p></div><div><p class=3DMsoNo=
rmal><span style=3D'color:#888888'><o:p>&nbsp;</o:p></span></p></div><p cla=
ss=3DMsoNormal><span class=3Dm113729561397367759m-8435650962555701363m24837=
44922763063904hoenzb><span style=3D'color:#888888'>-- </span><o:p></o:p></s=
pan></p><div><div><p class=3DMsoNormal><span style=3D'color:#888888'>Nick K=
ralevich | Android Security | <a href=3D"mailto:nnk@google.com" target=3D"_=
blank">nnk@google.com</a> | <a href=3D"tel:(650)%20214-4037" target=3D"_bla=
nk">650.214.4037</a></span></p></div></div></div><p class=3DMsoNormal><o:p>=
&nbsp;</o:p></p></div></div><p class=3DMsoNormal>__________________________=
_____________________<br>Seandroid-list mailing list<br><a href=3D"mailto:S=
eandroid-list@tycho.nsa.gov" target=3D"_blank">Seandroid-list@tycho.nsa.gov=
</a><br>To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leav=
e@tycho.nsa.gov" target=3D"_blank">Seandroid-list-leave@tycho.nsa.gov</a>.<=
br>To get help, send an email containing &quot;help&quot; to <a href=3D"mai=
lto:Seandroid-list-request@tycho.nsa.gov" target=3D"_blank">Seandroid-list-=
request@tycho.nsa.gov</a>.</p></blockquote></div><p class=3DMsoNormal><span=
 style=3D'color:#888888'><br><br clear=3Dall><br><span class=3Dm11372956139=
7367759m-8435650962555701363hoenzb>-- <o:p></o:p></span></span></p><div><p =
class=3DMsoNormal><span style=3D'color:#888888'>..tom</span></p></div></div=
><p class=3DMsoNormal><br>_______________________________________________<b=
r>Seandroid-list mailing list<br><a href=3D"mailto:Seandroid-list@tycho.nsa=
.gov" target=3D"_blank">Seandroid-list@tycho.nsa.gov</a><br>To unsubscribe,=
 send email to <a href=3D"mailto:Seandroid-list-leave@tycho.nsa.gov" target=
=3D"_blank">Seandroid-list-leave@tycho.nsa.gov</a>.<br>To get help, send an=
 email containing &quot;help&quot; to <a href=3D"mailto:Seandroid-list-requ=
est@tycho.nsa.gov" target=3D"_blank">Seandroid-list-request@tycho.nsa.gov</=
a>.</p></blockquote></div><p class=3DMsoNormal><span style=3D'color:#888888=
'><br><br clear=3Dall><span class=3Dm113729561397367759hoenzb><o:p></o:p></=
span></span></p><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><p cla=
ss=3DMsoNormal><span class=3Dm113729561397367759hoenzb><span style=3D'color=
:#888888'>-- </span><o:p></o:p></span></p><div><p class=3DMsoNormal style=
=3D'margin-bottom:12.0pt'><span style=3D'color:#888888'>Respectfully,<br><b=
r>William C Roberts</span></p></div></div></div></blockquote></div><p class=
=3DMsoNormal><br><br clear=3Dall></p></div><p class=3DMsoNormal><span style=
=3D'color:#888888'>-- <o:p></o:p></span></p><div><p class=3DMsoNormal><span=
 style=3D'color:#888888'>..tom<o:p></o:p></span></p></div></div></blockquot=
e></div></div></div></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p clas=
s=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_6B637D42-8D8C-477D-9622-F73F3F9DA0C0_--
