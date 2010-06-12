Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTZ016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:39 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVnGC003387
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:49 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXB9a009814
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBmH009813
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDjc6w028354
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:45:38 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DDlA7B028956
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:47:10 GMT
Received: by wyb35 with SMTP id 35so3010368wyb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:45:36 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:57:39 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 7/7 v2] selinux: fix error codes in symtab_init()
Message-ID: <20100612185739.GV5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hashtab_create() only returns NULL on allocation failures to -ENOMEM is
appropriate here.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Eric Paris <eparis@redhat.com>
---
V2: unchanged.

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index bcf9f62..160326e 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -36,7 +36,7 @@ int symtab_init(struct symtab *s, unsigned int size)
 {
 	s->table = hashtab_create(symhash, symcmp, size);
 	if (!s->table)
-		return -1;
+		return -ENOMEM;
 	s->nprim = 0;
 	return 0;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
