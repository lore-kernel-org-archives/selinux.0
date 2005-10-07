Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 15:37:52 -0400
Message-Id: <1128713872.1450.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 14:30 -0400, Stephen Smalley wrote:
> - expand_module already set the output type, so we only need to adjust
> the version here (and I changed it to use the kernel's policyvers if
> available instead of the config, as that is what will be loaded by
> load_policy now).

Ok, I've added sepol_policy_kern_vers_min/max() functions to libsepol so
that libsemanage can determine the range of versions supported by the
shared libsepol.  This is now used by conf-parse to set the default to
the max and to check the config value against the range. I also revised
semanage_expand_sandbox() to check the kernel version against that range
and fall back to the conf policyvers if the kernel version is outside of
that range, so that if the kernel version is higher than the one
supported by libsepol, we can still fall back to the older version
supported by libsepol.

load_policy functions in libselinux should likely do something similar
when deciding what version to load, at least as long as it continues to
use sepol* functions to manipulate boolean settings et al.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
