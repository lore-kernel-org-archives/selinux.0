Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBAGYLmT022514
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 11:34:21 -0500
Received: from web50204.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mBAGYLE1010583
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 16:34:21 GMT
Date: Wed, 10 Dec 2008 08:34:20 -0800 (PST)
From: Rahul Jain <erahul29@yahoo.com>
Reply-To: erahul29@yahoo.com
Subject: Non root user cannot execute semanage, semodule
To: sds@tycho.nsa.gov, dwalsh@redhat.com, casey@schaufler-ca.com,
        justinmattock@gmail.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-353075081-1228926860=:7919"
Message-ID: <652528.7919.qm@web50204.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-353075081-1228926860=:7919
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thankyou All,
=A0
This community is really awesome.
=A0
As suggested by Stephen I used sudo in=A0order to allow a non root user exe=
cute the priviledged commands like semodule and semanage and protected the =
configuration file using SELinux. Though I tried=A0to tweak the policycoreu=
tils also to get the things done but it did not work. The reason=A0being, t=
he=A0some intermediate directories that are created when these commands are=
 executed. The owner of these directories is root and a=A0non root user is =
not able to access these directories.
=A0
For me it was important to allow security officer execute these commands be=
cause his role entitles him to perform all security policy related tasks. S=
emodule was needed to load the policy modules while semanage was required t=
o map the Linux users with the selinux users.
=A0
Thanks and Regards
Rahul Jain
=A0
=A0=0A=0A=0A      
--0-353075081-1228926860=:7919
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><DIV>Thankyou All,</DIV>
<DIV>&nbsp;</DIV>
<DIV>This community is really awesome.</DIV>
<DIV>&nbsp;</DIV>
<DIV>As suggested by Stephen I used sudo in&nbsp;order to allow a non root user execute the priviledged commands like semodule and semanage and protected the configuration file using SELinux. Though I tried&nbsp;to tweak the policycoreutils also to get the things done but it did not work. The reason&nbsp;being, the&nbsp;some intermediate directories that are created when these commands are executed. The owner of these directories is root and a&nbsp;non root user is not able to access these directories.</DIV>
<DIV>&nbsp;</DIV>
<DIV>For me it was important to allow security officer execute these commands because his role entitles him to perform all security policy related tasks. Semodule was needed to load the policy modules while semanage was required to map the Linux users with the selinux users.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks and Regards</DIV>
<DIV>Rahul Jain</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></td></tr></table><br>



      
--0-353075081-1228926860=:7919--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
