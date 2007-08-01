Subject: Re: selinux rsbac and grsecurity internels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>
In-Reply-To: <7b740b700707311712n3c695740gb540b88412596a5a@mail.gmail.com>
References: <7b740b700707311712n3c695740gb540b88412596a5a@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 11:17:45 -0400
Message-Id: <1185981465.15215.337.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 05:12 +0500, shahbaz khan wrote:
> I would like to ask a few questions from the experts regarding some
> implementations. I am working on a survey on selinux rsbac and
> grsecurity. Got some from mailing lists but need more. References will
> be appreciated.. They are the following:

You seem to keep asking the same questions repeatedly.  Please don't.
Just wait patiently until someone answers the first posting.

> 1. What is a security aware application. What functionality it can
> provide? Has this functionality been provide in the other competitors.

A security-aware application is any application that is aware of SELinux
(or whatever the underlying security mechanism is) and explicitly uses
its features, versus a security-unaware application that is merely
transparently controlled by such a mechanism in accordance with some
default policy.  Security-aware applications include but are not limited
to "userspace object managers".

"Userspace object managers" are applications that enforce security
policy over their own objects and operations, such as window systems
(X), database managers (PostgreSQL), and application layer IPC
mechanisms (D-BUS).  This is necessary when the application must deal
with multiple security contexts (e.g. handles client requests from
processes running in different security contexts) and the application's
objects and operations do not have a one-to-one mapping to kernel
objects and operations.  In order to enforce a higher level security
goal, these applications must ensure that the goal is met for their
objects and operations, while the kernel ensures that the goal is met
for its objects and operations and that the application's dependencies
are met.  Userspace object managers in SELinux get their decisions in
the same manner as the kernel, leveraging the Flask security
architecture which separates policy decision-making from enforcement.

Security-aware applications other than userspace object managers include
applications that get or set security attributes of processes and/or
objects, as such applications are also necessarily aware of SELinux but
are not directly enforcing a policy.  ls is thus a "security-aware
application" (if you run it with -Z, it will get and display the file
security contexts), as is chcon (change context of a file).
Security-aware applications also include applications instrumented to
properly label individual objects they create, like ensuring
that /etc/passwd and /etc/shadow are correctly labeled when updated
(adduser and friends), ensuring that logs retain the right label when
rotated (logrotate), etc.

> 2. Where are sids implemented. I have heard that they are history now.
> How are they opaque to object managers?

A SID is just a lightweight handle to a security context.  In SELinux,
they are integers, but you can think of them as
pointers/references/descriptors.  They are used within object managers.
The kernel maintains a SID table for security contexts it uses, but no
longer exports its SIDs to userspace so that it is free to recycle them
at will (although it doesn't yet do that; requires internal reference
counting on them).  Userspace object managers can maintain their own SID
tables; libselinux provides a general facility for userspace SID
mappings along with its AVC.  

> 3. What difference has PMS brought to selinux. Do we have such in
> other implementations?
> 
> 4. How is PMS implemented? Any technical documents? Is it a secure
> application using the extended api?

Joshua answered these questions.

> 5. How and where is AVC implemented?

The AVC is a cache to avoid the cost of calling the security server and
performing a full security computation on each operation.  Thus, it
resides with each object manager.  There is a kernel AVC that is
in-kernel and used for all kernel permission checks.  There is a
userspace AVC implemented in libselinux that can be used by any
userspace object manager for its permission checks.  Each AVC is local
to its object manager.

> 6.Is there any good logging facility apart from regular denial? I have
> heard rsbac and grsecurity has better logging facilities.

Not sure what you mean by "better", but SELinux generates avc messages
with what information is available at the time of the permission check,
and if system call auditing is enabled and any audit filter is defined,
then a system call audit record will also be generated at system call
exit with further information not directly available to SELinux, like
PATH records.

> 7. SELinux uses syscall interception. Is it through LSM? How does
> rsbac and grsecurity manage this?

SELinux does not use syscall interception (i.e. we do not interpose at
the system call interface); it uses the LSM security hooks to mediate
access to the kernel objects.  See the Flask paper for why system call
interposition is not adequate, and the LSM papers for a discussion of
it.  Ask questions about rsbac and grsec elsewhere.

> 8. Of the topic but how does grsecurity implement acls and rbac. Is
> rbac used through the acls or a seperate module?

Not germane to this list.

> 9. How can we best judge the network controls of rsbac and grsecurity
> w.r.t. implementation, usability and functionality?

Not germane to this list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
