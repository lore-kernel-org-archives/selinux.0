Subject: Re: A good place to start?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bradley Chapman <kakadu@gmail.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
        Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0610300931w25367ca4nc8f914dc4277e8ab@mail.gmail.com>
References: <e294b46e0610300931w25367ca4nc8f914dc4277e8ab@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 10:33:08 -0500
Message-Id: <1162308788.32614.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-30 at 17:31 +0000, Bradley Chapman wrote:
> I've just finished installing a new Debian system and decided to put
> SELinux onto it. After getting the programs installed, the kernel
> recompiled, the filesystem relabeled and the policy reloaded, I now
> have a few questions I want to ask about what to do next:

What version of Debian?  What SELinux packages?  Modular/managed policy
or monolithic policy?

> - how do I allow domain transitions from user_r to sysadm_r? I keep
> getting the "user_u:sysadm_r:sysadm_t is not a valid context" error,
> even though /etc/selinux/refpolicy-strict/users/local.users AND
> /etc/selinux/refpolicy-strict/src/policy/config/local.users contain
> the following line:
> 
> user user roles { user_r sysadm_r };

That isn't what you want to do.  First, user_u is a fallback for
unprivileged users not otherwise identified in policy - you don't want
to grant it access to sysadm_r.  Second, for users who should be
authorized for sysadm_r, you want to make their default role staff_r so
that they are protected from user_r users.  staff_r should already be
authorized to transition to sysadm_r.

/etc/selinux/$P/users/local.users is also deprecated as a way of
defining local users in SELinux.  You should be using seusers (if Debian
supports that, which is unclear to me - check their pam_selinux to see
if it calls getseuserbyname() - if not, someone needs to file updated
SELinux patches for Debian), and using semanage to manage such user
mappings.

> - where should I start editing policy files to remove the various avc:
> denied errors I get when starting the machine? At the moment, there
> are quite a few - most of which occur in the
> system_u:system_r:initrc_t context. Should I begin there?

Are they actually denials from direct commands by the rc scripts, or
from daemons erroneously left in the calling domain due to lack of a
defined domain or proper domain transition rule?

> - out of the various GUI-based policy editors out there, which ones
> are good for SELinux newbies?

SLIDE has the best integration with reference policy.

SEEdit is the most oriented toward ease of use, but I believe that it
requires you to convert over entirely to its own simplified policy, and
it makes tradeoffs between quality of protection and ease of use.

Perhaps the better question is which ones do you find helpful?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
