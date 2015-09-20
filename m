Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8KDKWW5022793
 for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2015 09:20:32 -0400
Received: by wicfx3 with SMTP id fx3so79981115wic.0
 for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2015 06:20:27 -0700 (PDT)
Received: from LordFire (93-34-88-239.ip49.fastwebnet.it. [93.34.88.239])
 by smtp.gmail.com with ESMTPSA id t7sm8336150wia.9.2015.09.20.06.20.26
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Sep 2015 06:20:26 -0700 (PDT)
From: "Gmail" <pag.maurizio@gmail.com>
To: <selinux@tycho.nsa.gov>
Subject: How can i remove net_raw capability from unconfined?
Date: Sun, 20 Sep 2015 15:20:36 +0200
Message-ID: <004b01d0f3a7$2425cf10$6c716d30$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_004C_01D0F3B7.E7AEED30"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_004C_01D0F3B7.E7AEED30
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

 

I need to understand how can i remove net_raw capability from unconfined_t
domain, someone can help me?

I  need the source policy? Or can i remove another way? The systems are RHE=
L
6 and RHEL 7.

 

Thanks in advance,

 

Maurizio Pagani (LordFire in  #SELinux)



---
Questa e-mail =C3=A8 stata controllata per individuare virus con Avast anti=
virus.
https://www.avast.com/antivirus

------=_NextPart_000_004C_01D0F3B7.E7AEED30
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3DUTF-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
=2EMsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DIT link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o=
:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I nee=
d to understand how can i remove net_raw capability from unconfined_t domai=
n, someone can help me?<o:p></o:p></p><p class=3DMsoNormal>I &nbsp;need the=
 source policy? Or can i remove another way? The systems are RHEL 6 and RHE=
L 7.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMso=
Normal>Thanks in advance,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o=
:p></p><p class=3DMsoNormal>Maurizio Pagani (LordFire in&nbsp; #SELinux)<o:=
p></o:p></p></div>
<br /><br />
<hr style=3D'border:none; color:#909090; background-color:#B0B0B0; height: =
1px; width: 99%;' />
<table style=3D'border-collapse:collapse;border:none;'>
	<tr>
		<td style=3D'border:none;padding:0px 15px 0px 8px'>
			<a href=3D"https://www.avast.com/antivirus">
				<img border=3D0 src=3D"http://static.avast.com/emails/avast-mail-stamp.=
png" alt=3D"Avast logo" />
			</a>
		</td>
		<td>
			<p style=3D'color:#3d4d5a; font-family:"Calibri","Verdana","Arial","Helv=
etica"; font-size:12pt;'>
				Questa e-mail =C3=A8 stata controllata per individuare virus con Avast =
antivirus.
				<br><a href=3D"https://www.avast.com/antivirus">www.avast.com</a>
			</p>
		</td>
	</tr>
</table>
<br />
</body></html>
------=_NextPart_000_004C_01D0F3B7.E7AEED30--
