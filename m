Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12214
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 11:13:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10689
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 16:11:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA10685 for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 16:11:28 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Production servers?
Date: Thu, 28 Nov 2002 17:13:21 +0100
References: <200211281501.PAA16302@jazzswing.ncsc.mil>
In-Reply-To: <200211281501.PAA16302@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211281713.21640.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Nov 2002 15:59, Subba Rao wrote:
> Has anyone here on the list deployed SELinux in a production environment?
> I am interested on the server setup only.  Please let me know what type of
> servers have been successfully deployed (web, DBMS, FTP, Mail) Are there
> any commercial (payware) servers deployed on SELinux?

A small consulting company I occasionally work for has it's main server 
running SE Linux.  Apache, Postfix, FTP, Samba, Squid, and BIND.

A small ISP I occasionally work for has it's main server running SE Linux, two 
copies of Apache with one in a chroot environment, Postfix and Qmail for a 
rather complex email setup, BIND, Squid, FTP, and lots more.  They are a 
commercial ISP so I guess you could call it a "payware server".  If you are 
interested in becoming a customer then ask me for more information off-list, 
this list is not for advertising (and the ISP in question does not want the 
type of attention that will arise from being mentioned on this list).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
