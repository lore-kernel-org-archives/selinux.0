Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7DIOOxC011747
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 14:24:24 -0400
Received: from tayrelbas01.tay.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7DIOKDa010242
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 18:24:20 GMT
Message-ID: <46C0A119.1060103@hp.com>
Date: Mon, 13 Aug 2007 14:21:13 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: linux-audit@redhat.com, selinux@tycho.nsa.gov
Subject: certification test suite
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HP has posted the test suite we used for the audit and MLS
portions of our recent RHEL5 CAPP/LSPP/RBACPP certification.
http://sourceforge.net/projects/audit-test/

We used this suite in combination with the LTP and a handful
of manual tests to provide the necessary test coverage for our
evaluation.  Although this suite is called 'audit-test' and includes
coverage of all the security relevant system calls, it also includes
tests for other components such as NetLabel/CIPSO, IPsec, and CUPS.

The suite is available as a tarball, a source rpm, and as a noarch
rpm which will install files into /usr/local/eal4_testing/audit-test.
There are 3 README files which describe how to run the tests, how to
develop tests, and how to configure the test server for network tests.

These tests are known to pass on RHEL5 plus the updated packages listed
in our security target in both CAPP mode (optional targeted policy) and
LSPP mode (mls policy) on i386, x86_64 and ia64 architectures.  The
tests are known to run on the RHEL5.1 beta with about 17 failures due
to changes in some of the pam audit records.  Items on our TODO list
include updating the suite to support multiple versions of some of the
interesting packages (such as audit and pam), providing more
intuitive subsets of the test cases for specific components, and
separating the test harness into its own package.

We would appreciate feedback as well as patches through the
sourceforge project trackers if you use and update the suite.
We are especially interested in hearing from people running the
tests on other distros, with or without SELinux.

Thanks,

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
