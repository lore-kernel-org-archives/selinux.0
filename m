Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13779
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 11:50:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA12460
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:48:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA12455
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:48:57 GMT
Date: Thu, 11 Jan 2001 11:48:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
In-Reply-To: <20010111171602.B5816@caldera.de>
Message-ID: <Pine.SOL.3.95.1010111111746.23465T-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> No.  The policy for posix 1003.1e mac is set from userspace and stored
> in extended attributes, at least in the TrustedBSD version, my initial
> Linux hack and SGIs version.

By "policy", are you simply referring to file labels?  What about
the security policy logic that determines whether access is granted?
Where is that implemented?  It sounds like there may be a misunderstanding
here.  In SELinux, file labels can likewise be set by applications
and are associated with files through a combination of a field in
the inode and a set of label mapping files.  We would have used extended
attributes, except that they weren't available in ext2fs.  The
format and contents of security labels can be arbitrarily changed
without modifying or even recompiling the file system code (or
networking code or process management code, etc).  The security policy
decisions are specified through a set of security policy
configuration files that can be edited and compiled into a 
binary representation that is loaded and used by the security server.
Most desired security policy changes can be implemented simply
by changing that configuration and reloading it.  If you want a 
radically new style of policy, you can reimplement the security server
itself, but that still doesn't require any changes or even recompilation
of the other components of the operating system.

The POSIX.1e MAC tightly couples policy and enforcement because
it is designed for a particular kind of security policy.
It assumes a certain kind of security label.  It assumes hierarchical
relationships among labels.  It assumes that it is
sufficient to treat all operations as being read, write, or execute.  
In order to support Type Enforcement or Role-Based Access
Control or other kinds of mandatory security, you are very likely
to need to change or at least recompile the file system code,
the networking code, etc.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
