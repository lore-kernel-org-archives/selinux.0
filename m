Message-Id: <20061004154629.186531000@hp.com>
Date: Wed, 04 Oct 2006 11:46:29 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: eparis@redhat.com, jmorris@namei.org, sds@tycho.nsa.gov,
        vyekkirala@TrustedCS.com
Subject: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation bits and a bugfix
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset includes an update to the NetLabel/secid-reconciliation patch,
replacing my "v3" patch from earlier this week, and a bugfix patch to cure a
race condition found during testing this week.  The bugfix patch does not
rely on the secid patches and should be merged regardless as it fixes a bug
which has been around since the very first NetLabel patches (not sure why I
didn't see this sooner).

--
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
