Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA17378
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 08:26:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA00489
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 12:26:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id MAA00485
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 12:26:18 GMT
Date: Fri, 6 Apr 2001 08:25:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Amon Ott <ao@rsbac.org>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <01040510000003.00859@marvin>
Message-ID: <Pine.SOL.3.95.1010406081042.14880B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> No, you can always add or remove policies by kernel configuration, the
> unneeded attributes are then simply unused.

You can add policies that are in the set of fixed policies you provide.
But if you want to add a new policy module to this fixed set, then
you have to change a data structure that is visible across the
kernel ADF interface, new system call interfaces, and on-disk
file labels.  And why should users pay the cost for attributes
of policies they never intend to use?

> One advantage of keeping e.g. all user attributes in one struct is that for a
> run through all decision modules, only one full entry lookup is needed. For the
> second and following attribute readings or settings for this user, there is a
> shortcut pointer.

We also keep all of the attributes in a single struct, and only require
a single lookup of the security identifier (SID).  But the struct
definition is completely private to the security server.  Security
labels are only exported outside of the security server using the
policy-independent data types.

> An attribute value of 'inherit from parent' means that the lookup recurses to
> the next higher object level, e.g. the directory a file is in. If there is no
> higher level, but also no struct object for the current object, real default
> values are returned.
> 
> With this inheritance and default scheme, a complicated setup for a server with
> a lot of services (like our Communication Server mentioned before) only needs a
> few hundred attribute structs. Most of these are necessary, because /lib and
> /usr/lib contain a mixture of libraries and non-libraries.

What happens if a file has multiple hard links in different
directories with different attributes?  What happens if a file is
renamed to a directory with different attributes?  What happens
if a file system is mounted at multiple locations?  What happens
if you provide per-process namespaces?  

The explicit label bindings of SELinux only need to maintain
a single additional integer (the SID in memory, and the
persistent SID on disk) for each file.  Only a single copy
of each distinct security context (your attribute struct)
is needed.  Administrators can specify file labels recursively,
and even using pathname regular expressions, but the low-level
binding is explicit and avoids the problems associated with
implicit labeling schemes like yours (and also like DTE).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
