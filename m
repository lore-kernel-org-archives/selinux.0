Subject: Re: Application-level Access Management
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Kramer <josh@globalherald.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <alpine.LFD.2.00.0902191020490.13287@home-av-server.home-av>
References: <alpine.LFD.2.00.0902191020490.13287@home-av-server.home-av>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 16:16:42 -0500
Message-Id: <1235164602.6285.186.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-19 at 10:25 -0500, Joshua Kramer wrote:
> Hello Everyone,
> 
> I am working on adding SELinux-based ACLs to the Apache QPid project.  I 
> have considered how I might accomplish this based on QPid's ACL model.

I'm not familiar with QPid or its ACL model, so obviously what I say
below may not be entirely applicable.  Note btw that the semantics of
ACLs are not always what you want for MAC.

> However, I have a question.  Can I store the security context of arbitrary 
> objects in SELinux itself?  In this case, an 'object' is a C++ object 
> inside a qpid daemon: a queue, broker, etc.  The security contexts of 
> files, for example, are usually stored in the xattrs on the filesystem. 
> Can I store the security context of a qpid queue in SELinux somewhere, or 
> do I need to create a file to store those contexts?  Is there a more 
> secure way to store the contexts?

Generally each object manager is responsible for binding security
contexts to its objects. SELinux does not provide a generic object
context association storage service of any kind.  SE-PostgreSQL provides
for its own storage of security contexts, for example.  XSELinux binds
security contexts to its objects, like windows, but as the objects
themselves are non-persistent, there is no need for persistent storage
of the contexts.

I assume you've read the various papers about existing
userspace/application object managers, e.g. the SE-PostgreSQL
documentation, Applying Flask to X, Using GConf as an Example of a
Userspace Object Manager, etc.

> More detail about this endeavor is noted below.  This was a recent thread 
> on the qpid-dev mailing list.

A couple of comments interspersed below.

> 
> Thanks,
> -Josh
> 
> >> AclModule (which is pluggable). Can that not be implemented as a call to 
> >> security_compute_av? 
> > 
> > yea, I think we might have enough abstraction. We might need to add a map of 
> > IDs to the object list for SELinux. If that is needed I can volunteer to do
> 
> That's what I was thinking, as I took a look at
> 
> /qpid/cpp/src/qpid/broker/AclModule.h
> 
> ...and its friends under qpid/acl.  The data in AclModule.h looks like it's a 
> good representation of the various Actions we'll have to model. We will need to 
> model the security contexts pertaining to each item.  For example, you can have 
> a file type for an index.htm file, of httpd_sys_content_t.  Contrast this to 
> user_home_t.  We might have a queue, FinancialDataQueue, that should not be 
> able to be read by the webserver.  FinancialDataQueue would have a type of 
> fin_content_t.  Since the contexts are not stored in the Qpid objects 
> themselves, the ACL plugin will need to map each object to its context.  If a 
> user with type httpd_t attempts to read from FinancialDataQueue, then the 
> authorize call would go something like this:
> 
> 1. User Name = 'httpd'

Where does this identity come from?  How is it authenticated?

> 2. Queue Name = 'FinancialDataQueue'
> 3. Lookup current context of user 'httpd' (that is a SELinux library call, to 
> find the SELinux user called 'httpd') and find its type to be httpd_t

Even better would be to obtain the context of the actual originator of
the request, e.g. using getpeercon(3).  This is the approach taken in
XSELinux and I believe in SE-PostgreSQL.  Of course, that requires use
of either AF_LOCAL sockets or labeled IPSEC to convey the client
context.

> 4. Lookup current context of queue FinancialDataQueue and find its type to be 
> fin_content_t
> 5. Call security_compute_av with the contexts, and pass or fail as needed.

Here you want avc_has_perm() and friends.  Look at XSELinux, D-BUS, or
SE-PostgreSQL for examples (although the latter did some specialized
handling for performance and implemented its own custom AVC as I recall
rather than using the libselinux implementation).

> 
> Number 4 is tricky.  I am not yet sure if SELinux contexts can be stored for 
> arbitrary named objects.  On the filesystem the are usually stored in xattrs. 
> Dan?
> 
> Thoughts?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
