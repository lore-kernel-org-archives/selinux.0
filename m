Subject: Re: [PATCH -v2] SELinux: create new open permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Antill <james.antill@redhat.com>, Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <200802292337.29243.russell@coker.com.au>
References: <1204221520.3206.86.camel@localhost.localdomain>
	 <1204225233.3206.120.camel@localhost.localdomain>
	 <1204230728.11268.261.camel@code.and.org>
	 <200802292337.29243.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 08:00:16 -0500
Message-Id: <1204290016.31790.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-29 at 23:37 +1100, Russell Coker wrote:
> On Friday 29 February 2008 07:32, James Antill <james.antill@redhat.com> 
> wrote:
> > > > What does open on a dir mean?  Isn't that the same as the read perm?
> > >
> > > Admittedly there is very little distinction and I don't know the
> > > usefulness, but it is possible for a process to pass an open fd to a
> > > directory so I saw little reason to exclude it.
> >
> >  Also we have the *at() and fchdir() calls, so this distinction (between
> > open and read on dirs) is useful.
> 
> This new open permission is being created specifically to allow file handles 
> to be inherited across exec.
> 
> Inheriting a directory file handle for the purpose of fchdir() seems quite 
> unlikely.  In fact when fchdir() is mentioned in mailing list discussions it 
> always seems to be in the context of allowing a process to break out of a 
> chroot() jail.
> 
> Does anyone have a hypothetical example of how fchdir() could be used in a way 
> which doesn't break the security of a system but yet need to have open and 
> read access be differentiated?
> 
> As an aside, I'm concerned about the implications of this new file open 
> permission for overall quality of SE Linux policy (both reference policy and 
> custom policy).  I anticipate many people writing policy that allows read and 
> write access wildly with the idea that controls on open will prevent them 
> being exploited.

That is a concern, but on the other side of it, today we have to either
allow or dontaudit many cases where a program only inherits a descriptor
from the caller and should never directly open the file, so the new open
check gives us a way to distinguish such attempts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
