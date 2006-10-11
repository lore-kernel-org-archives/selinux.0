Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BNDunT007209
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 19:13:56 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BNDG6R016493
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 23:13:16 GMT
Message-Id: <20061011231046.825517000@hp.com>
Date: Wed, 11 Oct 2006 19:10:46 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, eparis@redhat.com
Subject: [PATCH 0/3] Collection of small NetLabel bugfixes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When doing some more testing today I ran into a few bugs, this patchset
addresses those bugs.  This patchset is backed against today's net-2.6 git
tree.

Please apply these patches for 2.6.19, thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
