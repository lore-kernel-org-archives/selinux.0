Message-ID: <535530EB.6010909@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 10:53:31 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Why is SELINUXTYPE policy specific?
References: <5353BC31.3070404@gmail.com>
In-Reply-To: <5353BC31.3070404@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/20/2014 08:23 AM, dE wrote:
> There are 3 security models in which SELinux can work -- TE, RBAC and MLS.
> 
> And there are 6 types of SELinux policies --
> 
> targeted, mls, mcs, standard, strict or minimum.
> 
> Each security model requires it's own set of policies and the policies
> can be 1 of the 6 types. So can all the 3 security modles and 6 types be
> intermixed? Won't there be conflicts like with MLS and RBAC?

The SELinux security server implements a hybrid RBAC/TE model (not
optional, always present) and an optional MLS model (can be enabled
alongside the RBAC/TE model, not as a substitute for it).  The MLS model
in fact relies upon the RBAC/TE model to serve certain functions such as
identifying, protecting, and limiting MLS trusted subjects (based on
their domain).

SELINUXTYPE in /etc/selinux/config is just a means of specifying the
name/location of the policy to be loaded.  It was originally for Red Hat
to allow them to support selection among multiple policy packages that
could all potentially be installed on the filesystem.  An alternate
implementation could have just used a symlink or just make the policy
packages conflict with each other so that only one could be installed at
a time.  The name conventionally suggests the kind of policy but there
is no intrinsic meaning to it.

Modern refpolicy build.conf has a TYPE that selects the kind of policy
to be built (standard == RBAC/TE only, mls == enable MLS and use the MLS
configuration, mcs == enable MLS and use the MCS configuration), and a
NAME that names the install location for the policy (which can be
anything and corresponds to the SELINUXTYPE of /etc/selinux/config).

The optional MLS model in the security server is in fact enabled in all
of the policy types in Fedora (any supported version) and RHEL 5 or
later, but used to implement Red Hat's MCS model in the targeted policy
(or any other policy type other than the mls one).  So targeted policy
in Fedora or RHEL corresponds to TYPE=mcs NAME=targeted in refpolicy
build.conf, while mls policy in Fedora or RHEL corresponds to TYPE=mls
NAME=mls in refpolicy build.conf.  standard is not used in Fedora or
RHEL AFAIK.  strict is no longer a separate policy in modern Fedora or
RHEL (>= 6?) because targeted and strict policies converged together and
strict policy can be achieved by mapping users to confined roles via
semanage on targeted policy and optionally by removing unconfined
entirely.  minimum is TYPE=mcs NAME=minimum and just differs in that it
has a different set of policy modules included in it.
