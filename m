Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4CKBFh3027796
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 16:11:15 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4CKBDsO026668
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 20:11:14 GMT
Subject: [GIT PULL] selinux tree for linus
From: Eric Paris <eparis@redhat.com>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov, pebolle@tiscali.nl
Date: Thu, 12 May 2011 16:11:07 -0400
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1305231068.2076.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The introduction of filename transition rules included some debugging
printk's set to KERN_ERR which should not have been committed.  They can
flood dmesg and push all useful info out of the top.  Delete them.

-Eric

The following changes since commit 6f239284542bae297d27355d06afbb8df23c5db9:

  Merge branch 'for-linus' of git://git.infradead.org/users/eparis/selinux into for-linus (2011-05-04 11:59:34 +1000)

are available in the git repository at:

  git://git.infradead.org/users/eparis/selinux.git for-linus

Eric Paris (1):
      SELinux: delete debugging printks from filename_trans rule processing

 security/selinux/ss/policydb.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
