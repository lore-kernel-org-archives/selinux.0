Subject: Re: New version of Targeted Reference policy is available to play
	with.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4373563F.1080200@redhat.com>
References: <4373563F.1080200@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:50:36 -0500
Message-Id: <1131637836.19626.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 09:16 -0500, Daniel J Walsh wrote:
> ftp://people.redhat.com/dwalsh/SELinux/refpolicy/selinux-policy-2.0.0-0.3.src.rpm

Caveat:  I tried updating to this policy from the current rawhide
targeted policy, and while it appeared to do the right things (modulo
some relabeling, see my other posting for the log file), when it
finished, rpm seems to have removed the generated policy files
(policy.20, file_contexts, seusers) that are now managed via
libsemanage.  Thus, a reboot immediately fails with no policy.

I think that what is happening is that rpm sees that these files _were_
owned by the previous targeted policy package and are no longer provided
by this new policy package (since they are now generated via
libsemanage), so rpm cheerfully deletes them as no longer being needed.
Can we suppress that removal in some way?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
