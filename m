From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chad Sellers <cdselle@tycho.nsa.gov>
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
Date: Fri, 13 May 2005 14:40:39 +1000
Cc: selinux@tycho.nsa.gov
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil> <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil> <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505131440.42410.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 May 2005 23:22, Chad Sellers <cdselle@tycho.nsa.gov> wrote:
> Have you tried implementing per-user /tmp directories yet?  I'm curious
> if it breaks anything (at least anything more than per security context
> does)?

Per user /tmp directories break the typical uses of Unix systems.  On Unix 
multi-user systems it's expected that you can copy a file to /tmp and give it 
mode 0644 to share it with other people.  Failing that the ways of giving 
files to other users on the same machine will be email and web.  Email gives 
delays and sharing via the web can lead to unintended consequences (IE data 
may not need to be kept secret from other local users but may need to be kept 
secret from the global Internet).

Then there's the issue of globally visible mounts.  If I am administering a 
multi-user system then I will need to be able to login remotely and 
mount/umount file systems.  If the shell for my login session uses the NEWNS 
option for clone then I can't do this (any mounts I do won't be visible to 
system processes or new user logins).  To alleviate this we want to allow 
logins by administrators without NEWNS.

If an administrator umounts a file system then any currently running user 
sessions created with NEWNS will still see it.  How do we solve this?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
