Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Justin Smith <jsmith@mcs.drexel.edu>, SELinux@tycho.nsa.gov
Subject: Re: Domain transition
Date: Tue, 17 Dec 2002 16:32:05 +0100
References: <1040129546.1247.7.camel@jsmith.org>
In-Reply-To: <1040129546.1247.7.camel@jsmith.org>
MIME-Version: 1.0
Message-Id: <200212171632.05424.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Dec 2002 13:52, Justin Smith wrote:
> The one domain with high privileges similar to the old root privileges
> is the initrc_t domain.

It seems that initrc_t only really lacks the ability to write to arbitary 
files.  It can ifconfig interfaces (needed for network start scripts), start 
and stop daemons (it's primary purpose), and see everything in "ps ax".

> But transitions cause this domain to "cease to
> exist" by the time Linux has completely booted.

No, there's "run_init" to run scripts in that domain to start daemons.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
