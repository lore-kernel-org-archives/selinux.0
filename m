Subject: Re: [PATCH] SELinux Loadable Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506281046.04113.jbrindle@tresys.com>
References: <200506281046.04113.jbrindle@tresys.com>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 14:04:48 -0400
Message-Id: <1120673088.21423.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-28 at 10:46 -0400, Joshua Brindle wrote:
> This set of patches (not included in email since they are fairly large) 
> include all the infrastructure from before as well as the module store, 
> compiler and associated utilities. These patches implement the full module 
> compiler and management system. The patches as well as the additional library 
> and clients are available at: 
> http://sepolicy-server.sourceforge.net/index.php?page=modules
> 
> Instructions for using the module store and some general information about 
> policy modules is available at:
> http://sepolicy-server.sourceforge.net/index.php?page=module-overview
> 
> I appreciate any feedback on these patches and the module system in general.

These patches, along with the new libsemod and the added semodule*
utilities in policycoreutils, have been committed to the sourceforge CVS
tree, along with some minor fixes and cleanups.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
