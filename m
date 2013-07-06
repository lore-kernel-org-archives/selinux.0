Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r66CWdRP023955
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2013 08:32:39 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id BB3E91A066
	for <selinux@tycho.nsa.gov>; Sat,  6 Jul 2013 14:32:35 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sljc2EV90iFS for <selinux@tycho.nsa.gov>;
	Sat,  6 Jul 2013 14:32:33 +0200 (CEST)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A783B1A053
	for <selinux@tycho.nsa.gov>; Sat,  6 Jul 2013 14:32:33 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] --handle-unknown option takes a required argument
Date: Sat,  6 Jul 2013 14:32:33 +0200
Message-Id: <1373113953-16739-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Fix a segmentation fault if the --handle-unknown option was set without
arguments.

Thanks to Alexandre Rebert and his team at Carnegie Mellon University
for detecting this crash.
---
 checkpolicy/checkmodule.c | 2 +-
 checkpolicy/checkpolicy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index cb58cf0..41ebab5 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -171,7 +171,7 @@ int main(int argc, char **argv)
 		{"output", required_argument, NULL, 'o'},
 		{"binary", no_argument, NULL, 'b'},
 		{"version", no_argument, NULL, 'V'},
-		{"handle-unknown", optional_argument, NULL, 'U'},
+		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
 		{NULL, 0, NULL, 0}
 	};
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 544f235..292f568 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -402,7 +402,7 @@ int main(int argc, char **argv)
 		{"binary", no_argument, NULL, 'b'},
 		{"debug", no_argument, NULL, 'd'},
 		{"version", no_argument, NULL, 'V'},
-		{"handle-unknown", optional_argument, NULL, 'U'},
+		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
-- 
1.8.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
