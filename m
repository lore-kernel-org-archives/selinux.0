Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1138308020.26199.5.camel@twoface.columbia.tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1137784500.31152.6.camel@twoface.columbia.tresys.com>
	 <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
	 <43D1553B.3090701@tresys.com>
	 <1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4ED7A.3090805@tresys.com>
	 <1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4F8DD.30705@tresys.com>
	 <1138031978.20815.103.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4FEBF.6020309@tresys.com>
	 <1138033134.20815.107.camel@moss-spartans.epoch.ncsc.mil>
	 <1138308020.26199.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 10:12:14 -0500
Message-Id: <1138374734.13075.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-26 at 15:40 -0500, Joshua Brindle wrote:
> This patch adds semanage_set_create_store which is callable by the
> client to create the store. Set to 1 by semodule when called with -b.
> Otherwise the same access checks as before are done.
> 
> Also adds semanage_is_connected to avoid an assertion failure in
> semodule if an error occurs before connecting.

Merged as of libsemanage 1.5.17 and policycoreutils 1.29.13, with the
following modifications:
- swigify/pywrap rebuild to pick up additional interfaces,
- dropped binary policy directory writability check,
- replaced obsolete semanage_store_writable prototype with
semanage_store_access_check prototype.

Also added a distclean target to the libsemanage top Makefile, and made
the relabel target apply restorecon to the .so file like the other
library Makefiles.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
