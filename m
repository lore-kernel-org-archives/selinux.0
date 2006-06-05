Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k55K2leY007005
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 16:02:47 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k55K2kjs014835
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 20:02:46 GMT
Subject: Re: Latest policy diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <447745D2.5000705@redhat.com>
References: <447745D2.5000705@redhat.com>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 16:03:18 -0400
Message-Id: <1149537798.13094.9.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-26 at 14:15 -0400, Daniel J Walsh wrote:
> Add ftp booleans to allow use of anonymous ftp sites on NFS/CIFS file 
> systems.
> 
> Allow rpm_script to transition to the execmem friendly domains.
> 
> Setup mplayer and valgrind as unconfined_execmem

I still believe the unconfined_execmem domain should be in the
unconfined module, and the interfaces should be overloaded.

Can you rebase this, I've been adding packet support to refpolicy, and
this no longer applies.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
