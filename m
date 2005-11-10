Subject: Re: New version of Targeted Reference policy is available to play
	with.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1131638425.19626.79.camel@moss-spartans.epoch.ncsc.mil>
References: <4373563F.1080200@redhat.com>
	 <1131637836.19626.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1131638222.19626.76.camel@moss-spartans.epoch.ncsc.mil>
	 <1131638425.19626.79.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 12:58:02 -0500
Message-Id: <1131645482.19626.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 11:00 -0500, Stephen Smalley wrote:
> Ok, I see what is happening in the code.  It checks
> is_selinux_mls_enabled() to decide whether to expect the MLS range
> field, and since SELinux is now disabled on this system (due to reboot
> w/o an installed policy), that returns false.

This raises the general question of the extent to which semanage needs
to work when SELinux is disabled or is enabled but running a very
different policy from the policy being managed for bootstrapping and
upgrading or conversion purposes. It already supports specifying the
store and disabling reloads, so that provides much of the necessary
flexibility.  Possibly src/seusers_file.c and src/users_file.c should be
using the MLS enabled status of the base policy rather than the current
system MLS enabled status.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
