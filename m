Subject: Re: SELinux and kernel 2.6.19.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <1169286048.7552.14.camel@zeroKnowledge>
References: <1169286048.7552.14.camel@zeroKnowledge>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 08:56:33 -0500
Message-Id: <1169474193.8180.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-01-20 at 10:40 +0100, Vincenzo Ciaglia wrote:
> Hello, like i said i had no problems to load SeLinux with a 2.6.14.5
> kernel. 
> 
> So today i decided to upgrade to the latest 2.6.19.2. I built the kernel
> succesfully but under "Security Options" i can't see the old "NSA
> SELinux Support". Where is it ? How can i give to my system full support
> with this kernel? I added Security Hooks support and security labels
> too.
> 
> So i tried to add in my .config the following lines:
> 
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> 
> But nothing happened. I still have no SELinux support.
> 
> Maybe this is a dumb question, sorry, but i never tried to add the
> SELinux support to one of the latest kernels. And i think there's
> something that i still don't know about this.
> 
> Any help would be appreciated. Thank you!

SELinux depends on the following options:  SECURITY_NETWORK (network
security hooks), AUDIT (basic audit support), NET && INET (network
support).  It also now selects NETWORK_SECMARK (new security marking
scheme for per-packet access control, obsoletes old netif/node/port
per-packet controls).  SECURITY_NETWORK_XFRM (xfrm/IPSEC hooks for
labeled IPSEC) is optional, as is NETLABEL (CIPSO labeling).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
