Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2SMHK2p022427
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 18:17:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 49CBE1A15A
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2012 00:17:18 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fg8sN3NYKI5W for <selinux@tycho.nsa.gov>;
	Thu, 29 Mar 2012 00:17:15 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 7A8FA1A044
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2012 00:17:15 +0200 (CEST)
Date: Thu, 29 Mar 2012 00:17:12 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: libsemanage test failure on several architectures
Message-ID: <20120329001712.05d2a09f@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

libsemanage package is now building with tests enabled on debian but it
seems that a test is failing on several architectures:

===================8<=================
     CUnit - A Unit testing framework for C - Version 2.1-0
     http://cunit.sourceforge.net/


Suite: semanage_store
  Test: semanage_store_access_check ... passed
  Test: semanage_get_lock ... passed
test_semanage_findval: : Invalid argument
libsemanage-tests: TestRun.c:132: CU_assertImplementation: Assertion `((void *)0) != f_pCurTest' failed.
make[2]: *** [test] Aborted
  Test: semanage_nc_sort ... passedmake[2]: Leaving directory `/build/buildd-libsemanage_2.1.6-4-powerpc-BZANkQ/libsemanage-2.1.6/tests'
make[1]: *** [test] Error 2
make[1]: Leaving directory `/build/buildd-libsemanage_2.1.6-4-powerpc-BZANkQ/libsemanage-2.1.6'
dh_auto_test: make -j1 test returned exit code 2
make: *** [build-arch] Error 29
===================8<=================

The complete logs can be found at:
https://buildd.debian.org/status/package.php?p=libsemanage

Any idea?

Cheers

Laurent Bigonville



Architecture memo: http://wiki.debian.org/ArchitectureSpecificsMemo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
