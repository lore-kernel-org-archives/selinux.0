Message-Id: <200502181441.j1IEfu8R008346@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: sepol_genusers
Date: Fri, 18 Feb 2005 09:41:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1108735689.29253.8.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Friday, February 18, 2005 9:08 AM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; selinux@tycho.nsa.gov
> Subject: RE: sepol_genusers
> 
> On Fri, 2005-02-18 at 09:00 -0500, Karl MacMillan wrote:
> > I know that't the point - I'm questioning whether that is the right 
> > approach for this. For the booleans, the worst case it to 
> fall back on the policy defaults.
> > For users, there is no fallback other than a previous 
> policy, which in 
> > this model won't have any users either. Why not have the user 
> > management tool generate a new policy (indirectly through a 
> helper, of 
> > course)? Really just a binary policy version of the seuser program 
> > (not the X tool or the scripts - the seuser program that 
> _only_ modifies the policy).
> 
> I don't quite see the first point; even with this in place, 
> the on-disk binary policy still has the base set of user 
> definitions (system_u, user_u, root), which is sufficient for 
> basic operation even if system.users and/or local.users is corrupted.
> 

The policy is not garunteed to have user_u and root, though I guess it likely
will. I guess I am saying that it is possible that the on-disk policy would not
have sufficient users to allow the system to function enough to fix the
corrupted files without entering permissive mode. Careful crafting of the
on-disk policy presumably could prevent this, though. With booleans, the worst
case doesn't seem, to me, to be so extreme, but I guess it would be possible to
have boolean defaults that would render the machine useless.

> The approach you describe is what I originally proposed using 
> the old genpolusers utility, which generated a new binary 
> policy file from an existing one and a new set of user 
> configuration files.  But that would mean that local 
> customization of user definitions will yield a different 
> binary policy file, thereby invalidating rpm -V checking.
>

Ahh. One of the continuing issues raised by policy files being managed by rpm.
Not that I have a better solution.

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 
 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
