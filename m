Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3H29Muw007561
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2008 22:09:22 -0400
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3H29KjW004452
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 02:09:21 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Cc: setools-bugs@tresys.com
Subject: [PATCH] Setools: Fix missing command name in logwatch script
Date: Wed, 16 Apr 2008 21:04:45 -0500
Message-ID: <871w55nsn6.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,


The logwatch script is trying to execute /usr/bin ; added
/seaudit-report to the path.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>

diff --git a/seaudit/seaudit-report-service.in b/seaudit/seaudit-report-service.in
index d923589..72a0957 100644
--- a/seaudit/seaudit-report-service.in
+++ b/seaudit/seaudit-report-service.in
@@ -2,7 +2,7 @@
 # shell script to run seaudit-report on STDIN
 #
 
-SEAUDITREPORT=@bindir@
+SEAUDITREPORT=@bindir@/seaudit-report
 OPTS="--stdin --malformed"
 
 echo "Date Range: $LOGWATCH_DATE_RANGE"
-- 
1.5.5

        manoj
-- 
To love is good, love being difficult.
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
