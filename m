From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sysadm home label
Date: Tue, 15 Mar 2005 01:56:52 +1100
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>
References: <1110690585.29852.68.camel@cobra.ivg2.net> <1110805900.21378.23.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110805900.21378.23.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503150156.55990.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 15 March 2005 00:11, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2005-03-13 at 00:09 -0500, Ivan Gyurdiev wrote:
> > Hi, I've noticed that every time I try to run any nontrivial app
> > that writes to $HOME as root, it causes pure chaos on my system.
> > That brings me to my two questions:
> >
> > 1) Why is /root labeled staff_home_dir_t, and its content staff_home_t
> > Why is it not sysadm_home_dir_t, and sysadm_home_t?
>
> I think that this happened when genhomedircon was introduced, as it
> simply generates the types based on the first role listed in the users
> file for the user.  Hence, you could move sysadm_r first in the list for
> root to cause genhomedircon to instead apply sysadm_home*_t to /root.

I believe that this is the correct solution.

> However, you would then need to decide what if anything you want to do
> about appconfig/root_default_contexts, as gdm and sshd logins by root
> currently default to staff_t and will thus encounter denials (likely
> fatal for a gdm session, but not for sshd - you can then just newrole to
> sysadm_r).  Of course, gdm and sshd logins by root aren't such a good
> idea anyway...

The generally agreed system administration practice (for non-SE systems) is to 
login to a non-root account and then su to root, it's generally agreed that 
you should configure sshd to enforce this policy to prevent the possibility 
of someone cracking root directly by guessing a root password.

Updating such a policy to work with SE Linux requires some changes.  I think 
that logging in as root:staff_r:staff_t and then running newrole on a SE 
Linux system gives a comparable result (I believe a better result but that's 
another issue).

I believe that the standard sys-admin practice of ssh to a non-root account 
and then "su -" is flawed.  The reason is that an attacker only needs to 
compromise one of the many non-root accounts used for this and change .bashrc 
to capture the root password when "su -" is executed.

If we have /root labeled as sysadm_home_dir_t then and regular files 
under /root labeled as sysadm_home_t then we solve the changing .bashrc 
attack - this doesn't entirely solve the problem (see 
macros/mini_user_macros.te for an attempt at doing better) but it makes a 
reasonable attempt and forces an attacker to remain logged in while waiting 
(which increases the chance of being caught).

gdm logins as root are a bad idea in any way and an even worse idea as 
sysadm_r.  But we have a tunable to allow sysadm_r logins via gdm for those 
people who really want it.  Gdm logins as root:sysadm_r with /root labeled as 
sysadm_home_dir_t is probably no worse than gdm logins as root:staff_r 
with /root labeled as staff_home_dir_t.

> > 2) If it should stay at staff_home_t, why can't I typealias
> > staff_home_t and staff_home_dir_t to sysadm_home_t/sysadm_home_dir_t.
>
> Right, if /root stays staff_home*_t, then sysadm_home*_t is unused and
> the dontaudit rules for it should be remapped to staff_home*_t.

Which would then remove a large part of the reason for having separate staff_r 
and sysadm_r roles entirely.  If we were to do that then we might as well 
revert to having only two roles in the default policy, user_r and sysadm_r.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
