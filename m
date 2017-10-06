Date: Fri, 6 Oct 2017 14:25:19 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <20171006192519.GB8935@mail.hallyn.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-6-sds@tycho.nsa.gov>
 <alpine.LRH.2.21.1710061210140.19396@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1710061210140.19396@namei.org>
Subject: Re: [RFC 05/10] selinux: support per-task/cred selinux
 namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting James Morris (jmorris@namei.org):
> On Mon, 2 Oct 2017, Stephen Smalley wrote:
> 
> > An alternative would be to hang the selinux namespace off of the
> > user namespace, which itself is associated with the cred.  This
> > seems undesirable however since DAC and MAC are orthogonal, and
> > there appear to be real use cases where one will want to use selinux
> > namespaces without user namespaces and vice versa. 
> 
> Indeed, an Oracle use-case is for privileged containers and for this MAC 
> must remain separate.

Will that always be the case?  Is that to allow (selinux-confined) device
administration from containers?
