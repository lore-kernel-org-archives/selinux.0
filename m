Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9DIc1rT022315
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 14:38:01 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9DIc1hD006355
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 18:38:01 GMT
Subject: Re: More SELinux fixes.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41688FAF.5010601@redhat.com>
References: <4165B9AA.8090803@redhat.com>
	 <1097258770.13326.14.camel@moss-lions.epoch.ncsc.mil>
	 <200410091622.08531.russell@coker.com.au>  <41688FAF.5010601@redhat.com>
Content-Type: text/plain
Message-Id: <1097692602.28227.11.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 13 Oct 2004 14:36:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with changes.

I added the space back before the udp in the inet_child_domain macros.

I did not remove the ifdef(`ypbind.te', ' ... ') from ypbind_macros.te,
since the allow_ypbind bool is declared in ypbind.te.

I think I got all of Russell's suggested changes made, except for the
udev patch.

On Sat, 2004-10-09 at 21:26, Daniel J Walsh wrote:
> Includes Collin's new cups patch.
> 
> I turned on every service in an everything install and came up with many 
> fixes for all the AVC messages.
> 
> Added arpwatch policy.
> 
> Changed allow_ypbind to a boolean, so policy can be turned on/off by 
> sysadmin.
> 
> Working with ipsec team to get program cleaned up so we can write better 
> policy.
> 
> Temporarily added a rule to allow apache to talk to tmp_t:sock_file in 
> targeted policy.  This allows
> it to work with postgresql.  Not sure of a good way to fix this.  One we 
> could add postgresql policy to targeted
> but I am afraid this is a slipperly slope,  Colin suggested that we add 
> a new policy postgresql_unconfined.te for
> targeted that basically runs postgres unconfined but creates /tmp files 
> with an appropriate security context. 
> What do you guys think?  Lastly we could tell any users who want to use 
> apache with postgres to turn off the
> transition of apache to context.
> 
> Dan

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
