Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FeuRd032338
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:40:56 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FetiA005244
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:40:55 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:40:46 -0000
Date: Sun, 7 May 2006 11:40:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC][SECMARK 08/08] Add selinux_relabel_packet_permission() check
 to xt_SECMARK
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Message-ID: <Pine.LNX.4.64.0605071139330.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the selinux_relabel_packet_permission() check to the 
SECMARK target, so that SELinux policy is consulted to ensure that the 
labeling operation is permitted by the current task.


Signed-off-by: James Morris <jmorris@namei.org>

---

 net/netfilter/xt_SECMARK.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/net/netfilter/xt_SECMARK.c linux-2.6.17-rc3-git7.w/net/netfilter/xt_SECMARK.c
--- linux-2.6.17-rc3-git7.p/net/netfilter/xt_SECMARK.c	2006-05-03 11:34:12.000000000 -0400
+++ linux-2.6.17-rc3-git7.w/net/netfilter/xt_SECMARK.c	2006-05-07 00:35:44.000000000 -0400
@@ -72,6 +72,12 @@ static int checkentry_selinux(struct xt_
 		return 0;
 	}
 
+	err = selinux_relabel_packet_permission(sel->selsid);
+	if (err) {
+		printk(KERN_INFO PFX "unable to obtain relabeling permission\n");
+		return 0;
+	}
+
 	return 1;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
