Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqUjW011894
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:30 -0400
Received: by mail-wg0-f44.google.com with SMTP id b13so6225105wgh.11
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:28 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/5] libselinux gentoo patches
Date: Wed, 25 Sep 2013 17:51:57 +0200
Message-Id: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Set of patches currently in use in the Gentoo distribution for libselinux. Most
have been sent here over the past few months, but got little to no feedback.

Sven Vermeulen (5):
  Mount sys before trying to mount selinuxfs
  Update pkgconfig definition
  Make RANLIB variable overridable
  Support udev-197 and higher
  Current stable policycoreutils requires selinux_current_policy_path

 libselinux/include/selinux/selinux.h             |  1 +
 libselinux/man/man3/selinux_binary_policy_path.3 |  7 ++++++-
 libselinux/src/Makefile                          |  2 +-
 libselinux/src/label_file.c                      |  3 +++
 libselinux/src/libselinux.pc.in                  |  4 ++--
 libselinux/src/load_policy.c                     | 12 ++++++++++--
 libselinux/src/selinux_config.c                  | 23 +++++++++++++++++++++++
 libselinux/src/selinux_internal.h                |  1 +
 8 files changed, 47 insertions(+), 6 deletions(-)

-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
