From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: Re: some policy feedback
Date: Mon, 2 Jun 2003 10:37:21 +1000
References: <20030601222359.D31891@lemuria.org>
In-Reply-To: <20030601222359.D31891@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306021037.21050.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Jun 2003 06:23, Tom wrote:
> I've just come back from a 3-day hacker convention where I brought an
> SELinux play system with me, to let the likes of teso, THC, LSD, etc.
> have a go at it.
>
> 1) su problem
> The default policy seems to have a hole that has potentially serious
> consequences. Root can run su and change to any user account authorized
> for root's current role. That way, root can set up traps for the sysadm
> when he logs into his own account, e.g. by trojaning the .bashrc file
> and having the sysadm execute a fake newrole (which calls the real one
> in the background, possibly a wrapper), capturing his password.

In /etc/pam.d/su:
# This allows root to su without passwords (normal operation)
#auth       sufficient pam_rootok.so

SE Linux does not aim to protect users against standard Unix issues.  The idea 
is that you either have standard Unix permissions set up for it or you have 
different roles.

If you setup a different role for the users with non-0 UIDs and label their 
home directories correctly then root can't do anything even if they su to the 
account.

> Someone (whose name I unfortunately forgot to get) did exploit this
> problem and modified my .bashrc in a non-malicious way. I discussed the
> issue with him and we both felt that it would probably be possible to
> exploit it.

Peter Palfreder has just demonstrated this on Method's SE-Gentoo system (see 
the IRC channel).

> One question was the usual LKM issue. Would it be possible to overload
> calls of the SELinux patch, in turn disabling it? Or does LSM and/or SE
> have any kind of "self-preservation" behaviour?

You could entirely prevent module loading and access to /dev/mem and 
/dev/kmem.  In a default configuration only X can access /dev/mem and only 
modutils can load modules into the kernel.  If you change it so that nothing 
can write to the modules files that get loaded or the modprobe/insmod/rmmod 
binaries and don't install the policy for the X server then it should be 
reasonably safe.

> 3) user macros
> I've been digging through the user macros, because I wanted to set up
> an additional unpriviledge (guest) user. Is there any documentation on
> why the macros were laid out the way they were?

They have just evolved like that.  They need to be sorted out more, 
documented, etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
