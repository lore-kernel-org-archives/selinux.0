Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o45EM5Gg025086
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 10:22:05 -0400
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o45ENCNh024945
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 14:23:12 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o45ERGBo006522
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 09:27:20 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 5 May 2010 10:22:00 -0400
Subject: Life cycle process for building products with selinux
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm not sure where to ask a question like this but I bet someone on the lis=
t will know...

Are there any guidelines or "best practices" for building products with sel=
inux?   (Think network appliances for example.)  I have in mind life cycle =
tasks such as

- Software development:  Where in the software development cycle do you int=
roduce selinux?  Should application developers have to develop on a system =
confined by selinux?   Is selinux policy maintenance a software development=
 task, or a separate phase in the development cycle?

- System integration:  Is this where selinux is first turned on?

- QA testing:  should QA testing include selinux-specific penetration testi=
ng?  Any guidelines or examples of how this is done?  Any tools?

- Who in the development organization needs selinux expertise?

- Are there services that can certify the MAC rules for the operating syste=
m?  For the product application?

- Any selinux-specific guidance for customers who install the protected app=
liance?

- Impact on the process for upgrades and patches because of selinux.  What =
not to do... for example, turning off selinux to apply a patch.  How to con=
figure a properly confined user for applying patches.

- Organizational policy to complement a properly designed system (separatio=
n of duties; physical security; etc).

- War stories, lessons learned... or anything of the sort

Thanks
Alan


--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4EUSAACMS0703e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>I'm not sure where to ask a question like this but I bet someone on th=
e list will know&#8230;</div>
<div>&nbsp;</div>
<div>Are there any guidelines or &quot;best practices&quot; for building pr=
oducts with selinux?&nbsp;&nbsp; (Think network appliances for example.)&nb=
sp; I have in mind life cycle tasks such as</div>
<div>&nbsp;</div>
<div>- Software development:&nbsp; Where in the software development cycle =
do you introduce selinux?&nbsp; Should application developers have to devel=
op on a system confined by selinux?&nbsp;&nbsp; Is selinux policy maintenan=
ce a software development task, or a separate phase
in the development cycle?</div>
<div>&nbsp;</div>
<div>- System integration:&nbsp; Is this where selinux is first turned on?&=
nbsp; </div>
<div>&nbsp;</div>
<div>- QA testing:&nbsp; should QA testing include selinux-specific penetra=
tion testing?&nbsp; Any guidelines or examples of how this is done?&nbsp; A=
ny tools?</div>
<div>&nbsp;</div>
<div>- Who in the development organization needs selinux expertise?&nbsp; <=
/div>
<div>&nbsp;</div>
<div>- Are there services that can certify the MAC rules for the operating =
system?&nbsp; For the product application?</div>
<div>&nbsp;</div>
<div>- Any selinux-specific guidance for customers who install the protecte=
d appliance?&nbsp; </div>
<div>&nbsp;</div>
<div>- Impact on the process for upgrades and patches because of selinux.&n=
bsp; What not to do&#8230; for example, turning off selinux to apply a patc=
h.&nbsp; How to configure a properly confined user for applying patches.</d=
iv>
<div>&nbsp;</div>
<div>- Organizational policy to complement a properly designed system (sepa=
ration of duties; physical security; etc).</div>
<div>&nbsp;</div>
<div>- War stories, lessons learned&#8230; or anything of the sort</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Alan</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
