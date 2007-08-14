Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7EJoowg010658
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 15:50:50 -0400
Received: from web51509.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7EJokqR012428
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 19:50:47 GMT
Date: Tue, 14 Aug 2007 12:50:46 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] correct return code in selinux_audit_rule_init
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1673104596-1187121046=:28392"
Message-ID: <979167.28392.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1673104596-1187121046=:28392
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This patch corrects an error return code to be something user space recognizes.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>



       
____________________________________________________________________________________
Got a little couch potato? 
Check out fun summer activities for kids.
http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz 
--0-1673104596-1187121046=:28392
Content-Type: text/x-patch; name="linux-2.6.18-return.patch"
Content-Description: 1437328182-linux-2.6.18-return.patch
Content-Disposition: inline; filename="linux-2.6.18-return.patch"

diff -urp linux-2.6.18.x86_64.orig/security/selinux/ss/services.c linux-2.6.18.x86_64/security/selinux/ss/services.c
--- linux-2.6.18.x86_64.orig/security/selinux/ss/services.c	2007-08-14 15:41:32.000000000 -0400
+++ linux-2.6.18.x86_64/security/selinux/ss/services.c	2007-08-14 15:42:56.000000000 -0400
@@ -1927,7 +1927,7 @@ int selinux_audit_rule_init(u32 field, u
 	*rule = NULL;
 
 	if (!ss_initialized)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	switch (field) {
 	case AUDIT_SUBJ_USER:

--0-1673104596-1187121046=:28392--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
