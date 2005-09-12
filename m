Subject: Re: disable setenforce
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, SELinux List <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200509121652.59242.russell@coker.com.au>
References: <1126283594.20003.17.camel@hive.ccit.arizona.edu>
	 <200509121652.59242.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 11:00:35 -0400
Message-Id: <1126537235.2999.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 16:52 +1000, Russell Coker wrote:
> I've attached a patch against the latest rawhide policy (which should also 
> work against the latest FC4 policy).
> 
> This patch adds a new boolean named secure_mode_policyload to cover loading 
> policy, setting boolean states, and setting enforcing mode.  It also adds a 
> new boolean named secure_mode_insmod to control module loading.
> 
> NB  Setting secure_mode_policyload to default to 1 at boot time will work, but 
> that means policy can only be loaded once at boot (should be able to install 
> new policy and reboot the machine though).  Setting secure_mode_insmod at 
> boot will probably make the boot process fail for all non-trivial machines, 
> the initial values of booleans are set before modules for devices such as 
> Ethernet cards.  Setting secure_mode_insmod after the boot process is 
> completed might be a good idea if you have no plans to use USB or 
> Cardbus/PCMCIA, there have been exploits which relied on the ability to trick 
> the system into loading modules (EG the ptrace exploit).

Did you attach the wrong patch?  The one you sent doesn't define new
booleans; it just wraps additional rules with the existing secure_mode
boolean.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
