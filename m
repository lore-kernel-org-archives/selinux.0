Message-ID: <43CD3CF8.8010408@cornell.edu>
Date: Tue, 17 Jan 2006 11:52:40 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Improve cache management
References: <43CD16C3.60603@cornell.edu>
In-Reply-To: <43CD16C3.60603@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050706060503030906020802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050706060503030906020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a bugfix for the last patch ...
clear must set/update the serial number.


--------------050706060503030906020802
Content-Type: text/x-patch;
 name="libsemanage.clear_set_serial.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.clear_set_serial.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-17 09:11:06.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-17 11:50:46.000000000 -0700
@@ -327,7 +327,14 @@ int dbase_llist_clear(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase) {
 
-	if (dbase->cache_serial >= 0) {
+	int old_serial = dbase->cache_serial;
+
+	if (dbase_llist_set_serial(handle, dbase) < 0) {
+		ERR(handle, "could not set serial of cleared dbase");
+		return STATUS_ERR;
+	}
+
+	if (old_serial >= 0) {
 		cache_entry_t *prev, *ptr = dbase->cache;
 		while (ptr != NULL) {
 			prev = ptr;

--------------050706060503030906020802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
