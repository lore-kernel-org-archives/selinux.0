Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QDvrWK031624
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 09:57:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 48F8A1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:57:52 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7OOfuoeXvFY for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 15:57:51 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 204981A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:57:51 +0200 (CEST)
Date: Mon, 26 Mar 2012 15:57:49 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] libsemanage -- fallback-user-level
Message-ID: <20120326155749.4003f8fd@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've no rational and no original author about this patch.


--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -863,7 +877,7 @@
 			level = semanage_user_get_mlslevel(*u);
 		} else {
 			prefix = name;
-			level = "s0";
+			level = FALLBACK_USER_LEVEL;
 		}
 
 		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
