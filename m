Message-ID: <1507646117.30616.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 10 Oct 2017 10:35:17 -0400
In-Reply-To: <20171006192421.GA8935@mail.hallyn.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-5-sds@tycho.nsa.gov>
 <alpine.LRH.2.21.1710061204020.19396@namei.org>
 <1507296062.8860.1.camel@tycho.nsa.gov>
 <20171006192421.GA8935@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 04/10] netns, selinux: create the selinux netlink socket
 per network namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-10-06 at 14:24 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Fri, 2017-10-06 at 12:07 +1100, James Morris wrote:
> > > On Mon, 2 Oct 2017, Stephen Smalley wrote:
> > > 
> > > > This change presumes that one will always unshare the network
> > > > namespace
> > > > when unsharing a new selinux namespace (the reverse is not
> > > > required).
> > > > Otherwise, the same inconsistencies could arise between the
> > > > notifications
> > > > and the relevant policy.  At present, nothing enforces this
> > > > guarantee
> > > > at the kernel level; it is left up to userspace (e.g. container
> > > > runtimes).
> > > > It is an open question as to whether this is a good idea or
> > > > whether
> > > > unsharing of the selinux namespace should automatically unshare
> > > > the
> > > > network
> > > > namespace.  
> > > 
> > > What about logging a kernel warning if just SELinux is unshared?
> > 
> > As with Serge's suggestion, the problem is that one can unshare
> > them in
> > any order, and potentially with intervening steps to set up the
> 
> But is it going to stay that way?  I thought that was a temporary
> thing
> while you test it out.
> 
> Because as it is it seems unacceptably loose.  A few questions:
> 
> (thinking as I type here - ok only the last one is the real question)
> 
> Assume I'm in my given netns.  I unshare just my selinuxns.  Does the
> selinuxns have the authority to decide things about that netns?
> 
> If I unshare selinuxns+netns, then the selinuxns clearly "owns" the
> netns,
> so the selinuxns has clear authority.  Likewise, when I unshare the
> netns after the selinuxns, from that point on the selinuxns can be
> said
> to have authority over the netns.
> 
> I think you want to keep it completely orthogonal, and I guess so
> long
> as the parent selinuxns policy still applies it's ok.
> 
> So I unshare my selinuxns but not userns.  I don't have CAP_MAC_ADMIN
> against the user_ns, so any selinux related changes will be denied.
> Once I unshare userns, they will be allowed.
> 
> Ah, right.  Here's the real question.  Policy dictates file
> transition
> rules.  How will those be namespaced?  Will only the init_selinux_ns
> be
> allowed to specify a file context?  You can't let
> ns_capable(current_selinux_ns,
> CAP_MAC_ADMIN) guide that safely, but capable(CAP_MAC_ADMIN) will be
> very restrictive.  What's the plan there?  Sorry if it's spelled out
> elsewhere.

I don't think we know yet.  The current patches support a separate and
distinct in-core inode security context for each namespace, which
supports scenarios such as using context mounts on the host OS to label
each container with a single context with MCS separation while using
per-file xattrs within a container to support a conventional targeted
policy, but we haven't yet resolved how to deal with the actual
persistent file security contexts, e.g. whether there will be only one
(possibly with a label mapping defined) or multiple.
