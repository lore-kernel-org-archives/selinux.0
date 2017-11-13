Message-ID: <1510582716.30953.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <james.l.morris@oracle.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Mon, 13 Nov 2017 09:18:36 -0500
In-Reply-To: <alpine.LFD.2.20.1711131734230.32474@localhost>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
 <1509390973.10174.9.camel@tycho.nsa.gov>
 <alpine.LFD.2.20.1710311357320.22021@localhost>
 <1509454842.20694.1.camel@tycho.nsa.gov>
 <1509458646.20694.10.camel@tycho.nsa.gov>
 <alpine.LFD.2.20.1711131734230.32474@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC v0.1][PATCH] selinuxns: extend namespace support to
 security.selinux xattrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-11-13 at 17:45 +1100, James Morris wrote:
> On Tue, 31 Oct 2017, Stephen Smalley wrote:
> 
> > This btw would be a bit cleaner if we dropped the .ns. portion of
> > the
> > name, such that we would have:
> > security.selinux # xattr name in the init namespace
> > security.selinux.vmN # xattr name in the vmN namespace
> > security.selinux.vmN.vmM # xattr name in the vmN.vmM namespace
> 
> Ok, just to clarify, the namespace name in the last example is
> "vmN.vmM", 
> not "vmM" ?
> 
> i.e. the namespaces are always hierarchical, and the security labels
> are 
> identified by that hierarchy.  If you enter vmM from the init
> namespace, 
> for example, the security labels for it are distinct from the labels
> under 
> vmN.  On disk, you would have both:
> 
> security.selinux.vmM
> security.selinux.vmN.vmM
> 
> which are independent.
> 
> Each of these instances would potentially inherit different labels,
> and 
> have different provenance characteristics, so this seems necessary in
> any 
> case.

Yes, at least with respect to the absolute namespace name maintained
within the kernel and used for xattr names. Not clear what should
happen with respect to the names written to or read from
/sys/fs/selinux/unshare; conceptually it seems cleaner if those are
relative to the namespace of the caller, such that if a process that is
already in "vmN" writes "vmM" to /sys/fs/selinux/unshare, then it ends
up in "vmN.vmM" automatically. But if we applied the same principle to
reading, then a subsequent read from /sys/fs/selinux/unshare would give
back the empty string since the process is already in that namespace. 
Was also wondering if the name read for the init namespace ought to
just be the empty string instead of the magic "init" value to make it
consistent with the fact that there is no xattr suffix.

Then there is the question of what to do upon a collision, e.g. if a
second process in "vmN" writes "vmM" to /sys/fs/selinux/unshare. We
could either fail with EEXIST and require the caller to use a unique
name relative to its current namespace or use this as a way to enter an
already existing namespace ala setns(2) for other namespaces, i.e. look
up the namespace named "vmN.vmM" and switch to it.
