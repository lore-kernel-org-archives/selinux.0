Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7U6uWdq013683
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 02:56:32 -0400
Received: from mail-yw0-f187.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7U6ttjQ023032
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 06:55:55 GMT
Received: by ywh17 with SMTP id 17so4547959ywh.3
        for <selinux@tycho.nsa.gov>; Sat, 29 Aug 2009 23:56:31 -0700 (PDT)
Date: Sun, 30 Aug 2009 14:56:26 +0800
From: "zheyeung" <zheyeung@gmail.com>
To: "selinux" <selinux@tycho.nsa.gov>
Cc: "refpolicy" <refpolicy@oss1.tresys.com>
Subject: I've got a problem in my installing selinux
Message-ID: <200908301456154069423@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon101623344630_====="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is a multi-part message in MIME format.

--=====003_Dragon101623344630_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,everybody, I'm a beginner . I've got a problem in selinux installing.

At first, I install from selinux-policy-targeted.f11.rpm (which in release CD), then edit /etc/ selinux/config. change the mode to (enforcing,targeted),restart. everything is ok.

Then ,I download refpolicy.tar.gz from tresys.com. make and make install it  by Eclipse-Slide. Here the problem comes. No matter I running selinux in enforcing or in permissive, my F11 failed in rebooting .It stop at Init process, which can not enter the graphic terminal.

I guess , is there extra work I should do but I didn't ?

2009-08-30 



zheyeung 

--=====003_Dragon101623344630_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=us-ascii">
<META content="MSHTML 6.00.6000.16809" name=GENERATOR><LINK 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}" 
rel=stylesheet></HEAD>
<BODY style="FONT-SIZE: 10pt; MARGIN: 10px; FONT-FAMILY: verdana">
<DIV><FONT size=2>Hi,everybody, I'm a beginner . I've got a problem in selinux 
installing.</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>At first, I install from selinux-policy-targeted.f11.rpm 
(which in release CD),&nbsp;then edit /etc/ selinux/config. change the mode 
to&nbsp;(enforcing,targeted),restart. everything is ok.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>Then ,I download refpolicy.tar.gz from tresys.com. make and make install it 
&nbsp;by Eclipse-Slide. Here the problem comes. No matter I running&nbsp;selinux 
in enforcing or in permissive, my F11 failed in rebooting .It&nbsp;stop at Init 
process, which can not enter the graphic terminal.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I guess , is there extra work I should do&nbsp;but I didn't ?</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT color=#c0c0c0 size=2>2009-08-30 </FONT></DIV><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT color=#c0c0c0 size=2><SPAN>zheyeung</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon101623344630_=====--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
