Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <43D0ECF2.9090104@tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137765246.3648.118.camel@moss-spartans.epoch.ncsc.mil>
	 <43D0ECF2.9090104@tresys.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 09:24:26 -0500
Message-Id: <1137767066.3648.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 09:00 -0500, Joshua Brindle wrote:
> semanage_can_write can be called separately. See the seobject.py patch 
> which calls it before anything that calls semanage_check_init. I suppose 
> I can move it to the direct_can_write but it is an semanage_store 
> function and this will only be called by direct_can_hook, not by ps or 
> any other api

Right, I was just looking for consistency in where check_init is called,
and presently it seems to always be done by the direct "layer" rather
than the store "layer".  

> hrm, at some point we need to test the writability of the binary policy 
> dir. If the whole commit goes through and then the policy can't be 
> written there is a consistency issue on the system

You already have rollback code, so the store should be rolled back to
the previous state which would already be consistent with the installed
policy.  You'd get two failure messages on both attempts to install the
binary policy file (first the new one, then the rolled back one), but
since it should already match the one from the previous sandbox, it
should be consistent nonetheless.

In any event, we shouldn't require write access to the policy directory
for all libsemanage operations.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
