Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4DAs2ac000969
	for <selinux@tycho.nsa.gov>; Sat, 13 May 2006 06:54:02 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4DAs19L019875
	for <selinux@tycho.nsa.gov>; Sat, 13 May 2006 10:54:01 GMT
Received: by ug-out-1314.google.com with SMTP id u2so538279uge
        for <selinux@tycho.nsa.gov>; Sat, 13 May 2006 03:54:00 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Trouble with setexeccon/setcon
Date: Sat, 13 May 2006 12:53:48 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002D_01C6768C.4B4AF360"
Message-ID: <4465bac8.7f1514c3.12f8.57e6@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C6768C.4B4AF360
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Messaggio originale-----
> Da: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Inviato: Friday, May 12, 2006 4:17 PM
> A: Mario Fanelli
> Cc: SeLinux Mailing List
> Oggetto: Re: Trouble with setexeccon/setcon

> 

> On Fri, 2006-05-12 at 15:40 +0200, Mario Fanelli wrote: 

> 

> > Yes, but runcon and newrole are user-space command. 

> >  

> > I have to modify the SuPhp C source code because I want that the

> > process SuPhp has different security context depending of an

> > environment variable that mod_suphp set. I try to use setexecon in

> > mod_suphp beforce executing SuPhp but the security context don't

> > change..setexeccon return -1.so I try to modify the suPhp exec with a

> > calling to setcon but another setcon don't work.

> > 

> > If I use runcon all works, but I need to modify the source code.

> 

> Right, I meant to look at the runcon.c or newrole.c source code as

> examples of how to use setexeccon() as well as how to create a context

> in the first place from a combination of the caller's context and some

> new type.  What errno do you get after the failed setexeccon() call?  In

> addition to replacing object_r with a legitimate process role, you also

> need to ensure that the role is authorized for the type/domain.

> 

> -- 

> Stephen Smalley

>  National Security Agency

 

I think that there is a problem with setcon/setexecon .. 

Perhaps now I try to write a wrapper program that execute the command
"runcon -t dummy_change_context_t  /path/of/suphp"..the program only use an
enviroment variable "SUPHP_SELINUX_DOMAIN" and call execve() with same
environment, but the result doesn't change

Now I have written a policy for suPhp with a domain_auto_trans macro.when
apache executes suphp, the context changes.but if I use a domain_trans and a
setcon in suPhp, I obtain an error and I don't find any error message in
/var/log/messages.I'm using a targetd policy and I put apache2 in
unconfined_t domain.

Where can I find the runcon/newrole source code?

 


------=_NextPart_000_002D_01C6768C.4B4AF360
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.StileMessaggioDiPostaElettronica18
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; -----Messaggio originale-----<br>
&gt; Da: Stephen Smalley [mailto:sds@tycho.nsa.gov] <br>
&gt; Inviato: Friday, May 12, 2006 4:17 PM<br>
&gt; A: Mario Fanelli<br>
&gt; Cc: <st1:PersonName ProductID=3D"SeLinux Mailing List" =
w:st=3D"on">SeLinux
 Mailing List</st1:PersonName><br>
&gt; Oggetto: Re: Trouble with =
setexeccon/setcon<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; On Fri, 2006-05-12 at 15:40 +0200, Mario Fanelli wrote: =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; Yes, but runcon and newrole are user-space command. =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; I have to modify the SuPhp C source code because I want =
that
the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; process SuPhp has different security context depending =
of an<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; environment variable that mod_suphp set. I try to use
setexecon in<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; mod_suphp beforce executing SuPhp but the security =
context
don&#8217;t<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; change..setexeccon return -1&#8230;so I try to modify =
the
suPhp exec with a<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; calling to setcon but another setcon don&#8217;t =
work.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; &gt; If I use runcon all works, but I need to modify the =
source
code&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; Right, I meant to look at the runcon.c or newrole.c source =
code as<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; examples of how to use setexeccon() as well as how to create =
a
context<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; in the first place from a combination of the caller's =
context and
some<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; new type.&nbsp; What errno do you get after the failed =
setexeccon()
call?&nbsp; In<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; addition to replacing object_r with a legitimate process =
role, you
also<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; need to ensure that the role is authorized for the =
type/domain.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; -- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D"Courier New"><span =
style=3D'font-size:
8.0pt'>&gt; Stephen Smalley<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'>&gt;&nbsp; National Security Agency<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'>I think that there is a problem with setcon/setexecon =
&#8230;.</span></font>
<o:p></o:p></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'>Perhaps now I try to write a wrapper program that execute the =
command
&#8220;runcon &#8211;t dummy_change_context_t&nbsp; =
/path/of/suphp&#8221;..the program
only use an enviroment variable &#8220;SUPHP_SELINUX_DOMAIN&#8221; and =
call
execve() with same environment, but the result doesn&#8217;t =
change<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'>Now I have written a policy for suPhp with a domain_auto_trans =
macro&#8230;when
apache executes suphp, the context changes&#8230;but if I use a =
domain_trans
and a setcon in suPhp, I obtain an error and I don&#8217;t find any =
error
message in /var/log/messages&#8230;I&#8217;m using a targetd policy and =
I put
apache2 in unconfined_t domain&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'>Where can I find the runcon/newrole source =
code?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D"Times New Roman"><span =
style=3D'font-size:
8.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_002D_01C6768C.4B4AF360--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
