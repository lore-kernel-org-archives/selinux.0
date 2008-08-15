Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7FHosG4001087
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 13:50:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7FHoYdN003155
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 17:50:38 GMT
Message-ID: <48A5C1F2.3080002@manicmethod.com>
Date: Fri, 15 Aug 2008 13:50:42 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [ANN] SELinux userland repository, wiki and bug tracking on oss.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have finished migrating the SELinux userland repository and bug tracking, it is available at http://oss.tresys.com/projects/selinux. 

The source code repository for read access is available via git:

git clone http://oss.tresys.com/git/selinux.git

or you can browse the source via:

http://oss.tresys.com/projects/selinux/browser

All users following trunk should switch over to git, subversion access on sourceforge will be turned off in the near future.

Anyone who wants to follow commits to the git repo are encouraged to add themselves to the selinux-commit mailing list by going to http://oss.tresys.com/mailman/listinfo/selinux-commits.

The page is a trac wiki so anyone interested in updating or writing new pages for the site can make an account and request access to modify.

In addition to moving to a more modern SCM and having more control over the content this move also provides additional resources to SELinux developers.

Please let me know if there are any questions concerning this migration.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
