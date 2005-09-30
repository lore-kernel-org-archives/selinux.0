Subject: Re: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com
In-Reply-To: <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
	 <433CB578.6070303@cornell.edu>
	 <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:35:24 -0400
Message-Id: <1128083724.12459.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 08:21 -0400, Stephen Smalley wrote:
> Yes, boolean and user components are expected to be handled by semanage
> in the future, regenerating the kernel binary policy file on each
> modification.  When that happens, selinux_mkload_policy() can drop out
> the calls to sepol_genusers and sepol_genbools, but will still
> encapsulate the logic for finding the right policy version, opening it
> and mmap'ing it, and loading it.

BTW, the "finding the right policy version" part is what motivated me to
go ahead and write this patch now.  Someone noted on fedora-list that
they couldn't boot 2.6.14-rc2-git6 on FC3, because /sbin/init was only
trying to load the current version supported by the kernel (from
reading /selinux/policyvers via security_policyvers()) and one version
lower if that didn't exist, and there have been two version increments
since FC3 was shipped (18->19 for MLS mainstreaming, 19->20 for the
avtab optimization), so FC3 only has policy.18.  Since we have to fix
init and load_policy anyway to continue trying older versions until they
finds one that exists (or alternatively they could scandir the directory
and just find the closest match to the current version), it seemed
sensible to push it all into a libselinux function now so that we don't
have to patch them again when the sepol* calls are dropped out.  
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
