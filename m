Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8DYWIi015455
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 08:34:32 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8DYZDE023816
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 13:34:35 GMT
Subject: Re: filesystems and selinux
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041108105414.GD31026@lkcl.net>
References: <20041108105414.GD31026@lkcl.net>
Content-Type: text/plain
Message-Id: <1099921041.3215.18.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Nov 2004 08:37:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-08 at 05:54, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> this is going to sound a bit weird and i will do my best to _not_
> confuse matters.
> 
> has anyone considered writing selinux policy - and using it instead of
> unix authorisation - for networked fileservers?
> 
> (note i didn't say authentication there).
> 
> in other words, you write an selinux policy which dictates the
> circumstances under which users are allowed access to files
> off of a networked file server.
> 
> ... or is that what the selinux-nfs patches do, already?

There are no differences in the policy used for selinux-nfs.  There is
an assumption that the client and server have the same policy (At least
to the extent that the client and server agree on what accesses to
allow.)  

For selinux-nfs, the client sends the security context of the process
wanting to access files on the NFS server.  The server uses that
security context to make its access decision and then sends the security
context of the files back to the client.  The client then can use that
security context for accesses to the cache, or display it if the request
was something like an 'ls -Z'.  In the case of a setxattr, the client
would also send the security context that the client's process wants the
file to have.  Being NFS, the client is still trusted.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
