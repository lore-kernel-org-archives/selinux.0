Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n031dOkP025725
	for <selinux@tycho.nsa.gov>; Fri, 2 Jan 2009 20:39:24 -0500
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n031akio024470
	for <selinux@tycho.nsa.gov>; Sat, 3 Jan 2009 01:36:46 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 845171807B
	for <selinux@tycho.nsa.gov>; Sat,  3 Jan 2009 12:39:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 0043021498
	for <selinux@tycho.nsa.gov>; Sat,  3 Jan 2009 12:39:18 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Debian SE Linux package dependencies
Date: Sat, 3 Jan 2009 12:39:17 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901031239.18614.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.gnowledge.org/debmap_view?objid=selinux-basics
http://www.gnowledge.org/debmap_view?objid=selinux-policy-refpolicy-targeted

The above URLs show diagrams of Debian package dependencies.  It appears that 
they only graphed Etch (the current stable release) not Lenny (which will 
become stable sometime really soon).  In Lenny there is no 
selinux-policy-refpolicy-targeted and instead we have selinux-policy-default 
which has the functionality that the selinux-policy-refpolicy-targeted and 
selinux-policy-refpolicy-strict packages had in Etch.

Unfortunately there is no option to list all the packages that depend on 
another package.  It would be good to see a list of all packages that depend 
on libselinux1 and other key packages.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
