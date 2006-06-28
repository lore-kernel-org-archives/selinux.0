Subject: Re: [PATCH 1/3] security:  Extend task_kill hook to handle signals
	sent by AIO completion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: David Quigley <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0606280937130.12338@d.namei>
References: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0606271625540.3759@d.namei>
	 <1151493716.20419.145.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0606280937130.12338@d.namei>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 09:56:15 -0400
Message-Id: <1151502975.20419.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-28 at 09:41 -0400, James Morris wrote:
> On Wed, 28 Jun 2006, Stephen Smalley wrote:
> 
> > On Tue, 2006-06-27 at 16:34 -0400, James Morris wrote:
> > > On Tue, 27 Jun 2006, David Quigley wrote:
> > > 
> > > > + * @task_getsecurityid:
> > > > + *	Retrieve the security identifier of the process @p.
> > > > + *	@p contains the task_struct for the process and place is into @sid.
> > > 
> > > As long as still LSM exists, we need to avoid SELinux-specific code in the 
> > > core kernel security framework.  This needs to be reworked to use some 
> > > kind of abstract security field.
> > 
> > What abstraction is needed beyond the abstraction of a SID (which is
> > already an abstraction itself)?  The problem with making it a generic
> > security blob is that it then requires lifecycle maintenance, which
> > requires tracing the lifecycles of the containing structs.
> 
> I was thinking about using a void pointer, which SELinux uses as a scalar 
> integer, and if another LSM wants more, then it can try and add the 
> lifecycle hooks.
> 
> Otherwise, can we at least change the naming so 'sid' isn't used in the 
> core kernel for this, as it usually refers to something else?
> 
> How about 'secid' ?

Seems dangerous to make it a void* without providing safety for using it
in that manner.  On the latter point, calling it secid or ctxid is fine
with me.  In that, the hook name should also match (task_getsecid or
task_getctxid), as should the underlying SELinux function (and we still
need to resolve the duplication and inconsistencies there, and decide
whether these should be providing the u32 secid/ctxid via return value
instead of pointer argument).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
