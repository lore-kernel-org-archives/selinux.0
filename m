Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76GLMrT013327
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 12:21:22 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76GKlTZ010439
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 16:20:47 GMT
Subject: Re: Now that SELinux supports booleans should we replace
	tunableswith booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <002201c47bce$22783840$0102a8c0@DESKTOP>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
	 <002201c47bce$22783840$0102a8c0@DESKTOP>
Content-Type: text/plain
Message-Id: <1091809200.8590.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 12:20:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 11:57, Karl MacMillan wrote:
> Just changing the booleans isn't enough - you would also need to evaluate
> all of the expressions and set rules to active/inactive. If you were
> planning to take the same approach as the user management tool that you just
> did, this should be trivial.

Yes, it shouldn't be difficult to create a genpolbools utility similar
to the recently created genpolusers utility.  However, I think that Dan
would want the functionality available as a library function that
operates entirely in-memory rather than on files, so that load_policy
can directly invoke it on the mmap'd policy file to rewrite the binary
policy in memory based on the separate saved boolean settings prior to
loading it into the kernel.  

> For the reload case, the only other idea that I can think of is to have
> security_load_policy copy the current boolean states to the newly loaded
> policy for booleans that are shared between the policies. I'm not certain
> this is a good idea - and you probably want to have a way to disable the
> behavior - but the advantage is that it allows booleans to be persistent
> while a machine is running without requiring them to be persistent across
> reboots. It seems to me that persistance across reboots is actually a
> separate case and I am concerned about administrator confusion about when a
> change to a boolean is temporary and when it is persistent. I agree,
> however, that it is important to have some safe mechanisms for making the
> boolean states stay during reload and reboots.

Under the proposed scheme, reboots and policy reloads would set the
booleans to the values saved in /etc/selinux/$SELINUXTYPE/booleans
(defaulting to the compile-time defaults if there was no value saved in
that file for a given boolean).  Admins would edit that file (directly
or using a tool) if they wanted the boolean setting to persist; if they
only want a temporary change that will be reverted by a reboot or policy
reload, then they would use setsebool to make that temporary change.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
