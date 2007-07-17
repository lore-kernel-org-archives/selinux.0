Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HF4U9R027232
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 11:04:30 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HF4TQA021250
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 15:04:29 GMT
Message-Id: <20070717150336.135143158@manicmethod.com>
Date: Tue, 17 Jul 2007 11:03:36 -0400
From: method@manicmethod.com
To: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: [POLICYREP] [RFC/PATCH 0/3] policy package implementation with xar
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This uses xar <http://code.google.com/p/xar/> to implement policy packages. This brings in a fair number of dependancies, unfortunately, but provides a useful featureset in exchange. This includes transparent compression of files in the package, signature support and so on. 

Currently it uses the filename to determine the kind of file (eg., file_context file vs. policy module) which is non-ideal, I think it might be better to use xar attributes in the ToC to specify the file but that means we'd have to implement our own packaging functions and could not use the xar command line utility to create packages. Since we don't currently do anything special like that there is no package_write functionality (or set operators for the implimentation). 

I also have concerns about using the module name property as that should be abstract to this code, instead using a xar subdocument could allow us to define the 'name' of the policy as a policy package attribute instead of putting it in the module. This is completely different from how the current code works but I feel like the name should be associated with the policy package rather than the module.

Comments welcome. This is primarilly an RFC to see if this is how we want to handle policy packages, though it should be mergable in its current state if everyone agrees this is the ideal implementation.

FWIW I also looked for more 'lightweight' archival systems and found that no libraries exist for tar, ar or cpio. A quick search of yum only shows one archive library and it is zip format.
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
