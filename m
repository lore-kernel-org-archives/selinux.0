Subject: Re: restorecon and symbolic links
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Orr <martin@martinorr.name>
Cc: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4A9F90B1.3000908@martinorr.name>
References: <4A996106.4060604@martinorr.name>
	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9BCE45.7060704@martinorr.name>
	 <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name>
	 <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9E6406.5000501@martinorr.name>
	 <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9F90B1.3000908@martinorr.name>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 11:25:48 -0400
Message-Id: <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-09-03 at 10:47 +0100, Martin Orr wrote:
> On 02/09/09 13:52, Stephen Smalley wrote:
> > On Wed, 2009-09-02 at 13:24 +0100, Martin Orr wrote:
> >> The reason I named the function that way was because the function with
> >> _realpath expects a real path as an argument, but if this is confusing or
> >> goes against a convention used elsewhere then it could be changed.
> > 
> > Except that symlink_realpath() internally calls realpath().  I think it
> > makes more sense to use process_one_realpath() for the function that
> > invokes realpath(), and process_one() for the function that merely acts
> > on its argument.  
> > 
> >> I copied the symlink_realpath code from what used to be in match.  I assumed
> >> that it needed a buffer on the stack because it then concatenates the last
> >> component of the path on to that buffer, and realpath might not allocate a
> >> long enough buffer.
> > 
> > That's fair.
> > 
> >>>> Not sure it is worth warning about the broken symlink case, and that
> >>>> will trigger warnings for your existing users in the
> >>>> restorecon /dev/stdin case, right?
> >> I agree, it is not worth warning about broken symlinks, except maybe if -v
> >> is specified.
> > 
> > If the behavior of restorecon on symlinks is to always relabel the
> > symlink and then if the target exists, relabel it as well, then it isn't
> > truly an error if the target doesn't exist.  It would be a bit clearer
> > if we used an explicit flag like -h, as existing utilities like chown
> > and chcon do, when we want to act on symlinks rather than their targets,
> > but that would break existing usage it seems.
> > 
> > Modified patch below.  Seem reasonable?
> 
> Looks fine to me.

Ok, applied as policycoreutils 2.0.72.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
