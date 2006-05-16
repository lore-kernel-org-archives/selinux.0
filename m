MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred mappingof inode security contexts
Date: Tue, 16 May 2006 08:50:56 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588170599@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Thomas Bleher" <bleher@informatik.uni-muenchen.de>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "James Morris" <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Tuesday, May 16, 2006 8:16 AM
> 
> On Mon, 2006-05-15 at 12:35 -0400, Stephen Smalley wrote:
> > # touch foo
> > # chcon -t foo_exec_t foo
> > # ls -Z foo
> > -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> 
> Note that an alternative would be to modify 
> security_sid_to_context() to return the unmapped string 
> representation if it exists rather than just falling through 
> to the unlabeled SID's context.  In that case,
> getxattr() would return the unmapped string, and userspace 
> would see user_u:object_r:foo_exec_t throughout the example 
> even though the kernel would internally be applying access 
> checks based on the unlabeled SID's context.  That seems 
> useful for programs that want to check the attributes (e.g. 
> restore), but prevents rpm from easily checking whether the 

In the restore case it is much more about what is on the physical disk
than what the kernel sees and that information is easy to obtain. If
this returns the unmapped string doesn't it make the canonicalization
fairly useless?

> attribute has been validated by a subsequent policy load 
> (although it could use security_check_context(3) for that 
> purpose).  Likewise, if an audit message is generated for a 
> SID that has been invalidated, having 
> security_sid_to_context() return the unmapped string 
> representation would preserve the original string label in 
> the audit message rather than degenerating to the unlabeled 
> SID's context.

I think it would be very confusing to have conflicting audit messages
(eg., avc says one thing, audit message says another) however, it is
probably very important to be able to audit privlabel events and be able
to see the unmapped context in an audit message, is that possible?

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
