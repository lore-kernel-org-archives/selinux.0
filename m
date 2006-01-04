Message-ID: <43BC39C7.9030805@cornell.edu>
Date: Wed, 04 Jan 2006 16:10:31 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Ordering of ports in compare fn
Content-Type: multipart/mixed;
 boundary="------------010204010009050804080809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010204010009050804080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

That's strange - I clearly remember writing this patch before, and 
somehow it got lost.
Anyway, it implements an ordered compare function for ports.

Please don't miss the other patches in the two threads above, namely:
- fix for single ports parser (whitespace assert issue)
- fix for the dbase add function (toggle modified flag)
- reorder swig included headers and add missing booleans_active.h


--------------010204010009050804080809
Content-Type: text/x-patch;
 name="libsepol.ports_ordering.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.ports_ordering.diff"

diff -Naurp --exclude man --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2006-01-04 10:47:46.000000000 -0500
+++ new/libsepol/src/port_record.c	2006-01-04 16:05:31.000000000 -0500
@@ -84,14 +84,28 @@ int sepol_port_compare(
 	sepol_port_t* port, 
 	sepol_port_key_t* key) {
 
-	/* FIXME: needs to support ordering of ports (-1, 0, 1) */
-
 	if ((port->low == key->low) && 
 	    (port->high == key->high) &&
 	    (port->proto == key->proto))
 		return 0;
 
-	return 1;
+	if (port->low < key->low) 
+		return -1;
+
+	else if (key->low < port->low)
+		return 1;
+
+	else if (port->high < key->high)
+		return -1;
+
+	else if (key->high < port->high)
+		return 1;
+
+	else if (port->proto < key->proto)
+		return -1;
+	
+	else
+		return 1;
 }
 
 /* Port */

--------------010204010009050804080809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
