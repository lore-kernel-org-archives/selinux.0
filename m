Message-ID: <43552AD9.6020701@cornell.edu>
Date: Tue, 18 Oct 2005 13:03:21 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Remove connection requirement from POLICYDB backend
Content-Type: multipart/mixed;
 boundary="------------090203020406050606010009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090203020406050606010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the is_connected check from the POLICYDB backend, 
because it doesn't accomplish anything. What we really want to check is 
whether the function was initialized or not (which can't be done at this 
point anyway, because we're _already_ executing this function - this is 
handled by the default database which I added).

Regarding is_connected.... we don't want to check that, because the 
POLICYDB backend will only be used in the policy server itself, which is 
exactly where we do not want a connection (server doesn't connect to 
itself). In the clients using a policy server, we're not using the 
POLICYDB backend - we're using the SERVER backend, where this parameter 
will be checked.

Besides, as is... those databases aren't even initialized if you don't 
call connect, so it's impossible to be executing that function while 
disconnected (although in the future we could initialize a database 
somewhere other than on connect).

--------------090203020406050606010009
Content-Type: text/x-patch;
 name="libsemanage.remove_connect.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.remove_connect.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-18 12:55:43.000000000 -0400
@@ -155,11 +155,6 @@ static int enter_ro(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	if (!handle->is_connected) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-	
 	if (semanage_get_read_lock(handle) < 0) {
 		/* FIXME: handle error */
 		return STATUS_ERR;
@@ -185,11 +180,6 @@ static int enter_rw(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	if (!handle->is_connected) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-	
 	if (!handle->is_in_transaction) {
 		/* FIXME: handle error */
 		return STATUS_ERR;

--------------090203020406050606010009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
