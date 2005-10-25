Subject: Re: [PATCH 4/4] features/fixes for rawhide and refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1130173509.15661.36.camel@twoface.columbia.tresys.com>
References: <1130173509.15661.36.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 08:44:53 -0400
Message-Id: <1130244293.17609.274.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-24 at 13:05 -0400, Joshua Brindle wrote:
> tool changes:
> 
> adds reload, noreload, store options to semodule
> fixes invalid free bug in dismod

All four patches, along with a number of bug fixes and other changes
discussed off-list, merged as of:
libsepol 1.9.27
checkpolicy 1.27.17
libselinux 1.27.14
libsemanage 1.3.33 (depends on libselinux 1.27.14)
policycoreutils 1.27.19 (depends on libsemanage 1.3.33)

Reminder:  The module package format has changed to the new versioned
and sectioned format, so you have to rebuild your module packages.
Also, semodule_package usage has changed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
