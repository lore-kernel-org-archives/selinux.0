Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAOHbFKk022538
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 12:37:15 -0500
Received: from web50204.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mAOHbFbP021669
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 17:37:15 GMT
Date: Mon, 24 Nov 2008 09:37:15 -0800 (PST)
From: Rahul Jain <erahul29@yahoo.com>
Reply-To: erahul29@yahoo.com
Subject: Problem Setting Policy To Enforcing Mode
To: sds@tycho.nsa.gov, justinmattock@gmail.com, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-72862731-1227548235=:6402"
Message-ID: <250575.6402.qm@web50204.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-72862731-1227548235=:6402
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,
=A0
Thanks you all, for your kind support. After your suggestion I was able to =
fix all my problems. So to put my policy in enforcing mode I deleted the "d=
ontaudit" rule=A0using "make enableaudit' . Then I did the fixes. My syslog=
d was taking long time to start because there were still some avc messages =
left, I fixed them and issue got resolved.=A0 I was=A0able to come back to =
permissive by adjusting the DAC permissions of the /etc/selinux/config file=
. My initial context on login was root:sysadm_r:sysadm_t. I checked the "se=
status" to see that my policy got loaded and that it is=A0enforcing mode.
=A0
So finally my policy is up and running.=20
=A0
Thanks and Regards
Rahul=20
=A0=0A=0A=0A      
--0-72862731-1227548235=:6402
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><DIV id=yiv561181965>Hi All,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks you all, for your kind support. After your suggestion I was able to fix all my problems. So to put my policy in enforcing mode I deleted the "dontaudit" rule&nbsp;using "make enableaudit' . Then I did the fixes. My syslogd was taking long time to start because there were still some avc messages left, I fixed them and issue got resolved.&nbsp; I was&nbsp;able to come back to permissive by adjusting the DAC permissions of the /etc/selinux/config file. My initial context on login was root:sysadm_r:sysadm_t. I checked the "sestatus" to see that my policy got loaded and that it is&nbsp;enforcing mode.</DIV>
<DIV>&nbsp;</DIV>
<DIV>So finally my policy is up and running. </DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks and Regards</DIV>
<DIV>Rahul </DIV>
<DIV>&nbsp;</DIV></td></tr></table><br>

      
--0-72862731-1227548235=:6402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
