From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Albert Cahalan <albert@users.sourceforge.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: threads
Date: Wed, 21 Jan 2004 16:09:05 +1100
Cc: SELinux@tycho.nsa.gov
References: <1072454081.827.103.camel@cube> <1072712224.845.66.camel@moss-spartans.epoch.ncsc.mil> <1074647474.953.40407.camel@cube>
In-Reply-To: <1074647474.953.40407.camel@cube>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401211609.05416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jan 2004 12:11, Albert Cahalan <albert@users.sourceforge.net> 
wrote:
> > For MAC, per-thread contexts make little sense
> > since you cannot enforce any separation of the memory.
>
> This is not quite right. A server daemon using
> per-thread contexts is clearly within your trusted
> computing base, just as the kernel is. This can
> improve security over the obvious alternative of
> having the server run in a context that can do
> anything.

Also having threads in different contexts may be helpful for file servers.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
