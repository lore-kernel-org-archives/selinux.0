Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AIWX5O016236
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:32:33 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AIXsjU003041
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 18:33:54 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n8AIRAGQ025156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 13:27:11 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n8AIOH61022977
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 13:24:18 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH]  setools: missing \ in libqpol/src/include/qpol/Makefile.{am,in}
Date: Thu, 10 Sep 2009 13:24:17 -0500
Message-ID: <878wgmpsj2.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I tried reporting this to bugs@tresys.com, as asked on
 http://oss.tresys.com/projects/setools/wiki/contribute , but I got
 this:
--8<---------------cut here---------------start------------->8---
This is an automatically generated Delivery Status Notification.
Delivery to the following recipients failed.
       bugs@tresys.com
--8<---------------cut here---------------end--------------->8---

        Original mail follows.

        manoj

From: Manoj Srivastava <srivasta@debian.org>

The missing \ truncated the list of files to be installed in
/usr/include/qpol

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 libqpol/include/qpol/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libqpol/include/qpol/Makefile.am b/libqpol/include/qpol/Makefile.am
index 91dc375..b55acb7 100644
--- a/libqpol/include/qpol/Makefile.am
+++ b/libqpol/include/qpol/Makefile.am
@@ -17,7 +17,7 @@ qpol_HEADERS = \
 	netifcon_query.h \
 	nodecon_query.h \
 	permissive_query.h \
-	polcap_query.h
+	polcap_query.h \
 	policy.h \
 	policy_extend.h \
 	portcon_query.h \
-- 
1.6.3.3


-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
