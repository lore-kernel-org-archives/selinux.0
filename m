Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6DF3FrT010037
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 11:03:16 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6DF2s5V011444
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 15:02:54 GMT
Message-ID: <40F3F9A0.9030601@gentoo.org>
Date: Tue, 13 Jul 2004 11:02:56 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: "James R. Marcus" <jmarcus@mvalent.net>
CC: selinux@tycho.nsa.gov
Subject: Re: vsftpd with SELinux
References: <E6E16A6D4277CD459BBDE6713766033C92A51E@exchange.mvalent.local> <200407131735.37408.russell@coker.com.au>
In-Reply-To: <200407131735.37408.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Tue, 13 Jul 2004 14:24, "James R. Marcus" <jmarcus@mvalent.net> wrote:
> 
>>Jul  6 15:58:42 ftp avc:  denied  { getattr } for  pid=21671
>>exe=/usr/sbin/xinetd path=/usr/sbin/vsftpd dev=hda3 ino=438973
>>scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:sbin_t
>>tclass=file
> 
> 
> It seems that /usr/sbin/vsftpd is mis-labelled on your system, it should have 
> context system_u:object_r:ftpd_exec_t not system_u:object_r:sbin_t.
> 

emerge selinux-ftpd
make -C /etc/security/selinux/src/policy/ reload
rlpkg vsftpd
/etc/init.d/vsftpd restart

and you should be all set


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
