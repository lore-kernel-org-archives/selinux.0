Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11Lv1NL022587
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 16:57:01 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o11LuqLk012232
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 21:56:52 GMT
Message-Id: <201002012156.o11LuwPK001720@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 22:56:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Diffstat output of switch-policy.patch

 security/selinux/include/security.h |    4 -
 security/selinux/selinuxfs.c        |    3
 security/selinux/ss/constraint.h    |    1
 security/selinux/ss/context.h       |   10 +--
 security/selinux/ss/mls.c           |   26 ++++----
 security/selinux/ss/mls.h           |    4 +
 security/selinux/ss/mls_types.h     |    5 -
 security/selinux/ss/policydb.c      |   24 +------
 security/selinux/ss/policydb.h      |    4 +
 security/selinux/ss/services.c      |   79 ++++++++++++++++++++++++--
 security/selinux/ss/services.h      |    1
 security/selinux/ss/sidtab.h        |    1
 security/selinux/ss/symtab.h        |    1
 13 files changed, 113 insertions(+), 50 deletions(-)
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
