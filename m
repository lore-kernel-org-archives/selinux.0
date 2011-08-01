Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71LANes005936
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 17:10:29 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p71LASOa011875
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 21:10:28 GMT
Subject: [PATCH 1/2] doc: Update the MAINTAINERS info for Paul Moore
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Cc: paul@paul-moore.com
Date: Mon, 01 Aug 2011 17:10:26 -0400
Message-ID: <20110801211026.11940.77623.stgit@localhost6.localdomain6>
In-Reply-To: <20110801210642.11940.49764.stgit@localhost6.localdomain6>
References: <20110801210642.11940.49764.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My @hp.com will no longer be valid starting August 5, 2011 so an update is
necessary.  My new email address is employer independent so we don't have
to worry about doing this again any time soon.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9c6324..e8e8927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4409,10 +4409,10 @@ F:	net/*/netfilter/
 F:	net/netfilter/
 
 NETLABEL
-M:	Paul Moore <paul.moore@hp.com>
+M:	Paul Moore <paul@paul-moore.com>
 W:	http://netlabel.sf.net
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/netlabel/
 F:	include/net/netlabel.h
 F:	net/netlabel/
@@ -4470,7 +4470,7 @@ F:	include/net/ip*
 F:	arch/x86/net/*
 
 NETWORKING [LABELED] (NetLabel, CIPSO, Labeled IPsec, SECMARK)
-M:	Paul Moore <paul.moore@hp.com>
+M:	Paul Moore <paul@paul-moore.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
