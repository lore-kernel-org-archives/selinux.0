Subject: RE: We are attempting once again to split policy outintoindividual
	RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Jeremy Katz <katzj@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146670602.6723.33.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158816FEDB@exchange.columbia.tresys.com>
	 <1146597202.13611.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1146670602.6723.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 May 2006 11:51:19 -0400
Message-Id: <1146671479.27735.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-03 at 11:36 -0400, Karl MacMillan wrote:
> On Tue, 2006-05-02 at 15:13 -0400, Stephen Smalley wrote:
> > I do think having rpm check the file contexts of the installed files
> > after policy load would be good practice, both for robustness and
> > security.  
> >  
> 
> I agree that this sounds like a good compromise - is there any chance
> that this will happen?

Jeremy followed up off list; his initial idea was to just validate the
contexts in the header, but wasn't clear as to what rpm should then do
if there is an error.  I suggested it should be actually checking the
effective labels of the installed files via lgetxattr/lgetfilecon, which
will return unlabeled_t if the attribute was never mapped to a valid
label, but he had a concern with the performance overhead there.  Even
in that case, he wasn't sure what rpm should then do, i.e. what is a
sane label to assign to the mislabeled file at that point.  It could, of
course, just set the xattr to truly be unlabeled_t on disk.

> Maybe I missed it, but if this privilege is added, how will it be
> granted. A permission on the filesystem object class?

Not decided, but I was thinking just the security class, as it is
effectively a security operation, similar to loading policy, and I would
expect us to be generally more careful about the security permissions in
the policy.  Applying it to the superblock/filesystem would be a bit
more granular, although no one today is using the per-superblock labels
for anything useful (except possibly in the MLS space).

Still looking at the issues of having the kernel revalidate/update the
inode SIDs from xattr upon policy reload - not very pleasant, of course,
but no surprise there.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
