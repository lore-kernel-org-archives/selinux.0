Message-ID: <1517498921.1750.27.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter enderborg <peter.enderborg@sony.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Date: Thu, 01 Feb 2018 10:28:41 -0500
In-Reply-To: <4c41ad02-5370-95bc-51e4-992767768559@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
 <20180126143241.23108-2-peter.enderborg@sony.com>
 <1517320017.14420.7.camel@tycho.nsa.gov>
 <4c41ad02-5370-95bc-51e4-992767768559@sony.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/5] selinux:Remove direct references to policydb.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-02-01 at 16:17 +0100, peter enderborg wrote:
> On 01/30/2018 02:46 PM, Stephen Smalley wrote:
> > On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
> > > From: Peter Enderborg <peter.enderborg@sony.com>
> > > 
> > > To be able to use rcu locks we seed to address the policydb
> > > though a pointer. This preparation removes the export of the
> > > policydb and send pointers to it through parameter agruments.
> > 
> > Just for reference, I have a patch series that does this not only
> > for
> > the policydb, sidtab, and class/perm mapping, but for all of the
> > SELinux global state, see:
> > https://github.com/stephensmalley/selinux-kernel/tree/selinuxns
> > and in particular
> > https://github.com/stephensmalley/selinux-kernel/commit/c10d90b43cd
> > 720c8f8aab51007e805bf7c4f10d2
> > https://github.com/stephensmalley/selinux-kernel/commit/ec038a64173
> > d56a331423b6d1564b801f0915afc
> > https://github.com/stephensmalley/selinux-kernel/commit/97aa5d7a05e
> > 4458bc4562c47d8f7bc4f56fbfefd
> > 
> > Those first three patches should have no effect on SELinux
> > behavior.
> > They need to be re-based to latest selinux next branch (some minor
> > conflict resolution required) but I was waiting for that to advance
> > to
> > something 4.15-rcX based.  I could however re-base it now if
> > desired.
> 
> I read that as that you want me to rebase the patches on that tree?
> Seems to
> be partly prepared but lot of changes.  Is it a moving target?

No, I wouldn't re-base on that tree.  If/when Paul updates the selinux
next branch (which should be what your patches are relative to), then I
will re-base my patches on his branch and re-submit the first few
patches to see if we can get those merged now since they don't change
SELinux behavior or interfaces.  That will take care of removing direct
references to the policydb, sidtab, and class/perm mapping among other
things.
