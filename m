Date: Sun, 17 Aug 2003 09:37:14 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: lilo and initrd
Message-ID: <20030816233714.GE28317@snoopy.apana.org.au>
References: <200308161715.35442.carstengrohmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308161715.35442.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Aug 16, 2003 at 05:15:35PM +0200, Carsten Grohmann wrote:
> today I read in the SELinux README file, I should not use the 
> initrd= option with the selinux entry. Knows anybody why? 

initrd creates extra complications that you need to think about order
into get a working system, eg. having a working policy on the itrd
infilesystem.

Unless you enjoy or especially want to debug initrd filesystems, etc, it
might be wise to avoid it. ;-).

I don't think there are any inherent problems though...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
