Message-ID: <46B38F7B.70409@redhat.com>
Date: Fri, 03 Aug 2007 16:26:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux Patch to prevent segfault from un-initialized print statement
Content-Type: multipart/mixed;
 boundary="------------050106000806070208070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050106000806070208070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050106000806070208070001
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-2.0.24/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2007-07-16 14:20:46.000000000 -0400
+++ libselinux-2.0.24/src/matchpathcon.c	2007-07-23 10:21:34.000000000 -0400
@@ -65,7 +65,7 @@
 #ifdef __GNUC__
     __attribute__ ((format(printf, 1, 2)))
 #endif
-    (*myprintf) (const char *fmt,...);
+    (*myprintf) (const char *fmt,...) = &default_printf;
 
 void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
 {

--------------050106000806070208070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
