Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9V1Q6vj014470
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 21:26:06 -0400
Received: from mail.magitekltd.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9V1OWOq003400
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2008 01:24:33 GMT
Received: from [24.242.137.194] (helo=[192.168.30.40])
	by mail.magitekltd.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <lenny@magitekltd.com>)
	id 1Kviko-0006Dt-6s
	for selinux@tycho.nsa.gov; Thu, 30 Oct 2008 20:24:46 -0500
Subject: Re: semanage help
From: LC Bruzenak <lenny@MagitekLtd.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4909FD84.2050906@redhat.com>
References: <1224727612.14755.244.camel@homeserver>
	 <1224766402.28867.4.camel@moss-spartans.epoch.ncsc.mil>
	 <4900A0C8.9050200@redhat.com>
	 <1224779343.28867.60.camel@moss-spartans.epoch.ncsc.mil>
	 <4900B01C.4070206@redhat.com> <1224782298.14755.267.camel@homeserver>
	 <4900B461.7090509@redhat.com>
	 <1224784833.2879.2.camel@moss-spartans.epoch.ncsc.mil>
	 <1224787273.14755.282.camel@homeserver>
	 <1224787700.3974.163.camel@moss-spartans.epoch.ncsc.mil>
	 <4909FD84.2050906@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Oct 2008 20:26:04 -0500
Message-Id: <1225416364.9388.365.camel@homeserver>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-10-30 at 14:31 -0400, Daniel J Walsh wrote:

> >>
> I believe policycoreutils-2.0.57-9.fc10 has the syntax correct now.
> 
> Please try it out.

Dan,

I believe it works as expected but there is a warning printed:

[root@v1 Download]# semanage fcontext -l | grep prelude
...
/var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s0
...

[root@v1 Download]# semanage fcontext -m -t prelude_spool_t -r s15:c0.c1023 '/var/spool/prelude(/.*)?'
libsemanage.dbase_llist_query: could not query record value
[root@v1 Download]# echo $?
0

[root@v1 Download]# semanage fcontext -l | grep prelude
...
/var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s15:c0.c1023 
...

Thanks,
LCB.

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
