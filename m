Subject: [RFC] Dropping support for disabling caching of context
	translations (CACHETRANS=0)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Steve G <linux_4ever@yahoo.com>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 07:54:40 -0500
Message-Id: <1172667280.19041.450.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Recent discussions about performing lazy reading of /etc/selinux/config
in libselinux [1] have raised the question of whether some of the
optional settings in that file are being used by anyone, as that has an
impact on when the config file needs to be processed (i.e. only for
functions that operate on policy files or more widely).  In particular,
the question is whether the CACHETRANS=0 optional setting for disabling
caching of context translations by libselinux is in use.

Looking back at the original discussion, it appears that the setting was
introduced to allow an admin to disable caching by libselinux for two
possible reasons:
- Ensuring freshness in the context translations for long running
processes, as there is no cache refresh mechanism presently.  This one
would be better provided by timeouts or a cache flush mechanism.  Or
even by a per-process cache disable rather than a global setting for
libselinux.
- Enabling "revocation" of access to the context translations in
response to a change in policy, since mcstransd does apply permission
checks when giving out translations.  However, this rationale was
rebutted at the time (by me), as the data has already leaked to the
client and if the client is going to further provide the data to others
in different security contexts, it would be an object manager itself and
would have to perform its own security checks.

So, is anyone using CACHETRANS=0?  Do we need to retain it going forward
in the trunk?

[1] http://marc.theaimsgroup.com/?t=117251719600003&r=1&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
