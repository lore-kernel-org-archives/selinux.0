Subject: RE: selinuxfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Wightman, Reid K Civ AFRL/IFEB" <Reid.Wightman@rl.af.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43055FDD054D464FA7923D0FFAF2C9C7024B1316@fsjrez02.adm.rl.af.mil>
References: 
	 <43055FDD054D464FA7923D0FFAF2C9C7024B1316@fsjrez02.adm.rl.af.mil>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 08:06:05 -0400
Message-Id: <1150286765.25236.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-13 at 16:02 -0400, Wightman, Reid K Civ AFRL/IFEB wrote:
> 
> > I suppose a selinuxfs man page might be nice.  
> > selinux-doc/README has a brief description at the end of the 
> > original set of selinuxfs nodes, but hasn't been kept up to 
> > date.  Note that you really aren't supposed to directly 
> > operate on the selinuxfs nodes - you should access them 
> > indirectly via the libselinux interfaces (using helper utilities as
> > appropriate) for portability.
> 
> I'm tinkering with some of the libselinux functions right now and getting a
> strange error from security_compute_user().  I see that it copies data out
> of <selinuxfs>/user .  On my system, this file is 0 bytes (everything is
> stock FC5, selinux status is enabled/targeted/permissive, and I just
> reloaded the policy).  Is this right?  How do the files here get populated?

They are populated by the kernel, just like /proc.  The {access,
context, create, member, relabel, user} nodes are transactional - the
program writes a query to them, and then reads back the response from
the kernel.  The user node is used by get_ordered_context_list and
friends to compute the set of contexts reachable for a given user from a
given security context, which in turn is used by login-like programs for
determining the session security context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
