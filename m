Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74CXURu002525
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 08:33:30 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22FBFC057EC6
 for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2016 12:33:25 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: semodule - remove 'q' from getopt string
Date: Thu,  4 Aug 2016 14:33:18 +0200
Message-Id: <1470313998-28458-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Users are confused that this option is not documented or that
'semodule -q' doesn't show:

semodule: invalid option -- 'q'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 63900f4..ce048bc 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -209,7 +209,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
-- 
1.8.3.1
