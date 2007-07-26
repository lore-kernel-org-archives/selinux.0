Message-Id: <20070726144535.573371598@manicmethod.com>
Date: Thu, 26 Jul 2007 10:45:35 -0400
From: method@manicmethod.com
To: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: [POLICYREP] [PATCHv2 0/3] policy package implentation with xar
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This uses xar <http://code.google.com/p/xar/> to implement policy packages. This brings in a fair number of dependancies, unfortunately, but provides a useful featureset in exchange. This includes transparent compression of files in the package, signature support and so on. 


This one is updated to use xar file attributes to identify the kind of file, use semodule_package to create policy packages, to break up the classes for creating the package from a file (PolicyPackageArchive) and reading/writing them from a package class (PolicyPackage). It also has lots of cleanups, including throwing std errors.

Note: The tests have been pulled out of this patchset as we are currently reimplementing the tests using a testing infrastructure like boost of cppunit.

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
