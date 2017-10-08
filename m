Date: Mon, 9 Oct 2017 09:08:42 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <20171006192519.GB8935@mail.hallyn.com>
Message-ID: <alpine.LRH.2.21.1710090907060.3670@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-6-sds@tycho.nsa.gov>
 <alpine.LRH.2.21.1710061210140.19396@namei.org>
 <20171006192519.GB8935@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC 05/10] selinux: support per-task/cred selinux
 namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 6 Oct 2017, Serge E. Hallyn wrote:

> Quoting James Morris (jmorris@namei.org):
> > On Mon, 2 Oct 2017, Stephen Smalley wrote:
> > 
> > > An alternative would be to hang the selinux namespace off of the
> > > user namespace, which itself is associated with the cred.  This
> > > seems undesirable however since DAC and MAC are orthogonal, and
> > > there appear to be real use cases where one will want to use selinux
> > > namespaces without user namespaces and vice versa. 
> > 
> > Indeed, an Oracle use-case is for privileged containers and for this MAC 
> > must remain separate.
> 
> Will that always be the case?  Is that to allow (selinux-confined) device
> administration from containers?

It's to provide the user with a full OS experience generally.  It's not 
necessarily the only use-case, though.



-- 
James Morris
<jmorris@namei.org>
