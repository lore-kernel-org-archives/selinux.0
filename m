Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs
	(v2)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Eric Paris <eparis@parisplace.org>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1175707361.20396.141.camel@localhost.localdomain>
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
	 <1175703431.20396.131.camel@localhost.localdomain>
	 <1175706011.30692.104.camel@moss-spartans.epoch.ncsc.mil>
	 <1175707361.20396.141.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 13:27:43 -0400
Message-Id: <1175707663.30692.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 13:22 -0400, Eric Paris wrote:
> On Wed, 2007-04-04 at 13:00 -0400, Stephen Smalley wrote:
> > On Wed, 2007-04-04 at 12:17 -0400, Eric Paris wrote:
> > > On Wed, 2007-04-04 at 10:11 -0400, James Carter wrote:
> > > > Make the initial SID contexts accessible to userspace via selinuxfs.
> > > > An initial use of this support will be to make the unlabeled context
> > > > available to libselinux for use for invalidated userspace SIDs.
> > > > 
> > > > This version fixes the problem with the for loop that Steve pointed out,
> > > > and changes the flow of security_get_initial_sid_context so that the if
> > > > clause checks for the error condition and uses unlikely().
> > > > 
> > > > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> > > 
> > > I'm just wondering why we have such arbitrary static i_ino for most
> > > inodes in /seliunx but it looks to me like we let avc, booleans, and all
> > > inodes inside avc pick up their i_ino from new_inode() as:
> > > 
> > > inode->i_ino = ++last_ino;
> > > 
> > > (now initial_sids is going to get it's i_ino from last_ino)  If /selinux
> > > were created at the wrong time such that last_ino was the same as one of
> > > the static i_ino ranges we use for /selinux we could have a collision.
> > > Talking with a FS guy he seemed to think the worst case a collision
> > > would cause userspace to mess up hard link detection (which we shouldn't
> > > really have in /selinux) but this seems like something we want to fix.
> > > I guess that is actually not something that needs to be fixed for this
> > > patch so I'm happy enough with this patch.
> > 
> > simple_fill_super() also calls new_inode() for each of the inodes in the
> > tree_descr (and then goes on to overwrite inode->i_ino with the index
> > value), so last_ino should be guaranteed to be above the range of the
> > fixed inodes before we proceed to create the rest of the inodes.  Right?
> 
> Correct, the inodes not explicitly numbered will never conflict with
> those created by simple_fill_super.  But notice that last_ino is global
> (not per SB) and so there is no garantee that last_ino is not going to
> be of a size (thanks to other FS's that are mounted and used new_inode
> before selinuxfs) that it starts to bump into the space used by other
> things.  If very very few inodes were created by other FS's we could
> land in the range used by the booleans (30+boolean number) or if lots
> and lots of inodes were created we could land in the range used by
> initial sids (0x01000000 + sid).  While I agree there is a whole lot of
> space in the middle to land in I still think collision is possible.
> 
> Note that on my system this range of free assignment lies between about
> 322 and 328 but since it is dictated by inodes created in FS's outside
> of selinux FS we have no way to guarantee that it can't fall into one of
> those static zones of inodes.

Ok, so explicitly setting i_ino in all cases would make sense to prevent
such collisions, as well as moving up the base for the booleans.
jwcart2 already has a patch in the works for the latter.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
