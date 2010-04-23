Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <4BD18CAE.4050201@redhat.com>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
	 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
	 <4BD18CAE.4050201@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Apr 2010 09:51:57 -0400
Message-Id: <1272030717.28015.91.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-04-23 at 08:03 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 04/22/2010 05:35 PM, Stephen Smalley wrote:
> > On Thu, 2010-04-22 at 16:46 -0400, Eric Paris wrote:
> >> This patch adds a new permission, setsuid, to the file class.  This
> >> permission is checked any time a file has its attributes modified
> >> (setattr) and the setuid or setgid bits are involved.  The purpose for
> >> this change is to further allow selinux to confine administrative
> >> duties.
> >>
> >> This permission is needed to both set the setuid bit and to add more
> >> permissions to a file which already has setuid bit.  This is also checked
> >> when an acl is modified on a file containing the suid or sgid bit.  We
> >> do not know if the acl is more or less restrictive, so we always check
> >> the permission on acl changes.
> > 
> > Can you help us all remember why you want this permission?  Specific use
> > case example, what threat you are mitigating, why it is sufficiently
> > important to justify an entirely new permission dedicated to it.
> > 
> > If we add this permission for this purpose, why wouldn't we also add
> > distinct permissions for other DAC purposes, e.g. suid-root vs.
> > suid-nonroot, suid vs sgid, sticky bit, setting vs clearing, making a
> > file executable, ...?  Where does it stop?
> > 
> > I'm also not keen on overloading it to also cover other changes to the
> > mode/ACL.  Presumably that is to constrain extending execute access to
> > an existing suid file more widely than originally set?  Write access
> > should kill suid/sgid bits.  Read access is perhaps a concern, but
> > relying on unreadable executables isn't a good idea.
> > 
> > Can you write a description of this permission and how it differs from
> > setattr permission in a way that will make sense to a typical Linux
> > admin?  
> > 
> >> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> My original thinking on this was a way to separate out Confined Root
> Admin from user.
> 
> One possible use case would be.  I want to allow a user to login as
> unconfined_t and only be able to become root as webadm_t through sudo.
> 
> If webadm_t has setattr on /var/www, he can cp /bin/sh /var/www/sh,
> chcon 4755 /var/www/sh, exit webadm_t and as unconfined_t become root
> using /var/www/sh.
> 
> I think your other examples are valid, but I believe setuid/setgid
> applications have always been considered much more of a problem then the
> others.

I dug up the old threads on this topic:
http://marc.info/?t=119005242700001&r=1&w=2
http://marc.info/?t=122425833800011&r=1&w=2

It sounds like your only concern is being able to prevent the creation
of new suid (or perhaps even only suid-root) executables?  If so, then
the permission check could be much more tailored to that purpose so that
you only ever have to allow it in that situation and no other.

If we are going to revisit selinux_inode_setattr(), it would be nice to
systematically rework it to address any and all known concerns with it
rather than approaching it piecemeal.  I think I've said that before.

For example:
- Do we want to distinguish setting DAC protection attributes
(owner/group/mode/ACL) from setting other attributes?
- Do we want to distinguish the truncate and utimes(NULL) case from just
'write' permission (so that 'open' permission is more useful)?  For the
original discussion that led to changing those two cases to check
'write' instead of 'setattr' permission, see:
http://marc.info/?t=105166906900001&r=1&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
