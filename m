From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: shravan kumar <shravanincosmos@yahoo.com>, SELinux@tycho.nsa.gov
Subject: Re: Installation Problem
Date: Wed, 13 Aug 2003 19:11:54 +1000
References: <20030813075008.81593.qmail@web13702.mail.yahoo.com>
In-Reply-To: <20030813075008.81593.qmail@web13702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308131911.54482.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Aug 2003 17:50, shravan kumar wrote:
>               drivers/char/riscom8.h:85: field `tqueue' has incomplete type
>               drivers/char/riscom8.h:86: field `tqueue_hangup' has
> incomplete type   drivers/char/riscom8.c:84: warning: type defaults to
> `int' in declaration of `DECLARE_TASK_QUEUE'

The easiest thing to do is to turn off the CONFIG_RISCOM8 option in your 
kernel configuration.

What happens when you compile a kernel without SE Linux?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
