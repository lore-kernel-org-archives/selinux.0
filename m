Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23575
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 11:04:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA21767
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:04:25 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA21763
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:04:24 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id LAA28661
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 11:03:55 -0500 (EST)
Date: Tue, 26 Dec 2000 11:03:54 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: procps patches
In-Reply-To: <200012222209.eBMM9ao457986@saturn.cs.uml.edu>
Message-ID: <Pine.SOL.3.95.1001226095501.26114E-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> Can I find out who wrote the procps (/bin/ps) patches?
> That is, without getting killed. :-) I'd be happy to include
> security data printing as part of the standard ps program.

The procps patch was contributed by MITRE.  MITRE wrote
patches for several of the Unix utilities (procps, psmisc,
fileutils, findutils, stat, tar) as a learning exercise 
to learn more about using SELinux prior to moving on to developing
a security policy configuration for crond.

> Note that I have already reserved several option flags
> for MAC data... is this not what is needed? If possible
> I'd prefer to keep the Linux ps compatible with what is
> used on Trusted IRIX, etc.
> 
> Reserved for security data:  -M -Z -x -z
> You may have seen the -x as -y on other systems;
> the -y option is already taken for another purpose.

In order to support many different kinds of security policies,
the Security-Enhanced Linux provides policy-independent
data types for security labels.  These types, the
security context and the security identifier, are described
in the kernel document (Integrating Flexible Support for
Security Policies into the Linux Operating System).  If
the reserved options are intended to be used with
traditional trusted operating systems, then they will
be specific to multi-level security (MLS) and will
not be appropriate for other kinds of mandatory security policies.
Hence, the current procps patch simply uses GNU-style long options
for displaying security contexts and SIDs.  I think that
we would be happy to use the existing reserved options if
they will support policy-independent labels.

> It is strongly preferred that columns of data never contain
> whitespace and that unknown or unavailable data print as '-'.
> So the "<not authorized>" stuff must become "-" instead.
> This is to allow parsing the output of ps by splitting columns
> apart based on whitespace. The "-" should always be printed
> when using a non-FLASK kernel, instead of the error message.

Ok.

> Um, if someone is not authorized to read security data, then
> why are they even allowed to know that the process exists?
> Somebody could transmit data by playing with signal masks and
> other items found under /proc.

Access to /proc is controlled by the file mandatory access controls,
as described in Section 7.1 of the kernel document and Section 3.3.4
of the policy document.  The ps program runs in the same security
context as its caller, so it has no special privileges in this
regard.  The <not authorized> cases were simply to handle errors
in obtaining the security context of the process, such as 
lacking getattr permission to the particular /proc/PID directory
or lacking permission to obtain the security context of the given SID.

> I can't allow the #ifdef inside the list of format specifiers,
> because this makes it hard for me to keep the list sorted.

Ok.  

> Generating a path to the process in pr_context() is poor.
> Really, this should be done in the library code.

As mentioned above, the utility patches were primarily exercises
for MITRE to learn about SELinux while simultaneously providing
some examples of how to use the new kernel features.  Feel free
to improve on the implementation.

> I notice that there are two new formats... why? It seems that
> there would be plenty of room to put all the data in one format,
> like this:
> 
> {"FLASK", "pid,secsid,context,command"}, /* FLASK security data */
> 
> On a standard 80-column screen you still get 22 characters for
> the command name and arguments. It would even be reasonable to
> include an extra column or two, like the (unimplemented?) LUID.

Since security contexts may consist of multiple security attributes,
a single security context could be quite long.  Even in a MLS
system, a human-readable version of a compartment set could
be quite long.  But I'm not especially adverse to merging the
two formats into a single one.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
