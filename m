Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0VBnFo3012822
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 06:49:15 -0500
Received: from ams-iport-1.cisco.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0VBnDva027636
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 11:49:13 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CBC13C.E0884347"
Subject: RE: Tiny version of SE-PostgreSQL got merged
Date: Mon, 31 Jan 2011 12:49:10 +0100
Message-ID: <0B31D28E10F4FA489A0261135B94A14804A45790@XMB-AMS-109.cisco.com>
In-Reply-To: <4D46A10F.6060809@rubix.com>
References: <4D466F3B.6090906@ak.jp.nec.com> <0B31D28E10F4FA489A0261135B94A14804A456B3@XMB-AMS-109.cisco.com> <4D469BA4.8@itechfrontiers.com> <4D46A10F.6060809@rubix.com>
From: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>
To: "Andy Warner" <warner@rubix.com>, <cto@itechfrontiers.com>
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBC13C.E0884347
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks. Where do I get info on DBMS's that are trusted? I have
considerations for Oracle Timesten, Informix IDS server and PostgresSQL.
Are there specific projects for these?

=20

From: Andy Warner [mailto:warner@rubix.com]=20
Sent: Monday, January 31, 2011 11:46 AM
To: cto@itechfrontiers.com
Cc: Ger Lawlor (gelawlor); KaiGai Kohei; selinux@tycho.nsa.gov
Subject: Re: Tiny version of SE-PostgreSQL got merged

=20

I would add that using a partitioned architecture (e.g., "it is possible
to achieve this by separation of databases and their storage location")
is not the same as having an integrated MLS database. There are certain
abilities that will not be nativly available, such as row based
polyinstantiation (I realize PG does not do this but others MLS DBMS's
do), true multi-level table views, and intra-table, inter-level key
uniqueness. There are other functionality that also would not be
possible with a partitioned approach. This is why, at least on some
level, Trusted DBMS's (MLS and other policies) continue to exist.=20

 =20
On 1/31/2011 12:23 PM, cto@itechfrontiers.com wrote:=20

Hello Ger.=20

I actually asked this before from Mr. Kohei, and we had a hot debate
here I refer you to this archive:=20

http://marc.info/?l=3Dselinux&m=3D129178180819602&w=3D2=20

Also this is original proposal of the project from Mr. KaiGai Kohei=20

http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf=20

In brief:=20

Since it is possible to use file labels and database locations and have
multiple instances of Postgresql as it is process based daemon, and just
separate classified and unclassified databases from each other=20

BUT:=20

the goal of Mr. KaiGai Kohei and se-postgresql project is to introduce
MLS  (Multilevel Security) to the structure of the database and its ACL
model for each user of the database in example up to the rows and
columns, so in practice THEORETICALLY it would be possible to mix
classified or unclassified records within a single database and have
various levels of users with different levels of access=20
(however in practice it may not be recommended)=20

Currently with PostgreSQL it is possible to achieve this by separation
of databases and their storage location; you have to completely separate
the datases, processes and daemons accessing such resources up to
different classifications you want to serve records on an MLS systems.=20



Best,=20

Patrick K.=20





On 1/31/2011 5:09 AM, Ger Lawlor (gelawlor) wrote:=20



I'm only new to SeLinux, but will have requirements around PostgreSQL.=20
Can you give me some background and info on why=20
This SE-PostgresQL exists? Is it specific to this database, or are there

similar projects for other database types?=20
Was it not possible to label files within a default installation? Was=20
this insufficient for Postgres security?=20

Thanks,=20
Ger.=20

-----Original Message-----=20
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]=20
On Behalf Of KaiGai Kohei=20
Sent: Monday, January 31, 2011 8:14 AM=20
To: selinux@tycho.nsa.gov=20
Subject: Tiny version of SE-PostgreSQL got merged=20

A few days ago, a tiny initial version of SE-PostgreSQL got merged=20
in the v9.1 development cycle at this commit: http://bit.ly/gF2QPQ=20

Although it omits various features which I planned at first, it=20
seems to me an ambitious first step.=20
PostgreSQL has shifted to provide a set of facilities to implement=20
label based mandatory access control, such as security label support=20
on database objects or security hooks being available for plug-in=20
modules.=20

The current version of SE-PostgreSQL is implemented as a plugin=20
module that utilizes these hooks (but only a limited places are=20
covered), then it asks SELinux in kernel whether the required=20
access shall be allowed, or not.=20

In the next development, I'd like to expand its access control coverage=20
using more fine grained security hooks. Right now, DDL permissions are=20
restrictions. Also, row-level security is in-progress feature.=20

I have much things to do for the v9.2 or v9.3, however, I'd like to=20
appreciate people who have given me many feedbacks since 2006=20

Thanks,=20



--=20
This message was distributed to subscribers of the selinux mailing list.

If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with=20
the words "unsubscribe selinux" without quotes as the message.=20


