Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27118
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 11:58:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA13866
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 15:58:10 GMT
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com [194.25.134.18])
	by jazzband.ncsc.mil  with ESMTP id PAA13862
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2001 15:58:09 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, RSBAC List <rsbac@compuniverse.de>
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Tue, 3 Apr 2001 16:35:28 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010402145703.8569J-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010402145703.8569J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040317572202.01693@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

As the main author of RSBAC, I will try to pick up some issues Stephen Smalley
pointed out. In the end, we might both end up with some new ideas.

My main problem sure is the lack of detailed knowledge about the SELinux
implementation, I just do not have the time to follow its development in detail.

On Mon, 02 Apr 2001 Stephen Smalley wrote:
> We've looked at RSBAC, since it has a number of similarities
> to SELinux.  In the following discussion, I'll try to summarize
> some of our observations about how RSBAC compares with SELinux.
> Of course, I'll welcome correction if I am in error about
> some aspect of RSBAC.

Here we are...
 
> RSBAC is based on the Generalized Framework for Access Control
> (GFAC), while SELinux is based on the Flask security architecture.
> Like the Flask architecture, the GFAC separates policy from
> enforcement and can support a variety of security policies.
> With regard to the specific policy modules implemented in
> the two systems, RSBAC provides a Role Compatibility policy module 
> that has similarities to the SELinux Type Enforcement policy module.
> 
> However, RSBAC also differs from SELinux in a number of ways:
> 
> 1) The GFAC does not specifically address the issue of atomic policy
> changes, so RSBAC lacks the SELinux support for dynamic security 
> policies and revocation.

All policy changes get into effect at once, so the next access control decision
will be based on the new settings. If you e.g. want to revoke file access, turn
on READ/WRITE interception, and after revoking the rights, all following read
attempts will fail.

> 2) RSBAC does not appear to provide policy-independent data types for
> security labels (the security context and security identifier in
> Flask/SELinux),

This is true, there had been no need for them. I rather wanted to have the
compiler control all data types. For the extended runtime policy registration
(REG), generic data storage is in progress.

> and it appears to expose policy-specific data types in
> its kernel ADF interfaces (through attribute parameters), new system
> calls, and on-disk file labels. 

Each decision module controls, which if its attributes can be accessed (read or
modified) by which subject. The attribute names are not hidden ('security by
obscurity'), because there is no need to do that. On-disk attribute data is
inaccessible for any user process.

> Furthermore, the kernel ADF depends on
> private kernel data structures and data types, and even takes pointers to
> private kernel objects as parameters through an attribute structure for
> some decisions.  This weakens the separation between policy and
> enforcement.

Yes, there are pointers given, e.g. dentry pointers. This is necessary for
attribute value inheritance from parent objects (or do you know a better way?).
However, no data in kernel structs is ever modified. Most of these extra
attributes contain simple integer values, e.g. the uid for a CHANGE_OWNER
request.

>  SELinux provides cleaner separation between the policy and
> enforcement through its data types, interfaces, and even in its
> security server implementation.  In part, this cleaner separation is a
> historical consequence of the fact that the security server was
> originally a user space server running on a microkernel in the
> predecessors of SELinux (DTMach, DTOS, and Flask).  In SELinux,
> the security server is a kernel subsystem, like the RSBAC ADF,
> but the interface still provides the same separation as in its
> predecessor systems.

As stated above, I cannot comment on SELinux details. Still, while depending on
some kernel values, this is only gathering data, not deciding anything.

You also have to provide kernel data somehow, because you want to decide about
subjects and objects identified by this data.
   
> 3) RSBAC does not appear to have an equivalent to the SELinux
> access vector cache (AVC) or AVC entry references in order
> to minimize the performance overhead of its controls.

Did you ever benchmark the access control overhead? RSBAC numbers told me to
rather spend work on other parts (see file benchmarks.htm).
  
> 4) RSBAC appears to lack equivalents for the extended API calls and new
> API calls of SELinux, instead only providing calls for setting and getting
> attributes of existing subjects and objects.  SELinux provides
> extended versions of existing system calls for creating new subjects
> and objects with specified labels (execve_secure, mkdir_secure).

For me, this is a clear RSBAC advantage. How many applications are you going to
change for your access control system? How will you keep up to date? How does
the user get support for arbitrary applications?

Careful planning has been done in RSBAC design to *avoid* change of existing
applications to new APIs. This has been done by providing several default value
settings in RSBAC administration. If you need other settings, OK, you can still
apply them after creation etc.

If the (small) time window is a problem, then you have an argument here. You
would have to create in a protected directory, set attributes and move the file
to its final destination.

BTW: For PM model, there are specific calls to create files of certain object
types - the model design does not provide default types.

As to subjects: User accounts are not (yet) controlled by the kernel anyway.
This has to be changed soon to get real kernel security.

So let's come to processes. Here you are wrong: Process attributes are
initialized by the decision modules directly after creation, and before control
is returned to the forking or the new process.

