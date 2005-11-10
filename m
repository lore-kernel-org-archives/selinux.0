Subject: Re: New version of Targeted Reference policy is available to play
	with.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1131637836.19626.73.camel@moss-spartans.epoch.ncsc.mil>
References: <4373563F.1080200@redhat.com>
	 <1131637836.19626.73.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:57:02 -0500
Message-Id: <1131638222.19626.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 10:50 -0500, Stephen Smalley wrote:
> On Thu, 2005-11-10 at 09:16 -0500, Daniel J Walsh wrote:
> > ftp://people.redhat.com/dwalsh/SELinux/refpolicy/selinux-policy-2.0.0-0.3.src.rpm
> 
> Caveat:  I tried updating to this policy from the current rawhide
> targeted policy, and while it appeared to do the right things (modulo
> some relabeling, see my other posting for the log file), when it
> finished, rpm seems to have removed the generated policy files
> (policy.20, file_contexts, seusers) that are now managed via
> libsemanage.  Thus, a reboot immediately fails with no policy.
> 
> I think that what is happening is that rpm sees that these files _were_
> owned by the previous targeted policy package and are no longer provided
> by this new policy package (since they are now generated via
> libsemanage), so rpm cheerfully deletes them as no longer being needed.
> Can we suppress that removal in some way?

Hmmm...so I tried regenerating the generated files from the sandbox via
semodule -B, but I get the following:
Committing changes:
libsemanage.parse_assert_space: missing whitespace
(/etc/selinux/targeted/modules/tmp/seusers: 1):
root:root:s0-s0:c0.c255
libsemanage.seuser_parse: could not parse seuser record
libsemanage.dbase_file_cache: could not cache file database
libsemanage.enter_ro: could not enter read-only section
libsemanage.semanage_commit_components: could not commit local
modifications
Failed!

This is with the stock seusers file from the targeted policy that was
copied into the sandbox by the %post script.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
