Subject: Re: sysadm home label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1110690585.29852.68.camel@cobra.ivg2.net>
References: <1110690585.29852.68.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 08:11:40 -0500
Message-Id: <1110805900.21378.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-13 at 00:09 -0500, Ivan Gyurdiev wrote:
> Hi, I've noticed that every time I try to run any nontrivial app
> that writes to $HOME as root, it causes pure chaos on my system. 
> That brings me to my two questions:
> 
> 1) Why is /root labeled staff_home_dir_t, and its content staff_home_t
> Why is it not sysadm_home_dir_t, and sysadm_home_t?

I think that this happened when genhomedircon was introduced, as it
simply generates the types based on the first role listed in the users
file for the user.  Hence, you could move sysadm_r first in the list for
root to cause genhomedircon to instead apply sysadm_home*_t to /root.
However, you would then need to decide what if anything you want to do
about appconfig/root_default_contexts, as gdm and sshd logins by root
currently default to staff_t and will thus encounter denials (likely
fatal for a gdm session, but not for sshd - you can then just newrole to
sysadm_r).  Of course, gdm and sshd logins by root aren't such a good
idea anyway...

> 2) If it should stay at staff_home_t, why can't I typealias
> staff_home_t and staff_home_dir_t to sysadm_home_t/sysadm_home_dir_t.

Right, if /root stays staff_home*_t, then sysadm_home*_t is unused and
the dontaudit rules for it should be remapped to staff_home*_t.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
