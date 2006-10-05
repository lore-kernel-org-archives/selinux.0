Message-Id: <20061005184104.089078000@hp.com>
Date: Thu, 05 Oct 2006 14:41:04 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: eparis@redhat.com, vyekkirala@TrustedCS.com, jmorris@namei.org,
        sds@tycho.nsa.gov
Subject: [RFC v5 0/1] The 'v5' NetLabel secid support patch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the latest NetLabel secid support patch, the changes from the last (v4)
version include:

 * feedback from yesterday (10/4) regarding moving to SECINITSID_UNLABELED
   for the NetLabel TE information when there is nothing else available
 * changes to allow NetLabel to send error messages back to the peer as
   required by the CIPSO specifications (my fault for not catching this
   sooner)
 * bug fixes

This patch is based against the following (in order):

 * David Miller's net-2.6 git tree from about an hour ago
 * The RFC patch I posted earlier today to use SECINITSID_UNLABELED in the
   non secid case (I haven't heard anything on this, if there is still no
   comment I will be pushing this to netdev this evening)
 * Venkat's nine secid patches from Sunday (10/1)
 * Venkat's small update from earlier this week

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
