Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06212
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 08:19:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18166
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 12:18:50 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzband.ncsc.mil  with SMTP id MAA18162
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 12:18:45 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015241DA@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Conan Callen'" <ccallen@windowpane.com>, selinux@tycho.nsa.gov
Subject: RE: Successful install 
Date: Thu, 30 Aug 2001 07:19:05 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C1314D.F620EBC0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C1314D.F620EBC0
Content-Type: text/plain;
	charset="iso-8859-1"

The current version of selinux does support X-Windows, but does not support
a graphice login.
I have ported gdm (gnone display manager) to selinux. When I Finish the
policies files for 
the gdm I will mail the port and policy file to you if you would like.
 
Mark Westerman

-----Original Message-----
From: Conan Callen [mailto:ccallen@windowpane.com]
Sent: Wednesday, August 29, 2001 4:49 PM
To: selinux@tycho.nsa.gov
Subject: Successful install 


I finished the install this morning, selinux is up and runing. It all seems
to be running ok.
 
The README (Building & Installing) instructions worked great. The only
problem I ran into was that I missed step 15 (adding /usr/local/selinux/bin
to the path).
 
I read earlier that selinux had no support for x windows, is this still true
with this latest drop? Is anyone working on a secured desktop?
 
I have installed Bastille ( www.bastille-linux.org
<http://www.bastille-linux.org> ) and am using the firewall that comes with
it. Will this conflict with anything in selinux?
 
Conan


------_=_NextPart_001_01C1314D.F620EBC0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.00.2919.6307" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=840152112-30082001>The 
current version of selinux does support X-Windows, but does not support a 
graphice login.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=840152112-30082001>I have 
ported gdm (gnone display manager) to selinux. When I Finish the policies files 
for </SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=840152112-30082001>the 
gdm I will mail the port and policy file to you if you would 
like.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=840152112-30082001></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=840152112-30082001>Mark 
Westerman</SPAN></FONT></DIV>
<BLOCKQUOTE style="MARGIN-RIGHT: 0px">
  <DIV align=left class=OutlookMessageHeader dir=ltr><FONT face=Tahoma 
  size=2>-----Original Message-----<BR><B>From:</B> Conan Callen 
  [mailto:ccallen@windowpane.com]<BR><B>Sent:</B> Wednesday, August 29, 2001 
  4:49 PM<BR><B>To:</B> selinux@tycho.nsa.gov<BR><B>Subject:</B> Successful 
  install <BR><BR></DIV></FONT>
  <DIV><FONT face=Arial size=2>I finished the install this morning, selinux is 
  up and runing. It all seems to be running ok.</FONT></DIV>
  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>The README (Building &amp; Installing) 
  instructions worked great. The only problem I ran into was that I missed step 
  15 (adding /usr/local/selinux/bin to the path).</FONT></DIV>
  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I read earlier that selinux had no support for x 
  windows, is this still true with this latest drop? Is anyone working on a 
  secured desktop?</FONT></DIV>
  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I have installed Bastille (<A 
  href="http://www.bastille-linux.org">www.bastille-linux.org</A>) and am using 
  the firewall that comes with it. Will this conflict with anything in 
  selinux?</FONT></DIV>
  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Conan</FONT></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C1314D.F620EBC0--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
