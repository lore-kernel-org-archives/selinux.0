Subject: RE: sepol_genusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200502181400.j1IE0j8R008122@gotham.columbia.tresys.com>
References: <200502181400.j1IE0j8R008122@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:08:09 -0500
Message-Id: <1108735689.29253.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-18 at 09:00 -0500, Karl MacMillan wrote:
> I know that't the point - I'm questioning whether that is the right approach for
> this. For the booleans, the worst case it to fall back on the policy defaults.
> For users, there is no fallback other than a previous policy, which in this
> model won't have any users either. Why not have the user management tool
> generate a new policy (indirectly through a helper, of course)? Really just a
> binary policy version of the seuser program (not the X tool or the scripts - the
> seuser program that _only_ modifies the policy).

I don't quite see the first point; even with this in place, the on-disk
binary policy still has the base set of user definitions (system_u,
user_u, root), which is sufficient for basic operation even if
system.users and/or local.users is corrupted.

The approach you describe is what I originally proposed using the old
genpolusers utility, which generated a new binary policy file from an
existing one and a new set of user configuration files.  But that would
mean that local customization of user definitions will yield a different
binary policy file, thereby invalidating rpm -V checking.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
