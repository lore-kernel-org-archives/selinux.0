Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA17726
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 09:19:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA04594
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 13:18:42 GMT
Received: from mailout00.sul.t-online.com (mailout00.sul.t-online.com [194.25.134.16])
	by jazzswing.ncsc.mil  with ESMTP id NAA04587
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 13:18:41 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Fri, 6 Apr 2001 14:40:35 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010406081042.14880B-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010406081042.14880B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040615181000.00879@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fre, 06 Apr 2001 Stephen Smalley wrote:
> > No, you can always add or remove policies by kernel configuration, the
> > unneeded attributes are then simply unused.
> 
> You can add policies that are in the set of fixed policies you provide.
> But if you want to add a new policy module to this fixed set, then
> you have to change a data structure that is visible across the
> kernel ADF interface, new system call interfaces, and on-disk
> file labels.  And why should users pay the cost for attributes
> of policies they never intend to use?

Every single model is free to implement its own data structures. PM, AUTH, RC
and ACL already do, but only ACL does not also use the general attribute
struct, except for log settings.

Changing the general structs extends the syscall interface, but it keeps
compatible with previous versions. This is only a matter of recompiling. The
general struct is just pretty convenient for fixed models, where attributes
rarely change.

The overhead of unused attributes is a rather small amount of memory only, and
the biggest parts of the struct are common values for log settings.

The more dynamic runtime added modules have to bring their own data
structures anyway, what is about to be changed to generic persistent data
handling. They can register as many syscalls as they like - without changes to
the framework or the system syscall table. Still, the possibility of runtime
policy modifications can lead to additional security compromises.

> > An attribute value of 'inherit from parent' means that the lookup recurses to
> > the next higher object level, e.g. the directory a file is in. If there is no
> > higher level, but also no struct object for the current object, real default
> > values are returned.
> > 
> > With this inheritance and default scheme, a complicated setup for a server with
> > a lot of services (like our Communication Server mentioned before) only needs a
> > few hundred attribute structs. Most of these are necessary, because /lib and
> > /usr/lib contain a mixture of libraries and non-libraries.
> 
> What happens if a file has multiple hard links in different
> directories with different attributes?

The directory you use for lookup is taken as the valid parent.

>  What happens if a file is
> renamed to a directory with different attributes?

It inherits the new directory's values. This is how the inheritance scheme is
meant to work. If you prefer different settings, you will have to set them
individually for this object. Putting the file into a different filesystem area
is treated as on purpose.

>  What happens
> if a file system is mounted at multiple locations?

The first mount point is taken as parent. This will probably be changed to
somehow reflect the lookup path. Multiple mounts have only recently been added
in the 2.3/2.4 kernel series and are not available in 2.2 kernels.

>  What happens
> if you provide per-process namespaces?  

This has not yet been worked out completely, so I cannot tell for sure. This is
also a rather new feature, which is (as far as I know) still not commonly used.
  
> The explicit label bindings of SELinux only need to maintain
> a single additional integer (the SID in memory, and the
> persistent SID on disk) for each file.  Only a single copy
> of each distinct security context (your attribute struct)
> is needed.  Administrators can specify file labels recursively,
> and even using pathname regular expressions, but the low-level
> binding is explicit and avoids the problems associated with
> implicit labeling schemes like yours (and also like DTE).

We implemented a similar scheme within PM data structures, where identifiers
are used to lookup in another lists. This is the old discussion about explicit
vs. implicit labels. The RSBAC decision for some models (not all) was for
implicit labels, depending on the object context and thus on changes at other
objects.

However, also with RSBAC you can use explicit labels everywhere, if you want
to. If explicit labelling only is chosen, the indirect scheme with SIDs is
probably a good solution - with a focus on inheritance and extensive use of
default values it mostly slows down the recursive lookup.

BTW: The switching between inheritance as default vs. explicit labels has only
for the last version 1.1.1 been reduced to MAC model. All other models that
support inheritance now default to inheritance.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
