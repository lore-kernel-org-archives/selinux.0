From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Policy source and initial ramdisk
Date: Wed, 17 Sep 2003 20:32:56 +1000
References: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
In-Reply-To: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172032.56257.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 07:22, Karl MacMillan wrote:
> It appears that users are required to call mkinitrd whenever the policy
> is modified. If this is the case it seems that users might be unaware
> that make install /etc/security/selinux/src/policy doesn't change the
> policy loaded during the next boot. Additionally, it is problematic for
> tools that modify the policy source. The quickest solution would be to
> modify the install target to call mkinitrd, but this has some issues
> (like reliably determining the name of the ramdisk image). Does anyone
> have any thoughts about the best way to approach this problem?

My solution to this is to have a base policy in the initrd which defines every 
type for a file that may be accessed in the early stages of the boot process 
(up until the root fs is re-mounted read-write), and all the policy for those 
parts of the boot.

Then in the early stage of boot the real policy will be loaded from the root 
fs.

This avoids re-building an initrd every time the policy is changed (which 
incurs danger of making the maching non-bootable if there is an error and 
which is difficult in the case of updating several kernels at the same time).

I'll release some sample policy for this soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
