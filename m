From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, txtoth@gmail.com,
        Caleb Case <ccase@tresys.com>
Subject: [PATCH 0/2] [src-policy] CIL compiler path and flags in semanage.conf
Date: Wed, 27 Jan 2010 12:12:38 -0500
Message-Id: <1264612360-32106-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an addendum to the RFC Source Policy Support patchset[1]. It
adds the ability to change the CIL compiler path and flags via
semanage.conf. This has two benefits: 1) it makes the location and name
of the CIL compiler mutable and 2) it allows for better debugging of
policy compilation errors.

[1] http://marc.info/?l=selinux&m=126454398524934&w=2

Caleb Case (2):
  [src-policy] cil compiler path in semanage.conf
  [src-policy] cil compiler flags in semanage.conf

 libsemanage/src/conf-parse.y     |   25 +++++++++++++++++++++++
 libsemanage/src/conf-scan.l      |    2 +
 libsemanage/src/semanage_conf.h  |   10 +++++++++
 libsemanage/src/semanage_store.c |   41 +++++++++++++++++++++++++++----------
 4 files changed, 67 insertions(+), 11 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
