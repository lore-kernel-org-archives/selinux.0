Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3MGOvI4026385
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 12:24:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3MGOj7R011741
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:24:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3MGOjKP011738 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:24:45 GMT
Subject: Re: important patch for init.te
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200304131815.00210.russell@coker.com.au>
References: <200304131815.00210.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051028655.14761.64.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Apr 2003 12:24:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-04-13 at 04:14, Russell Coker wrote:
> It seems that /sbin/init really wants to talk to itself via fifo's.  If it 
> can't do so then something that a libc6 package upgrade on Debian does will 
> trigger init into going into boot mode (after which it doesn't reap zombies 
> and generally your system doesn't work properly).
> 
> While I still haven't tracked down the cause of this, and it's only been shown 
> to be a real problem when doing libc6 upgrades at the moment (which is only 
> possible on Debian), it still needs to be changed as a priority.
> 
> I have just killed several machines in the process of upgrading them before I 
> tracked this one down (if you tell dselect to upgrade 30+ packages and walk 
> away while it's doing so then by the time you get back the evidence of where 
> the problem originated will be obscured).

The patches for init.te, the devfsd Makefile, and portability have been
merged into the sourceforge CVS tree. Thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
