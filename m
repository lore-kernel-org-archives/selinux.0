Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3ELBXZ014775
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 09:21:11 -0500 (EST)
Received: from smtp.puc.cl (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3EJn4w010121
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 14:19:50 GMT
Received: from tayataf.puc.cl (HELO mx1.puc.cl) ([146.155.99.171])
          (envelope-sender <amery@geeks.cl>)
          by tarahuin-smtp.puc.cl (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 3 Nov 2004 14:21:10 -0000
Received: from dhcpsn19.ing.puc.cl (HELO [146.155.3.78]) (amery@[146.155.3.7
	8])(envelope-sender <amery@geeks.cl>)by mx1.puc.cl (qmail-ldap-1.03) with R
	C4-MD5 encrypted SMTPfor <selinux@tycho.nsa.gov>; 3 Nov 2004 14:21:10 -0000
Message-ID: <4188E956.7020808@geeks.cl>
Date: Wed, 03 Nov 2004 11:21:10 -0300
From: Alejandro Mery <amery@geeks.cl>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux without sysvinit
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, i am a complete newbie about selinux but i would like to use it on 
my machines.

the 'problem' is i don't use sysvinit. i use runit 
http://smarden.org/runit/ instead.

runit has only 3 stages, and runs an script on each one.
stage 1: configures the machine
stage 2: run services and keep them supervised (like daemontools)
stage 3: stop services, umount and halt

on download page you said sysvinit patch can be replaced by initrd, how? 
how safe is it? may i need to patch runit in the same way?

Thanks in advance,
Alejandro Mery

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
