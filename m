Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QFhjMD007280
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:43:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id BBB7E1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:43:44 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbSIMtawdupd for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 17:43:43 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 807BB1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:43:43 +0200 (CEST)
Date: Mon, 26 Mar 2012 17:43:41 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] policycoreutils -- fix ftbfs with hardening flags
Message-ID: <20120326174341.0ecbf595@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We are now building our packages with -Werror=format-security enabled.
The attached patch fix the FTBFS. More patch related to this could
follow.

Laurent

From: Laurent Bigonville <bigon@debian.org>
Date: Mon, 5 Mar 2012 22:45:58 +0100
Subject: fix ftbfs with hardening flags

---
 sandbox/seunshare.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index c493e98..d7eb0b9 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -311,8 +311,8 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
  */
 static int sandbox_error(const char *string)
 {
-	fprintf(stderr, string);
-	syslog(LOG_AUTHPRIV | LOG_ALERT, string);
+	fprintf(stderr, "%s", string);
+	syslog(LOG_AUTHPRIV | LOG_ALERT, "%s", string);
 	exit(-1);
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
