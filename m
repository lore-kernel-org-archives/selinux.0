Message-ID: <36282A1733C57546BE392885C061859236466D@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Subject: [patch] libselinux MLS category bug
Date: Mon, 23 Aug 2004 13:52:08 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C48939.E8ECA2E0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C48939.E8ECA2E0
Content-Type: text/plain;
	charset="iso-8859-1"


The attached patch (against libselinux-1.16) fixes a bug in the
"context_range_set" function.  This function was rejecting
any MLS range which contained an MLS category.

Please apply.

  src/context.c |   18 +++++++++---------
  1 files changed, 9 insertions(+), 9 deletions(-)




------_=_NextPart_000_01C48939.E8ECA2E0
Content-Type: text/plain;
	name="mlscategory.patch"
Content-Disposition: attachment;
	filename="mlscategory.patch"

diff -Nur libselinux-1.16.orig/src/context.c libselinux-1.16/src/context.c
--- libselinux-1.16.orig/src/context.c	2004-08-19 11:20:35.000000000 +0000
+++ libselinux-1.16/src/context.c	2004-08-19 19:28:48.000000000 +0000
@@ -136,7 +136,7 @@
         if ( !t ) { return 1; }
         for ( p = str; *p; p++ ) {
                 if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
-                     *p == ':' ) {
+                     (*p == ':' && index != COMP_RANGE) ) {
                         free(t);
                         return 1;
                 }
@@ -186,12 +186,12 @@
 main()
 {
         context_t c1,c2;
-        c1 = context_new("user:role:type:levellow-levelhigh");
+        c1 = context_new("user:role:type:levellow:cat1,cat2-levelhigh:cat3");
         c2 = context_new("user2:role2:type2");
 
         /* see if strings come back unchanged */
 
-        if ( strcmp(context_str(c1),"user:role:type:levellow-levelhigh") ) {
+        if ( strcmp(context_str(c1),"user:role:type:levellow:cat1,cat2-levelhigh:cat3") ) {
                 test_fail("context_str c1");
         }
         if ( strcmp(context_str(c2),"user2:role2:type2") ) {
@@ -209,7 +209,7 @@
         if ( strcmp(context_type_get(c1),"type") ) {
                 test_fail("context_type_get(c1)");
         }
-        if ( strcmp(context_range_get(c1),"levellow-levelhigh" ) ) {
+        if ( strcmp(context_range_get(c1),"levellow:cat1,cat2-levelhigh:cat3" ) ) {
                 test_fail("context_range_get(c1)");
         }
         if ( strcmp(context_role_get(c2),"role2") ) {
@@ -231,8 +231,8 @@
              strcmp(context_type_get(c1),"newtype1") ) {
                 test_fail("context_type_set(c1)");
         }
-        if ( context_range_set(c1,"newrange1") ||
-             strcmp(context_range_get(c1),"newrange1") ) {
+        if ( context_range_set(c1,"newrange1:newcat1") ||
+             strcmp(context_range_get(c1),"newrange1:newcat1") ) {
                 test_fail("context_range_set(c1)");
         }
         if ( context_role_set(c1,"newrole1") ||
@@ -250,15 +250,15 @@
                 test_fail("context_type_set with whitespace");
         }
 
-        /* check trying to set with a colon */
+        /* check trying to set non-range component with a colon */
 
-        if ( !context_range_set(c1,"newrange:1") ) {
+        if ( !context_type_set(c1,"newrole:newtype") ) {
                 test_fail("context_type_set with colon");
         }
 
         /* check new value */
 
-        if ( strcmp(context_str(c1),"newuser1:newrole1:newtype1:newrange1") ) {
+        if ( strcmp(context_str(c1),"newuser1:newrole1:newtype1:newrange1:newcat1") ) {
                 test_fail("second context_str(c1)");
         }
 

------_=_NextPart_000_01C48939.E8ECA2E0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
