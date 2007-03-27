Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2R0PCwv001364
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 20:25:12 -0400
Received: from aston.electric.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2R0PAok021519
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 00:25:10 GMT
Received: from root by aston.electric.net with emc1-ok (Exim 4.62)
	(envelope-from <ylee@eqo.com>)
	id 1HVzUs-0000Fd-Th
	for selinux@tycho.nsa.gov; Mon, 26 Mar 2007 17:25:10 -0700
Received: from [24.83.96.109] (helo=yonglaptop)
	by aston.electric.net with esmtpa (Exim 4.62)
	(envelope-from <ylee@eqo.com>)
	id 1HVzUr-0000FJ-To
	for selinux@tycho.nsa.gov; Mon, 26 Mar 2007 17:25:09 -0700
From: "Yong Lee" <ylee@eqo.com>
To: <selinux@tycho.nsa.gov>
Subject: runcon problems
Date: Mon, 26 Mar 2007 17:25:10 -0700
Message-ID: <012201c77006$615c44a0$aa5a0a0a@yonglaptop>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0123_01C76FCB.B4FD6CA0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0123_01C76FCB.B4FD6CA0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0124_01C76FCB.B4FD6CA0"


------=_NextPart_001_0124_01C76FCB.B4FD6CA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

 

I'm rather new to selinux and was hoping that someone could help me with a
problem I am having.  I'm running on redhat WS 4 2.6.9-42.  I'm trying to
get a php based web application to make a system call to do a java compile.
I was getting a bunch of avc issues trying to do this and rather than try to
change the selinux policy I was hoping to make use of the runcon command to
run a script which would do my java compile call.

 

So I have a script that looks something like this :

 

#!/bin/sh

 

exec /usr/bin/java -jar $2 $3 $4 $5

 

 

and I'm trying to call it using a system call from php :

 

/usr/bin/runcon /home/test/runjava a b c d

 

denied  { write } for  pid=727 comm="runcon" name="exec" dev=proc
ino=47644693 scontext=root:system_r:httpd_sys_script_t
tcontext=root:system_r:httpd_sys_script_t tclass=file

 

when I edit my targeted policy and recompile to allow the write on exec, I
get :

 

Mar 26 16:54:14 localhost kernel: audit(1174953254.268:1216): avc:  denied
{ setexec } for  pid=1097 comm="runcon"
scontext=root:system_r:httpd_sys_script_t
tcontext=root:system_r:httpd_sys_script_t tclass=process

 

I was going to add 

 

allow httpd_sys_script_t self:process setexec;

 

to the policy rules but I'm thinking that this may not be a good idea and
there must be a better way to get this done.  I'm hoping that some of u
gurus with a lot more experience in this area could help shed some light on
the best way of allowing my php script to successfully call the java binary
without making so many changes to the existing selinux policy.

 

thanks,

Yong.

 

 

Yong Lee

Developer

ylee@EQO.com

 <http://www.eqo.com/> 

direct:      +1.604.273.8173 x113

mobile:    +1.604.418.4470

fax:         +1.604.273.8172

web:        www.EQO.com <http://www.eqo.com/> 

EQO ID:   yonglee

 

 


------=_NextPart_001_0124_01C76FCB.B4FD6CA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m rather new to selinux and was hoping that =
someone
could help me with a problem I am having. &nbsp;I&#8217;m running on =
redhat WS
4 2.6.9-42.&nbsp; I&#8217;m trying to get a php based web application to =
make a
system call to do a java compile. &nbsp;I was getting a bunch of avc =
issues
trying to do this and rather than try to change the selinux policy I was =
hoping
to make use of the runcon command to run a script which would do my java
compile call.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>So I have a script that looks something like this =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>#!/bin/sh<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>exec /usr/bin/java &#8211;jar $2 $3 $4 =
$5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>and I&#8217;m trying to call it using a system call =
from php
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/bin/runcon /home/test/runjava a b c =
d<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>denied&nbsp; { write } for&nbsp; pid=3D727 =
comm=3D&quot;runcon&quot;
name=3D&quot;exec&quot; dev=3Dproc ino=3D47644693 =
scontext=3Droot:system_r:httpd_sys_script_t
tcontext=3Droot:system_r:httpd_sys_script_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>when I edit my targeted policy and recompile to allow =
the
write on exec, I get :<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mar 26 16:54:14 localhost kernel: =
audit(1174953254.268:1216):
avc:&nbsp; denied&nbsp; { setexec } for&nbsp; pid=3D1097 =
comm=3D&quot;runcon&quot; scontext=3Droot:system_r:httpd_sys_script_t
tcontext=3Droot:system_r:httpd_sys_script_t =
tclass=3Dprocess<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I was going to add <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow httpd_sys_script_t self:process =
setexec;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>to the policy rules but I&#8217;m thinking that this =
may not
be a good idea and there must be a better way to get this done.&nbsp; =
I&#8217;m
hoping that some of u gurus with a lot more experience in this area =
could help
shed some light on the best way of allowing my php script to =
successfully call
the java binary without making so many changes to the existing selinux =
policy.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Yong.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:9.0pt'><font size=3D2 =
face=3DVerdana><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Verdana'>Yong =
Lee<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:9.0pt'><font size=3D2 =
face=3DVerdana><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Verdana'>Developer<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal style=3D'text-indent:9.0pt'><font size=3D2 =
face=3DVerdana><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Verdana'><a
href=3D"mailto:ylee@EQO.com">ylee@EQO.com</a><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'text-indent:9.0pt'><font size=3D3 =
face=3DVerdana><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:Verdana'><a
href=3D"http://www.eqo.com/" title=3D"http://www.eqo.com/"><span =
style=3D'text-decoration:
none'><span title=3D"http://www.eqo.com/"><img border=3D0 width=3D95 =
height=3D53
id=3D"_x0000_i1025" =
src=3D"cid:image001.jpg@01C76FCB.B4C6A530"></span><font
color=3Dblack><span =
style=3D'color:windowtext;text-decoration:none'></span></span></font></a>=
</span></font><font
size=3D2 face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Verdana'><o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt'><font size=3D1
face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'>direct:
&nbsp;&nbsp;&nbsp;&nbsp; +1.604.273.8173 =
x113<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt'><font size=3D1
face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'>mobile:&nbsp;&nbsp;&nbsp;
+1.604.418.4470<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt'><font size=3D1
face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'>fax:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+1.604.273.8172<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt'><font size=3D1
face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'>web:&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
<a href=3D"http://www.eqo.com/" =
title=3D"http://www.eqo.com/">www.EQO.com</a><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt'><font size=3D1
face=3DVerdana><span lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'>EQO
ID:&nbsp;&nbsp; yonglee<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:9.0pt'><font size=3D1 =
face=3DVerdana><span
lang=3DEN-US =
style=3D'font-size:8.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0124_01C76FCB.B4FD6CA0--

