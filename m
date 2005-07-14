Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6EFYOgA003932
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 11:34:24 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6EFUx5c018567
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 15:30:59 GMT
Subject: [PATCH] Fix hierarchy checking on type rules
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 11:30:58 -0400
Message-Id: <1121355058.10979.6.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the hierarchy checker will incorrectly try to check type
rules, this patch fixes that.

diff -u -r1.4 hierarchy.c
--- libsepol/src/hierarchy.c    6 Jul 2005 17:45:07 -0000       1.4
+++ libsepol/src/hierarchy.c    14 Jul 2005 15:29:16 -0000
@@ -127,6 +127,11 @@
        uint32_t av;
        type_datum_t *t = NULL, *t2 = NULL;

+       if (!d->specified & AVTAB_AV) {
+               /* This is a type rule, no checking done */
+               return 0;
+       }
+
        a = (hierarchy_args_t *)args;
        if (find_parent(a->p->p_type_val_to_name[k->source_type - 1],
&parent))
                return -1;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
