Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OEMNrC024210
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 10:22:23 -0400
To: SELinux <selinux@tycho.nsa.gov>,
 Selinux on Fedora discussion <selinux@lists.fedoraproject.org>
From: Petr Lautrbach <plautrba@redhat.com>
Subject: Fedora COPR repositories with builds of latest code
Message-ID: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
Date: Wed, 24 May 2017 16:22:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For the motivation see
https://marc.info/?l=selinux&m=149435307518336&w=2

I've restarted building of Fedora packages based on latest SELinux 
userspace code in Fedora COPR. Packages are built using the 
https://gitlab.com/bachradsusi/selinux-rpm project.

There is a new selinux.spec [1] file which allows to build all Fedora 
packages from one src.rpm and Makefile which makes the process simple.

Currently there are two COPR projects:

* https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/

This is built with Python3 support based on Fedora patches which are 
rebased against latest upstream code.


* https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELinuxProject/

This is based on pure upstream sources and without Python 3.


Currently I run copr builds manually but the plan is to make it fully 
automated.


Let me know if you find it useful or if you have ideas, comments and so on.


[1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/selinux.spec


Thanks,

Petr
