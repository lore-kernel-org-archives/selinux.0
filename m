Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03Hbo9O012547
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 12:37:50 -0500
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m03Hbl61023378
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 17:37:48 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v10 00/20] Labeled networking changes for 2.6.25
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 03 Jan 2008 12:37:42 -0500
Message-ID: <20080103173225.15387.60940.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One more update on the 2.6.25 labeled networking patchset.  As usual, these
changes can also be found in git form here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing 

This revision fixes a problem with the sk_buff's 'iif' field not being copied
during a clone operation.  Thanks to Valdis for reporting the problem over the
holidays.  In order to help spot similar problems in the future I added some
warning messages to the SELinux network code to eliminate these silent drops.

If you are run into any problems or have any comments please let me know.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
