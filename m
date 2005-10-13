Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <1129228997.13490.16.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <4346D745.6080203@tresys.com>
	 <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
	 <4346DD70.1070806@tresys.com>
	 <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
	 <434C41D9.7010206@tresys.com>
	 <1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>
	 <434D2CFB.5040208@tresys.com>
	 <1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>
	 <434D3792.7020606@tresys.com>
	 <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
	 <434D5097.5060007@tresys.com>
	 <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
	 <1129147889.26188.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1129221837.26188.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1129228997.13490.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 14:54:06 -0400
Message-Id: <1129229646.13490.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 14:43 -0400, Stephen Smalley wrote:
> On Thu, 2005-10-13 at 12:43 -0400, Stephen Smalley wrote:
> > Patches below for libsemanage and libselinux (after merging Ivan's
> > diffs).  libsemanage goes back to always using sh->conf->policyvers,
> > which is initialized to sepol_policy_kern_vers_max() but can be changed
> > in the config file, and libselinux tries to automatically downgrade.
> 
> Ok, updated the SELinux userland on a FC4 system to latest cvs with
> these changes, built a policy.20 with the updated checkpolicy, moved
> aside the existing policy.19 (kernel only supports 19), and tried out
> load_policy.  Downgraded the policy.20 in memory to a version 19 image
> and loaded it successfully into the kernel.

Also, the following sequence worked as expected on the FC4 system, with
libsemanage producing a new policy.20 file and load_policy downgrading
it automatically for the kernel:
checkmodule -o base.mod policy.conf
semodule_package base.pp base.mod file_contexts
semodule -b base.pp

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
