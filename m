Message-ID: <452A6A21.5080005@trustedcs.com>
Date: Mon, 09 Oct 2006 10:26:25 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: redhat-lspp@redhat.com, jmorris@namei.org, sds@tycho.nsa.gov,
        paul.moore@hp.com, eparis@redhat.com, jbrindle@tresys.com
Subject: [PATCH 0/1] selinux: secid reconciliation fixes V02: Repost patchset
 with updates
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset is relative to davem's net-2.6 git tree as of a few weeks back,
and is an incremental fix to the secid-reconciliation patch series plus
the ipsec leak patches.

This patchset includes the fix sent out this past Friday night.

This patchset is more immediately intended for the kernels undergoing
LSPP certification, but needs to be reviewed for very-near-future
upstreaming into 2.6.19.

Changes since previous post:

- change description on igmp_classify_packet to be non-SELinux specific.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
