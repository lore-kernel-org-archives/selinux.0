Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6CK1SGK019483
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2012 16:01:29 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q6CK1PWH025714
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2012 13:01:26 -0700 (PDT)
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: build failure for SE Android 4.1.1_r1
Date: Thu, 12 Jul 2012 20:01:24 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E38365079ECF@ALA-MBB.corp.ad.wrs.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not sure whether this is something I'm doing wrong, but I had a build problem with the JellyBean branch.  I'm using toro, but I think it's probably the same otherwise.

In build, the most recent commit in my tree is:

commit 30f604e06e91cb640e8d94b768b598aef3780338
Author: Joshua Brindle <jbrindle@tresys.com>
Date:   Wed Jun 20 11:58:02 2012 -0400

    add selinux-network.sh to SELINUX_DEPENDS for SELinux network labeling
    
    Signed-off-by: Joshua Brindle <jbrindle@tresys.com>

 core/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

The problem is that nothing is available in my tree to install selinux-network.sh.  Just reverting that change makes it build.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
