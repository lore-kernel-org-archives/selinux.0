Subject: Re: RFE: inheritance
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1109619068.17982.3.camel@cobra.ivg2.net>
References: <1109400342.4581.25.camel@cobra.ivg2.net>
	 <1109618167.28470.46.camel@moss-spartans.epoch.ncsc.mil>
	 <1109619068.17982.3.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:25:54 -0500
Message-Id: <1109618754.28470.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-28 at 14:31 -0500, Ivan Gyurdiev wrote:
> What about execmod?
> 
> define(`legacy_domain', `
> allow $1_t self:process { execmem };
> allow $1_t { texrel_shlib_t shlib_t }:file execmod;
> allow $1_t ld_so_t:file execmod;
> allow $1_t ld_so_cache_t:file execute;
> ')

Depends on whether execute permission to the modified mapping was
directly requested by the application (including ld.so) or was added
automatically by the kernel read-implies-exec logic.  My patch only
removes the need for execmod rules for the latter case.

> Also, I still like the idea of inheritance for types,
> whether or not this problem is fixed differently.

The policy language used to include a 'clone' statement that allowed
cloning all TE rules for a given type into another type, but it didn't
seem to work very well in practice, so it was left to more customized
definition by macros.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
