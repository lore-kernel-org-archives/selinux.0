Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3OGYigA026441
	for <selinux@tycho.nsa.gov>; Sun, 24 Apr 2005 12:34:44 -0400 (EDT)
Received: from web51509.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j3OGQPu7010164
	for <selinux@tycho.nsa.gov>; Sun, 24 Apr 2005 16:26:25 GMT
Message-ID: <20050424162826.1167.qmail@web51509.mail.yahoo.com>
Date: Sun, 24 Apr 2005 09:28:26 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Strange audit messages - whitespace
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I get audit messages that look like this (with lots of 
>extra whitespace) for my new GConf domain. Any idea what 
>can cause this? 

This sounds like an old kernel bug. There was a patch on the audit mail list that
fixes it. It is pending being merged in the mm kernel. It only affects syslog  
messages. If you use the audit daemon, you won't see the problem.

-Steve Grubb


--- linux/kernel/audit.c.orig   2005-02-16 13:49:28.839925080 -0500
+++ linux/kernel/audit.c        2005-02-16 13:53:24.757060224 -0500
@@ -513,8 +513,8 @@
                if (!audit_pid) { /* No daemon */
                        int offset = ab->nlh ? NLMSG_SPACE(0) : 0;
                        int len    = skb->len - offset;
-                       printk(KERN_ERR "%*.*s\n",
-                              len, len, skb->data + offset);
+                       skb->data[offset + len] = '\0';
+                       printk(KERN_ERR "%s\n", skb->data + offset);
                }
                kfree_skb(skb);
                ab->nlh = NULL;


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
