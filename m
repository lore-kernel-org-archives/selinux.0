Message-ID: <43DFBDB6.1040601@tresys.com>
Date: Tue, 31 Jan 2006 14:42:46 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol - fix assertion copying
Content-Type: multipart/mixed;
 boundary="------------040606090605090608030101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040606090605090608030101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

currently permission maps for assertions are not being copied correctly 
during linking. This patch addresses that issue.


--------------040606090605090608030101
Content-Type: text/x-patch;
 name="1-assertion-perm-map.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-assertion-perm-map.diff"

diff -purN -x.svn libsepol/src/link.c libsepol/src/link.c
--- libsepol/src/link.c	2006-01-30 23:42:08.000000000 -0500
+++ libsepol/src/link.c	2006-01-31 16:30:03.000000000 -0500
@@ -869,7 +869,7 @@ static int copy_avrule_list(avrule_t *li
                         new_perm->class = module->map[SYM_CLASSES][cur_perm->class - 1];
                         assert(new_perm->class);
 
-                        if (new_rule->specified & AVRULE_AV) {
+                        if (new_rule->specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
                                 for (i = 0; i < 32; i++) {
                                         if (!(cur_perm->data & (1U << i)))
                                                 continue;


--------------040606090605090608030101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
