From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: lilo and initrd
Date: Sun, 17 Aug 2003 12:21:17 +1000
References: <200308161715.35442.carstengrohmann@gmx.de>
In-Reply-To: <200308161715.35442.carstengrohmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308171221.17910.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 17 Aug 2003 01:15, Carsten Grohmann wrote:
> today I read in the SELinux README file, I should not use the
> initrd= option with the selinux entry. Knows anybody why?

The initrd has always worked well for me.  I use initrd on all my systems 
except Cobalt machines (because the Qube BIOS has no method for loading the 
initrd).

I have had the policy be loaded from the initrd for old-style SE Linux, and 
apparently this may be required for 2.6.x.  In any case there are definately 
no problems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