------_=_NextPart_001_01CBC13C.E0884347
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
</o:shapelayout></xml><![endif]--></head><body bgcolor=3Dwhite =
lang=3DEN-US link=3Dblue vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Thanks. Where do I get info on DBMS&#8217;s that are trusted? I have =
considerations for Oracle Timesten, Informix IDS server and PostgresSQL. =
Are there specific projects for these?<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:windowt=
ext'>From:</span></b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:windowt=
ext'> Andy Warner [mailto:warner@rubix.com] <br><b>Sent:</b> Monday, =
January 31, 2011 11:46 AM<br><b>To:</b> =
cto@itechfrontiers.com<br><b>Cc:</b> Ger Lawlor (gelawlor); KaiGai =
Kohei; selinux@tycho.nsa.gov<br><b>Subject:</b> Re: Tiny version of =
SE-PostgreSQL got merged<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Arial","sans-serif"'>I would add that using a =
partitioned architecture </span>(e.g., &quot;it is possible to achieve =
this by separation of databases and their storage location&quot;) is not =
the same as having an integrated MLS database. There are certain =
abilities that will not be nativly available, such as row based =
polyinstantiation (I realize PG does not do this but others MLS DBMS's =
do), true multi-level table views, and intra-table, inter-level key =
uniqueness. There are other functionality that also would not be =
possible with a partitioned approach. This is why, at least on some =
level, Trusted DBMS's (MLS and other policies) continue to exist. =
<br><br>&nbsp; <br>On 1/31/2011 12:23 PM, <a =
href=3D"mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</a> wrote: =
<o:p></o:p></p><p class=3DMsoNormal>Hello Ger. <br><br>I actually asked =
this before from Mr. Kohei, and we had a hot debate here I refer you to =
this archive: <br><br><a =
href=3D"http://marc.info/?l=3Dselinux&amp;m=3D129178180819602&amp;w=3D2">=
http://marc.info/?l=3Dselinux&amp;m=3D129178180819602&amp;w=3D2</a> =
<br><br>Also this is original proposal of the project from Mr. KaiGai =
Kohei <br><br><a =
href=3D"http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux=
.pdf">http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.p=
df</a> <br><br>In brief: <br><br>Since it is possible to use file labels =
and database locations and have multiple instances of Postgresql as it =
is process based daemon, and just separate classified and unclassified =
databases from each other <br><br>BUT: <br><br>the goal of Mr. KaiGai =
Kohei and se-postgresql project is to introduce MLS&nbsp; (Multilevel =
Security) to the structure of the database and its ACL model for each =
user of the database in example up to the rows and columns, so in =
practice THEORETICALLY it would be possible to mix classified or =
unclassified records within a single database and have various levels of =
users with different levels of access <br>(however in practice it may =
not be recommended) <br><br>Currently with PostgreSQL it is possible to =
achieve this by separation of databases and their storage location; you =
have to completely separate the datases, processes and daemons accessing =
such resources up to different classifications you want to serve records =
on an MLS systems. <br><br><br><br>Best, <br><br>Patrick K. =
<br><br><br><br><br><br>On 1/31/2011 5:09 AM, Ger Lawlor (gelawlor) =
wrote: <br><br><o:p></o:p></p><p class=3DMsoNormal>I'm only new to =
SeLinux, but will have requirements around PostgreSQL. <br>Can you give =
me some background and info on why <br>This SE-PostgresQL exists? Is it =
specific to this database, or are there <br>similar projects for other =
database types? <br>Was it not possible to label files within a default =
installation? Was <br>this insufficient for Postgres security? =
<br><br>Thanks, <br>Ger. <br><br>-----Original Message----- <br>From: <a =
href=3D"mailto:owner-selinux@tycho.nsa.gov">owner-selinux@tycho.nsa.gov</=
a> [<a =
href=3D"mailto:owner-selinux@tycho.nsa.gov">mailto:owner-selinux@tycho.ns=
a.gov</a>] <br>On Behalf Of KaiGai Kohei <br>Sent: Monday, January 31, =
2011 8:14 AM <br>To: <a =
href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a> =
<br>Subject: Tiny version of SE-PostgreSQL got merged <br><br>A few days =
ago, a tiny initial version of SE-PostgreSQL got merged <br>in the v9.1 =
development cycle at this commit: <a =
href=3D"http://bit.ly/gF2QPQ">http://bit.ly/gF2QPQ</a> <br><br>Although =
it omits various features which I planned at first, it <br>seems to me =
an ambitious first step. <br>PostgreSQL has shifted to provide a set of =
facilities to implement <br>label based mandatory access control, such =
as security label support <br>on database objects or security hooks =
being available for plug-in <br>modules. <br><br>The current version of =
SE-PostgreSQL is implemented as a plugin <br>module that utilizes these =
hooks (but only a limited places are <br>covered), then it asks SELinux =
in kernel whether the required <br>access shall be allowed, or not. =
<br><br>In the next development, I'd like to expand its access control =
coverage <br>using more fine grained security hooks. Right now, DDL =
permissions are <br>restrictions. Also, row-level security is =
in-progress feature. <br><br>I have much things to do for the v9.2 or =
v9.3, however, I'd like to <br>appreciate people who have given me many =
feedbacks since 2006 <br><br>Thanks, <o:p></o:p></p><p =
class=3DMsoNormal><br><br>-- <br>This message was distributed to =
subscribers of the selinux mailing list. <br>If you no longer wish to =
subscribe, send mail to <a =
href=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with =
<br>the words &quot;unsubscribe selinux&quot; without quotes as the =
message. <o:p></o:p></p></div></body></html>
------_=_NextPart_001_01CBC13C.E0884347--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
