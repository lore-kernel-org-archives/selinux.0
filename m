Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CDeQAU008042
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 09:40:26 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CDeP6C009392
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 13:40:25 GMT
Received: by ug-out-1314.google.com with SMTP id u2so404651uge
        for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 06:40:25 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Trouble with setexeccon/setcon
Date: Fri, 12 May 2006 15:40:18 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0011_01C675DA.6058F200"
Message-ID: <44649047.13bdcb9a.0dcb.4ef4@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0011_01C675DA.6058F200
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

> > * Mario Fanelli <mario.fanelli@gmail.com> [2006-05-12 10:10]:

> > > Hello, my name is Mario and I have a trouble with selinux's api. My 

> > > goal is to modify the suPhp apache module, but the function setcon 

> > > and function setexeccon don't work.

> > > 

> > > My apache process runs in dummy_t domain and suPhp file has a 

> > > security context "user_u:object_r:dummy_exec_t"; in the policy file I
write:

> > > 

> > > "domain_trans(dummy_t,dummy_exec_t,dummy_change_context_t)"

> > > 

> > > "domain_trans(dummy_t,dummy_exec_t,dummy_change1_context_t)"

> > > 

> > > And before calling apr_create_process in mod_suphp, I use

> > > setexeccon("user_u:object_r:dummy_change_context_t") but the 

> > > function return

> >                      ^^^^^^^^

> > > always -1

> > 

> > You need user_r instead of object_r. I've never used this api so I 

> > can't comment further, but at least you need to change this.

 

> Yes, and please don't hardcode security contexts in your program.  Make
sure that they are configurable so that your code > can adapt to other
policies.  Note that you likely just want to configure the type, and let the
rest be inherited from the > caller's context.  See newrole (in

> policycoreutils) or runcon (in coreutils) for examples of how to construct
a context by taking an existing context and 

> then just mutating a particular field, like the type.

 

> --

> Stephen Smalley

> National Security Agency

 

Yes, but runcon and newrole are user-space command. 

I have to modify the SuPhp C source code because I want that the process
SuPhp has different security context depending of an environment variable
that mod_suphp set. I try to use setexecon in mod_suphp beforce executing
SuPhp but the security context don't change..setexeccon return -1.so I try
to modify the suPhp exec with a calling to setcon but another setcon don't
work.

If I use runcon all works, but I need to modify the source code.

 

 

 


------=_NextPart_000_0011_01C675DA.6058F200
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.StileMessaggioDiPostaElettronica18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
lang=3DIT style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; =
* Mario
Fanelli &lt;mario.fanelli@gmail.com&gt; [2006-05-12 =
10:10]:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
Hello, my name
is Mario and I have a trouble with selinux's api. My =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; goal =
is to
modify the suPhp apache module, but the function setcon =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; and =
function
setexeccon don't work.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; My =
apache
process runs in dummy_t domain and suPhp file has a =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
security
context &quot;user_u:object_r:dummy_exec_t&quot;; in the policy file I =
write:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
&quot;domain_trans(dummy_t,dummy_exec_t,dummy_change_context_t)&quot;<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt;
&quot;domain_trans(dummy_t,dummy_exec_t,dummy_change1_context_t)&quot;<o:=
p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; And =
before
calling apr_create_process in mod_suphp, I =
use<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt;
setexeccon(&quot;user_u:object_r:dummy_change_context_t&quot;) but the =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
function
return<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
^^^^^^^^<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; &gt; =
always -1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; You need =
user_r
instead of object_r. I've never used this api so I =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; &gt; can't =
comment
further, but at least you need to change =
this.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; Yes, and please =
don't hardcode
security contexts in your program.&nbsp; Make sure that they are =
configurable
so that your code &gt; can adapt to other policies.&nbsp; Note that you =
likely
just want to configure the type, and let the rest be inherited from the =
&gt;
caller's context.&nbsp; See newrole (in<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; =
policycoreutils) or
runcon (in coreutils) for examples of how to construct a context by =
taking an
existing context and <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; then just =
mutating a
particular field, like the type.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; =
--<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; Stephen =
Smalley<o:p></o:p></span></font></p>

<div style=3D'border:none;border-bottom:solid windowtext =
1.0pt;padding:0in 0in 1.0pt 0in'>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>&gt; National =
Security Agency<o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>Yes, but runcon and =
newrole
are user-space command. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>I have to modify the =
SuPhp C
source code because I want that the process SuPhp has different security
context depending of an environment variable that mod_suphp set. I try =
to use
setexecon in mod_suphp beforce executing SuPhp but the security context
don&#8217;t change..setexeccon return -1&#8230;so I try to modify the =
suPhp
exec with a calling to setcon but another setcon don&#8217;t =
work.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier New"'>If I use runcon all =
works,
but I need to modify the source<font color=3Dnavy><span =
style=3D'color:navy'> =
code</span></font>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D1 =
face=3D"Courier New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0011_01C675DA.6058F200--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
