Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UEVurT005206
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 10:31:56 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UEV7AE027244
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 14:31:08 GMT
Subject: Re: Fwd: OpenSSH 3.9 released
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200408201413.05986.russell@coker.com.au>
References: <200408201413.05986.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093876206.5447.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 30 Aug 2004 10:30:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 00:13, Russell Coker wrote:
> "* Make sshd(8) re-execute itself on accepting a new connection. This security 
> measure ensures that all execute-time randomisations are reapplied for each 
> connection rather than once, for the master process' lifetime. This includes 
> mmap and malloc mappings, shared library addressing, shared library mapping 
> order, ProPolice and StackGhost cookies on systems that support such things"
> 
> This has some interesting potential.  Maybe we should change the policy to 
> have a sshd_listener_t domain that binds to port 22 and then 
> domain_auto_trans(sshd_listener_t, sshd_exec_t, sshd_t) for the real work?

sshd also re-executes itself upon SIGHUP, so I don't think the kernel
policy can distinguish the two different cases (would require changes to
sshd to setexeccon prior to the re-exec).  

It appears that the policy is missing can_exec(sshd_t, sshd_exec_t) at
present, which prevents SIGHUP restart as well as the re-exec upon
accepting a new connection.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
