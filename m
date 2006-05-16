Subject: Re: [RFC][PATCH] selinux:  introduce support for
	deferred	mappingof inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <4469DB84.1080507@gentoo.org>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588170599@exchange.columbia.tresys.com>
	 <1147786883.30789.104.camel@moss-spartans.epoch.ncsc.mil>
	 <4469DB84.1080507@gentoo.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 10:54:10 -0400
Message-Id: <1147791250.30789.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-16 at 10:02 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2006-05-16 at 08:50 -0400, Joshua Brindle wrote:
> >   
> > <snip>
> > IIUC, restore -C works by calling lgetxattr() on the files and comparing
> > the attribute returned by it against what is in the dump.  So if
> > lgetxattr() returns unlabeled_t rather than the unmapped string, the
> > compare will fail.  Likewise for verification of a successful restore
> > from a dump.  IIUC, the raw read of the device only occurs when dumping
> > the partition; restore itself operates via the normal system calls on
> > the fs.
> >
> >   
> I'm not sure if this is the appropriate behavior. For example, restore 
> doesn't/can't verify that the UID/GID for the file being restored is 
> mapped the same as it was when the archive was created. IMHO restore's 
> job isn't to interpret the backup, its job is to write it out and let 
> the admin interpret it.

Yes, restore doesn't check what the uid maps to (i.e. it doesn't look up
the username); it just gets the uid via lstat() and compares with what
is in the dump IIUC.  Likewise for the attribute, using lgetxattr().
But with the current patch, the lgetxattr() will still return
unlabeled_t for these not-yet-valid contexts, and thus won't match the
value in the dump.

This is all based on the description in the bug report:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845

Now, if we don't plan to use this technique for restore at all, instead
just using Chad's proposed approach, then it may not matter.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845#c27
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189845#c30

Part of the problem here is the overloading of lgetxattr().  Having two
separate calls (one for getting the raw on-disk attribute and one for
getting the MAC label as seen incore) would be nice, but not too likely
at this point.

> > At present, both the avc and audit will end up displaying the unlabeled
> > SID's context for all invalid contexts because that is what
> > security_sid_to_context() will return.  What I'm suggesting would change
> > that behavior so that they both will display the unmapped string
> > representation, thereby preserving the actual text label.
> >   
> 
> So the denial would have the unmapped context? I don't think I 
> understand that, it wouldn't be a denial that represents what actually 
> happened (not to mention the type wouldn't necessarilly be in the policy 
> so any attempt to audit2allow or similar will yield an 
> uncompilable/unlinkable policy)

Strictly speaking, that is already possible when running audit2allow or
audit2why on an audit log generated while running a different policy.
And it isn't clear that you want audit2allow automatically converting a
denial on a not-yet-valid (or previously valid) context into access to
unlabeled_t, but that is another matter.  But you seem to be unhappy
with either alternative (avc and audit both log the unmapped string, avc
and audit log different values).  So you think they should just continue
to log unlabeled_t in both cases?  That loses information that we have
available with this change.  Possibly they could log both, but that
becomes a format change to the audit messages.

Going back to your earlier comment, you asked about auditing labelpriv
events and being able to see the unmapped context in an audit message.
We can certainly auditallow labelpriv in the policy to trigger an audit
message on each one, although that wouldn't include the unmapped context
value.  I presently have printk(KERN_INFO) statements when an unmapped
value is first added to the SID table and when contexts switch from
mapped to unmapped or vice versa upon policy reload; those could be
converted to audit_log calls if that is preferable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
