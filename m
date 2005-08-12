Date: Fri, 12 Aug 2005 14:22:31 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] fix order of error checking in libsepol
Message-ID: <20050812192231.GA7053@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch fixes a bug found by Coverity in libsepol:

	In write.c, a check for items==0 is done after a goto out: if
	items!=1, resulting in dead code, and rc==-1 when items==0
	(which I assume is not intended).

thanks,
-serge

Index: src/write.c
===================================================================
--- src.orig/write.c
+++ src/write.c
@@ -567,10 +567,9 @@ static int cond_write_av_list(policydb_t
 	
 	buf[0] = cpu_to_le32(len);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		goto out;
-	if (items == 0) {
-		rc = 0;
+	if (items != 1) {
+		if (items == 0)
+			rc = 0;
 		goto out;
 	}
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
