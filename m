Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1M6DRdW020898
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 01:13:28 -0500 (EST)
Received: from mail02.infosat.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1M6BAZE017226
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 06:11:13 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 207393770 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 08:10:54 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 644353850 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 08:10:54 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: fc3 - password change problem - syslog and portmapper
Date: Tue, 22 Feb 2005 08:09:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502220809.40631.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Got FC3 running SELINUX in enforcing mode.

1. however when i try to change my password, i get the ffg error:
SystemError: couldn't get security context of `/etc/passwd': No data available

2. also, when i boot up, syslogd, and portmap cannot start, so i disabled it 
in SELinux. i would like to get this to work, though.

i am running kernel Linux shiva 2.6.10-1.741_FC3smp

thanks in advance for ur time and co-operation.

God bless.


-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator  

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
