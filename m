Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28212
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 15:32:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA01089
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 19:31:54 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA01085
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 19:31:53 GMT
Date: Tue, 3 Apr 2001 15:30:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Amon Ott <ao@rsbac.org>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <01040317572202.01693@marvin>
Message-ID: <Pine.SOL.3.95.1010403133151.12927O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>In the end, we might both end up with some new ideas.

I think that this is a good perspective.  Both RSBAC and SELinux
appear to have similar goals and features, and I'm sure that
each project can learn from the other.

> All policy changes get into effect at once, so the next access control decision
> will be based on the new settings. If you e.g. want to revoke file access, turn
> on READ/WRITE interception, and after revoking the rights, all following read
> attempts will fail.

Our paper from the 8th USENIX Security Symposium (available via
http://www.nsa.gov/selinux/flask-abs.html) about the Flask
security architecture talks at length about the difficulty
in truly supporting dynamic security policies.  You need to
address the potential interleaving of policy changes with
the execution of controlled operations and provide an effective
atomicity for policy changes so that you know when the new policy
is truly in effect.  You also need a mechanism to revoke permissions that
are implicitly retained in the state of the system, e.g. open file
descriptions, memory-mapped files, established TCP connections,
and even operations currently in progress that have already checked
permissions.  The Flask architecture and interfaces were designed to
address these issues, and the SELinux controls were designed to permit
efficient revalidation of permissions on use for many services.  Although
it is true that RSBAC now provides optional READ/WRITE interception on
read/write calls, I don't think it fully addresses these issues.  SELinux
isn't perfect in this area either, but it provides the basic
infrastructure needed to support policy changes and it performs
revalidation of permissions for many services.

> This is true, there had been no need for them. I rather wanted to have the
> compiler control all data types. For the extended runtime policy registration
> (REG), generic data storage is in progress.

This issue is also discussed further in the aforementioned paper.
The content and format of security labels is dependent on the particular
security policy, so you need policy-independent data types for labels
in order to truly encapsulate the security policy.  In SELinux,
the security server interfaces for the kernel, the new system calls,
and the file labels make use of these policy-independent data types.
Hence, the content and format of security labels can be radically
revised without needing to change or even recompile anything other
than the security server.  Also, since the security contexts for
files are stored in each file system, human-readable and meaningful
security information is available if the file system is moved to
another system or the policy is changed, so translation of
security attributes is feasible. 

> Yes, there are pointers given, e.g. dentry pointers. This is necessary for
> attribute value inheritance from parent objects (or do you know a better way?).
> However, no data in kernel structs is ever modified. Most of these extra
> attributes contain simple integer values, e.g. the uid for a CHANGE_OWNER
> request.
> You also have to provide kernel data somehow, because you want to decide about
> subjects and objects identified by this data.

I would encourage you to take a look at the SELinux/Flask interfaces
described in the documentation.  We do not pass any pointers to
any private kernel objects to the security server.  The security
server only needs to know the security labels of the relevant
subjects and objects, not kernel objects or identifiers.  
In part, this difference is architectural - the GFAC subdivides
the responsibility between the enforcement code and the decision
facility differently than Flask.

> Did you ever benchmark the access control overhead? RSBAC numbers told me to
> rather spend work on other parts (see file benchmarks.htm).

Yes, we have run benchmarks, and the results will be published at
the upcoming Freenix.  Macrobenchmark tests (kernel compilation,
WebStone) had almost no overhead, so they didn't really show
the performance benefit of the cache.  But microbenchmark test suites
(lmbench, UnixBench) showed that the cache has a significant benefit
for the performance of individual operations.

> For me, this is a clear RSBAC advantage. How many applications are you going to
> change for your access control system? How will you keep up to date? How does
> the user get support for arbitrary applications?

Perhaps I was unclear.  SELinux is mostly transparent to applications
(except upon access failures, of course).  We provide a set of
extended and new API calls to allow modified and new applications
to be developed that have some degree of awareness of the new
security features.  But existing applications can certainly
run unchanged on SELinux and appropriate default behaviors
are applied when the ordinary API calls are used.  As an
example, we provide a modified ps program that displays
the security contexts of processes.  But you can run the
ordinary ps program if you want - you just won't see the
security contexts with it.  And notice that since we
provide policy-independent data types for security labels,
our modified ps program never needs to be changed even if
the format or content of security labels is radically revised.

> If the (small) time window is a problem, then you have an argument here. You
> would have to create in a protected directory, set attributes and move the file
> to its final destination.
> BTW: For PM model, there are specific calls to create files of certain object
> types - the model design does not provide default types.

Ok, so you already have a case where a policy module requires the
ability to allow applications to create files with a particular label.
By using policy-independent data types for labels, you can have
a single set of APIs (open_secure, mkdir_secure, etc) that can provide
this functionality for any policy.  And yes, it is important to be
able to create objects with a particular label rather than just
creating them with a default and then relabeling them.  Relabeling
has its own complications - do you fully address the revocation problem
for open file descriptions and memory-mapped files?

> As to subjects: User accounts are not (yet) controlled by the kernel anyway.
> This has to be changed soon to get real kernel security.

I'm not entirely sure what you mean by this statement.

> So let's come to processes. Here you are wrong: Process attributes are
> initialized by the decision modules directly after creation, and before control
> is returned to the forking or the new process.

Sure, process attributes are initialized on fork.  But I was talking
about an extended form of execve to allow changes in attributes
upon program execution.  That is the most natural point for
a change in attributes, because you can easily control the
inheritance of state and the initialization in the new label,
and you can establish a binding between the new label and
the executable.  RSBAC supports default label changes on execve
(e.g. RC forced role transitions), but doesn't provide any
way for an application to explicitly request such a transition.

> > It also provides new API calls to allow applications to obtain
> > security policy decisions from the security server in order to
> > support application policy enforcers.  For example, a windowing
> > system might be enhanced to provide labeling and separation of
> > windows, with controlled cut-and-paste between windows, or
> > a database management system might be enhanced to provide
> > labeling and separation of individual database records maintained
> > in a single file.  These application policy enforcers would
> > still be controlled by the kernel, but could further refine
> > the granularity of protection provided by the kernel.
> 
> This has been thought about in RSBAC, too (see Nordsec paper on Malware
> Scanning). What already exists is the request function itself, which can be
> called from within the kernel. The necessary glue to user space can easily be
> provided by a kernel module.    

Ok.  This has actually been done with one of our prior prototypes (DTOS).
One university integrated similar controls into the X Window System,
and another university provides similar functionality in a database
management system.

> OK, if you think that security relevant *and* not sufficiently covered by
> existing mechanisms.

With regard to specific controls, I would encourage you to look at
the Control Requirements sections in our design and implementation
document (available via http://www.nsa.gov/selinux/slinux-abs.html).
They specify the precise set of controls for each system call that
we defined.

> > controls on
> > the use of Linux capabilities, 
> 
> What for? I do not mess with the existing discretionary access control, it is
> completely independent. I only control access control data that is relevant for
> RSBAC.

A number of the capabilities are used to control highly privileged
system operations.  We could define our own separate set of permissions
and add checks to each such privileged operation, but it seems better
to leverage the work being done by the Linux-Privs people and
add a hook to the capable function to perform a permission check as well.
That allows the security policy to control all capability usage, and
thus control a large number of privileged operations with minimal
code modifications.

>  
> > 6) RSBAC uses the Linux real user identity attribute for its decisions
> > and must control changes to this attribute, so it is not completely
> > orthogonal to the existing Linux access controls.
> 
> I believe that a common thing in all access control models that reside on a
> single system is the identity of a user. This is what authentication is meant
> to be about.
> 
> If users need more than one identity, the model is wrong. She should rather
> need several roles, or transaction procedures with additional rights, or
> whatever.

The SELinux controls themselves are only based on a single user identity
- the user identity in the security context.  By providing a separate
usre identity attribute, we can enforce whatever controls we want
over changes to it without affecting compatibility.  I agree
that we want to establish the user's identity and then handle
any needed changes in access rights by changing the role/domain
rather than the user identity itself.  The concern with using the
existing Linux real uid is that we must then balance between
providing rigorous controls over changes to it and maintaining
compatibility.  There is also an acceptability concern; it
seems like the kernel developers would be more open to an
access control scheme that is orthogonal to the existing scheme
than one that is intermingled with it.

> I'll have to get a closer look into your model. We seem to have addressed
> similar problems, e.g. transaction procedure support.
> 
> What do you think is weaker in the role/domain changes controls of RC?

It appears that there are three ways a role change can occur in RSBAC RC:
1) when the Linux real uid is changed (in which case the role is typically
reset to the default role for the new uid), 2) by an explicit call to
change roles, 3) by executing a forced role program.  The RC role compatibility 
vector only controls role changes caused by an explicit system call to
change roles.  The other two kinds of role changes are not constrained by
this vector.

