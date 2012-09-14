Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8EGMDox023058
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 12:22:13 -0400
Message-ID: <50535A56.2010209@tresys.com>
Date: Fri, 14 Sep 2012 12:24:54 -0400
From: Pat McClory <pmcclory@tresys.com>
MIME-Version: 1.0
To: <eparis@redhat.com>, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: policycoreutils build failure
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

I tried to build your latest upstream push, and I'm having trouble 
building policycoreutils:

make[1]: Entering directory `/home/pmcclory/selinux/policycoreutils/po'
make[1]: *** No rule to make target `../gui/selinux.tbl', needed by 
`policycoreutils.pot'.  Stop.
make[1]: Leaving directory `/home/pmcclory/selinux/policycoreutils/po'
make: *** [all] Error 1

it looks like policycoreutils/gui/selinux.tbl is added in commit 
f237aac4506e398367575319e7c0e7741ff7bce0 in the queue branch, but isn't 
in master.

pat mcclory

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
