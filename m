Subject: Re: hal - denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112483670.14277.5.camel@cobra.ivg2.net>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
	 <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
	 <1112029334.3350.2.camel@cobra.ivg2.net>
	 <1112029488.2914.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1112030817.3350.6.camel@cobra.ivg2.net>
	 <1112031473.2914.109.camel@moss-spartans.epoch.ncsc.mil>
	 <1112483670.14277.5.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 08:55:42 -0400
Message-Id: <1112619342.7629.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-02 at 18:14 -0500, Ivan Gyurdiev wrote:
> Ok, here is what hald required to stop complaining.
> Which ones should be dontaudit? I take it you won't like
> allowing hald to write to /selinux, and read /dev/mem.

Writing to /selinux/context to check the validity of a context is ok,
and necessary for checking the context it is going to use for the mount
option.  Note that each node under /selinux has its own finer-grained
permission check in the security class to allow distinctions to be made
among the operations separate from the inode-based permission check.
See the can_getsecurity() macro for an example of allowing the ability
to get any kind of security decision from selinuxfs (as distinct from
being able to set things like the enforcing status, booleans, or loading
policy, which have their own macros).

> 
> re: dmidecode - 
> dmidecode decodes the DMI data present in x86 and IA64 BIOS's.
> 
> Can't that be made to run in its own domain?

Likely should be.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
