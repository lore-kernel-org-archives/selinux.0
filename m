Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA16885
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:10:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA01292
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:09:12 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA01288
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:09:11 GMT
Date: Thu, 11 Jan 2001 17:10:28 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101112310.RAA87961@tomcat.admin.navo.hpc.mil>
To: hch@ns.caldera.de, Stephen Smalley <sds@tislabs.com>
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
Cc: Casey Schaufler <casey@sgi.com>, selinux@tycho.nsa.gov,
        linux-privs-discuss@sourceforge.net
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Christoph Hellwig <hch@ns.caldera.de>:
> On Thu, Jan 11, 2001 at 01:31:44PM -0500, Stephen Smalley wrote:
> > > That's because those are the only operations POSIX systems
> > > support! It's implicit in being a POSIX (DRAFT) standard.
> > 
> > You can define distinct operations (permissions) in the
> > mandatory security policy for distinct kernel services
> > without altering the interfaces or behavior for discretionary
> > access controls. 
> 
> Sure you can.  But Posix 1003.1e is designed to fit nicely into
> a UNIX/Posix enviroment.  And that's exactly why I like it.
> 
> > As discussed ad nauseum on the robust open source mailing list,
> > Type Enforcement is desirable for its support for ensuring that
> > applications are unbypassable and tamperproof, that processes
> > with any sort of privileges cannot execute untrustworthy
> > code, and for providing least privilege.
> 
> For this you have capabilities.  Look at the allowed set in filesystem
> capabilities.  That's another fine part of Posix 1003.1e: it seperates
> cleanly what does not belong together.

That is true for some security policies, not for others. POSIX is/was
based on the TSEC description, which is a very black/white model. It
does not support a more complex model such as a chinese wall structure.

That policy allows a user to access anything. But once the user accesses
an isolated object, the user can no longer access other objects. This
is related to the problem of "privileged communication" and "conflict
of interest" resolution. It also has some limitations when it comes to
certain privacy controls that are beginning to show up in industry and
government.

It appears that the SELinux implementation might be able to allow such
a structure to be created, and enforced.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
