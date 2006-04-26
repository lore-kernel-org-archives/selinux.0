Subject: Re: Labeling only policy and problems with booleans
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net,
        marius@cs.utt.ro
In-Reply-To: <200604262118.21217.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil>
	 <1146060789.15625.20.camel@sgc>  <200604262118.21217.edwin@gurde.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 26 Apr 2006 15:23:20 -0400
Message-Id: <1146079400.15625.45.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-26 at 21:18 +0300, Török Edwin wrote:
> On Wednesday 26 April 2006 17:13, Christopher J. PeBenito wrote:
> > On Wed, 2006-04-26 at 09:37 -0400, Stephen Smalley wrote:
> > >
> > > Should be some higher level interface for running a program as a user
> > > app and as a daemon, right?  You don't want to make direct references to
> > > other modules' types if it can be avoided.
> >
> > There isn't one currently for unconfined users, but that should be added
> > for 3rd party use. 
> What about interface(`unconfined_domain',  (in unconfined.fc)?
> > There are two potentials for the initrc, 
> > init_daemon_domain() and init_system_domain().  The first one is
> > (obviously) for daemons, and the second one is for short running
> > initialization-style processes such as mount and ifconfig; they both
> > have the same parameters, for example:
> >
> > init_daemon_domain(myapp_t,myapp_exec_t)
> I'll use this one and unconfined_domain.
> 
> Is using unconfined_domain enough, or should I also add init_daemon_domain? 
> Does init_daemon_domain grant any privileges that unconfined domain doesn't 
> have?

unconfined_domain() only makes the specified domain unconfined, it
doesn't make a transition from unconfined_t to the domain.
init_daemon_domain() makes a transition from initrc_t to the specified
domain.  Perhaps we should consider renaming the interfaces to clear up
this confusion.

> I also need to remove the ability to load policy from an unconfined domain 
> (see my previous mail), if I remove that from unconfined.te, build a base.pp, 
> and distribute that along with fireflier, will that be ok? 

If you want the fierflier policy to replace the distro's policy, that
seems reasonable.

> Or will you consider including a boolean to disable policy loading for 
> unconfined domains (separate from the boolean that restrict policy loading 
> for the kernel), so that I can turn off policy loading for unconfined 
> domains, but keep it for "privileged" domains?

Right now in the upstream policy, unconfined_domain() means fully
unconfined.  It might be more acceptable if we do a labeled boolean so
only access to that boolean is disabled when secure mode is enabled,
rather than disabling all boolean access.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
