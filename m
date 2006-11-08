Message-ID: <45526241.10805@trustedcs.com>
Date: Wed, 08 Nov 2006 17:03:29 -0600
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Subject: [PATCH 0/3] labeled-ipsec: Repost patchset with updates [Originally:
 mlsxfrm: Various Fixes]
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset is against davem's net-2.6.git. Please apply to 2.6.19.

The following are the changes since the previous post of this patchset:

1. Separate BUG_ON usage per Eric's suggestion.

2. Replace security_sid_compare with a simple sid compare check per
   a suggestion from Paul/Stephen.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
