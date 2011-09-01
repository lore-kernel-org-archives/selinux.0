Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813TrSg031915
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:03 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813Tp06012549
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:29:52 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813TpmT007111
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:29:51 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: v2 Discard unused tunables from raw policy
Date: Thu, 1 Sep 2011 11:29:39 +0800
Message-ID: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Special Notes
---------------
1. So far the latest master toolchain seems to have a segfault problem related
   with the commit of "libsemanage: patch for MCS/MLS in user files", which
   would be gone if we revert that commit or specify
   "disable-genhomedircon = true" in semanage.conf.


Differences from v1
--------------------

The v2 patchset just provides two minor changes from v1:

1. 0008-Preserve-tunables-when-required-by-semodule-program.patch
   Extract the codes to make use of sh->preserve_tunables flag in discard_tunable()
   from the 0007 patch in v1, and present them in this separate 0008 patch;

2. 0007-Create-a-new-preserve_tunables-flag-in-sepol_handle_.patch
   Fix an obvious error to mistakenly set sh->preserve_tunables flag in
   semanage_direct_connect(), which should be solely set according to the options
   passed for the semodule program.

   Then the preserve_tunables flag file in the module store could be properly
   removed if no "-P/--preserve_tunables" option used for semodule.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
