Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2OERru8022011
 for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2017 10:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B66A624A9
 for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2017 14:27:52 +0000 (UTC)
Received: from unused-4-196.brq.redhat.com (unused-4-196.brq.redhat.com
 [10.34.4.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE28784400
 for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2017 14:27:51 +0000 (UTC)
Message-ID: <1490365670.3086.9.camel@redhat.com>
Subject: [PATCH] mcstrans: fix typo in mcstransd.8 man page
From: Nikola =?ISO-8859-1?Q?Forr=F3?= <nforro@redhat.com>
Reply-To: nforro@redhat.com
To: selinux@tycho.nsa.gov
Date: Fri, 24 Mar 2017 15:27:50 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nikola Forró <nforro@redhat.com>
---
 mcstrans/man/man8/mcstransd.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mcstrans/man/man8/mcstransd.8 b/mcstrans/man/man8/mcstransd.8
index c1dc483..64774a5 100644
--- a/mcstrans/man/man8/mcstransd.8
+++ b/mcstrans/man/man8/mcstransd.8
@@ -23,7 +23,7 @@ Output a short summary of available command line options\&.
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was originally written by Dan Walsh <dwalsh@redhat.com>.
-The program was enhanced/rwwritten by Joe Nall <joe@nall.com>.
+The program was enhanced/rewritten by Joe Nall <joe@nall.com>.
 
 .SH "FILES"
 /etc/selinux/{SELINUXTYPE}/setrans.conf 
-- 
2.7.4
