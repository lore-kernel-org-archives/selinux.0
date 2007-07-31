Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VL5qmY010385
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 17:05:52 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6VL5oM8013781
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 21:05:51 GMT
Message-Id: <20070731195112.978592561@manicmethod.com>
Date: Tue, 31 Jul 2007 15:51:12 -0400
From: method@manicmethod.com
To: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Subject: [POLICYREP][patchv3 0/3] policy package implementation with xar
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This uses xar <http://code.google.com/p/xar/> to implement policy packages. This brings in a fair number of dependancies, unfortunately, but provides a useful featureset in exchange. This includes transparent compression of files in the package, signature support and so on. 

This one is updated to use xar file attributes to identify the kind of file, use semodule_package to create policy packages, to break up the classes for creating the package from a file (PolicyPackageArchive) and reading/writing them from a package class (PolicyPackage). It also has lots of cleanups, including throwing std errors.

Note: The tests have been pulled out of this patchset as we are currently reimplementing the tests using a testing infrastructure like boost or cppunit.

There is additional functionality in this set, for writing policy modules to the xar packages. I still need to implement a Parser constructor that reads from a char* for the reading functionality, I'll send this out later.

This set has fixed formatting, note to self: do not run lident on c++ code. Instead I used astyle with the following ~/.astylerc:

brackets=attach
indent=tab=8
break-blocks
preserve-date
pad=oper
unpad=paren
one-line=keep-statements
one-line=keep-blocks

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
