Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6160XrT004485
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 02:00:33 -0400 (EDT)
Received: from audiogram.mail.pas.earthlink.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6160Vbv017733
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 06:00:32 GMT
Message-ID: <40E3A875.6010403@mindspring.com>
Date: Thu, 01 Jul 2004 02:00:21 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: avc denied from postgresql
References: <40CEBF5F.9020609@mindspring.com>	<200406152253.00552.russell@coker.com.au>	<40CFCD3E.8090400@mindspring.com> <20040630114334.4ca86d5e.ynakam@hitachisoft.jp>
In-Reply-To: <20040630114334.4ca86d5e.ynakam@hitachisoft.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:

> On Wed, 16 Jun 2004 00:31:58 -0400
> Richard Hally <rhallyx@mindspring.com> wrote:
> 
>>With the above change to the postgresql.fc I get the following avc 
>>denied messages when booting:
> 
> You must add 
> /usr/bin/postgres --    system_u:object_r:postgresql_exec_t
> to postgresql.fc
> and , comment out 
> session           optional     /lib/security/$ISA/pam_selinux.so multiple
> from /etc/pam.d/su. 
> 
Thanks for the reply, it looks to me that the problem is more like the 
policy and file_contexts were written for the way Debian(or some other 
distro) installs PostgresSQL and Fedora installs things differently. The 
most notable is that in the .fc it has the only postgresql_exec_t with a 
regex for /usr/lib(64)?/postgresql/bin/.* and on Fedora the executables 
are in /usr/bin.
The question I have is: how do we handle these case where different 
distros put the same files in different places? Do we continue to add to 
the policy for each different distro?

Richard Hally



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
