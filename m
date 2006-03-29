Message-ID: <442AEF1E.9020503@redhat.com>
Date: Wed, 29 Mar 2006 15:33:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fix file descriptor leak
Content-Type: multipart/mixed;
 boundary="------------080002010805030305080104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080002010805030305080104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080002010805030305080104
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-1.6.2/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2006-03-10 09:48:01.000000000 -0500
+++ libsemanage-1.6.2/src/semanage_store.c	2006-03-29 14:20:16.000000000 -0500
@@ -1159,6 +1159,8 @@
 		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
 		return -1;
 	}
+	fcntl(fd, FD_CLOEXEC, 0);
+
 	if (sh->timeout == 0) {
 		/* return immediately */
 		origtime.tv_sec = 0;

--------------080002010805030305080104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
