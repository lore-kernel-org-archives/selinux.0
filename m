Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA20036
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 23:07:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA24348
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:05:35 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA24344 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:05:33 GMT
Date: Sat, 27 Jul 2002 13:06:39 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: more thoughts on the ssh policy
Message-ID: <20020727030639.GA18313@snoopy.apana.org.au>
References: <20020726155158.135D819C3@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020726155158.135D819C3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 26, 2002 at 05:51:57PM +0200, Russell Coker wrote:
> Do we need two types for the files under ~/.ssh?
> 
> With the current setup in my policy tree the sshd can read the ~/.ssh/id* 
> files from all users, which of course could be useful in attacking other 
> machines.

Sounds like a good idea.

> Of course if you have a bug in sshd then you can (in theory at least) cause 
> it to execute a shell in the user's security context which runs "scp" to 
> transfer the ~/.ssh/id* files to a host controlled by the attacker.  Although 
> such exploits may be easier said than done (maybe there's a bug in sshd that 
> doesn't allow executing arbitary code but merely allows reading arbitary 
> files and sending the result out the TCP socket).

Also, don't forget ssh-agents socket files, eg:
/tmp/ssh-XXDe4IRT/agent.768

Ideally, only trusted user programs should be able to run ssh in
a domain that has access to these sockets. That might mean any
*interactive* shell, cvs, rsync, etc.

ie. it may not be sufficient just to allow ssh to access it, if an
"untrusted" program can execute ssh, as this program could execute "ssh
remotehost rm -rf ."

Getting all of these requirements might be difficult, so a compromise may
be required.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
