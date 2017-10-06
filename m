Message-ID: <1507296062.8860.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
Date: Fri, 06 Oct 2017 09:21:02 -0400
In-Reply-To: <alpine.LRH.2.21.1710061204020.19396@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-5-sds@tycho.nsa.gov>
 <alpine.LRH.2.21.1710061204020.19396@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 04/10] netns, selinux: create the selinux netlink socket
 per network namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-10-06 at 12:07 +1100, James Morris wrote:
> On Mon, 2 Oct 2017, Stephen Smalley wrote:
> 
> > This change presumes that one will always unshare the network
> > namespace
> > when unsharing a new selinux namespace (the reverse is not
> > required).
> > Otherwise, the same inconsistencies could arise between the
> > notifications
> > and the relevant policy.  At present, nothing enforces this
> > guarantee
> > at the kernel level; it is left up to userspace (e.g. container
> > runtimes).
> > It is an open question as to whether this is a good idea or whether
> > unsharing of the selinux namespace should automatically unshare the
> > network
> > namespace.  
> 
> What about logging a kernel warning if just SELinux is unshared?

As with Serge's suggestion, the problem is that one can unshare them in
any order, and potentially with intervening steps to set up the
namespace or prepare for doing so, so there is no obvious point where
you could detect and issue such a warning.  Without an interface that
allows unsharing them both simultaneously (either unshare(2)-based or
selinuxfs-based), I don't think we can provide such a warning.

I don't think it will prove to be a problem in practice however;
container runtimes just need to do the right thing (and we can help
this by providing helpers in libselinux or the like).  The larger
concern is not that we'll forget to unshare the network namespace when
we unshare the selinux namespace, but that subsequent further unsharing
of the network namespace by itself could cause lossage of
notifications.  The two cases of concern are that a process unshares
its network namespace again (after the original unsharing of both
selinux namespace and network namespace for the container creation) and
subsequently:

1) Does not get any netlink notifications of setenforce or policy load
events for its selinux namespace. This is only an issue if a program
that uses the userspace AVC also unshares its network namespace or
otherwise is launched into its own network namespace separate from that
of its container.  And it isn't a regression, since before this change
notifications would only be sent to the init network namespace ever, so
this change actually represents an improvement in the ability to at
least get notifications when running in the container's network
namespace.

2) Sets enforcing mode or loads policy itself, in which case the
notification for its setenforce or load_policy will only go to its
network namespace and will not be received by other processes in the
same selinux namespace.  This is only an issue if a process running in
a separate network namespace from that of its container sets enforcing
mode or loads policy.  This seems unlikely to me, since such setting of
enforcing mode or loading of policy will conventionally be restricted
to a small set of privileged processes, such as the container init
process, administrator shells, and package installation/updates, and I
wouldn't expect them to run in a separate network namespace than their
container.

> 
> I think we want to avoid surprising the user by unsharing things for
> them, 
> and yes, it will be possible to mess your system up if you configure
> it 
> badly.
> 
> > However, keeping them separate is consistent with the handling
> > of the mount namespace currently, which also should be unshared so
> > that
> > a private selinuxfs mount can be created.
> 
> Right, and this will in practice always be automated and abstracted
> from 
> an end user pov.
