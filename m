Subject: [PATCH] libsepol - assertion invalid destroy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-KSh7CABoxGZgHaA0ug/V"
Date: Tue, 04 Oct 2005 10:32:56 -0400
Message-Id: <1128436376.28919.10.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KSh7CABoxGZgHaA0ug/V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In the case when there were no assertions in the policy, the assertion
checking function would attempt an invalid destroy of the ebitmaps that had
not been initialized. Since assertions are stored in avrules, if there
are no avrules it returns successfully.

--=-KSh7CABoxGZgHaA0ug/V
Content-Disposition: attachment; filename=8-libsepol-assertion-invalid-free.diff
Content-Type: text/x-patch; name=8-libsepol-assertion-invalid-free.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn libsepol/src/assertion.c libsepol/src/assertion.c
--- libsepol/src/assertion.c	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/src/assertion.c	2005-10-03 09:16:11.000000000 -0400
@@ -128,6 +128,13 @@ int check_assertions(policydb_t *p, avru
         unsigned int i, j;
 	int errors = 0;
 
+	if (!avrules) {
+		/* Since assertions are stored in avrules, if it is NULL
+		   there won't be any to check. This also prevents an invalid
+		   free if the avtabs are never initialized */
+		return 0;
+	}
+
 	if (avrules) {
 		if (avtab_init(&te_avtab))
 			goto oom;

--=-KSh7CABoxGZgHaA0ug/V--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
