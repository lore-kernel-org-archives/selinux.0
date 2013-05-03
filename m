Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43LOZW8000686
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 17:24:41 -0400
Received: by mail-yh0-f41.google.com with SMTP id i72so376888yha.28
        for <selinux@tycho.nsa.gov>; Fri, 03 May 2013 14:24:34 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Chris PeBenito <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] Add SELinux policy capability for always checking packet and peer classes.
Date: Fri, 03 May 2013 17:24:30 -0400
Message-ID: <3098007.l65VPEx95O@sifl>
In-Reply-To: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
References: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 03, 2013 09:05:39 AM Chris PeBenito wrote:
> Currently the packet class in SELinux is not checked if there are no
> SECMARK rules in the security or mangle netfilter tables.  Some systems
> prefer that packets are always checked, for example, to protect the system
> should the netfilter rules fail to load or if the nefilter rules
> were maliciously flushed.
> 
> Add the always_check_network policy capability which, when enabled, treats
> SECMARK as enabled, even if there are no netfilter SECMARK rules and
> treats peer labeling as enabled, even if there is no Netlabel or
> labeled IPSEC configuration.

For those who have forgotten the previous discussion on this I feel the need 
to renew my comment that if you are really serious about this you need to also 
provide a mechanism to validate the current secmark labeling configuration 
against the policy.

> Includes definition of "redhat1" SELinux policy capability, which
> exists in the SELinux userpace library, to keep ordering correct.

This is a bit of a nit, but I might suggest submitting the "redhat1" policy 
capability as a distinct patch just to make it clear that it isn't really 
related to this change and to also document what the "redhat1" policy 
capability signifies.

> The SELinux userpace portion of this was merged last year, but this kernel
> change fell on the floor.
> 
> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

It likely won't matter, but NACK'd in principle to get Chris to do this the 
right way and also provide a way to validate the secmark configuration.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
