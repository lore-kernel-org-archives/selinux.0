Message-Id: <20060929201746.711738000@hp.com>
Date: Fri, 29 Sep 2006 16:17:46 -0400
From: paul.moore@hp.com
To: vyekkirala@TrustedCS.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, method@gentoo.org,
        kmacmillan@mentalrootkit.com
Subject: [PATCH 0/1] NetLabel: patch against Venkat's secid patchset
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch is against this morning's net-2.6 tree with Venkat's secid patches applied.  You may notice some differences as I had to fuzz/fix-up Venkat's patches in a few places.

This patch provides the missing NetLabel support for the secid reconciliation patches based on the discussions we have been having on the mailing lists.  Ideally I would hope Venkat could merge this patch in with his patchset so that the secid patchset will include NetLabel support.  However, if that is not possibile I'll respin this patch later once the secid patches have been committed.

Venkat, please merge this patch into your next version of the secid patches.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
