Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q65In11Q009573
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2012 14:49:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id D3DD31A145
	for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2012 20:49:00 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ctoSR6LYi7u for <selinux@tycho.nsa.gov>;
	Thu,  5 Jul 2012 20:48:59 +0200 (CEST)
Received: from fornost.bigon.be (unknown [213.211.144.61])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id EAC581A143
	for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2012 20:48:57 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Patch for mcstrans to not abort when it sees a squeeze config file
Date: Thu,  5 Jul 2012 20:48:51 +0200
Message-Id: <d7ced17f7267e4756e17cefdb40a0bf3928dc2f1.1341513795.git.bigon@bigon.be>
In-Reply-To: <cover.1341513795.git.bigon@bigon.be>
References: <cover.1341513795.git.bigon@bigon.be>
In-Reply-To: <cover.1341513795.git.bigon@bigon.be>
References: <cover.1341513795.git.bigon@bigon.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Russell Coker <russell@coker.com.au>

---
 policycoreutils/mcstrans/src/mcstrans.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/policycoreutils/mcstrans/src/mcstrans.c b/policycoreutils/mcstrans/src/mcstrans.c
index 4d31857..c655a41 100644
--- a/policycoreutils/mcstrans/src/mcstrans.c
+++ b/policycoreutils/mcstrans/src/mcstrans.c
@@ -745,6 +745,13 @@ process_trans(char *buffer) {
 
 	if (*buffer == 0) return 0;
 
+	/* special case for old format */
+	if(!strcmp("s0=", buffer))
+	{
+		syslog(LOG_ERR, "Ignoring old format line \"s0=\".");
+		return 0;
+	}
+
 	char *delim = strpbrk (buffer, "=!>");
 	if (! delim) {
 		syslog(LOG_ERR, "invalid line (no !, = or >) %d", lineno);
-- 
1.7.10


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
