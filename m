MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support fordeferred	mappingof inode security contexts
Date: Tue, 16 May 2006 11:42:55 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015881705CD@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>,
        "Thomas Bleher" <bleher@informatik.uni-muenchen.de>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "James Morris" <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Tue, 2006-05-16 at 10:02 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Tue, 2006-05-16 at 08:50 -0400, Joshua Brindle wrote:
<snip>
> 
> Yes, restore doesn't check what the uid maps to (i.e. it 
> doesn't look up the username); it just gets the uid via 
> lstat() and compares with what is in the dump IIUC.  Likewise 
> for the attribute, using lgetxattr().
> But with the current patch, the lgetxattr() will still return 
> unlabeled_t for these not-yet-valid contexts, and thus won't 
> match the value in the dump.
> 

Right, it is unfortunate that there is no way to get the raw EA off
disk, which is really what archive should use. 

> This is all based on the description in the bug report:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845
> 
> Now, if we don't plan to use this technique for restore at 
> all, instead just using Chad's proposed approach, then it may 
> not matter.
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845#c27
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845#c30
> 
> Part of the problem here is the overloading of lgetxattr().  
> Having two separate calls (one for getting the raw on-disk 
> attribute and one for getting the MAC label as seen incore) 
> would be nice, but not too likely at this point.
> 

Not too likely in the vfs you mean? It occurs to me that maybe changing
the semantics of getxattr() could have been avoided if there was a way
to request a canonicalized version (via selinuxfs). Granted this means
lots of applications have to change :\ but it seems more appropriate.

<snip>
> 
> Strictly speaking, that is already possible when running 
> audit2allow or audit2why on an audit log generated while 
> running a different policy.
> And it isn't clear that you want audit2allow automatically 
> converting a denial on a not-yet-valid (or previously valid) 
> context into access to unlabeled_t, but that is another 
> matter.  But you seem to be unhappy with either alternative 
> (avc and audit both log the unmapped string, avc and audit 
> log different values).  So you think they should just 
> continue to log unlabeled_t in both cases?  That loses 
> information that we have available with this change.  
> Possibly they could log both, but that becomes a format 
> change to the audit messages.

Fair enough, getting unlabeled_t rules from audit2allow is almost as bad
(if not worse) than getting types that won't build. Now sure how to deal
with this but IMO they should be consistent between avc messages and
audit messages. However, if the sidtab_node has an unmapped context
could the avc denial put it in another field? Another security server
call to obtain the unmapped context for a sid could be put in
avc_dump_query to add the field. Do you think this is
doable/appropriate?

> 
> Going back to your earlier comment, you asked about auditing 
> labelpriv events and being able to see the unmapped context 
> in an audit message.
> We can certainly auditallow labelpriv in the policy to 
> trigger an audit message on each one, although that wouldn't 
> include the unmapped context value.  I presently have 
> printk(KERN_INFO) statements when an unmapped value is first 
> added to the SID table and when contexts switch from mapped 
> to unmapped or vice versa upon policy reload; those could be 
> converted to audit_log calls if that is preferable.
> 

Yea, I think turning it into a audit message is ideal. Can you generate
an extra field in the avc message for this permission? (eg.,
unmappedcon=...) that way you can auditallow this permission and get the
unmapped contexts being writen (and by whom).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
