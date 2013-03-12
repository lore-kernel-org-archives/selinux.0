Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2CKu0PX027616
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2013 16:56:00 -0400
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 946EDC3522_13F965FB
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2013 20:55:59 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
	by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id 1CBFDC063A_13F965FF
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2013 20:55:59 +0000 (GMT)
From: "Langland, Blake" <blangland@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: SELinux network labeling
Date: Tue, 12 Mar 2013 20:55:58 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
	boundary="_000_DA8D339A60101247B36E202899B1C93A7C9378CHUNEX01integrity_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_DA8D339A60101247B36E202899B1C93A7C9378CHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to set up a system using SELinux system that needs to have cert=
ain network traffic blocked based on the MLS label. Basically, there are tw=
o machines running SELinux (call them A and B). Both machines have two proc=
esses, say A1 and B1 are at sensitivity s0, and A2 and B2 are at s1. I want=
 to let process A1 talk to B1, and A2 talk to B2, but block A1->B2, and A2-=
>B1. Without using labeled IPsec, what systems for network labeling should =
I use? With the Netlabel fallback labels I am not able to specify the port.=
 I currently am setting the label via secmark based on the source, destinat=
ion, and port, and then running each process at the appropriate level, and =
also have the port labeled at the appropriate level. This is not blocking t=
he traffic I want it to.

I have been reading Paul Moore's blogs about Secmark and network labeling a=
nd am a little bit confused about packet vs. peer labeling. Are both packet=
 and peer labeling required? If both are, am I out of luck since Netlabel c=
an not specify a port? If only packet labeling is required, what is causing=
 the scheme explained above to not block traffic?

Thank you,
Blake Langland


--_000_DA8D339A60101247B36E202899B1C93A7C9378CHUNEX01integrity_
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
<p class=3D"MsoNormal">I am trying to set up a system using SELinux system =
that needs to have certain network traffic blocked based on the MLS label. =
Basically, there are two machines running SELinux (call them A and B). Both=
 machines have two processes, say
 A1 and B1 are at sensitivity s0, and A2 and B2 are at s1. I want to let pr=
ocess A1 talk to B1, and A2 talk to B2, but block A1-&gt;B2, and A2-&gt;B1.=
 Without using labeled IPsec, what systems for network labeling should I us=
e? With the Netlabel fallback labels I
 am not able to specify the port. I currently am setting the label via secm=
ark based on the source, destination, and port, and then running each proce=
ss at the appropriate level, and also have the port labeled at the appropri=
ate level. This is not blocking
 the traffic I want it to.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have been reading Paul Moore&#8217;s blogs about S=
ecmark and network labeling and am a little bit confused about packet vs. p=
eer labeling. Are both packet and peer labeling required? If both are, am I=
 out of luck since Netlabel can not specify
 a port? If only packet labeling is required, what is causing the scheme ex=
plained above to not block traffic?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">Blake Langland<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DA8D339A60101247B36E202899B1C93A7C9378CHUNEX01integrity_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
