Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3GCLJI4000997
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 08:21:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3GCLI7R010445
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 12:21:18 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h3GCLFKP010442 for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 12:21:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux version of sudo
Date: Wed, 16 Apr 2003 22:21:05 +1000
References: <3E9C17E9.2060203@redhat.com> <200304161408.06042.russell@coker.com.au> <3E9D3163.9040807@redhat.com>
In-Reply-To: <3E9D3163.9040807@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304162221.05403.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Apr 2003 20:33, Daniel J Walsh wrote:
> I like the idea of combining DAC with MAC using sudo rather than
> su/newrole.  This would allow
> an administrator to allow other people run functions that require
> greater access to the system without them
> having to have the root password.   IE.  You could allow someone to
> manage the printers database without
> having to become root.  Doing all MAC becomes to combersome for this
> type of thing.

To solve this problem I was thinking of creating some setuid programs that do 
the following:
1)  Check if SE Linux is in enforcing mode and exit if not.
2)  setreuid(0, 0)
3)  Call run_init or other similar program to do the real work once the 
security context has been set.

Domain transition rules (the run_program() macro) would be used to determine 
who is authorised to run the program.

As for authentication, it would use PAM which can probably be used to 
configure whether a password is required for such operations.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
