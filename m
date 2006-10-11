Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BNDw1a007250
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 19:13:58 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BNCf4J020088
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 23:12:41 GMT
Message-Id: <20061011231357.321273000@hp.com>
References: <20061011231046.825517000@hp.com>
Date: Wed, 11 Oct 2006 19:10:49 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, eparis@redhat.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/3] NetLabel: the CIPSOv4 passthrough mapping does not pass categories correctly
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The CIPSO passthrough mapping had a problem when sending categories which
would cause no or incorrect categories to be sent on the wire with a packet.
This patch fixes the problem which was a simple off-by-one bug.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: net-2.6_bugfix_2/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6_bugfix_2.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6_bugfix_2/net/ipv4/cipso_ipv4.c
@@ -832,8 +832,8 @@ static int cipso_v4_map_cat_rbm_hton(con
 
 	switch (doi_def->type) {
 	case CIPSO_V4_MAP_PASS:
-		net_spot_max = host_cat_len - 1;
-		while (net_spot_max > 0 && host_cat[net_spot_max] == 0)
+		net_spot_max = host_cat_len;
+		while (net_spot_max > 0 && host_cat[net_spot_max - 1] == 0)
 			net_spot_max--;
 		if (net_spot_max > net_cat_len)
 			return -EINVAL;

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
