Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m76KeiKq017265
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2008 16:40:44 -0400
Received: from mail.rowdy.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m76KeaiB025829
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2008 20:40:36 GMT
Received: from spacetime.nextelcup.rowdy.com ([208.81.230.219])
        by mail.helixsystems.com (HXS1 mail server) with ASMTP (SSL) id MCU45244
        for <selinux@tycho.nsa.gov>; Wed, 06 Aug 2008 16:40:44 -0400
Date: Wed, 6 Aug 2008 16:39:49 -0400 (EDT)
From: Lucas Emery <lucas@rowdy.com>
To: selinux@tycho.nsa.gov
Message-ID: <7478930.41218055185078.JavaMail.SYSTEM@Spacetime>
In-Reply-To: <11565128.21218055038859.JavaMail.SYSTEM@Spacetime>
Subject: Re: selinux freaking out about samba share
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>Looks like the same problem your having, have you seen this?
>
>http://www.nsa.gov/selinux/list-archive/0606/thread_body10.cfm#15927
>
>
>-Max


Hm. Yup, that's exactly what I'm seeing.  And the bug report referenced in that post explains why ("SELinux sets up the inode security state upon d_instantiate, so it expects the
inode mode to be set (so that it can set the inode security class).  cifs appears to call d_instantiate before fully setting up the inode state.").  Now I'm just wondering
what I'm doing wrong because the report says this issue is fixed in kernels 2.6.18 and above, and I'm running a kernel > 2.6.18......

Thanks,

Lucas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
