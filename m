Date: Thu, 20 May 2004 21:10:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: se-samba
Message-ID: <20040520211032.GG18182@lkcl.net>
References: <40ACFC0C.9020101@snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40ACFC0C.9020101@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 01:42:20PM -0500, Joshua Brindle wrote:
> A few of us talked about samba at a get together a few weeks ago and 
> since it seems like we have a new ambition user on the list who is part 
> of the samba-tng team I thought I'd bring this up.
 
 hello.

> Apparently Luke Kenneth Casson Leighton is part of the samba-tng team? 
> (correct me if I'm wrong) 

 *sigh*.  yes, i am - an inactive member.  for a number of reasons.
 
 i tried installing samba recently with winbind, and when i discovered
 that it was no significantly further along from 2000, i had to dig
 a bit further.  after a few hours, i started to get very depressed,
 which lasted several days.  there were _really_ good reasons why
 i stopped working on samba.

 so, i know you didn't ask, but now you know a little about the
 effects of what happened in 2000.


 all that having been said, it is ironic that the intent of the samba tng
 project was to subdivide it at clear protocol boundaries, such as
 authentication points, NT services, and even at the LANMAN pipes.

 so, NT authentication is done in samrd, which is root-access-only
 over a unix domain socket.

 that sort of thing.

 there is quite a bit of sorting out still to do.


> So I'll lay out what we talked about for 
> getting samba to support selinux in a meaningful way.

 okay.

 i'll bite.

> Basically the idea is that samba runs in it's own domain (ofcourse), but 
> this domain has to be able to access/read/write files in other domains, 
> particularly user domains. However we want the same enforcements over 
> samba that a user would get on the local system, so the idea is to make 
> samba use the userspace-avc library to do permission validation before 
> it allows any access by the user. 

> This would allow samba to access all 
> user files which it has permission to, but rely on it to validate the 
> connecting users permissions by passing the request to the userspace 
> avc. This wouldn't be hard to implement but I'm curious to hear what 
> someone who works on samba thinks of the idea..
 

 in other words, you are being bitten by the same seteuid issue that is
 affecting famd.

 the thing is, you can't do userspace stuff like that without running
 into serious race conditions.

 samba has been _specifically_ designed to avoid race conditions and
 security issues.  andrew tridgell has absolutely zero respect for
 people that he deems to be a threat to him, but he is an extremely
 competent and experienced unix systems programmer [and from there
 unfortunately he believes that that competence and experience gives
 him authority in areas beyond his expertise].

 anyway.

 if i remember correctly, samba source code has quite good
 autoconf support and is capable of adapting to OSes that
 DON'T have seteuid.

 in other words, they use setuid.

 under such circumstances, the smbd daemon, when it attempts to gain
 root (at the end of a file access session), will exit.

 now, you _will_ get problems with this approach if your client
 attempts to use the same SMB session (which in smbd's design means
 using the same smbd process) for multiple user sessions.

 that means that if you use Citrix or other multi-session NT
 systems, and even in some other circumstances such as threaded
 DCE/RPC applications (spoolss printing being one of them),
 you end up with problems.

 why?  because the SMB protocol has the means for several separate
 user sessions to be multiplexed onto the same SMB connection
 (TCP connection or IPX/SPX connection.  although samba doesn't
 support IPX/SPX, the NetBIOS protocol does).

 the use of seteuid avoids these issues because inside the same
 smbd server, just before accessing a file, a user context switch
 is performed.
 
 so.

 you have hit upon a design flaw in samba.


 the solution is one which will actually dramatically improve samba
 in some unexpected ways, and it is a solution that has been deployed
 by other SMB server vendors (commercial ones).

 what you do is you split out the file handling from the SMB processing,
 into separate daemons.

 the design of the SMB protocol reflects, implicitly, its origins in:

 1) the INT 33 (or 21 or 10, i forget which) DOS disk access system
    "shoved" over-the-wire.

 2) a multithreaded server.

 by separating the SMB-processing from the file-accessing, you
 effectively end up with an easy opportunity to emulate
 multi-threading, and in the process a very very long-standing
 and obscure bug will be fixed [which can be demonstrated by running
 a multi-threaded benchmark test suite against a samba server].


 now, you _might_ be able to get away with writing a VFS plugin,
 or by subdiving the smbd source code so that the file-access bits
 of smbd are called (eventually) by the SMB-parsing bits of smbd.

 in fact, if i was going to do the work, that's where i would start,
 and once that was done, i would then add in a subdivision layer
 over, oh, say, unix domain sockets or shared memory communication.

 the two separate tasks (making all file access go via the VFS layer
 and then doing a daemon split at the same VFS interface) make very
 clear and very straightforward milestones.

 in fact, one possible simple implementation of the above is to
 write an SMB proxy VFS plugin which then accesses _another_ smb
 server, running on say port 8139 instead of 139.
  
 and i suspect that you may find that an SMB proxy VFS plugin
 already exists: if not, it'll only take a few days to write
 one using libsmb, or the same code used by smbclient.


 in this way, it becomes possible to run an smbd server without
 needing to know _anything_ about unix security model whatsoever,
 which communicates to a file server that is _specifically_ thunked
 on a per-process basis to deal with one user and its security
 context.

 
 and funnily enough it might actually result in a performance
 improvement, because a lot of user-context switching could be
 avoided.

 i did hear of someone porting samba to the linux kernel (!!!)
 in 1998 and they got a _dramatic_ performance of over 50%
 increase due to zero user-context switching.


 btw i am sorry you have to learn of the difficulties i had
 with the samba leaders, and also to hear about it here:
 the fault is mine, in that i was unable to moderate the
 way i presented ideas to them, and was unable to compromise
 effectively on design issues that i considered important.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
