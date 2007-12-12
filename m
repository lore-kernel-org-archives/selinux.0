MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: libsepol should not write policy.18 with mls enabled
Date: Wed, 12 Dec 2007 14:03:30 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588014565C5@exchange.columbia.tresys.com>
References: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com> <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil> 
From: "Todd Miller" <Tmiller@tresys.com>
To: "Todd Miller" <tmiller@tresys.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> libsepol.policydb_read: policydb module version 7 does not match my
> version range 4-6 
> libsepol.sepol_module_package_read: invalid module in module package
> (at section 0) 
> libsemanage.semanage_load_module: Error while reading from module
> file /etc/selinux/refpolicy/modules/tmp/modules/acct.pp.
> /usr/sbin/semodule:  Failed! 

Sorry, that was caused by some leftover cruft.  The actual error is:

libsepol.cat_copy_callback: awstats: Category c1000 not declared by
base.
libsemanage.semanage_link_sandbox: Link packages failed
/usr/sbin/semodule:  Failed!
make: *** [load] Error 1

So it seems the version check is not getting triggered early enough.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
