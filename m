Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D7ZlrT007756
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 03:35:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D7ZiSK006531
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 07:35:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "James R. Marcus" <jmarcus@mvalent.net>
Subject: Re: vsftpd with SELinux
Date: Tue, 13 Jul 2004 17:35:37 +1000
Cc: <selinux@tycho.nsa.gov>
References: <E6E16A6D4277CD459BBDE6713766033C92A51E@exchange.mvalent.local>
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033C92A51E@exchange.mvalent.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407131735.37408.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jul 2004 14:24, "James R. Marcus" <jmarcus@mvalent.net> wrote:
> Jul  6 15:58:42 ftp avc:  denied  { getattr } for  pid=21671
> exe=/usr/sbin/xinetd path=/usr/sbin/vsftpd dev=hda3 ino=438973
> scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:sbin_t
> tclass=file

It seems that /usr/sbin/vsftpd is mis-labelled on your system, it should have 
context system_u:object_r:ftpd_exec_t not system_u:object_r:sbin_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
