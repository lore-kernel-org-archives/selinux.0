Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <20060517075435.GB7665@thorium.jmh.mhn.de>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:52:16 -0400
Message-Id: <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 09:54 +0200, Thomas Bleher wrote:
> [Added CCs from earlier thread]
> 
> * Stephen Smalley <sds@tycho.nsa.gov> [2006-05-15 18:31]:
> > During the earlier thread on splitting policy into individual packages
> > (using policy modules), it was requested that SELinux provide a way for
> > a privileged process (like a package manager) to label an inode with a
> > not-yet-defined security context (treating it as having the unlabeled
> > SID until defined in the policy) and then automatically update the
> > in-memory state when a policy that defines the security context is
> > loaded such that the inode immediately becomes accessible under the
> > rules governing access to that context in the new policy.
> [...]
> > The second logical change introduces the
> > support for setting invalid contexts by privileged processes, both via
> > setxattr() and via /proc/self/attr/fscreate, which is the more
> > controversial aspect.
> 
> I am still not convinced that we actually need this second change.
> 
> In http://marc.theaimsgroup.com/?l=selinux&m=114677075207486&w=2, I
> outlined how rpm could work with the current kernel. I think this scheme
> is preferable to changing the kernel, mainly because of two points:
> 
> * It makes it possible to later confine rpm more strictly:
>   If you load policy before installing the package, you can use the
>   policy server to prevent rpm from loading certain policies; rpm will
>   only be able to put labels on disk it is allowed to by policy.
>   If you load policy after package installation, rpm needs the labelpriv
>   privilege, so you can't confine rpm in any meaningful sense.
> 
> * It allows rpm to know beforehand if the policy module will actually 
>   apply on top of the current system policy (which is important if you 
>   think of the differences between strict and targeted policy). It is
>   better to abort install before than to have invalid labels on disk
>   later.
> 
> As I didn't receive any response regarding my posting, I'd like to ask:
> What prevents you from implementing it in a way similar to what I
> described?
> RPM already has trigger scripts so from the outside it looks like it
> shouldn't be that hard to implement.
> 

To get some realtime discussion going on this issue a telecon was held
with Red Hat, Tresys, and Steve participating. I'll try to summarize the
problems with the approaches that you, Josh, and I were pushing that
came out during that telecom. This is in the context of rpm, but I
believe that the problems are more general.

There are two basic ways to ensure that the policy needed by an rpm is
installed before that rpm: use package dependencies to make certain that
separate policy rpms are installed before rpms that require them or, as
you suggest, collect and install all of the policies from all of the
rpms at the start of the transaction.

The first solution does not work because it is not possible to order rpm
installation within a transaction based on dependencies because of
mutual and circular dependencies. There is _no_ general solution to
sorting packages so that dependencies are met at every step of the
transaction in the face of circular or mutual dependencies. Basically,
topological sorting only works for directed _acyclic_ graphs (see
http://en.wikipedia.org/wiki/Topological_sorting). Instead, rpm makes a
more general guarantee that the dependencies will be met at the end of
the transaction, which is not sufficient for our needs.

The second solution, which you describe, has two problems. As rpm works
now there are many circumstances, like network installations, where a
transaction begins without all of the rpms. Changing this would not only
be difficult, it is not clear that it would be desirable.

Even if all of the rpms were available, there are many potential
problems when a policy upgrade depends on a library or tool upgrade
(e.g., libsepol or semodule). This leads directly back to the dependency
problems.

This leads me to conclude that package managers may need to be able to
set raw contexts that are not currently valid. It is not a pleasant
trade-off, but it does have potential side benefits for backup and
restore tools.

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> Thomas
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
