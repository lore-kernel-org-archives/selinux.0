Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5EH9hmP025996
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2011 13:09:45 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5EH9i6w014627
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2011 17:09:44 GMT
Message-ID: <4DF795D5.9050403@redhat.com>
Date: Tue, 14 Jun 2011 13:09:41 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: jmorris@namei.org
CC: selinux@tycho.nsa.gov
Subject: [GIT PULL] SELinux: for 3.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both are bugs introduced in the pull for 3.0.

-Eric

The following changes since commit ea77f7a2e8561012cf100c530170f12351c3b53e:

   Merge commit 'v2.6.39' into 20110526 (2011-05-26 17:20:14 -0400)

are available in the git repository at:

   git://git.infradead.org/users/eparis/selinux.git for-linus

Kohei Kaigai (1):
       selinux: fix case of names with whitespace/multibytes on 
/selinux/create

Roy.Li (1):
       SELinux: skip file_name_trans_write() when policy downgraded.

  security/selinux/selinuxfs.c   |   37 
++++++++++++++++++++++++++++++++++++-
  security/selinux/ss/policydb.c |    3 +++
  2 files changed, 39 insertions(+), 1 deletions(-)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
