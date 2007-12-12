MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: libsepol should not write policy.18 with mls enabled
Date: Wed, 12 Dec 2007 14:40:27 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588014565D0@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588014565C5@exchange.columbia.tresys.com>
References: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com> <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil>  <6FE441CD9F0C0C479F2D88F959B01588014565C5@exchange.columbia.tresys.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Todd Miller" <tmiller@tresys.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> libsepol.cat_copy_callback: awstats: Category c1000 not declared by
> base. libsemanage.semanage_link_sandbox: Link packages failed
> /usr/sbin/semodule:  Failed!
> make: *** [load] Error 1

This looks like an issue with overriding the default redhat policy
and the non-default number of categories they support.

If I install things into a separate tree under /etc/selinux the
check in sepol_policydb_set_vers() doesn't get triggered at all
by semodule since p->mls will not be set due to automatic downgrading
in policydb_write().  So I'm not sure how we could do both automatic
downgrading for the kernel load but not for semodule (or if we'd even
want to).

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
