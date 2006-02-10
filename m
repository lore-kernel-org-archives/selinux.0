Message-ID: <43ED0824.4020104@cornell.edu>
Date: Fri, 10 Feb 2006 16:39:48 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Fix parse_optional_ch
Content-Type: multipart/mixed;
 boundary="------------030106080701030608000208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030106080701030608000208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 > Method ivg2: it appears that an seuser with no mls field causes a 
segfault
 > ivg2 how so?
 > ivg2 trace?
 > ivg2 should not happen
 > Method #0  0x00379ad9 in parse_skip_space (handle=0x99336c0, 
info=0xa0526b0) at parse_utils.c:96
 > Method #1  0x00380abd in seuser_parse (handle=0x99336c0, 
info=0xa0526b0, seuser=0xa052638) at seusers_file.c:84
 > Method #2  0x00371d22 in dbase_file_cache (handle=0x99336c0, 
dbase=0x9938198) at database_file.c:101
 > Method #3  0x0037aa6e in semanage_base_merge_components 
(handle=0x99336c0) at policy_components.c:164
 > Method #4  0x00375df9 in semanage_direct_commit (sh=0x99336c0) at 
direct_api.c:512
 > Method #5  0x00378424 in semanage_commit (sh=0x99336c0) at handle.c:227
 > Method #6  0x08049b13 in main (argc=6, argv=0xbff199d4) at semodule.c:361

Joshua please try to reproduce with the following patch applied.
Changelog:
- handle NULL as no match in parse_optional_ch
- do not advance a NULL pointer in parse_optional_ch - that breaks NULL 
check later
- remove NULL check in parse_optional_str - doesn't seem necessary.



--------------030106080701030608000208
Content-Type: text/x-patch;
 name="libsemanage.parse_optional_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.parse_optional_fix.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2006-01-05 12:49:15.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2006-02-10 16:33:29.000000000 -0500
@@ -217,23 +217,24 @@ int parse_assert_str(
 }
 
 int parse_optional_ch(parse_info_t* info, const char ch) {
-	if (info->ptr && (*(info->ptr) != ch))
+
+	if (!info->ptr)
 		return STATUS_NODATA;
-	else {
-		info->ptr++;
-		return STATUS_SUCCESS;
-	}
+	if (*(info->ptr) != ch)
+		return STATUS_NODATA;
+		
+	info->ptr++;
+	return STATUS_SUCCESS;
 }
 
 int parse_optional_str(parse_info_t* info, const char* str) {
 	size_t len = strlen(str);
 
-	if (info->ptr && strncmp(info->ptr, str, len))
+	if (strncmp(info->ptr, str, len))
 		return STATUS_NODATA;
-	else {
-		info->ptr += len;
-		return STATUS_SUCCESS;
-	}
+
+	info->ptr += len;
+	return STATUS_SUCCESS;
 }
 
 int parse_fetch_int(

--------------030106080701030608000208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