[SELinux]
> It also provides new API calls to allow applications to obtain
> security policy decisions from the security server in order to
> support application policy enforcers.  For example, a windowing
> system might be enhanced to provide labeling and separation of
> windows, with controlled cut-and-paste between windows, or
> a database management system might be enhanced to provide
> labeling and separation of individual database records maintained
> in a single file.  These application policy enforcers would
> still be controlled by the kernel, but could further refine
> the granularity of protection provided by the kernel.

This has been thought about in RSBAC, too (see Nordsec paper on Malware
Scanning). What already exists is the request function itself, which can be
called from within the kernel. The necessary glue to user space can easily be
provided by a kernel module.    

> 5) RSBAC appears to lack a number of the controls provided by SELinux for
> each of the kernel subsystems.  Some examples of such gaps in its
> controls include:  consistent controls on changes in process
> labels,

OK, if you think this is security relevant.

> controls on the inheritance and transfer of open file
> descriptions across execve or via local IPC,

True, but reading from and writing to them is controlled, so what will you use
them for?

> control of asynchronous I/O
> signals, control of receiving the exit status via wait,

OK, if you think that security relevant *and* not sufficiently covered by
existing mechanisms.

> controls on
> the use of Linux capabilities, 

What for? I do not mess with the existing discretionary access control, it is
completely independent. I only control access control data that is relevant for
RSBAC.

> failure to check permission to
> all affected directories and files for several of the directory
> operations,

Which ones? If I missed some security relevant ones, those are bugs to be fixed.

> and the lack of an equivalent to the layered networking
> controls provided by SELinux.

Real, subject and object based network access control has been designed and will
be implemented for version 1.2.0. Clearly, the current network access control is
insufficient.

>  Furthermore, the SELinux controls are
> designed to address both the case where the ordinary API call is used
> (e.g. execve) and the case where the extended API call is used (e.g.
> execve_secure) in a consistent manner, while the RSBAC controls
> only address the ordinary API calls.

No argument, because there are (and will be) no extended APIs in RSBAC (s.a.).
 
> 6) RSBAC uses the Linux real user identity attribute for its decisions
> and must control changes to this attribute, so it is not completely
> orthogonal to the existing Linux access controls.

It is not as independent as it could be. But at least, I do not mess with
capabilities... ;)

I believe that a common thing in all access control models that reside on a
single system is the identity of a user. This is what authentication is meant
to be about.

If users need more than one identity, the model is wrong. She should rather
need several roles, or transaction procedures with additional rights, or
whatever.

> There is
> a configuration option for maintaining a separate user identity
> attribute, but the option is not robust and is not recommended.
> SELinux maintains a separate user identity attribute as part
> of the process security context, and is not dependent on the Linux 
> identity attributes for the correct enforcement of the mandatory 
> security policy.

For my above reasons, the option has been kept inactive. Stability was another
reason which added in the decision, but would be no reason now. The option has
not yet disappeared completely, because I thought about porting to other
operating system types with possibly other user id concepts, e.g. name based.

> 7) Most of the RSBAC policy modules are very hardwired in their
> policy logic, and can be easily expressed using the SELinux Type
> Enforcement (TE) configuration.

I'd really like to see that expressed for PM or RC with ACLs. The logic is
hardwired, because it expresses a fixed model. What is the difference to a
model implemented in a description language other than C, e.g. your description
files? For me it is mostly a significant speedup.

>  The RSBAC Role Compatibility (RC) module 
> has many parallels to TE, but it seems to be weaker in its
> controls over role/domain changes and it has special cases
> that are more cleanly addressed in the TE configuration (e.g.
> its special values for inheritance vs. TE transition rules).

I'll have to get a closer look into your model. We seem to have addressed
similar problems, e.g. transaction procedure support.

What do you think is weaker in the role/domain changes controls of RC?

> The RC module also has some implementation limitations (e.g.
> limitation to 64 roles and types) while the SELinux TE module
> has no such fixed limitation.

This was a compromise with performance. Still, I won't agree to it being a
limitation until you give me an example, where you need more than 64 roles in a
single system, and do not think ACLs to be a better solution.

To give you an example: Our Compuniverse communication server configurations
with firewalling, proxies, Mail server, Webserver, several Web interfaces, Fax
server, Internet application server (Netscape etc.), etc. currently use 13
roles and 15 File/Dir types. I am running out of ideas what to use more roles
and types for.

Also, please do not forget that RSBAC is designed to *combine* different
models - if RC is not suitable, also use MAC or ACL.

> RSBAC does not appear to have an equivalent
> to the human-readable SELinux policy configuration files, and it requires
> that the policy be configured through a set of new utilities that use new
> system calls. 

As explained above, I believe separate mechanisms for RSBAC administration to
be a much better solution than hacking it into existing interfaces. What is the
problem with some extra system calls?


Hopefully, this text makes some ideas easier to understand.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
