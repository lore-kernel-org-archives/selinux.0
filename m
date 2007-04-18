Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IL5QQt008782
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:05:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IL5POP028126
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 21:05:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL5P7E027317
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:05:25 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL5PLB004441
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:05:25 -0400
Received: from [10.11.14.21] (vpn-14-21.rdu.redhat.com [10.11.14.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL5OnJ029278
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:05:25 -0400
Subject: [PATCH - policyrep] Export symtab hash functions
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 17:02:02 -0400
Message-Id: <1176930122.11469.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Export the symtab symbol hash and compare functions for use in other
parts of libsepol.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 1280147740b5 libsepol/include/sepol/policydb/symtab.h
--- a/libsepol/include/sepol/policydb/symtab.h	Tue Jan 30 15:41:54 2007 -0500
+++ b/libsepol/include/sepol/policydb/symtab.h	Tue Jan 30 15:46:59 2007 -0500
@@ -31,6 +31,12 @@ typedef struct {
 	uint32_t nprim;		/* number of primary names in table */
 } symtab_t;
 
+extern unsigned int sepol_symhash(hashtab_t h,
+				  hashtab_key_t key);
+
+extern int sepol_symcmp(hashtab_t h, hashtab_key_t key1,
+			hashtab_key_t key2);
+
 extern int symtab_init(symtab_t *, unsigned int size);
 
 #endif				/* _SYMTAB_H_ */
diff -r 1280147740b5 libsepol/src/symtab.c
--- a/libsepol/src/symtab.c	Tue Jan 30 15:41:54 2007 -0500
+++ b/libsepol/src/symtab.c	Tue Jan 30 15:46:59 2007 -0500
@@ -11,7 +11,7 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
-static unsigned int symhash(hashtab_t h, hashtab_key_t key)
+unsigned int sepol_symhash(hashtab_t h, hashtab_key_t key)
 {
 	char *p, *keyp;
 	size_t size;
@@ -26,7 +26,7 @@ static unsigned int symhash(hashtab_t h,
 	return val & (h->size - 1);
 }
 
-static int symcmp(hashtab_t h
+int sepol_symcmp(hashtab_t h
 		  __attribute__ ((unused)), hashtab_key_t key1,
 		  hashtab_key_t key2)
 {
@@ -39,7 +39,7 @@ static int symcmp(hashtab_t h
 
 int symtab_init(symtab_t * s, unsigned int size)
 {
-	s->table = hashtab_create(symhash, symcmp, size);
+	s->table = hashtab_create(sepol_symhash, sepol_symcmp, size);
 	if (!s->table)
 		return -1;
 	s->nprim = 0;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
