Date: Sat, 28 Oct 2017 22:16:53 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>
Message-ID: <20171029031653.GB24212@mail.hallyn.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-5-sds@tycho.nsa.gov>
 <20171005054739.GA10620@mail.hallyn.com>
 <1507212415.27146.10.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1507212415.27146.10.camel@tycho.nsa.gov>
Subject: Re: [RFC 04/10] netns,
 selinux: create the selinux netlink socket per network namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 05, 2017 at 10:06:55AM -0400, Stephen Smalley wrote:
> On Thu, 2017-10-05 at 00:47 -0500, Serge E. Hallyn wrote:
> > On Mon, Oct 02, 2017 at 11:58:19AM -0400, Stephen Smalley wrote:
> > > The selinux netlink socket is used to notify userspace of changes
> > > to
> > > the enforcing mode and policy reloads.  At present, these
> > > notifications
> > > are always sent to the initial network namespace.  In order to
> > > support
> > > multiple selinux namespaces, each with its own enforcing mode and
> > > policy, we need to create and use a separate selinux netlink socket
> > > for each network namespace.
> > 
> > ...
> > 
> > > +static int __init selnl_init(void)
> > > +{
> > > +	if (register_pernet_subsys(&selnl_net_ops))
> > > +		panic("Could not register selinux netlink
> > > operations\n");
> > >  	return 0;
> > >  }
> > 
> > This doesn't seem right to me.  If the socket is only used to send
> > notifications to userspace, then every net_ns doesn't need a socket,
> > only the first netns that the selinux ns was associated, right?
> 
> What does "the first netns that the selinux ns was associated" mean?
> We could unshare them in any order; in the sample command sequence I
> gave in the patch description for "selinux: add a selinuxfs interface
> to unshare selinux namespace", I unshared the SELinux namespace first,
> then the network namespace, but we could just as easily do it in the
> reverse order (or at the same time if unshare(2) supported that).  So
> you can't assume that the network namespace in which you are running at
> the time you unshare selinux namespace is the right one, nor that the
> first unshare of the network namespace after unsharing the selinux
> namespace is the right one (not that we even have a way to catch that
> currently).
> 
> > So long as there is a way to find the netns to which an selinux ns
> > is tied, a userspace logger could even setns into that netns to
> > listen
> > for updates, if it wasn't certain to be in the right ns when it ran.
> > 
> > Otherwise (I haven't peeked ahead) you'll have to keep the *list* of
> > net_ns which live in a given selinuxfs and copy all messages to all
> > of
> > those namesapces?
> 
> No, we only deliver to the network namespace of the process that
> performed the setenforce or policy load (most commonly init, could also

(Oops, I see I never replied to this,)

I see - sounds good then, thanks.
