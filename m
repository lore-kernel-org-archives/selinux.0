From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: Strange trace - tty problems
Date: Sun, 29 May 2005 16:27:02 +1000
Cc: SELinux@tycho.nsa.gov
References: <1115874626.18756.5.camel@localhost.localdomain>
In-Reply-To: <1115874626.18756.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505291627.05984.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 May 2005 15:10, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> Then I couldn't open any terminals. Logging out of X
> and back in let me open terminals just fine.

The issue of not being able to open terminals is separate from the trace you 
saw.  Usually when you see such a trace you can still open terminals.

There is another kernel bug which makes it unable to create new Unix98 pty 
devices until you first close every open device.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
