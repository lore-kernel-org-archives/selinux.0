Message-ID: <404020F5.9080202@snu.edu>
Date: Fri, 27 Feb 2004 23:02:45 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: PaX + selinux integration update
References: <403CF8AB.5080309@snu.edu> <20040226164707.GC31204@rom.cip.informatik.uni-muenchen.de>
In-Reply-To: <20040226164707.GC31204@rom.cip.informatik.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:

> * Joshua Brindle <jbrindle@snu.edu> [2004-02-25 21:49]:
> 
>>These are the fixed up versions thanks to Chris Pebenito, the kernel 
>>patch no longer specifies defaults, so now all decisions come directly 
>>from policy.
>>
>>Also the excess amount of denials will not be displayed per policy
> 
> 
> Great! I think this is really useful work!

Thank you
> 
> Do you think there is any chance of integrating your work into PAX? I
> understand that your patch will not go into the kernel in the near future, 
> but if it was at least integrated into PAX it would be much more likely
> to be used.
> 
The author of PaX doesn't want to add any implementation specific stuff 
into mainline (understandably since he works with the grsecurity author 
quite a bit) but this is what we are going to do:

We've started a little project called openpax which implements some of 
the non-ACL aspects of grsecurity, /proc restrictions, chroot 
restrictions, things like that. Not all of them are applicable to 
selinux since the policy can take care of it but some are nicer this way 
(especially /proc). Regardless, I've added the selinux pax integrations 
into openpax, available at http://www.openpax.net or directly at
http://openpax.net/linux-2.6.3-openpax-0.9.patch

Basically we are using this as a testing ground for our Hardened Gentoo 
kernels, the configuration we are using is PaX + openpax + SELinux to 
provide all the currently supported layers of security.

> I think a lot of people use ExecShield because the patch is not too big
> and supported by RedHat. If PAX with proper SELinux-support was
> available as a single patch more people would consider using it on
> production systems where every additional patch counts.
> 
> Thomas
> 
Well, too big is fairly irrelavent if it doesn't provide the necessary 
protections (IMO) . Furthermore, every single PaX option is optional and 
  encased in #ifdef's so every additional patch shouldn't count since 
nothing unnecessary will end up in the compiled kernel.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
