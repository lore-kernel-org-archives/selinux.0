Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mALEx3iK032264
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 09:59:03 -0500
Received: from web50206.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id mALEv9av016493
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 14:57:09 GMT
Date: Fri, 21 Nov 2008 06:59:03 -0800 (PST)
From: Rahul Jain <erahul29@yahoo.com>
Reply-To: erahul29@yahoo.com
Subject: Problem Setting Policy To Enforcing Mode
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1521159587-1227279543=:37401"
Message-ID: <459507.37401.qm@web50206.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1521159587-1227279543=:37401
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,
=A0
This is the first time I am writing to this mailing list in hope of receivi=
ng help. I am trying to port reference policy by tresys on Montavista. I am=
 able to run the policy well in permmisive mode with no avc messages in aud=
it log, kern.log or messages. But when I put the policy into enforcing mode=
 my system fails to boot, reason seems to be=A0problem with init process.=
=A0I am not able to debug the problem because=A0no=A0avc messages are gener=
ated for the same, probably because the issue comes up even before logging =
deamons start. Is=A0there anyway I can=A0debug my policy and=A0log=A0the av=
c messages=A0from the very beginning of the system startup.
=A0
Rahul Jain
Rahul=A0Jain=A0=A0=0A=0A=0A      
--0-1521159587-1227279543=:37401
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><DIV>Hi All,</DIV>
<DIV>&nbsp;</DIV>
<DIV>This is the first time I am writing to this mailing list in hope of receiving help. I am trying to port reference policy by tresys on Montavista. I am able to run the policy well in permmisive mode with no avc messages in audit log, kern.log or messages. But when I put the policy into enforcing mode my system fails to boot, reason seems to be&nbsp;problem with init process.&nbsp;I am not able to debug the problem because&nbsp;no&nbsp;avc messages are generated for the same, probably because the issue comes up even before logging deamons start. Is&nbsp;there anyway I can&nbsp;debug my policy and&nbsp;log&nbsp;the avc messages&nbsp;from the very beginning of the system startup.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Rahul Jain</DIV>
<DIV>Rahul&nbsp;Jain&nbsp;&nbsp;</DIV></td></tr></table><br>



      
--0-1521159587-1227279543=:37401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