With the SELinux TE module, a domain transition can only occur via an
execve (or execve_secure), and is always controlled in a consistent
manner.  The controls ensure that the old domain can start the
program, that the old domain can transition to the new domain, and that
the new domain can be entered via the program.  They also address
issues such as inheritance of open file descriptions, continuance
of any process tracing in progress, sharing of any state across
the execve, and ultimately whether or not the new domain can
return an exit status to the old domain.  

> This was a compromise with performance. Still, I won't agree to it being a
> limitation until you give me an example, where you need more than 64 roles in a
> single system, and do not think ACLs to be a better solution.

The example configuration provided with SELinux defines 70 domains,
188 file types, and 38 other types (e.g. network-related types).
I don't think that supporting arbitrary numbers of domains and types
has much affect on the performance of our TE implementation.

> > RSBAC does not appear to have an equivalent
> > to the human-readable SELinux policy configuration files, and it requires
> > that the policy be configured through a set of new utilities that use new
> > system calls. 
> 
> As explained above, I believe separate mechanisms for RSBAC administration to
> be a much better solution than hacking it into existing interfaces. What is the
> problem with some extra system calls?

I probably wasn't clear.  With SELinux, you edit the human-readable policy
configuration files to set up your policy (starting with the example
configuration we provide if you want), then compile that policy
into a binary representation and install it.  You can then load
the updated policy into your running kernel (if the policy authorizes
such runtime changes) using a new system call, or you can reboot
(in which case the kernel will load the new policy when it
initializes).  My concern was with the need to run a special
set of utilities that use a special set of system calls to
customize the configuration, as opposed to being able to edit
human-readable configuration files.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
