Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QFjsnY007432
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:45:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id E52EA1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:45:52 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGc-AujagsPS for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 17:45:51 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id EF0E51A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:45:50 +0200 (CEST)
Date: Mon, 26 Mar 2012 17:45:49 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] policycoreutils -- Make restorecon return 0 when a file
 has changed context with no error
Message-ID: <20120326174549.07f27c96@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

restorecon should return 0 when a file has changed context with no
error. With the last version it's returning 1.

I'm not sure if a patch has already been proposed for this issue.

Laurent

Description: Make restorecon return 0 when a file has changed context with no error
Author: Russell Coker <russell@coker.com.au>
Last-Update: 2012-03-07
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=662990

---
 setfiles/restore.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 9a7d315..a378af0 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -218,10 +218,9 @@ static int restore(FTSENT *ftsent)
 			r_opts->progname, my_file, newcon, strerror(errno));
 		goto skip;
 	}
-	ret = 1;
 out:
 	freecon(newcon);
-	return ret;
+	return 0;
 skip:
 	freecon(newcon);
 	return SKIP;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
