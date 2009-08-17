Subject: Re: checking user status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Larry Ross <selinux.larry@gmail.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1250512929.27712.92.camel@gorn.columbia.tresys.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <1250512929.27712.92.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 08:54:28 -0400
Message-Id: <1250513668.3629.114.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-17 at 08:42 -0400, Christopher J. PeBenito wrote:
> On Mon, 2009-08-17 at 08:29 -0400, Stephen Smalley wrote:
> > On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:
> > > Using the RHEL5.3 strict policy I am trying to allow a custom selinux
> > > user permission to use the passwd and chage commands to get the status
> > > of a local user.
> > >  
> > > With selinux in permissive it works as expected, with selinux in
> > > enforcing, all I get are cryptic error messages.  I installed the
> > > enableaudit.pp base policy module, still no denials.
> > >  
> > > Does anyone know what permissions I need to add or what I could
> > > be doing wrong?  Is this even possible?
> > 
> > Did you allow the :passwd permission to the custom selinux user's
> > domain?
> > 
> > allow <userdomain> self:passwd { passwd };
> 
> Perhaps a denial message should be emitted from
> selinux_check_passwd_access() so people know when this perm check is
> denied.

Ideally we'd convert the callers of this function and all direct callers
of security_compute_av() to using the userspace AVC.  The userspace AVC
just didn't exist when passwd and friends (and crond) were originally
instrumented for SELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
