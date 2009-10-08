Subject: Re: [PATCH] libselinux: raw string_to_class/string_to_av_perm
 variants
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4ACCF117.4060807@tycho.nsa.gov>
References: <4ACCE820.4080007@tycho.nsa.gov>
	 <4ACCF117.4060807@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 08:30:53 -0400
Message-Id: <1255005053.2182.18.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-07 at 15:50 -0400, Eamon Walsh wrote:
> This patch adds support for remapping classes and permissions on policy 
> reload.  This is accomplished by separating the code that computes the 
> "real" kernel class and permission values into a helper function, 
> mapping_compute().  This function is called both from 
> selinux_set_mapping() when the user specifies a new mapping, and from 
> the netlink code when a policyload notification is received.  The 
> function now builds up a temporary mapping and swaps it in rather than 
> working on the active mapping in place.
> 
> Issue: There is a race condition in which old class and permission 
> values may arrive from userspace after a kernel policyload has taken 
> place.  Fixing this would require a string interface to the kernel, or 
> some kind of transaction support.

Also, in addition to these changes, you'll want to grab the
security_deny_unknown() value at startup and upon policy reloads and use
it inside of map_decision() for unknown permissions and inside of
security_compute_av_flags_raw() for unknown classes just as in the
kernel for map_decision() and security_compute_av().  And possibly
mapping_compute() should log unknown classes/permissions and their
disposition (allow or deny) in the same manner as the kernel's
selinux_set_mapping().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
