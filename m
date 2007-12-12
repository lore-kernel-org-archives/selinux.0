MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: libsepol should not write policy.18 with mls enabled
Date: Wed, 12 Dec 2007 13:50:58 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588014565BD@exchange.columbia.tresys.com>
In-Reply-To: <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil>
References: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com> <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Is that the right place to check it (vs. upon sepol_policydb_set_vers,
> although checkpolicy/checkmodule don't presently use that)?

We could do it both in sepol_policydb_set_vers as well as in checkpolicy
(checkmodule doesn't allow the user to specify the version so I don't
think
there is a need for a check there).  There is an advantage in doing the
check
in checkpolicy as the user would be warned much earlier.

Unfortunately, I don't think we can call ERR() from
sepol_policydb_set_vers
which means the user won't get a useful error message from, e.g.
semodule.
The user ends up with a confusing error like this:

libsepol.policydb_read: policydb module version 7 does not match my
version range 4-6
libsepol.sepol_module_package_read: invalid module in module package (at
section 0)
libsemanage.semanage_load_module: Error while reading from module file
/etc/selinux/refpolicy/modules/tmp/modules/acct.pp.
/usr/sbin/semodule:  Failed!

> Also, what does this mean for automatic dowgrading of policy versions
> at policy load time?  For example, if booting an old kernel with a
> newer policy that had MLS enabled.

The question is whether or not automatic downgrading in this case really
makes sense.
I'm not convinced that it does.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
