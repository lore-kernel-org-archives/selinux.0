Subject: Re: [RFC] Dynamic discover of object classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1155585599.4756.23.camel@localhost.localdomain>
References: <C1064621.16507%csellers@tresys.com>
	 <1155585599.4756.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 16:29:11 -0400
Message-Id: <1155587351.28766.243.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-14 at 15:59 -0400, Karl MacMillan wrote:
> On Mon, 2006-08-14 at 15:24 -0400, Chad Sellers wrote:
> > I sent out an RFC on this subject a long time ago (see below), but I was
> > overcome by events and didn't actually get to implement it. I'm finally
> > getting back to it, but wanted to send out an updated RFC on the subject.
> > The question that still remains is whether to do this entirely in userspace
> > or to create a kernel interface (via selinuxfs) to query the kernel about
> > object class values and permission offsets. I'd prefer to do this in
> > userspace if possible, as that would mean that a userspace object manager
> > could use the same mechanism for querying any security server (i.e. the
> > kernel one or a userspace security server).
> > 
> > So, the basic approach I talked about before is to have the policy compiler
> > write out an auxiliary file with the necessary data, and a userspace object
> > manager would look it up there before checking permissions. The problem with
> > this approach is consistency, as the policy on disk may not be consistent
> > with the one in the security server. This could result in one userspace
> > object manager (say mysql) accidentally checking permissions for another
> > userspace object manager's object class (say apache). We could help this by
> > writing the auxiliary file at policy load time instead of compile time, but
> > this would require the filesystem to be writeable when the policy was
> > loaded. Either way, there are also race conditions associated with
> > synchronizing filesystem data with kernel state.
> > 
> > So, I think I'm back to creating an interface to the kernel to query object
> > class value and permission offsets. A similar interface for the userspace
> > security server will be necessary in the future as well. I'd love to hear
> > any other ideas anyone may have, or any comments on the above approach.
> > 
> 
> The other drawback to the kernel approach is that the kernel would have
> to know about all object classes, but that isn't a large problem. Just
> to be clear, the policy toolchain and kernel would still have to agree
> on the ids for classes and perms, correct? This is only for userspace
> code doing enforcement?

At present, the kernel won't let you remove or alter the value of a
class or permission upon a policy reload if it was defined by the
initial policy (or any previously loaded policy) so that the class and
permission values compiled into the kernel for its own checks and object
class assignments are never disturbed in a running kernel (but it never
truly validates that the initial ones were right either).  That would be
an overly limiting restriction for userspace object manager classes and
permissions, so we would need to adjust that at least for non-kernel
classes and permissions.  This also ties into the desire to allow more
graceful evolution of kernel classes and permissions, see:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=195238#c1

Note that you have to make sure that all uses of classes and permissions
are properly translated by the object manager (kernel or otherwise) if
using such a scheme, not only the permission checks but also any cached
classes in e.g. object security structures.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
