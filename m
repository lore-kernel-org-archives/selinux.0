Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VH0SrT013973
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 13:00:28 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VGxcQD008704
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 16:59:38 GMT
Message-ID: <4134AEA2.5090300@tresys.com>
Date: Tue, 31 Aug 2004 13:00:18 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
References: <20040830222355.GI31497@lkcl.net>	 <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>	 <20040831122506.GE11456@lkcl.net>	 <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>	 <20040831132756.GH11456@lkcl.net>	 <1093958949.8517.81.camel@moss-spartans.epoch.ncsc.mil>	 <4134A695.9060008@tresys.com> <1093970980.8517.169.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093970980.8517.169.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> On Tue, 2004-08-31 at 12:25, Joshua Brindle wrote:
> 
>>It's worth noting that this will not stop execution of said binaries 
>>entirely. One only needs to know enough to use /lib/ld.so to run any 
>>dynamically linked binary which he doesn't have execute access on. 
>>Unfortunatly disabling user domains access to ld.so would make him 
>>unable to run any dynamically linked apps whatsoever, sounds like we 
>>need a userland enforcer in glibc ;)
> 
> 
> Running it via ld.so should still trigger SELinux permission checks for
> read and execute (upon the mmap) and possibly other checks induced by
> earlier operations by ld.so (e.g. stat'ing the file will require
> getattr), so this only has an affect on the execute_no_trans check.
> 
> With regard to the latter point, the kernel doesn't check
> execute_no_trans to the interpreter when handling an execve itself, so
> you can remove execute_no_trans permission to ld.so from a domain to
> prevent direct execution while still allowing the kernel to invoke it on
> behalf of the process upon an execve.
> 

Ah, my mistake. Out of curiousity why does the ld_so_t have execute 
permission in the uses_shlib macro if the kernel is executing it? Does 
the kernel still check for execute permission for the current domain 
before it executes ld.so?

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
