Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VGQBrT013612
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 12:26:11 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VGP9QF002209
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 16:25:22 GMT
Message-ID: <4134A695.9060008@tresys.com>
Date: Tue, 31 Aug 2004 12:25:57 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
References: <20040830222355.GI31497@lkcl.net>	 <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>	 <20040831122506.GE11456@lkcl.net>	 <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>	 <20040831132756.GH11456@lkcl.net> <1093958949.8517.81.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093958949.8517.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> On Tue, 2004-08-31 at 09:27, Luke Kenneth Casson Leighton wrote:
> 
>> ... so port type equates to port number.
> 
> 
> The net_contexts configuration maps port numbers to port types, so you
> can group them into equivalence classes.  Note that there has been a
> recent change to checkpolicy (in the sourceforge CVS tree) in this area
> to preserve the specified ordering for matching so that you can have
> overlapping port ranges, and a general entry for ports 1-1023 has been
> added to net_contexts to map them all to reserved_port_t if not
> otherwise specified.
> 
> 
>> ... but it would be easy to, say, deny users the ability to execute
>> user_u:object_r:user_t binaries, or default_t binaries etc. yes?
> 
> 
> user_home_t?  Yes.  If you look at macros/base_user_macros.te, you'll
> see the specific can_exec() rules that allow the user domains to execute
> files in their home directories and their own temporary files in the
> current policy.  You would want to go through and remove all such rules
> for any type that the user can create/write.  apol is your friend for
> such analysis, as it can quickly find all cases including those covered
> by rules that use type attributes.
> 
It's worth noting that this will not stop execution of said binaries 
entirely. One only needs to know enough to use /lib/ld.so to run any 
dynamically linked binary which he doesn't have execute access on. 
Unfortunatly disabling user domains access to ld.so would make him 
unable to run any dynamically linked apps whatsoever, sounds like we 
need a userland enforcer in glibc ;)

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
