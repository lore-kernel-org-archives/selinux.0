Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: patch to install libsecure man pages
Date: Thu, 24 Oct 2002 11:54:59 +0200
References: <200210240916.JAA07281@jazzband.ncsc.mil>
In-Reply-To: <200210240916.JAA07281@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200210241154.59754.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Oct 2002 11:15, Carsten Grohmann wrote:
> The attached patch help you to install the man pages from
> libsecure/man to /usr/local/selinux/man.

This may do for Slackware.  But for RPM distributions like SUSE you should 
probably do something similar to what I did for Debian.

I diverted the original man pages for open(2) etc from open.2.gz to 
open.2.gz.non-se and then installed the SE Linux man pages into the regular 
places.

So "man 2 open" gives you the documentation on the open_secure() system call.

Otherwise people won't find them...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
