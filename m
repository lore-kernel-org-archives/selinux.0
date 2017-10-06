Date: Fri, 6 Oct 2017 12:07:53 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, paul@paul-moore.com
In-Reply-To: <20171002155825.28620-5-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1710061204020.19396@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-5-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC 04/10] netns,
 selinux: create the selinux netlink socket per network namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2 Oct 2017, Stephen Smalley wrote:

> This change presumes that one will always unshare the network namespace
> when unsharing a new selinux namespace (the reverse is not required).
> Otherwise, the same inconsistencies could arise between the notifications
> and the relevant policy.  At present, nothing enforces this guarantee
> at the kernel level; it is left up to userspace (e.g. container runtimes).
> It is an open question as to whether this is a good idea or whether
> unsharing of the selinux namespace should automatically unshare the network
> namespace.  

What about logging a kernel warning if just SELinux is unshared?

I think we want to avoid surprising the user by unsharing things for them, 
and yes, it will be possible to mess your system up if you configure it 
badly.

> However, keeping them separate is consistent with the handling
> of the mount namespace currently, which also should be unshared so that
> a private selinuxfs mount can be created.

Right, and this will in practice always be automated and abstracted from 
an end user pov.


-- 
James Morris
<jmorris@namei.org>
