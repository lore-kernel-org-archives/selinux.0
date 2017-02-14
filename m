Message-ID: <1487105628.29417.38.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Perform access check using euid instead of
 uid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 14 Feb 2017 15:53:48 -0500
In-Reply-To: <1487103470.29417.21.camel@tycho.nsa.gov>
References: <20170214131448.22837-1-vmojzis@redhat.com>
 <1487085107.29417.4.camel@tycho.nsa.gov>
 <1487085930.29417.9.camel@tycho.nsa.gov>
 <1487103470.29417.21.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-02-14 at 15:17 -0500, Stephen Smalley wrote:
> On Tue, 2017-02-14 at 10:25 -0500, Stephen Smalley wrote:
> > 
> > On Tue, 2017-02-14 at 10:11 -0500, Stephen Smalley wrote:
> > > 
> > > 
> > > On Tue, 2017-02-14 at 14:14 +0100, Vit Mojzis wrote:
> > > > 
> > > > 
> > > > 
> > > > Use faccessat() with AT_EACCESS instead of accesss() in order
> > > > to
> > > > check
> > > > permissions of effective user. access() calls checking
> > > > existence
> > > > of
> > > > a file (F_OK) were left untouched since they work correctly.
> > > > 
> > > > This enables setuid programs to use libsemanage.
> > > 
> > > Not sure we want setuid programs using libsemanage.  Is there a
> > > use
> > > case for that?  I wouldn't warrant it to be safe.
> > > 
> > > AT_EACCESS is not implemented by the kernel, so this seems to
> > > rely
> > > on
> > > some libc magic to support?  Is that done in a safe way?
> > 
> > Per the man page glibc notes, AT_EACCESS is implemented by the
> > glibc
> > wrapper function by using fstatat(2) and emulating the permission
> > check
> > in userspace.  This however is not equivalent to access(2), since
> > the
> > latter will perform SELinux checks too.  It is also seemingly
> > glibc-
> > specific and thus non-portable.
> 
> Looked at the glibc implementation and it seems very broken; it
> hardcodes legacy Unix permission checking without consideration of
> Linux capabilities, POSIX ACLs, or anything else including SELinux
> permissions.  Someone really ought to consider removing that.
> 
> musl implementation is perhaps more reliable but has to use a complex
> workaround (clones a child that call setuid(), setgid() and then
> faccessat() under the new uid/gid and reports the status to the
> parent
> via a pipe).

This seems to be a known issue,
https://bugzilla.redhat.com/show_bug.cgi?id=1333764
