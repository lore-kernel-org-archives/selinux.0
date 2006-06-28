Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5SDwA4K007096
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 09:58:10 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5SDw7WT004659
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 13:58:08 GMT
Date: Wed, 28 Jun 2006 09:58:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: David Quigley <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] security:  Extend task_kill hook to handle signals
 sent by AIO completion
In-Reply-To: <1151502975.20419.213.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0606280957290.12544@d.namei>
References: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
 <Pine.LNX.4.64.0606271625540.3759@d.namei>  <1151493716.20419.145.camel@moss-spartans.epoch.ncsc.mil>
  <Pine.LNX.4.64.0606280937130.12338@d.namei> <1151502975.20419.213.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Jun 2006, Stephen Smalley wrote:

> On Wed, 2006-06-28 at 09:41 -0400, James Morris wrote:
> > On Wed, 28 Jun 2006, Stephen Smalley wrote:
> > 
> > > On Tue, 2006-06-27 at 16:34 -0400, James Morris wrote:
> > > > On Tue, 27 Jun 2006, David Quigley wrote:
> > > > 
> > > > > + * @task_getsecurityid:
> > > > > + *	Retrieve the security identifier of the process @p.
> > > > > + *	@p contains the task_struct for the process and place is into @sid.
> > > > 
> > > > As long as still LSM exists, we need to avoid SELinux-specific code in the 
> > > > core kernel security framework.  This needs to be reworked to use some 
> > > > kind of abstract security field.
> > > 
> > > What abstraction is needed beyond the abstraction of a SID (which is
> > > already an abstraction itself)?  The problem with making it a generic
> > > security blob is that it then requires lifecycle maintenance, which
> > > requires tracing the lifecycles of the containing structs.
> > 
> > I was thinking about using a void pointer, which SELinux uses as a scalar 
> > integer, and if another LSM wants more, then it can try and add the 
> > lifecycle hooks.
> > 
> > Otherwise, can we at least change the naming so 'sid' isn't used in the 
> > core kernel for this, as it usually refers to something else?
> > 
> > How about 'secid' ?
> 
> Seems dangerous to make it a void* without providing safety for using it
> in that manner.  On the latter point, calling it secid or ctxid is fine
> with me.  In that, the hook name should also match (task_getsecid or
> task_getctxid), as should the underlying SELinux function (and we still
> need to resolve the duplication and inconsistencies there, and decide
> whether these should be providing the u32 secid/ctxid via return value
> instead of pointer argument).

I think secid is easier for everyone.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
