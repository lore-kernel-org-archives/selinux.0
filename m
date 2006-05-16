Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred
	mappingof inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588170599@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588170599@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 09:41:23 -0400
Message-Id: <1147786883.30789.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-16 at 08:50 -0400, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > Note that an alternative would be to modify 
> > security_sid_to_context() to return the unmapped string 
> > representation if it exists rather than just falling through 
> > to the unlabeled SID's context.  In that case,
> > getxattr() would return the unmapped string, and userspace 
> > would see user_u:object_r:foo_exec_t throughout the example 
> > even though the kernel would internally be applying access 
> > checks based on the unlabeled SID's context.  That seems 
> > useful for programs that want to check the attributes (e.g. 
> > restore), but prevents rpm from easily checking whether the 
> 
> In the restore case it is much more about what is on the physical disk
> than what the kernel sees and that information is easy to obtain. If
> this returns the unmapped string doesn't it make the canonicalization
> fairly useless?

IIUC, restore -C works by calling lgetxattr() on the files and comparing
the attribute returned by it against what is in the dump.  So if
lgetxattr() returns unlabeled_t rather than the unmapped string, the
compare will fail.  Likewise for verification of a successful restore
from a dump.  IIUC, the raw read of the device only occurs when dumping
the partition; restore itself operates via the normal system calls on
the fs.

Canonicalization would still occur for contexts that are valid; the only
change here is in what we return to userspace (and in logs) for invalid
contexts.

> > attribute has been validated by a subsequent policy load 
> > (although it could use security_check_context(3) for that 
> > purpose).  Likewise, if an audit message is generated for a 
> > SID that has been invalidated, having 
> > security_sid_to_context() return the unmapped string 
> > representation would preserve the original string label in 
> > the audit message rather than degenerating to the unlabeled 
> > SID's context.
> 
> I think it would be very confusing to have conflicting audit messages
> (eg., avc says one thing, audit message says another) however, it is
> probably very important to be able to audit privlabel events and be able
> to see the unmapped context in an audit message, is that possible?

At present, both the avc and audit will end up displaying the unlabeled
SID's context for all invalid contexts because that is what
security_sid_to_context() will return.  What I'm suggesting would change
that behavior so that they both will display the unmapped string
representation, thereby preserving the actual text label.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
