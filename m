Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i37GLTRb010723
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 12:21:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i37GJTUZ023581
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 16:19:29 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id i37GJRmT023527
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 16:19:28 GMT
Message-ID: <407429A6.5090606@tresys.com>
Date: Wed, 07 Apr 2004 12:17:42 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Mark Shakespeare <mshakes@llnl.gov>, selinux@tycho.nsa.gov,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: Sepcut Relabel problem
References: <p06100503bc98ecccb8c1@[128.115.96.64]> <200404071008.i37A8d9U011172@turing-police.cc.vt.edu>
In-Reply-To: <200404071008.i37A8d9U011172@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 06 Apr 2004 16:31:12 PDT, Mark Shakespeare <mshakes@llnl.gov>  said:
> 
>>--============_-1130828223==_ma============
>>Content-Type: text/plain; charset="us-ascii" ; format="flowed"
>>
>>Trying to relabel file system from within Sepcut ( most current version )
>>
>>getting a weird error....
>>
>>
>>couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory
>>couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory
> 
> 
>>Sepcut hangs....then no other X-based apps can run. A reboot clears things.
>>
>>Any ideas?
> 
> 
> Seen in /etc/security/selinux/src/policy/Makefile:
> 
> relabel:  $(FC) $(SETFILES)
>         @echo "Cleaning out /tmp"
>         -rm -rf /tmp/.??* /tmp/*
> 
> which is where your /tmp/sepcut-* and /tmp/.X11-unix/ went (the first
> explaining your sepcut error, the second explaining your X11 problem).
> 
> I'll let somebody else address the question of whether that 'rm' command
> is over-zealous, as I'm not sure what it's trying to do.  If it's trying to
> make sure there's no symlink attacks, it's going about it wrongly, as all
> that does is close down the race conditions a bit.
> 
> Most likely, what it *should* be doing is a mkdir and working inside that
> directory for temp files.

The "rm" line appears to have been added relatively recently to the 
relabel target.  My guess is that the rationale was that many of the 
files in /tmp were no longer labeled correctly after a relabel because 
most of them would have been created via a file transition rule (and 
thus a relabel would change them all to incorrect/default labels, most 
likely denying access to the files anyway if the system were in 
enforcing mode).

David


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
