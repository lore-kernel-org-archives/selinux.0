Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA17296
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 08:07:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA01243
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 12:07:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA01239
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 12:07:08 GMT
Date: Fri, 6 Apr 2001 08:06:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Paul D. Robertson" <proberts@clark.net>
cc: RSBAC List <rsbac@rsbac.org>, selinux@tycho.nsa.gov
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <Pine.LNX.4.10.10104040817380.8824-100000@gargoyle.clark.net>
Message-ID: <Pine.SOL.3.95.1010406073047.14880A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> If policy changes aren't rare, both administrative overhead and the
> oppertunity an administrator has to do bad things (maliciously or
> accidently) are higher.   

Most policies require some degree of dynamic behavior, e.g. as
user authorizations change, and some policies must revoke
permissions dynamically based on the history of operations 
performed or in response to some event.  So the idea is to provide the
necessary infrastructure to support policy changes at runtime rather than
requiring that the system be restarted in order to ensure that accesses
are revoked properly.

> > > The example configuration provided with SELinux defines 70 domains,
> > > 188 file types, and 38 other types (e.g. network-related types).
> 
> How do the SELinux people expect auditing to take place in such an
> example?  Users switching jobs and system upgrades seem to be difficult to
> audit effectively with that many default permutations, or am I missing
> something?

As I mentioned in my reply to Amon, most of the domains deal with
system processes and programs that require special access rights.
For users, related domains are grouped into roles, and only a small
number of distinct roles are defined.  If a system upgrade involves
adding new system processes, privileged programs, or sensitive files,
then you would naturally want to update your configuration to address
those entities.  Also, note that this is simply an example policy
configuration.  Administrators are free to find their preferred
balancing point between fine-grained protection (with the cost
of complexity) and ease of management (with the cost of quality
of protection).  But my preference would be to encourage the
development of tools to ease the management without sacrificing
the granularity of protection.

> I assume that the policy compiler is the equivalent of a special set of
> utilities, is that a correct assumption?  Syscall auditing is pretty cut
> and dried, how do you audit policy changes in SELinux between binary
> representations?  How do you deal with an administrator compiling three
> different policies then trying to figure out which one to install a week
> later? 

I'm not sure what you mean by auditing in this context.  
The policy compiler can also be used to load a binary representation
and issue queries against it.  You can use it to test and debug
the policy before installing it (and also to test and debug a
copy of the security server in user space).  I suppose we could
have it "disassemble" a binary representation back into the
human-readable form, or do automatic comparisons with human-readable
forms.

> I'm also still intensely interested in "two man missile key" stuff.  How
> does SELinux handle a model where either multiple adminitstrators should
> be necessary to grant access to something, or granting a subset of grant
> privs. to a subject is possible to stop the subject from granting all
> grant privs. to another subject or itself (which makes it easy to get to
> the first part by requiring both privs. to do something)?  Is it possible to 
> set up a system where an administrator doesn't have access to certain
> targets, and whilst they could grant permissions to other targets on the
> same sytem, and even grant access to grant access to other targets, were
> still blocked from seeing the data they're not supposed to have access to
> (obviously along with their grantees)?  [IOW: is granting rights to grant
> rights restrictable in a way other than a binary yes/no fashion?]

You could model n-person control by defining a n-stage pipeline,
something that TE is naturally suited for.  But I'm curious about
the real intended use for your policy.  Do you really want n-person
control over some operating system service (e.g. a file access), or do
you really need n-person control over some application service?  If
you need it for some application service, then you are likely to need
enforcement support in the application itself, using the OS mechanisms
to protect the application from tampering or bypass and to confine the
damage that might occur if the application mechanism fails.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
