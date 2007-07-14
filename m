Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6E3HNR7009431
	for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2007 23:17:23 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6E3HMvb017569
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 03:17:22 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070714030401.888612123@hp.com>
Date: Fri, 13 Jul 2007 23:04:01 -0400
To: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Subject: [PATCH 0/2] Fix for the unlabeled NetLabel access check patch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset consists of two patches, both based against Linus' tree of about
an hour ago. the first is largely a resend of a previous patch which was
accepted into 2.6.23, the second is a fix for the first patch because it broke
stuff :/   More information about the breakage can be found in the link in the
patch description.

The first patch is the patch which converted NetLabel to make use of the netmsg
initial SID for MLS labeled packets so that the unlabeled initial SID could be
used for truly unlabeled packets.  Unfortunately, this turned out to cause
problems on systems with older policy.  The second patch in this series
addresses this problem by providing a runtime enable/disable status flag for
NetLabel which SELinux (and other LSMs for that matter) can use to decide if
they should perform NetLabel label enforcement.

I've given this patchset a quick test and everything behaves as I would expect,
that is to say the following happens:

 1. When the system is booted NetLabel is disabled (no NetLabel config present)
    - no NetLabel access checks for labeled or unlabeled packets
 2. Once NetLabel is configured (netlabelctl cipsov4 add ...) NetLabel is
    enabled
    - NetLabel access checks are performed for both labeled and unlabeled
      packets
 3. If all of the NetLabel labeled protocol configurations are removed
    (netlabelctl cipsov4 del ...) then NetLabel is disabled again
    - no NetLabel access checks for labeled or unlabeled packets

This should solve the problems seen in the early 2.6.23 git kernels.

Michal, if you're not sick of verifying things yet - could you test this
patchset on your configuration and verify that you do not see any regressions?

Thank you all for your patience, and sorry for all the confusion.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
