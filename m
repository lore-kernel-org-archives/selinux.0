From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Bill Laut <wlsel@verizon.net>, SELinux@tycho.nsa.gov
Subject: Re: Newbie Q on "disappearing" boot dialog
Date: Tue, 8 Jul 2003 04:05:27 +1000
References: <200307071232.49186.wlsel@verizon.net>
In-Reply-To: <200307071232.49186.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307080405.27489.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Jul 2003 02:32, Bill Laut wrote:
> How do I get all of the startup messages to be logged again?  Is the
> default kernel ring buffer too small?  (I haven't yet edited the policy to
> resolve the "avc: denied" messages).  Or is there an SELinux parameter
> somewhere I need to set?

If your policy is very misconfigured then you can receive a huge number of 
messages on boot.

Also in some situations even an appropriate policy will give many messages if 
the machine is in "permissive mode" (eg you deny access to a directory and 
use a dontaudit rule to prevent it being audited, but because the machine is 
in permissive mode the program can access hundreds of files and/or 
directories below it and have them all accessed).

I suggest not worrying about the lack of messages at this stage and fixing the 
policy first.

You could also modify the kernel to increase the size of the message buffer...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
