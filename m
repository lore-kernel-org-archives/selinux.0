Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VHNdrT014346
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 13:23:39 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VHMoQD011673
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 17:22:50 GMT
Subject: Re: banning copying of binaries (e.g. mozilla etc).
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4134AEA2.5090300@tresys.com>
References: <20040830222355.GI31497@lkcl.net>
	 <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20040831122506.GE11456@lkcl.net>
	 <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>
	 <20040831132756.GH11456@lkcl.net>
	 <1093958949.8517.81.camel@moss-spartans.epoch.ncsc.mil>
	 <4134A695.9060008@tresys.com>
	 <1093970980.8517.169.camel@moss-spartans.epoch.ncsc.mil>
	 <4134AEA2.5090300@tresys.com>
Content-Type: text/plain
Message-Id: <1093972918.8517.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 31 Aug 2004 13:21:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-31 at 13:00, Joshua Brindle wrote:
> Ah, my mistake. Out of curiousity why does the ld_so_t have execute 
> permission in the uses_shlib macro if the kernel is executing it? Does 
> the kernel still check for execute permission for the current domain 
> before it executes ld.so?

The kernel calls open_exec() on the interpreter, which calls
permission() with MAY_EXEC, so SELinux ends up performing a parallel
execute check.  But we don't perform another execute_no_trans check. 
One could likely even remove execute_no_trans to ld.so from can_exec_any
and only break a few domains such as prelink.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
