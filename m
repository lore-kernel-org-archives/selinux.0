Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs
	(v2)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Eric Paris <eparis@parisplace.org>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1175703431.20396.131.camel@localhost.localdomain>
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
	 <1175703431.20396.131.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 13:00:11 -0400
Message-Id: <1175706011.30692.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 12:17 -0400, Eric Paris wrote:
> On Wed, 2007-04-04 at 10:11 -0400, James Carter wrote:
> > Make the initial SID contexts accessible to userspace via selinuxfs.
> > An initial use of this support will be to make the unlabeled context
> > available to libselinux for use for invalidated userspace SIDs.
> > 
> > This version fixes the problem with the for loop that Steve pointed out,
> > and changes the flow of security_get_initial_sid_context so that the if
> > clause checks for the error condition and uses unlikely().
> > 
> > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> I'm just wondering why we have such arbitrary static i_ino for most
> inodes in /seliunx but it looks to me like we let avc, booleans, and all
> inodes inside avc pick up their i_ino from new_inode() as:
> 
> inode->i_ino = ++last_ino;
> 
> (now initial_sids is going to get it's i_ino from last_ino)  If /selinux
> were created at the wrong time such that last_ino was the same as one of
> the static i_ino ranges we use for /selinux we could have a collision.
> Talking with a FS guy he seemed to think the worst case a collision
> would cause userspace to mess up hard link detection (which we shouldn't
> really have in /selinux) but this seems like something we want to fix.
> I guess that is actually not something that needs to be fixed for this
> patch so I'm happy enough with this patch.

simple_fill_super() also calls new_inode() for each of the inodes in the
tree_descr (and then goes on to overwrite inode->i_ino with the index
value), so last_ino should be guaranteed to be above the range of the
fixed inodes before we proceed to create the rest of the inodes.  Right?

> But, if you do have to redo the patch though there are 2 very very minor
> nits below about * placement.  Maybe James can just clean those up when
> he puts it into GIT.

patch-tester.pl also complains about a couple places where trailing
whitespace is added; another trivial cleanup.

> -Eric
> 
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -102,5 +102,7 @@ int security_fs_use(const char *fstype, unsigned int *behavior,
> >  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
> >  	u32 *sid);
> >  
> > +const char* security_get_initial_sid_context(u32 sid);
> 
> char *security_get_initial_sid_context
> 
> 
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -594,6 +594,13 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
> >  
> >  #include "initial_sid_to_string.h"
> >  
> > +const char* security_get_initial_sid_context(u32 sid)
> 
> char *security_get_initial_sid_context
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
