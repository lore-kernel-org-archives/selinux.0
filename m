Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q73Ng51c004067
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2012 19:42:05 -0400
Received: from StaEx7mb3.telecom.sna.samsung.com ([105.52.12.125]) by cuda3.sta.samsung.com with ESMTP id gPyyaaag8ksenGxG for <selinux@tycho.nsa.gov>; Fri, 03 Aug 2012 18:38:03 -0500 (CDT)
From: Leonard Miyata <l.miyata@sta.samsung.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 3 Aug 2012 18:36:53 -0500
Subject: seinfo tag label
Message-ID: <C1432A7484D61749AF22A060C2B03C5D061854A865@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: multipart/alternative;
	boundary="_000_C1432A7484D61749AF22A060C2B03C5D061854A865StaEx7mb3tele_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_C1432A7484D61749AF22A060C2B03C5D061854A865StaEx7mb3tele_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been tasked with working on the Middleware Flask implementation for th=
e SE Android Project. After spending some time trying to figure out the exi=
sting Android Permission enforcement, as well as the current state of the S=
E Linux/Android implementation, I am starting to develop some concerns on t=
he usefulness of the Middleware implementation of the seinfo tag informatio=
n.

The seinfo tag is defined in 'class ApplicationInfo'. The 'class ActivityMa=
nagerService' maintains multiple Hash Sets of the current running applicati=
ons (one indexed by packagename/uid, another indexed by pid) of 'class Proc=
essRecord', which contains a 'ApplicationInfo info' field that would contai=
n the seinfo Tag information...

However, the comment in 'class ProcessRecord' for the 'ApplicationInfo info=
' field is "all about the first app in the process" which would seem to imp=
ly that you can have other apps, (possibly installed with different Securit=
y Properties) associated with the Process, and could be a potential loophol=
e for Middleware Flask enforcement.

It could very well be that calling down to the SE Linux Kernel and extracti=
ng the Security Context associated with the pid may provide better 'trust' =
for a security 'tag', but I have yet to figure out the relationship between=
 the 'Flask' labels returned by the SE Linux Security Context, and the X.50=
9 Certs, (and associated digital signatures) used to verify the 'trust' lev=
els of installed packages.

Any comments on this and Middleware Flask implementation in general?


Leonard Miyata

--_000_C1432A7484D61749AF22A060C2B03C5D061854A865StaEx7mb3tele_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>I&#8217;ve been =
tasked with working on the Middleware Flask implementation for the SE Andro=
id Project. After spending some time trying to figure out the existing Andr=
oid Permission enforcement, as well as the current state of the SE Linux/An=
droid implementation, I am starting to develop some concerns on the usefuln=
ess of the Middleware implementation of the seinfo tag information.<o:p></o=
:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The s=
einfo tag is defined in &#8216;class ApplicationInfo&#8217;. The &#8216;cla=
ss ActivityManagerService&#8217; maintains multiple Hash Sets of the curren=
t running applications (one indexed by packagename/uid, another indexed by =
pid) of &#8216;class ProcessRecord&#8217;, which contains a &#8216;Applicat=
ionInfo info&#8217; field that would contain the seinfo Tag information&#82=
30;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoN=
ormal>However, the comment in &#8216;class ProcessRecord&#8217; for the &#8=
216;ApplicationInfo info&#8217; field is &#8220;all about the <b><i>first a=
pp</i></b> in the process&#8221; which would seem to imply that you can hav=
e other apps, (possibly installed with different Security Properties) assoc=
iated with the Process, and could be a potential loophole for Middleware Fl=
ask enforcement.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p=
 class=3DMsoNormal>It could very well be that calling down to the SE Linux =
Kernel and extracting the Security Context associated with the pid may prov=
ide better &#8216;trust&#8217; for a security &#8216;tag&#8217;, but I have=
 yet to figure out the relationship between the &#8216;Flask&#8217; labels =
returned by the SE Linux Security Context, and the X.509 Certs, (and associ=
ated digital signatures) used to verify the &#8216;trust&#8217; levels of i=
nstalled packages.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p>=
<p class=3DMsoNormal>Any comments on this and Middleware Flask implementati=
on in general?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p c=
lass=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Leonard Miyata<o=
:p></o:p></p></div></body></html>=

--_000_C1432A7484D61749AF22A060C2B03C5D061854A865StaEx7mb3tele_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
