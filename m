Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5NHkKko004750
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 13:46:20 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5NHkIoq023119
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 17:46:18 GMT
Date: Sat, 23 Jun 2007 13:45:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        nfsv4@linux-nfs.org, Karl MacMillan <kmacmill@redhat.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <20070623071536.GA23364@infradead.org>
Message-ID: <Line.LNX.4.64.0706231118090.12813@localhost.localdomain>
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain>
 <519223.91074.qm@web36605.mail.mud.yahoo.com> <20070623071536.GA23364@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Jun 2007, Christoph Hellwig wrote:

> I'd love to see having support for this protocol on Linux.  There's
> a lot of demand both for security label and just general user extended
> attributes on NFS.

NFSv4 has named attributes, which are modeled on Solaris subfile-style 
extended attributes.  Technically, I think we could emulate Linux style 
xattrs over named attributes, but it's ugly:

1. Semantics would need to be restricted to those of Linux xattrs, so that 
they act like strings rather than streams, don't allow subdirectories etc.

2. Named attributes are specified as being opaque to NFS and for use by 
applications.  This conflicts with security labeling, where labels are 
typically manipulated and interpreted at the kernel level as well as the 
application level (similar issues exist for some other Linux xattr types 
such as 'system' and 'trusted').

3. Under Linux, xattr semantics are encoded into the xattr namespace.  
e.g. SELinux labels are in the "security.selinux" namespace, where both 
the security and selinux components specify semantics.  Trying to emulate 
this over named attributes would further conflict with their opaque and 
user-managed characteristics.  We'd need to do some ugly things like 
perhaps reserve a top-level namespace which implements Linux semantics, 
and try to prevent interoperability issues such as an unprivileged user 
on a Solaris client arbitrarily setting security xattrs on a Linux server.

4. SELinux labels, and potentially other kernel-managed Linux xattrs, 
require considerably more state than can be conveyed by any simple notion 
of attributes over the wire.  xattrs are an appropriate local mechanism 
for security labeling, because they provide a consistent API and 
filesystem portability.  However, other local security state is also 
utilized by the security system, such as the current security label of the 
process accessing the file (as opposed to the one which opened it) and its 
fscreate attribute.  Once we start to distribute SELinux labeling, it 
becomes apparent that we need to a lot more than simply send file labels 
over the wire.  In addition to managing volatile client security state, we 
need to cater to many other aspects of the system, including but not 
limited to: binding SELinux-specific authentication credentials to 
operations; allowing the client to obtain SELinux labeling and enforcement 
decisions from the server for cached/delegated objects; ensuring 
consistency when server policy changes; and conveying audit messages 
across the wire.


One approach would be to extend NFSv4 to support Linux-style xattrs as a 
distinct set of operations (e.g. SETXATTR, GETXATTR etc), which I 
understand would also be useful for a few other OSs.

This would certainly allow for a clean implementation of user-managed 
xattrs, potentially addressing the first three items above.  However, it 
would not address the wider set of issues arising from kernel-managed 
labeling per the fourth item above.

xattrs over the wire are probably a good fit for user-managed xattrs, as 
the network protocol maps well to local filesystem operations, but they're 
not a good general solution for kernel-managed xattrs.

(Note that the Linux NFSv4 ACL implementation does not use xattrs over the 
wire, even though xattrs are used as a mechanism at the local filesystem 
level).

There are existing mechanisms in NFSv4 which are both extensible and 
likely to provide more natural mapping of requirements. e.g. extend 
SETATTR for the actual labeling, which has existing provisions for 
interoperability and is in fact described as a mechanism for modifiying 
authorization on objects.  We don't need to create or adapt a separate 
mechanism in this case.  Similar for GETATTR and potentially others.

So, what I think we have here are two separate problems to be solved:

a) Extending security labeling to NFSv4, where conveying security labels 
over the wire is a relatively small part of a complex project, and is not 
served optimally by a generalized NFS xattr scheme.

b) Implementing generalized user-managed xattrs with Linux/BSD semantics 
as set of new NFSv4 operations.

The focus of this work would be on (a), and I think that (b) is an 
entirely separate and somewhat simpler project.


Btw, I will be in Ottawa next week.  Perhaps it might be worth organizing 
a lunch or similar for people who are there and interested in discussing 
this.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
