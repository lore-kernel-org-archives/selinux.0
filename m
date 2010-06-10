Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5AK9Ljg031967
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 16:09:21 -0400
Received: from mx01.colomx.prod.int.phx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5AK8X4I010612
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 20:08:34 GMT
Received: from mail05.corp.redhat.com (zmail05.collab.prod.int.phx2.redhat.com [10.5.5.46])
	by mx01.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o5AK9KBq019118
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 16:09:20 -0400
Date: Thu, 10 Jun 2010 16:09:20 -0400 (EDT)
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <34336314.69411276200560271.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: PATCH: Fix module specification with single number
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, here is a patch for https://bugzilla.redhat.com/show_bug.cgi?id=588260.

diff --git a/policy_parse.y b/policy_parse.y
index 8d1bc37..fd55305 100644
--- a/policy_parse.y
+++ b/policy_parse.y
@@ -755,6 +755,8 @@ module_def              : MODULE identifier version_identifier ';'
                         ;
 version_identifier      : VERSION_IDENTIFIER
                         { if (insert_id(yytext,0)) return -1; }
+                       | number
+                        { if (insert_id(yytext,0)) return -1; }
                         | ipv4_addr_def /* version can look like ipv4 address */
                         ;
 avrules_block           : avrule_decls avrule_user_defs

# echo > empty.if
# echo > empty .fc
# echo "policy_module(ursus_mock_utils,1)" > empty.te
# make NAME=targeted -f /usr/share/selinux/devel/Makefile

Now compiles fine.  The issue was that a single number without dots was being matched by the NUMBER rule in policy_scan.l instead of VERSION_IDENTIFIER.

-Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
