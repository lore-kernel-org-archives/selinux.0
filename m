Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOEwhIi019841
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 09:58:43 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOEwiC8027087
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 14:58:45 GMT
Date: Wed, 24 Nov 2004 15:09:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: xen 2.0 - adding selinux permissions
Message-ID: <20041124150927.GP5146@lkcl.net>
References: <20041123220352.GF5146@lkcl.net> <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 08:39:16AM -0500, Stephen Smalley wrote:
> On Tue, 2004-11-23 at 17:03, Luke Kenneth Casson Leighton wrote:
> > - add in some new selinux security ids representing the xen commands
> >   (create virtual machine, list virtual machines, shutdown a machine,
> >    suspend-a-session-to-disk, etc.)
> 
> I assume you actually mean add a new security class (xen) and define an
> access vector for it with permissions for each of these operations, not
> add a security identifier.  

 yes?

> As there is no real object for these
> requests, I suppose you could just make them task->self checks as with
> the existing capability checks.  No need to add a new security id for
> the target.

 okay, i must have misunderstood.

 i envisage creating a xen_has_perm() and _that_ means adding
 something to security/selinux/include/av_permissions.h
 #define XEN_VM_CREATE  0x00000001UL
 #define XEN_VM_DESTROY 0x00000002UL, etc.

 and creating a SECCLASS_XEN?

	 /* Check whether a task is allowed to perform a xen virtual machine
	    operation. */
	int xen_has_perm(struct task_struct *tsk, u32 perms)
	{
		struct task_security_struct *tsec;

		tsec = tsk->security;

		return avc_has_perm(tsec->sid, tsec->sid,
				SECCLASS_XEN, perms, NULL, NULL);
	}

 what alternative to this approach is there?


 bearing in mind that the xen daemon (running in the xen master)
 offers access to the consoles of the guest operating systems.

 i _really_ want to be able to stop that access from happening, or
 at least control the circumstances under which access to the
 guest's consoles is allowed!

 at present, any program with access to port 8000 (on localhost or on
 the LAN depending on a config option) can start a guest OS, kill an
 existing one, access all consoles and start hacking away at the login
 prompt, that sort of thing...

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
