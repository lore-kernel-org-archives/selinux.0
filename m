Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2HH1rMg004318
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 13:01:54 -0400
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id DC25FC3588_3272A80B
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 17:01:52 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
 by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id
 713C7C0619_3272A80F
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 17:01:52 +0000 (GMT)
From: "Langland, Blake" <blangland@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: SELinux design and Domain Name resolution
Date: Mon, 17 Mar 2014 17:01:51 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93AB4E642@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
 boundary="_000_DA8D339A60101247B36E202899B1C93AB4E642CHUNEX01integrity_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_DA8D339A60101247B36E202899B1C93AB4E642CHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a couple general design questions in relation to SELinux but I need =
to explain my whole situation for them to make sense, so here it goes...

I am working on implementing a MLS SOA architecture and we are trying to us=
e SELinux. I would like to explain our current plan and hopefully get some =
feedback from people who have done similar work. Basically, our team is tas=
ked with taking an existing SOA and turning it into a MLS SOA. The existing=
 SOA Architecture is fairly typical with things like a machine running Apac=
he web server which proxies requests to a machine running Tomcat; Let's foc=
us on these machines and two security domains.

In order to create two domains, we would need a web server and Tomcat at ea=
ch level, so we have two installations of Apache on VM A and two installati=
ons of Tomcat on VM B. Since clients expect Apache to bind on standard port=
s (80 & 443) it made sense to have each installation bind on a different ne=
twork interface, so each VM has two network interfaces, one for each domain=
. Is this a typical way to achieve the separation we want? Should we have e=
ach Apache and Tomcat instance bind on the same interface but use different=
 ports? Does it even make sense to have two web servers, or two Tomcat inst=
ances running on the same machine (as opposed to using two VMs for each lev=
el)?

The problem that we have run into with our current approach (1 VM, 2 instal=
lations, and 2 Network interfaces) is domain name resolution. We are essent=
ially given these applications (Apache, Tomcat, among many other) as black =
boxes that we plug into our environment. For example, if the Apache we are =
given knows the Tomcat VM as "tomcat", we would need to modify each Apache =
instance to then proxy to the appropriate Tomcat VM interface, such as "tom=
cat_a" and "tomcat_b." This is further complicated on the Tomcat VM as it i=
s running OWF with also expects other web applications to exist at "tomcat.=
" Since we are given these as "black boxes," we can't really go find all co=
nfigurations that reference "tomcat" and change it to either "tomcat_a" or =
"tomcat_b."

Any comments or previous experiences would be greatly appreciated.

Thanks,
Blake Langland

--_000_DA8D339A60101247B36E202899B1C93AB4E642CHUNEX01integrity_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a couple general design questions in relation=
 to SELinux but I need to explain my whole situation for them to make sense=
, so here it goes&#8230;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on implementing a MLS SOA architecture =
and we are trying to use SELinux. I would like to explain our current plan =
and hopefully get some feedback from people who have done similar work. Bas=
ically, our team is tasked with taking
 an existing SOA and turning it into a MLS SOA. The existing SOA Architectu=
re is fairly typical with things like a machine running Apache web server w=
hich proxies requests to a machine running Tomcat; Let&#8217;s focus on the=
se machines and two security domains.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In order to create two domains, we would need a web =
server and Tomcat at each level, so we have two installations of Apache on =
VM A and two installations of Tomcat on VM B. Since clients expect Apache t=
o bind on standard ports (80 &amp; 443)
 it made sense to have each installation bind on a different network interf=
ace, so each VM has two network interfaces, one for each domain. Is this a =
typical way to achieve the separation we want? Should we have each Apache a=
nd Tomcat instance bind on the same
 interface but use different ports? Does it even make sense to have two web=
 servers, or two Tomcat instances running on the same machine (as opposed t=
o using two VMs for each level)?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The problem that we have run into with our current a=
pproach (1 VM, 2 installations, and 2 Network interfaces) is domain name re=
solution. We are essentially given these applications (Apache, Tomcat, amon=
g many other) as black boxes that
 we plug into our environment. For example, if the Apache we are given know=
s the Tomcat VM as &#8220;tomcat&#8221;, we would need to modify each Apach=
e instance to then proxy to the appropriate Tomcat VM interface, such as &#=
8220;tomcat_a&#8221; and &#8220;tomcat_b.&#8221; This is further complicate=
d
 on the Tomcat VM as it is running OWF with also expects other web applicat=
ions to exist at &#8220;tomcat.&#8221; Since we are given these as &#8220;b=
lack boxes,&#8221; we can&#8217;t really go find all configurations that re=
ference &#8220;tomcat&#8221; and change it to either &#8220;tomcat_a&#8221;=
 or &#8220;tomcat_b.&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any comments or previous experiences would be greatl=
y appreciated.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Blake Langland<o:p></o:p></p>
</div>
</body>
</html>

--_000_DA8D339A60101247B36E202899B1C93AB4E642CHUNEX01integrity_--
