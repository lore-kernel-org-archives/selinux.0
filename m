Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13402
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:02:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA20640
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 22:01:08 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id WAA20632 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 22:01:03 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015243E6@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Ryan Bergauer'" <privateryan@mindspring.com>, selinux@tycho.nsa.gov
Subject: RE: CVS tree make error
Date: Mon, 5 Aug 2002 17:03:01 -0500 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C23CCB.DD989FF0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C23CCB.DD989FF0
Content-Type: text/plain;
	charset="iso-8859-1"

I had the same problem. There was more than on place, I don't remember the
place.
I just delete all occurences of ko..... from the make file. I should have
reported it.
 
Thanks
 
Mark
-----Original Message-----
From: Ryan Bergauer [mailto:privateryan@mindspring.com]
Sent: Monday, August 05, 2002 4:36 PM
To: selinux@tycho.nsa.gov
Subject: CVS tree make error


Just as a heads up, when I make selinux/utils from the current CVS tree I
get:
 
Making all in po
make[3]: Entering directory `/usr/src/selinux/utils/tar-1.13.19/po'
file=./`echo ko | sed 's,.*/,,'`.gmo \
  && rm -f $file && PATH=../src:$PATH /usr/bin/msgfmt -o $file ko.po
ko.po:1431:17: invalid multibyte sequence
ko.po:1434:6: invalid multibyte sequence
/usr/bin/msgfmt: found 2 fatal errors
make[3]: *** [ko.gmo] Error 1
 
This is on a barebones Red Hat 7.3 install. The July 3 release doesn't give
this error.
 
-Ryan 
 

------_=_NextPart_001_01C23CCB.DD989FF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 5.50.4913.1100" name=3DGENERATOR>
<META content=3D"Microsoft Word 10" name=3DOriginator><LINK=20
href=3D"cid:filelist.xml@01C23C9E.24299740" rel=3DFile-List><!--[if gte =
mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; mso-header-margin: .5in; mso-footer-margin: .5in; =
mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: =
personal-compose; mso-style-noshow: yes; mso-ansi-font-size: 10.0pt; =
mso-bidi-font-size: 10.0pt; mso-ascii-font-family: Arial; =
mso-hansi-font-family: Arial; mso-bidi-font-family: Arial
}
SPAN.SpellE {
	mso-style-name: ""; mso-spl-e: yes
}
SPAN.GramE {
	mso-style-name: ""; mso-gram-e: yes
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]--></HEAD>
<BODY lang=3DEN-US style=3D"tab-interval: .5in" vLink=3Dpurple =
link=3Dblue>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff size=3D2>I had=20
the same problem. There was more than on place, I don't remember the=20
place.</FONT></SPAN></DIV>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff size=3D2>I just=20
delete all occurences of ko..... from the make file. I should have =
reported=20
it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D358080322-05082002><FONT face=3DArial =
color=3D#0000ff=20
size=3D2>Mark</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Ryan Bergauer=20
  [mailto:privateryan@mindspring.com]<BR><B>Sent:</B> Monday, August =
05, 2002=20
  4:36 PM<BR><B>To:</B> selinux@tycho.nsa.gov<BR><B>Subject:</B> CVS =
tree make=20
  error<BR><BR></FONT></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Just as a heads up, =
when I make=20
  <SPAN class=3DSpellE>selinux/utils</SPAN> from the current CVS tree I =

  get:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Making all in <SPAN=20
  class=3DSpellE>po</SPAN><o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><SPAN class=3DGramE><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">make[</SPAN></FONT></SPAN><FONT=20
  face=3DArial size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">3]:=20
  Entering directory=20
  `/usr/src/selinux/utils/tar-1.13.19/po'<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><SPAN class=3DGramE><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">file</SPAN></FONT></SPAN><FONT=20
  face=3DArial size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">=3D./`echo=20
  <SPAN class=3DSpellE>ko</SPAN> | <SPAN class=3DSpellE>sed</SPAN> =
's,.*/,,'`.<SPAN=20
  class=3DSpellE>gmo</SPAN> \<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
  style=3D"mso-spacerun: yes">&nbsp; </SPAN>&amp;&amp; <SPAN=20
  class=3DSpellE>rm</SPAN> -f $file &amp;&amp; PATH=3D<SPAN=20
  class=3DGramE>..</SPAN>/<SPAN class=3DSpellE>src<SPAN=20
  class=3DGramE>:$</SPAN>PATH</SPAN> /<SPAN =
class=3DSpellE>usr/bin/msgfmt</SPAN> -o=20
  $file <SPAN class=3DSpellE>ko.po</SPAN><o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">ko.po:1431:17: invalid =
<SPAN=20
  class=3DSpellE>multibyte</SPAN> sequence<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">ko.po:1434:6: invalid =
<SPAN=20
  class=3DSpellE>multibyte</SPAN> sequence<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">/<SPAN=20
  class=3DSpellE>usr/bin/msgfmt</SPAN>: found 2 fatal=20
  errors<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><SPAN class=3DGramE><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">make[</SPAN></FONT></SPAN><FONT=20
  face=3DArial size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">3]: ***=20
  [<SPAN class=3DSpellE>ko.gmo</SPAN>] Error =
1<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">This is on a barebones =
Red Hat 7.3=20
  install. The July 3 release doesn't give this=20
  error.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">-Ryan=20
<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HT=
ML>

------_=_NextPart_001_01C23CCB.DD989FF0--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
