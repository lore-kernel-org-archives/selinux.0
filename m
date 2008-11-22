Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAMB9KcL012915
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 06:09:21 -0500
Received: from web50212.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id mAMB7PvP015830
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 11:07:25 GMT
Date: Sat, 22 Nov 2008 03:09:20 -0800 (PST)
From: Rahul Jain <erahul29@yahoo.com>
Reply-To: erahul29@yahoo.com
Subject: Problem Setting Policy To Enforcing Mode
To: selinux@tycho.nsa.gov
Cc: justinmattock@gmail.com, sds@tycho.nsa.gov, dwalsh@redhat.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1449585364-1227352160=:15460"
Message-ID: <674101.15460.qm@web50212.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1449585364-1227352160=:15460
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thankyou all for your kind help.
=A0
Finally I was able to boot my policy. As suggested, I removed dontaudit rul=
es from my policy by doing "make enableaudit". Then I did some quick fixes =
and was finally able to boot the policy.=A0However I am still facing some i=
ssues:
Firstly - My syslog daemon takes too long to start almost 10 min. Please no=
te my test systems are high end multiprocessor express servers with 8 GB of=
 RAM.
Secondly: I am not able to come back to permissive mode, not even by=A0logi=
n as sysadm_r role. My file system is read only and so I am not able to edi=
t the /etc/selinux/config file.=A0"setenforce" command temperoraly puts the=
 policy in permissive mode but still config file could not be edited. I eve=
n tried=A0it in linux single user mode, but=A0the problem persists. Is it t=
he property of the tresys reference policy or=A0my policy is still not beha=
ving properly?
I reallly appreciate your kind help
=A0
Thanks=20
Rahul=A0=A0=A0=A0=0A=0A=0A      
--0-1449585364-1227352160=:15460
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><DIV id=yiv1082060110>Thankyou all for your kind help.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Finally I was able to boot my policy. As suggested, I removed dontaudit rules from my policy by doing "make enableaudit". Then I did some quick fixes and was finally able to boot the policy.&nbsp;However I am still facing some issues:</DIV>
<DIV>Firstly - My syslog daemon takes too long to start almost 10 min. Please note my test systems are high end multiprocessor express servers with 8 GB of RAM.</DIV>
<DIV>Secondly: I am not able to come back to permissive mode, not even by&nbsp;login as sysadm_r role. My file system is read only and so I am not able to edit the /etc/selinux/config file.&nbsp;"setenforce" command temperoraly puts the policy in permissive mode but still config file could not be edited. I even tried&nbsp;it in linux single user mode, but&nbsp;the problem persists. Is it the property of the tresys reference policy or&nbsp;my policy is still not behaving properly?</DIV>
<DIV>I reallly appreciate your kind help</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks </DIV>
<DIV>Rahul&nbsp;&nbsp;&nbsp;&nbsp;</DIV></td></tr></table><br>

      
--0-1449585364-1227352160=:15460--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
