From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: Default Policy question?
Date: Tue, 3 Jun 2003 09:51:59 +1000
Cc: SELinux@tycho.nsa.gov
References: <3EDB7585.8050308@redhat.com> <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil> <20030602230314.C3637@lemuria.org>
In-Reply-To: <20030602230314.C3637@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306030951.59964.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Jun 2003 07:03, Tom wrote:
> But if the secadm_r controls the policy, he should have enough power at
> his hands to prevent subversion. Things he would have to protect:
>
> * his home directory (environment)
> * policy and policy tools
> * kernel and kernel modules

So who runs debugfs/fdisk/mkfs?

> Other than that, all other tools are limited by the policy, aren't
> they? The sysadm_r can replace ls with a trojaned binary, but he can't
> make it do anything that the normal ls isn't allowed to do.

When "ls" is run by any userdomain it does not trigger a domain transition.  
If ls is compromised it's game-over, ls can do lots of interesting things 
other than list the stats of files if it wants to...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
