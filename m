Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NHM8gA028763
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:22:08 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NHBkRO028949
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 17:11:46 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5NHCJ55021654
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:12:19 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5NHCJu23352
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:12:19 -0400
Received: from wbar1.sjo1-4-4-004-002.sjo1.dsl-verizon.net (vpn50-45.rdu.redhat.com [172.16.50.45])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id j5NHCJi9015139
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:12:19 -0400
Subject: [PATCH] selinux_sb_copy_data requires a whole page?
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:15:20 -0400
Message-Id: <1119546920.10817.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently selinux_sb_copy_data requires an entire page be allocated to
void *orig when the function is called.  This "requirement" is based on
the fact that we call copy_page(in_save, nosec_save); and in_save =
orig.  Problem is that the lustre filesystem was calling do_kern_mount
with about 10 bytes of options, which got passed here and then we
corrupted page size - 10 bytes of memory (with all zeros.)  Causing a
panic.

The first fix and one that seems we might want to do is change copy_page
to memcpy(in_save, nosec_save, strlen(nosec_save)) so we only copy back
what we need to.

The lustre fs people have agreed to allocate a whole page because
"that's the way sys_mount does it."  

Is there a good reason I'm missing why we should require a whole page?
Maybe somebody else (or an old version of lustre) is going to hit on
this.  Comments?

Eric

--- linux-2.6.9/security/selinux/hooks.c.cor	2005-06-23 16:53:05.000000000 -0400
+++ linux-2.6.9/security/selinux/hooks.c	2005-06-23 16:54:01.000000000 -0400
@@ -1980,7 +1980,7 @@ static int selinux_sb_copy_data(struct f
 		}
 	} while (*in_end++);
 
-	copy_page(in_save, nosec_save);
+	memcpy(in_save, nosec_save, strlen(nosec_save));
 	free_page((unsigned long)nosec_save);
 out:
 	return rc;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
