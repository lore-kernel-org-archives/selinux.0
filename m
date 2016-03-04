Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u24LGv5d003764
 for <selinux@tycho.nsa.gov>; Fri, 4 Mar 2016 16:16:57 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: initial_sid context via libsepol
Date: Fri, 4 Mar 2016 21:16:36 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56011F6F39@ORSMSX103.amr.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="_000_476DC76E7D1DF2438D32BFADF679FC56011F6F39ORSMSX103amrcor_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_476DC76E7D1DF2438D32BFADF679FC56011F6F39ORSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


How can one obtain the same value as /sys/fs/selinux/initial_contexts/file =
via libsepol?

I've been digging around libsepol and its not quite clear to me.

It looks as though the record is here:
                context_struct_t *a =3D &((policydb_t *)pol.db)->ocontexts[=
OCON_ISID]->context[0];
                context_struct_t *b =3D &((policydb_t *)pol.db)->ocontexts[=
OCON_ISID]->context[1];

                printf("%u\n", a->type);
                printf("%u\n",b->type);

Prints:
185
0

Not sure if this is right, and how to format the context struct to a string=
. I didn't see any helpers.

Thanks,
Bill

--_000_476DC76E7D1DF2438D32BFADF679FC56011F6F39ORSMSX103amrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How can one obtain the same value as /sys/fs/selinux=
/initial_contexts/file via libsepol?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve been digging around libsepol and its not =
quite clear to me.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It looks as though the record is here:<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context_struct_t *a =3D &amp;((polic=
ydb_t *)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context_struct_t *b =3D &amp;((polic=
ydb_t *)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[1];<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%u\n&quot;, a-&gt;type)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%u\n&quot;,b-&gt;type);=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Prints:<o:p></o:p></p>
<p class=3D"MsoNormal">185<o:p></o:p></p>
<p class=3D"MsoNormal">0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Not sure if this is right, and how to format the con=
text struct to a string. I didn&#8217;t see any helpers.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Bill<o:p></o:p></p>
</div>
</body>
</html>

--_000_476DC76E7D1DF2438D32BFADF679FC56011F6F39ORSMSX103amrcor_--
