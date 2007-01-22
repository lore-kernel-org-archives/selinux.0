Subject: Re: SELinux and kernel 2.6.19.2
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <1169474193.8180.32.camel@moss-spartans.epoch.ncsc.mil>
References: <1169286048.7552.14.camel@zeroKnowledge>
	 <1169474193.8180.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 15:46:27 +0100
Message-Id: <1169477187.4995.2.camel@zeroKnowledge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno lun, 22/01/2007 alle 08.56 -0500, Stephen Smalley ha scritto:

> SELinux depends on the following options:  SECURITY_NETWORK (network
> security hooks), AUDIT (basic audit support), NET && INET (network
> support).  It also now selects NETWORK_SECMARK (new security marking
> scheme for per-packet access control, obsoletes old netif/node/port
> per-packet controls).  SECURITY_NETWORK_XFRM (xfrm/IPSEC hooks for
> labeled IPSEC) is optional, as is NETLABEL (CIPSO labeling).

Oh...thank you, now i see the SELinux support. I didn't set the "audit
support".

And thank you for the "pam library" suggestion. Now it works!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix - <www.netwosix.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
