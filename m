Subject: Re: New version of Targeted Reference policy is available to play
	with.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1131638222.19626.76.camel@moss-spartans.epoch.ncsc.mil>
References: <4373563F.1080200@redhat.com>
	 <1131637836.19626.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1131638222.19626.76.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 11:00:25 -0500
Message-Id: <1131638425.19626.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 10:57 -0500, Stephen Smalley wrote:
> Hmmm...so I tried regenerating the generated files from the sandbox via
> semodule -B, but I get the following:
> Committing changes:
> libsemanage.parse_assert_space: missing whitespace
> (/etc/selinux/targeted/modules/tmp/seusers: 1):
> root:root:s0-s0:c0.c255
> libsemanage.seuser_parse: could not parse seuser record
> libsemanage.dbase_file_cache: could not cache file database
> libsemanage.enter_ro: could not enter read-only section
> libsemanage.semanage_commit_components: could not commit local
> modifications
> Failed!
> 
> This is with the stock seusers file from the targeted policy that was
> copied into the sandbox by the %post script.

Ok, I see what is happening in the code.  It checks
is_selinux_mls_enabled() to decide whether to expect the MLS range
field, and since SELinux is now disabled on this system (due to reboot
w/o an installed policy), that returns false.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
