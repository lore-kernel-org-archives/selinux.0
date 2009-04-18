Subject: Fwd: [LTP] [PATCH] Fix an errorneous using of a different return
	value in selinux_entrypoint test
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Content-Type: text/plain
Date: Sun, 19 Apr 2009 00:21:24 +0530
Message-Id: <1240080684.5108.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen ??

-------- Forwarded Message --------
From: Jiri Palecek > <<jirka@debian.POK.IBM.COM>
Cc: ltp-list@lists.sourceforge.net <ltp-list@lists.sourceforge.net>
Subject: [LTP] [PATCH] Fix an errorneous using of a different return
value in selinux_entrypoint test
Date: Thu, 16 Apr 2009 17:59:00 +0200

Hello,

I have been trying to run the selinux tests on Debian and discovered a small flaw. The test was using a return value variable which wasn't set by the test.

I've coma across another strange (at least to me) fact - when you execute a program without path, it is searched for in $PATH. However, if the program is in one directory if $PATH and selinux rejects to run the file, the following directories in $PATH are search, and the call can succeed. Is this behavior planned? I know it can't tamper the security of selinux, but it can lead to surprising results.

Also, I've found some uses of macros not present in Debian's refpolicy. Should I send a patch for them?

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../tests/entrypoint/selinux_entrypoint.sh         |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
index bd58845..4680491 100755
--- a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
+++ b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
@@ -52,6 +52,7 @@ test02()

 	# Verify that test_entrypoint_t can be entered via this program.
 	runcon -t test_entrypoint_t $SELINUXTMPDIR/true
+	RC=$?
         if [ $RC -ne 0 ]
         then
 		echo "$TCID   FAIL : entrypoint failed."


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