------=_NextPart_000_0123_01C76FCB.B4FD6CA0
Content-Type: image/jpeg;
	name="image001.jpg"
Content-Transfer-Encoding: base64
Content-ID: <image001.jpg@01C76FCB.B4C6A530>

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAA1AF8DASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2Wko7
VWuLny3WGMgyOM89FA6k1MpKKuxpXJmkVBlmVR7nFRi7tmO1Z48+m4VBgPnylErd2YZFVp4L7BJg
gmXupAziuWpXnFXSuvLU0UE9GzW681BJe20TbZJ41b0LCsaW6g+zkGeaFVPz24PJPoG6gUsEF9Io
NtZwwRnpvUZI/HJrD69z6QV35al+wt8Tt6m5HPFKuY5Vcf7JBpZJEjQs7KoHcnArClMto4a+tQFJ
4uLfhlPviqk0y3F15cCtqU55DSD5EHsvT8TT+u20a17dfuGqF9U9O/T7zoV1KyZtq3cJb03irAO7
kHIrn/sesLHuNtZuP+ee0fl0/rSWN4yzGKGJredeWtWPyuO+3PQ1UcVJNKcWr+VhOjo3F3sdHS1D
BOlzCssZyrDIqWu9NNXRztNOzDpXN3t26PcyZ+ea48hPZQBx+JNdJiuS1ZHjF0VGXtbkTgeqMBz+
Yrjxl/Z6HRh0nKz/AK/pm7cSGwtEWGJpXyFVVBOT3Josn1BnLXcccceOBn5h+XFEd2buyE9o6kum
ULcgH0OKylsdWvLkfb51WAHLKj/eHoAP5mlU5lOMoJtdEnp8wjFWak0rd9/kajW9nd3wnDq7w/eU
YIJ7E/Sq2qa41ncGCFFJUAszdPpTLeTT9N1M2cLESTLkgtkKR0H1PNN1DRUv70T+cY1YYdQMk46Y
rCrGtKk/q9lK+tjSHs4zTq3tbS5d0/UItVtnDxgMvyyITkc/0pscVtoenyyLkhcu5P3m9B/IVHZ2
dtpEU7iQhGO5mc/dUDp/P86bFdWut6Y+xj5cgKsM/Mh/zg10QjJRSm06lnqZuzk3FPkujNi8YObk
C4t0WEnBKk5UevvV3xKgFiuoRELNbFWRh1IJ/wD1ViJ4UuTdBZbmL7ODyy53sPTHY1d8V6gsenpp
0PzTXLKqIOu0Hj8zgVyQWI9hNYjfp3udkvYutD2G3XsbOkTiaSUqMLIqTqPTcOf1B/OtMVj6BEUE
pBykapbqR0OxcEj/AIESPwrZFelRVoHn1fjFrN1Gxa4ZbiDAuIwVAb7sinqp9vfsa0qK0lFSVmQm
07o4gRXNhO39m3C2rMctZ3XygH/ZJ4I9xUst94gdNrvZ2ingyGQfpya6yWGKZds0SSL6MARUcen2
cLbo7WFW9QgBrl+rdE2l5PQ6vrHVxTfmjk49Jh+yPJLFdT7zua8AIKt6qvUr6mnJe63bxkW8ttqM
aDIYN8+B6jg5rs8VRvNLtrzL7fKmBysyABlPrnv9DS+q8usHb0GsTfSauvM4y41D/hINTgtjdtFb
OuWhAwysOo9yexojCROZtKnOnTg7Xt7g5ViO248Z+tad74ammuBJLaRzSA5FxbS+UxPqVPGfoat2
ul3b38Ms1sEVFImkkdWMy4wFKrweecn0rFUZtvm1d99b/edDrQSXLtbbS33GPJqXiMoVKWMQ/wCe
vmLge/X+lGj6NcXV2brzmuLhuGvGB2Rjvsz95scZ6CuvGlWCvuWzgDeoiH+FW8ADHauhULtOTbsc
zxOjUYpEVrbRWlukES7Y0GFFTUUtdSSSsjkbbd2FFFFMAooooAKKKKACiiigAooooAKKKKAP/9k=

------=_NextPart_000_0123_01C76FCB.B4FD6CA0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
