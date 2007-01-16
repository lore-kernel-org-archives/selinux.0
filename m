Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GFQ2b3010302
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 10:26:02 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GFQtVB022414
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 15:26:56 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0GFQtBP017961
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 10:26:55 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GFQtC9031027
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 10:26:55 -0500
Received: from [10.11.14.57] (vpn-14-57.rdu.redhat.com [10.11.14.57])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GFQsq6023502
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 10:26:54 -0500
Message-ID: <45ACEE9E.7000709@mentalrootkit.com>
Date: Tue, 16 Jan 2007 10:26:22 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] add selpolgen
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a patch (available for download because of size - see url below) 
to add a python library named selpolgen and a new version of audit2allow 
that uses this library. This is a minimally changed version of what I 
have been calling madison.

I am submitting this for inclusion as part of the main selinux 
distribution. I believe that inclusion here will help make good policy 
generation tools develop sooner and give a common base for creating new 
tools.

Questions:
* I have the library at the top-level of the project - like the C 
libraries. Is this the best location? What about the name?

* Should the old audit2allow be retained in any form? I've tried to make 
this a drop-in replacement, but there are likely regressions / changes. 
There are also a few options still missing that I will add soon.

Karl

http://people.redhat.com/kmacmill/patches/selinux/2007-01-16-selpolgen-initial-submission.patch.gz

  a/policycoreutils/audit2allow/avc.py          |  553
  b/policycoreutils/audit2allow/selpolgen-ifgen |   84
  b/selpolgen/HACKING                           |   79
  b/selpolgen/Makefile                          |   23
  b/selpolgen/TODO                              |   33
  b/selpolgen/VERSION                           |    1
  b/selpolgen/selpolgen/Makefile                |   12
  b/selpolgen/selpolgen/access.py               |  297
  b/selpolgen/selpolgen/audit.py                |  444
  b/selpolgen/selpolgen/classperms.py           |  116
  b/selpolgen/selpolgen/defaults.py             |   41
  b/selpolgen/selpolgen/interfaces.py           |  425
  b/selpolgen/selpolgen/lex.py                  |  712 +
  b/selpolgen/selpolgen/matching.py             |  254
  b/selpolgen/selpolgen/module.py               |  219
  b/selpolgen/selpolgen/objectmodel.py          |  172
  b/selpolgen/selpolgen/output.py               |  159
  b/selpolgen/selpolgen/policygen.py            |  344
  b/selpolgen/selpolgen/refparser.py            |  746 +
  b/selpolgen/selpolgen/refpolicy.py            |  727 +
  b/selpolgen/selpolgen/selpolgeni18n.py        |   26
  b/selpolgen/selpolgen/util.py                 |   87
  b/selpolgen/selpolgen/yacc.py                 | 2175 +++
  b/selpolgen/share/Makefile                    |    8
  b/selpolgen/share/perm_map                    |  993 +
  b/selpolgen/test_data/audit.log               | 5225 +++++++
  b/selpolgen/test_data/httpd.log               |10850 ++++++++++++++++
  b/selpolgen/test_data/short.log               |   15
  b/selpolgen/tests/Makefile                    |    8
  b/selpolgen/tests/audit.txt                   |  200
  b/selpolgen/tests/module_compile_test.te      |    8
  b/selpolgen/tests/perm_map                    |  993 +
  b/selpolgen/tests/run-tests.py                |   45
  b/selpolgen/tests/test_access.py              |  238
  b/selpolgen/tests/test_audit.py               |  151
  b/selpolgen/tests/test_interfaces.py          |  282
  b/selpolgen/tests/test_matching.py            |  144
  b/selpolgen/tests/test_module.py              |   35
  b/selpolgen/tests/test_objectmodel.py         |   44
  b/selpolgen/tests/test_policygen.py           |   31
  b/selpolgen/tests/test_refparser.py           |  120
  b/selpolgen/tests/test_refpolicy.py           |  164
  policycoreutils/audit2allow/Makefile          |   16
  policycoreutils/audit2allow/audit2allow       |  486
  44 files changed, 27000 insertions(+), 785 deletions(-)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
