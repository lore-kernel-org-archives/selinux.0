Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB9Hqj6Y032043
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2008 12:52:45 -0500
Received: from web50202.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mB9HqjUv003750
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2008 17:52:45 GMT
Date: Tue, 9 Dec 2008 09:52:44 -0800 (PST)
From: Rahul Jain <erahul29@yahoo.com>
Reply-To: erahul29@yahoo.com
Subject: Non root user cannot execute semanage, semodule
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-802691868-1228845164=:35568"
Message-ID: <829347.35568.qm@web50202.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-802691868-1228845164=:35568
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,
=A0
I am currently developing a Role Based Access Solution on Montavista linux =
using SELiunx. I started my implementaion with the reference policy from Tr=
esys. In this implementation I had assigned a role of security officer to o=
ne of my non root Linux user. This user is resposible for maintaining SELin=
ux related tasks such as creation, building of policy etc. But this user of=
 mine, being a non root user is not able to execute some priviledged comman=
ds such as semodule and semanage.=20
Is there any in which I can permit a non root user execute these commands.
=A0
Thanks and Regards
Rahul Jain=0A=0A=0A      
--0-802691868-1228845164=:35568
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><DIV>Hi All,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am currently developing a Role Based Access Solution on Montavista linux using SELiunx. I started my implementaion with the reference policy from Tresys. In this implementation I had assigned a role of security officer to one of my non root Linux user. This user is resposible for maintaining SELinux related tasks such as creation, building of policy etc. But this user of mine, being a non root user is not able to execute some priviledged commands such as semodule and semanage. </DIV>
<DIV>Is there any in which I can permit a non root user execute these commands.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks and Regards</DIV>
<DIV>Rahul Jain</DIV></td></tr></table><br>



      
--0-802691868-1228845164=:35568--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
