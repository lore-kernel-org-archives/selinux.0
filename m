Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j86ICxOb022507
	for <selinux@tycho.nsa.gov>; Tue, 6 Sep 2005 14:12:59 -0400 (EDT)
Received: from iron1-mx.tops.gwu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j86IB0cC023998
	for <selinux@tycho.nsa.gov>; Tue, 6 Sep 2005 18:11:01 GMT
Message-Id: <4bk2k6$54al2s@iron1-mx.tops.gwu.edu>
Date: Tue, 06 Sep 2005 14:10:48 -0400
From: Yuichi Nakamura <ynakam@gwu.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: ynakam@gwu.edu
Subject: ANN: SELinux Policy Editor 1.2
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi. 

We've released SELinux Policy Editor 1.2.0.
How to download and install, see 
http://seedit.sourceforge.net/doc/install/INSTALL.html

Documents are updated at 
http://seedit.sourceforge.net/documents.html

Major Changes from 1.0 
(1) Improved implementation to support different distributions 
Now supports Fedora Core4, Turbo Linux 10 Server, Asianux 2.0.
(2) Added more sample policy
(3) Improved Simplified Policy Description language
See http://seedit.sourceforge.net/documents.html for 
updated simplified policy description language.
(4) Developer's policy
For developers, simplified policy that uses macros are prepared 
in seedit-policy-devel package.
# Documentations for developer's policy is not prepared yet. 
# Be careful to use it.
(5) policy without RBAC
Policy without RBAC(like targeted policy) can be installed 
when installing from source.


For feedback, e-mail to seedit-admin@lists.sourceforge.net .

---
Yuichi Nakamura
Hitachi Software, The George Washington University
Japan SELinux Users Group(JSELUG)
Japan Open Source Advocacy Organization(JOSAO)
SELinux Policy Editor:  http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
