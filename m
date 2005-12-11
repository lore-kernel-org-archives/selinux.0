Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBDFBfMA026702
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 10:11:41 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBDF2Knv000145
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 15:02:20 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id jBDF2PWR021156
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 10:02:25 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id jBDF2PDx021155
	for selinux@tycho.nsa.gov; Tue, 13 Dec 2005 10:02:25 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBBKFGMA007643
	for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2005 15:15:18 -0500 (EST)
Received: from zproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBBK6W9M023311
	for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2005 20:06:32 GMT
Received: by zproxy.gmail.com with SMTP id r28so1247948nza
        for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2005 12:07:22 -0800 (PST)
Message-ID: <9a8748490512111207g15d107f5mf40c4fe696bfe978@mail.gmail.com>
Date: Sun, 11 Dec 2005 21:07:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] selinux: Remove unneeded k[cm]alloc() return value casts
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
   selinux@tycho.nsa.gov, Andrew Morton <akpm@osdl.org>,
   Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <200512112035.02729.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200512112035.02729.jesper.juhl@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[resending this as it didn't seem to reach LKML on the first try -
sorry if you recieve it twice]


Remove redundant casts of k*alloc() return values in
security/selinux/ss/services.c

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 security/selinux/ss/services.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc5-git1-orig/security/selinux/ss/services.c  
2005-12-04 18:49:02.000000000 +0100
+++ linux-2.6.15-rc5-git1/security/selinux/ss/services.c       
2005-12-11 19:46:39.000000000 +0100
@@ -1712,11 +1712,11 @@ int security_get_bools(int *len, char **
                goto out;
        }

-       *names = (char**)kcalloc(*len, sizeof(char*), GFP_ATOMIC);
+       *names = kcalloc(*len, sizeof(char*), GFP_ATOMIC);
        if (!*names)
                goto err;

-       *values = (int*)kcalloc(*len, sizeof(int), GFP_ATOMIC);
+       *values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
        if (!*values)
                goto err;

@@ -1724,7 +1724,7 @@ int security_get_bools(int *len, char **
                size_t name_len;
                (*values)[i] = policydb.bool_val_to_struct[i]->state;
                name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
-               (*names)[i] = (char*)kmalloc(sizeof(char) * name_len,
GFP_ATOMIC);
+               (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
                if (!(*names)[i])
                        goto err;
                strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);





--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
