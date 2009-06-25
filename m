Subject: Re: This patch add seusers support to SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Chris PeBenito <pebenito@gentoo.org>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <4A429655.1020306@manicmethod.com>
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com>
	 <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com>
	 <4A3AA03E.4010208@manicmethod.com> <4A3B6110.8010308@redhat.com>
	 <4A3BA9DC.2060406@manicmethod.com> <4A3BACE9.6000403@redhat.com>
	 <4A3BD53A.5050908@manicmethod.com>  <4A3BD905.3030401@redhat.com>
	 <1245439846.3574.12.camel@defiant.pebenito.net>
	 <4A3BEC4B.5080504@redhat.com>
	 <1245442170.3574.23.camel@defiant.pebenito.net>
	 <4A429655.1020306@manicmethod.com>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 08:31:41 -0400
Message-Id: <1245933101.9669.98.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-06-24 at 17:10 -0400, Joshua Brindle wrote:
> Chris PeBenito wrote:
> > On Fri, 2009-06-19 at 15:51 -0400, Daniel J Walsh wrote:
> >> On 06/19/2009 03:30 PM, Chris PeBenito wrote:
> >>> On Fri, 2009-06-19 at 14:29 -0400, Daniel J Walsh wrote:
> >>>> Basically this is the exact same file as the seusers file except it one
> >>>> per Linux User where is the seusers file is one record per Linux User.
> >>>>
> >>>> If I have a distributed environment, I need to say stuff like
> >>>>
> >>>> engineers logging into people.redhat.com get guest_t:s0
> >>>> Admins logging in get unconfined_t:SystemLow-SystemHigh
> >>>>
> >>>> In addition on some machines dwalsh is an admin and on others he is a
> >>>> peon.  So using IPA we generate a mapping from MACHINE to User
> >>>>
> >>>> dwalsh on dwalsh_laptop gets unconfined_t
> >>>> dwalsh on desktop gets user_t
> >>>> dwalsh on people gets guest_t
> >>>>
> >>>> There is a potential use for service but it will probably default to *
> >>>> for now.
> >>> I don't have a problem with this idea, but I do have a problem with this
> >>> not replacing the current seuser behavior.  Having two ways to map linux
> >>> users to selinux users is an administration nightmare.  People will be
> >>> confused about which one to use and you'll need to know precedence.
> >>> What you describe above with the contents of each file just having a *
> >>> service would be the same as the current seuser behavior.
> >>>
> >> Well I don't see administrators editing the new format, we have not even
> >> used it yet, since IPA has not shipped this functionality yet.
> >
> > I don't see how IPA's usage matters.  If we go this way, in the future
> > there will be two ways for the seusers mapping, which is confusing.
> >
> 
> Ping, does anyone else have an opinion on this using the context of the service 
> rather than the pam name of the service? I still think the context is more 
> appropriate.

Pros of using pam service name:
- Familiar to regular Linux admins (which we expect to configure
seusers, not just policy admins, right?),
- Can distinguish cases where multiple services run in the same context,
even unconfined services.

Pros of using the server daemon context (ala default_contexts):
- Consistent with default_contexts,
- Can distinguish cases where the same service runs in multiple
contexts.

But default_contexts has been a source of significant confusion and
misconfiguration.

> Also, if we do this I think we should get rid of the old way of having seusers 
> since it isn't clear where to do seuser updates anymore and it isn't even noted 
> which of these take precedence.

Not sure what you mean by "get rid of".  You want getseuserbyname() to
also search the new files and use them if present, using "*" as the
service name?  IOW, directly pull the getseuserbyname() logic into
getseuser() and turn getseuserbyname() into a simple wrapper for
getseuser()?  And then do something on the semanage side for these new
files?

Are we sure that this new functionality is ever actually going to get
used?  Is it really too late to just drop this interface and remove the
call from pam_selinux upstream (only gets built if it detects the
interface in the libselinux against which it is built already).

What we need to do is to overhaul the way the entire user context
computation happens, not just add new ways to further confuse matters.
The full generality of get_ordered_context_list is in retrospect
overkill and prone to misconfiguration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
