Return-Path: <SRS0=KxHl=TW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD5C072A4
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 05:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E7C20821
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 05:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="qluz3aB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEVFt0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 May 2019 01:49:26 -0400
Received: from rgout0404.bt.lon5.cpcloud.co.uk ([65.20.0.217]:51270 "EHLO
        rgout04.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfEVFtZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 May 2019 01:49:25 -0400
X-OWM-Source-IP: 86.147.201.202 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepshgvhhgrshhhrdhrvgenucfkphepkeeirddugeejrddvtddurddvtddvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtddurddvtddvpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoeiguhhntghhrghnghesghhoohhglhgvrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehsvghhrghshhdrrhgvnecukfhppeekiedrudegjedrvddtuddrvddtvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtuddrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (86.147.201.202) by rgout04.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C55FFA90A73D56E; Wed, 22 May 2019 06:42:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1558504164; 
        bh=xARVrBpe32Nbh2NomRPhvIuzilIHW+ZFpYotMFpl+GA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=qluz3aB3I4PPRcWzRtUJb8iY4ZnqhrhrW5i7+dHLCeEuLTvJ9rWpAZWWJXjn69dfUyobj5NNA3m9DKKqvUL25AmhRCbSW1FhFfiiHoinq+RIzeFEMcLddaacVWZrHXSVsg5scfjcYupbMWweyKr40NnPPbecLS554gzpywNQpI4=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, xunchang@google.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/3] libselinux: Save digest of all partial matches for directory
Date:   Wed, 22 May 2019 06:42:27 +0100
Message-Id: <20190522054227.3520-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We used to hash the file_context and skip the restorecon on the top
level directory if the hash doesn't change. But the file_context
might change after an OTA update; and some users experienced long
restorecon time as they have lots of files under directories like
/data/media.

This CL tries to hash all the partial match entries in the
file_context for each directory; and skips the restorecon if that
digest stays the same, regardless of the changes to the other parts
of file_context.

This is a version ported from Android that was originally written by:
xunchang <xunchang@google.com>

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/label.h            |   5 +
 libselinux/include/selinux/restorecon.h       |  17 +-
 .../selabel_get_digests_all_partial_matches.3 |  70 +++++
 libselinux/man/man3/selinux_restorecon.3      |  91 +++---
 .../man3/selinux_restorecon_default_handle.3  |   9 +-
 .../man/man3/selinux_restorecon_xattr.3       |  11 +-
 libselinux/src/label.c                        |  15 +
 libselinux/src/label_file.c                   |  51 ++++
 libselinux/src/label_file.h                   |   4 +
 libselinux/src/label_internal.h               |   5 +
 libselinux/src/selinux_restorecon.c           | 267 +++++++++++-------
 libselinux/utils/.gitignore                   |   1 +
 .../selabel_get_digests_all_partial_matches.c | 170 +++++++++++
 13 files changed, 549 insertions(+), 167 deletions(-)
 create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
 create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index e537aa1..9628263 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -106,6 +106,11 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 
 bool selabel_partial_match(struct selabel_handle *handle, const char *key);
 
+bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
+					     const char *key,
+					     uint8_t **calculated_digest,
+					     uint8_t **xattr_digest,
+					     size_t *digest_len);
 bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
                                       const char *key, uint8_t* digest);
 
diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 595e772..754b864 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -27,8 +27,8 @@ extern int selinux_restorecon(const char *pathname,
  * restorecon_flags options
  */
 /*
- * Force the checking of labels even if the stored SHA1
- * digest matches the specfiles SHA1 digest.
+ * Force the checking of labels even if the stored SHA1 digest
+ * matches the specfiles SHA1 digest (requires CAP_SYS_ADMIN).
  */
 #define SELINUX_RESTORECON_IGNORE_DIGEST		0x0001
 /*
@@ -96,12 +96,17 @@ extern int selinux_restorecon(const char *pathname,
  * See SELINUX_RESTORECON_PROGRESS flag for details.
  */
 #define SELINUX_RESTORECON_MASS_RELABEL			0x4000
+/*
+ * Set if no digest is to be read or written (as only processes
+ * running with CAP_SYS_ADMIN can read/write digests).
+ */
+#define SELINUX_RESTORECON_SKIP_DIGEST			0x8000
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
  * @hndl: specifies handle to set as the global fc handle.
  *
- * Called by a process that has already called selabel_open(3) with it's
+ * Called by a process that has already called selabel_open(3) with its
  * required parameters, or if selinux_restorecon_default_handle(3) has been
  * called to set the default selabel_open(3) parameters.
  */
@@ -110,7 +115,7 @@ extern void selinux_restorecon_set_sehandle(struct selabel_handle *hndl);
 /**
  * selinux_restorecon_default_handle - Sets default selabel_open(3) parameters
  *				       to use the currently loaded policy and
- *				       file_contexts, also requests the digest.
+ *				       file_contexts.
  *
  * Return value is the created handle on success or NULL with @errno set on
  * failure.
@@ -134,12 +139,12 @@ extern void selinux_restorecon_set_exclude_list(const char **exclude_list);
 extern int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath);
 
 /**
- * selinux_restorecon_xattr - Read/remove RESTORECON_LAST xattr entries.
+ * selinux_restorecon_xattr - Read/remove security.sehash xattr entries.
  * @pathname: specifies directory path to check.
  * @xattr_flags: specifies the actions to be performed.
  * @xattr_list: a linked list of struct dir_xattr structures containing
  *              the directory, digest and result of the action on the
- *              RESTORECON_LAST entry.
+ *              security.sehash entry.
  *
  * selinux_restorecon_xattr(3) will automatically call
  * selinux_restorecon_default_handle(3) and selinux_restorecon_set_sehandle(3)
diff --git a/libselinux/man/man3/selabel_get_digests_all_partial_matches.3 b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
new file mode 100644
index 0000000..2366375
--- /dev/null
+++ b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
@@ -0,0 +1,70 @@
+.TH "selabel_get_digests_all_partial_matches" "3" "14 April 2019" "SELinux API documentation"
+
+.SH "NAME"
+selabel_get_digests_all_partial_matches \- retrieve the partial matches digest
+and the xattr digest that applies to the supplied path \- Only supported
+on file backend.
+.
+.SH "SYNOPSIS"
+.B #include <stdbool.h>
+.br
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.BI "bool selabel_get_digests_all_partial_matches("
+.in +\w'selabel_get_digests_all_partial_matches('u
+.BI "struct selabel_handle *" hnd ,
+.br
+.BI "const char *" key ,
+.br
+.BI "uint8_t **" calculated_digest ,
+.br
+.BI "uint8_t **" xattr_digest ,
+.br
+.BI "size_t *" digest_len ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selabel_get_digests_all_partial_matches ()
+retrieves the file_contexts partial matches digest and the xattr digest that
+applies to the supplied path on the handle
+.IR hnd .
+.br
+The
+.IR key
+parameter is the path to retrieve the digests.
+.br
+The
+.IR calculated_digest
+is a pointer to the
+.IR key
+calculated file_contexts digest of all applicable partial matches, or NULL if
+none exist. The caller must
+.BR free (3)
+the buffer.
+.br
+The
+.IR xattr_digest
+is a pointer to the
+.IR key
+.BR xattr (7)
+stored digest, or NULL if it does not exist.
+The caller must
+.BR free (3)
+the buffer.
+.br
+The
+.IR digest_len
+is the length of the digests that will always be returned (even if both are
+NULL). Note that if both digests are returned, they will always be the same length.
+.sp
+.SH "RETURN VALUE"
+TRUE if the digests match or FALSE if they do not or either or both are missing.
+.sp
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.BR selabel_partial_match (3),
+.BR selabel_open (3),
+.BR selinux (8),
+.BR selabel_file (5)
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 1eac6ed..a13b53f 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -28,39 +28,53 @@ If this is a directory and the
 .B SELINUX_RESTORECON_RECURSE
 has been set (for descending through directories), then
 .BR selinux_restorecon ()
-will write an SHA1 digest of the combined specfiles (see the
+will write an SHA1 digest of specfile entries caculated by
+.BR selabel_get_digests_all_partial_matches (3)
+to an extended attribute of
+.IR security.sehash
+once the relabeling has been completed successfully (see the
 .B NOTES
-section for details) to an extended attribute of
-.IR security.restorecon_last
-once the relabeling has been completed successfully. This digest will be
-checked should
+section for details).
+.br
+These digests will be checked should
 .BR selinux_restorecon ()
-be rerun
-with the
+be rerun with the
 .IR restorecon_flags
 .B SELINUX_RESTORECON_RECURSE
-flag set. If any of the specfiles had been updated, the digest
+flag set. If any of the specfile entries had been updated, the digest
 will also be updated. However if the digest is the same, no relabeling checks
-will take place (unless the
+will take place.
+.br
+The
+.IR restorecon_flags
+that can be used to manage the usage of the SHA1 digest are:
+.RS
+.B SELINUX_RESTORECON_SKIP_DIGEST
+.br
 .B SELINUX_RESTORECON_IGNORE_DIGEST
-flag is set).
+.RE
 .sp
 .IR restorecon_flags
 contains the labeling option/rules as follows:
 .sp
 .RS
 .sp
+.B SELINUX_RESTORECON_SKIP_DIGEST
+Do not check or update any extended attribute
+.IR security.sehash
+entries.
+.sp
 .B SELINUX_RESTORECON_IGNORE_DIGEST
 force the checking of labels even if the stored SHA1 digest matches the
-specfiles SHA1 digest. The specfiles digest will be written to the
-.IR security.restorecon_last
+specfile entries SHA1 digest. The specfile entries digest will be written to the
+.IR security.sehash
 extended attribute once relabeling has been completed successfully provided the
 .B SELINUX_RESTORECON_NOCHANGE
 flag has not been set.
 .sp
 .B SELINUX_RESTORECON_NOCHANGE
 don't change any file labels (passive check) or update the digest in the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute.
 .sp
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
@@ -70,7 +84,7 @@ default specfile context.
 .sp
 .B SELINUX_RESTORECON_RECURSE
 change file and directory labels recursively (descend directories)
-and if successful write an SHA1 digest of the combined specfiles to an
+and if successful write an SHA1 digest of the specfile entries to an
 extended attribute as described in the
 .B NOTES
 section.
@@ -140,16 +154,6 @@ is useful where there is a non-seclabel fs mounted with a seclabel fs mounted
 on a directory below this.
 .RE
 .sp
-The behavior regarding the checking and updating of the SHA1 digest described
-above is the default behavior. It is possible to change this by first calling
-.BR selabel_open (3)
-and not enabling the
-.B SELABEL_OPT_DIGEST
-option, then calling
-.BR selinux_restorecon_set_sehandle (3)
-to set the handle to be used by
-.BR selinux_restorecon (3).
-.sp
 If the
 .I pathname
 is a directory path, then it is possible to set directories to be excluded
@@ -182,12 +186,13 @@ To improve performance when relabeling file systems recursively (e.g. the
 .B SELINUX_RESTORECON_RECURSE
 flag is set)
 .BR selinux_restorecon ()
-will write an SHA1 digest of the specfiles that are processed by
-.BR selabel_open (3)
+will write a caculated SHA1 digest of the specfile entries returned by
+.BR selabel_get_digests_all_partial_matches (3)
 to an extended attribute named
-.IR security.restorecon_last
-to the directory specified in the
-.IR pathname .
+.IR security.sehash
+for each directory in the
+.IR pathname
+path.
 .IP "2." 4
 To check the extended attribute entry use
 .BR getfattr (1) ,
@@ -195,40 +200,26 @@ for example:
 .sp
 .RS
 .RS
-getfattr -e hex -n security.restorecon_last /
+getfattr -e hex -n security.sehash /
 .RE
 .RE
 .IP "3." 4
-The SHA1 digest is calculated by
-.BR selabel_open (3)
-concatenating the specfiles it reads during initialisation with the
-resulting digest and list of specfiles being retrieved by
-.BR selabel_digest (3).
-.IP "4." 4
-The specfiles consist of the mandatory
-.I file_contexts
-file plus any subs, subs_dist, local and homedir entries (text or binary versions)
-as determined by any
-.BR selabel_open (3)
-options e.g.
-.BR SELABEL_OPT_BASEONLY .
-.sp
-Should any of the specfiles have changed, then when
+Should any of the specfile entries have changed, then when
 .BR selinux_restorecon ()
 is run again with the
 .B SELINUX_RESTORECON_RECURSE
-flag set, a new SHA1 digest will be calculated and all files will be automatically
+flag set, new SHA1 digests will be calculated and all files automatically
 relabeled depending on the settings of the
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
 flag (provided
 .B SELINUX_RESTORECON_NOCHANGE
 is not set).
-.IP "5." 4
+.IP "4." 4
 .B /sys
 and in-memory filesystems do not support the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute and are automatically excluded from any relabeling checks.
-.IP "6." 4
+.IP "5." 4
 By default
 .B stderr
 is used to log output messages and errors. This may be changed by calling
@@ -239,6 +230,8 @@ with the
 option.
 .
 .SH "SEE ALSO"
+.BR selabel_get_digests_all_partial_matches (3),
+.br
 .BR selinux_restorecon_set_sehandle (3),
 .br
 .BR selinux_restorecon_default_handle (3),
diff --git a/libselinux/man/man3/selinux_restorecon_default_handle.3 b/libselinux/man/man3/selinux_restorecon_default_handle.3
index 52f5ad3..9c318c0 100644
--- a/libselinux/man/man3/selinux_restorecon_default_handle.3
+++ b/libselinux/man/man3/selinux_restorecon_default_handle.3
@@ -17,15 +17,14 @@ sets default parameters for
 .BR selinux_restorecon (3)
 by calling
 .BR selabel_open (3)
-with the
-.B SELABEL_OPT_DIGEST
-option only. This will enable a digest to be calculated on the currently
-loaded policy
+for the
+.B SELABEL_CTX_FILE
+backend using the default loaded policy
 .BR file_contexts (5)
 set of files as described in the
 .B NOTES
 section of
-.BR selinux_restorecon (3).
+.BR selinux_restorecon (3)
 .sp
 Calling
 .BR selinux_restorecon_default_handle ()
diff --git a/libselinux/man/man3/selinux_restorecon_xattr.3 b/libselinux/man/man3/selinux_restorecon_xattr.3
index 516d266..e1e6759 100644
--- a/libselinux/man/man3/selinux_restorecon_xattr.3
+++ b/libselinux/man/man3/selinux_restorecon_xattr.3
@@ -2,7 +2,7 @@
 
 .SH "NAME"
 selinux_restorecon_xattr \- manage default
-.I security.restorecon_last
+.I security.sehash
 extended attribute entries added by
 .BR selinux_restorecon (3),
 .BR setfiles (8)
@@ -29,7 +29,7 @@ structures containing information described below based on:
 .RS
 .IR pathname
 containing a directory tree to be searched for
-.I security.restorecon_last
+.I security.sehash
 extended attribute entries.
 .sp
 .IR xattr_flags
@@ -119,14 +119,11 @@ By default
 .BR selinux_restorecon_xattr (3)
 will use the default set of specfiles described in
 .BR files_contexts (5)
-to calculate the initial SHA1 digest to be used for comparison.
+to calculate the SHA1 digests to be used for comparison.
 To change this default behavior
 .BR selabel_open (3)
 must be called specifying the required
 .B SELABEL_OPT_PATH
-and setting the
-.B SELABEL_OPT_DIGEST
-option to a non-NULL value.
 .BR selinux_restorecon_set_sehandle (3)
 is then called to set the handle to be used by
 .BR selinux_restorecon_xattr (3).
@@ -143,7 +140,7 @@ flag has been set.
 and
 .B TMPFS
 filesystems do not support the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute and are automatically excluded from searches.
 .IP "4." 4
 By default
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 1d16f68..a03192e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -274,6 +274,21 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 	return rec->func_partial_match(rec, key);
 }
 
+bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
+					     const char *key,
+					     uint8_t **calculated_digest,
+					     uint8_t **xattr_digest,
+					     size_t *digest_len)
+{
+	if (!rec->func_get_digests_all_partial_matches)
+		return false;
+
+	return rec->func_get_digests_all_partial_matches(rec, key,
+							 calculated_digest,
+							 xattr_digest,
+							 digest_len);
+}
+
 bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
                                       const char *key, uint8_t *digest) {
 	if (!rec->func_hash_all_partial_matches) {
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0ca60b7..ea52883 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -972,6 +972,55 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 	return result;
 }
 
+/*
+ * Returns true if the digest of all partial matched contexts is the same as
+ * the one saved by setxattr, otherwise returns false. The length of the SHA1
+ * digest will always be returned. The caller must free any returned digests.
+ */
+static bool get_digests_all_partial_matches(struct selabel_handle *rec,
+					    const char *pathname,
+					    uint8_t **calculated_digest,
+					    uint8_t **xattr_digest,
+					    size_t *digest_len)
+{
+	uint8_t read_digest[SHA1_HASH_SIZE];
+	ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
+				     read_digest, SHA1_HASH_SIZE);
+	uint8_t hash_digest[SHA1_HASH_SIZE];
+	bool status = selabel_hash_all_partial_matches(rec, pathname,
+						       hash_digest);
+
+	*xattr_digest = NULL;
+	*calculated_digest = NULL;
+	*digest_len = SHA1_HASH_SIZE;
+
+	if (read_size == SHA1_HASH_SIZE) {
+		*xattr_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
+		if (!*xattr_digest)
+			goto oom;
+
+		memcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE);
+	}
+
+	if (status) {
+		*calculated_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
+		if (!*calculated_digest)
+			goto oom;
+
+		memcpy(*calculated_digest, hash_digest, SHA1_HASH_SIZE);
+	}
+
+	if (status && read_size == SHA1_HASH_SIZE &&
+	    memcmp(read_digest, hash_digest, SHA1_HASH_SIZE) == 0)
+		return true;
+
+	return false;
+
+oom:
+	selinux_log(SELINUX_ERROR, "SELinux: %s: Out of memory\n", __func__);
+	return false;
+}
+
 static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
 {
 	assert(digest);
@@ -1200,6 +1249,8 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_stats = &stats;
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
+	rec->func_get_digests_all_partial_matches =
+					&get_digests_all_partial_matches;
 	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
 	rec->func_lookup_best_match = &lookup_best_match;
 	rec->func_cmp = &cmp;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 6f4ee10..7b38659 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -6,6 +6,7 @@
 #include <string.h>
 
 #include <sys/stat.h>
+#include <sys/xattr.h>
 
 /*
  * regex.h/c were introduced to hold all dependencies on the regular
@@ -31,6 +32,9 @@
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
 	SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
 
+/* Required selinux_restorecon and selabel_get_digests_all_partial_matches() */
+#define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
+
 struct selabel_sub {
 	char *src;
 	int slen;
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 1fa5ade..7ed2a43 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -87,6 +87,11 @@ struct selabel_handle {
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
 	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
+	bool (*func_get_digests_all_partial_matches) (struct selabel_handle *h,
+						      const char *key,
+						      uint8_t **calculated_digest,
+						      uint8_t **xattr_digest,
+						      size_t *digest_len);
 	bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
 	                                       const char *key, uint8_t *digest);
 	struct selabel_lookup_rec *(*func_lookup_best_match)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 5f18923..21da1cb 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -36,17 +36,12 @@
 
 #include "callbacks.h"
 #include "selinux_internal.h"
-
-#define RESTORECON_LAST "security.restorecon_last"
-
-#define SYS_PATH "/sys"
-#define SYS_PREFIX SYS_PATH "/"
+#include "label_file.h"
+#include "sha1.h"
 
 #define STAR_COUNT 1024
 
 static struct selabel_handle *fc_sehandle = NULL;
-static unsigned char *fc_digest = NULL;
-static size_t fc_digest_len = 0;
 static char *rootpath = NULL;
 static int rootpathlen;
 
@@ -77,7 +72,6 @@ struct rest_flags {
 	bool mass_relabel;
 	bool set_specctx;
 	bool add_assoc;
-	bool ignore_digest;
 	bool recurse;
 	bool userealpath;
 	bool set_xdev;
@@ -299,57 +293,60 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 			   bool delete_all)
 {
 	char *sha1_buf = NULL;
-	unsigned char *xattr_value = NULL;
-	ssize_t xattr_size;
-	size_t i;
+	size_t i, digest_len = 0;
 	int rc, digest_result;
 	struct dir_xattr *new_entry;
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
 
 	if (!directory) {
 		errno = EINVAL;
 		return -1;
 	}
 
-	xattr_value = malloc(fc_digest_len);
-	if (!xattr_value)
-		goto oom;
+	selabel_get_digests_all_partial_matches(fc_sehandle, directory,
+						&calculated_digest,
+						&xattr_digest, &digest_len);
 
-	xattr_size = getxattr(directory, RESTORECON_LAST, xattr_value,
-			      fc_digest_len);
-	if (xattr_size < 0) {
-		free(xattr_value);
+	if (!xattr_digest) {
+		free(calculated_digest);
 		return 1;
 	}
 
 	/* Convert entry to a hex encoded string. */
-	sha1_buf = malloc(xattr_size * 2 + 1);
+	sha1_buf = malloc(digest_len * 2 + 1);
 	if (!sha1_buf) {
-		free(xattr_value);
+		free(xattr_digest);
+		free(calculated_digest);
 		goto oom;
 	}
 
-	for (i = 0; i < (size_t)xattr_size; i++)
-		sprintf((&sha1_buf[i * 2]), "%02x", xattr_value[i]);
+	for (i = 0; i < digest_len; i++)
+		sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
 
-	rc = memcmp(fc_digest, xattr_value, fc_digest_len);
+	rc = memcmp(calculated_digest, xattr_digest, digest_len);
 	digest_result = rc ? NOMATCH : MATCH;
 
 	if ((delete_nonmatch && rc != 0) || delete_all) {
 		digest_result = rc ? DELETED_NOMATCH : DELETED_MATCH;
-		rc = removexattr(directory, RESTORECON_LAST);
+		rc = removexattr(directory, RESTORECON_PARTIAL_MATCH_DIGEST);
 		if (rc) {
 			selinux_log(SELINUX_ERROR,
 				  "Error: %s removing xattr \"%s\" from: %s\n",
-				  strerror(errno), RESTORECON_LAST, directory);
+				  strerror(errno),
+				  RESTORECON_PARTIAL_MATCH_DIGEST, directory);
 			digest_result = ERROR;
 		}
 	}
-	free(xattr_value);
+	free(xattr_digest);
+	free(calculated_digest);
 
 	/* Now add entries to link list. */
 	new_entry = malloc(sizeof(struct dir_xattr));
-	if (!new_entry)
+	if (!new_entry) {
+		free(sha1_buf);
 		goto oom;
+	}
 	new_entry->next = NULL;
 
 	new_entry->directory = strdup(directory);
@@ -736,18 +733,78 @@ err:
 	goto out1;
 }
 
+struct dir_hash_node {
+	char *path;
+	uint8_t digest[SHA1_HASH_SIZE];
+	struct dir_hash_node *next;
+};
+/*
+ * Returns true if the digest of all partial matched contexts is the same as
+ * the one saved by setxattr. Otherwise returns false and constructs a
+ * dir_hash_node with the newly calculated digest.
+ */
+static bool check_context_match_for_dir(const char *pathname,
+					struct dir_hash_node **new_node,
+					int error)
+{
+	bool status;
+	size_t digest_len = 0;
+	uint8_t *read_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+
+	if (!new_node)
+		return false;
+
+	*new_node = NULL;
+
+	/* status = true if digests match, false otherwise. */
+	status = selabel_get_digests_all_partial_matches(fc_sehandle, pathname,
+							 &calculated_digest,
+							 &read_digest,
+							 &digest_len);
+
+	if (status)
+		goto free;
+
+	/* Save digest of all matched contexts for the current directory. */
+	if (!error && calculated_digest) {
+		*new_node = calloc(1, sizeof(struct dir_hash_node));
+
+		if (!*new_node)
+			goto oom;
+
+		(*new_node)->path = strdup(pathname);
+
+		if (!(*new_node)->path) {
+			free(*new_node);
+			*new_node = NULL;
+			goto oom;
+		}
+		memcpy((*new_node)->digest, calculated_digest, digest_len);
+		(*new_node)->next = NULL;
+	}
+
+free:
+	free(calculated_digest);
+	free(read_digest);
+	return status;
+
+oom:
+	selinux_log(SELINUX_ERROR, "%s: Out of memory\n", __func__);
+	goto free;
+}
+
+
 /*
  * Public API
  */
 
 /* selinux_restorecon(3) - Main function that is responsible for labeling */
 int selinux_restorecon(const char *pathname_orig,
-				    unsigned int restorecon_flags)
+		       unsigned int restorecon_flags)
 {
 	struct rest_flags flags;
 
-	flags.ignore_digest = (restorecon_flags &
-		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
 	flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
 	flags.verbose = (restorecon_flags &
@@ -777,10 +834,10 @@ int selinux_restorecon(const char *pathname_orig,
 	flags.warnonnomatch = true;
 	ignore_mounts = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
-
-	bool issys;
-	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
-					* FALSE = don't use xattr */
+	bool ignore_digest = (restorecon_flags &
+		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
+	bool setrestorecondigest = (restorecon_flags &
+		    SELINUX_RESTORECON_SKIP_DIGEST) ? false : true;
 	struct stat sb;
 	struct statfs sfsb;
 	FTS *fts;
@@ -788,9 +845,9 @@ int selinux_restorecon(const char *pathname_orig,
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
 	int fts_flags, error, sverrno;
-	char *xattr_value = NULL;
-	ssize_t size;
 	dev_t dev_num = 0;
+	struct dir_hash_node *current = NULL;
+	struct dir_hash_node *head = NULL;
 
 	if (flags.verbose && flags.progress)
 		flags.verbose = false;
@@ -800,12 +857,6 @@ int selinux_restorecon(const char *pathname_orig,
 	if (!fc_sehandle)
 		return -1;
 
-	if (fc_digest_len) {
-		xattr_value = malloc(fc_digest_len);
-		if (!xattr_value)
-			return -1;
-	}
-
 	/*
 	 * Convert passed-in pathname to canonical pathname by resolving
 	 * realpath of containing dir, then appending last component name.
@@ -853,13 +904,9 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 	paths[0] = pathname;
-	issys = (!strcmp(pathname, SYS_PATH) ||
-			    !strncmp(pathname, SYS_PREFIX,
-			    sizeof(SYS_PREFIX) - 1)) ? true : false;
 
 	if (lstat(pathname, &sb) < 0) {
 		if (flags.ignore_noent && errno == ENOENT) {
-			free(xattr_value);
 			free(pathdnamer);
 			free(pathname);
 			return 0;
@@ -872,9 +919,9 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	}
 
-	/* Ignore restoreconlast if not a directory */
+	/* Skip digest if not a directory */
 	if ((sb.st_mode & S_IFDIR) != S_IFDIR)
-		setrestoreconlast = false;
+		setrestorecondigest = false;
 
 	if (!flags.recurse) {
 		if (check_excluded(pathname)) {
@@ -886,30 +933,19 @@ int selinux_restorecon(const char *pathname_orig,
 		goto cleanup;
 	}
 
-	/* Ignore restoreconlast on /sys */
-	if (issys)
-		setrestoreconlast = false;
-
-	/* Ignore restoreconlast on in-memory filesystems */
-	if (setrestoreconlast && statfs(pathname, &sfsb) == 0) {
-		if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC)
-			setrestoreconlast = false;
+	/* Obtain fs type */
+	if (statfs(pathname, &sfsb) < 0) {
+		selinux_log(SELINUX_ERROR,
+			    "statfs(%s) failed: %s\n",
+			    pathname, strerror(errno));
+		error = -1;
+		goto cleanup;
 	}
 
-	if (setrestoreconlast) {
-		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
-							    fc_digest_len);
-
-		if (!flags.ignore_digest && (size_t)size == fc_digest_len &&
-			    memcmp(fc_digest, xattr_value, fc_digest_len)
-								    == 0) {
-			selinux_log(SELINUX_INFO,
-			    "Skipping restorecon as matching digest on: %s\n",
-				    pathname);
-			error = 0;
-			goto cleanup;
-		}
-	}
+	/* Skip digest on in-memory filesystems and /sys */
+	if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC ||
+	    sfsb.f_type == SYSFS_MAGIC)
+		setrestorecondigest = false;
 
 	if (flags.set_xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
@@ -973,8 +1009,9 @@ int selinux_restorecon(const char *pathname_orig,
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
 		case FTS_D:
-			if (issys && !selabel_partial_match(fc_sehandle,
-					    ftsent->fts_path)) {
+			if (sfsb.f_type == SYSFS_MAGIC &&
+			    !selabel_partial_match(fc_sehandle,
+			    ftsent->fts_path)) {
 				fts_set(fts, ftsent, FTS_SKIP);
 				continue;
 			}
@@ -983,6 +1020,31 @@ int selinux_restorecon(const char *pathname_orig,
 				fts_set(fts, ftsent, FTS_SKIP);
 				continue;
 			}
+
+			if (setrestorecondigest) {
+				struct dir_hash_node *new_node = NULL;
+
+				if (check_context_match_for_dir(ftsent->fts_path,
+								&new_node,
+								error) &&
+								!ignore_digest) {
+					selinux_log(SELINUX_INFO,
+						    "Skipping restorecon on directory(%s)\n",
+						    ftsent->fts_path);
+					fts_set(fts, ftsent, FTS_SKIP);
+					continue;
+				}
+
+				if (new_node && !error) {
+					if (!current) {
+						current = new_node;
+						head = current;
+					} else {
+						current->next = new_node;
+						current = current->next;
+					}
+				}
+			}
 			/* fall through */
 		default:
 			error |= restorecon_sb(ftsent->fts_path,
@@ -995,13 +1057,24 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	} while ((ftsent = fts_read(fts)) != NULL);
 
-	/* Labeling successful. Mark the top level directory as completed. */
-	if (setrestoreconlast && !flags.nochange && !error && fc_digest) {
-		error = setxattr(pathname, RESTORECON_LAST, fc_digest,
-						    fc_digest_len, 0);
-		if (!error && flags.verbose)
-			selinux_log(SELINUX_INFO,
-				   "Updated digest for: %s\n", pathname);
+	/*
+	 * Labeling successful. Write partial match digests for subdirectories.
+	 * TODO: Write digest upon FTS_DP if no error occurs in its descents.
+	 */
+	if (setrestorecondigest && !flags.nochange && !error) {
+		current = head;
+		while (current != NULL) {
+			if (setxattr(current->path,
+			    RESTORECON_PARTIAL_MATCH_DIGEST,
+			    current->digest,
+			    SHA1_HASH_SIZE, 0) < 0) {
+				selinux_log(SELINUX_ERROR,
+					    "setxattr failed: %s: %s\n",
+					    current->path,
+					    strerror(errno));
+			}
+			current = current->next;
+		}
 	}
 
 out:
@@ -1019,7 +1092,15 @@ cleanup:
 	}
 	free(pathdnamer);
 	free(pathname);
-	free(xattr_value);
+
+	current = head;
+	while (current != NULL) {
+		struct dir_hash_node *next = current->next;
+
+		free(current->path);
+		free(current);
+		current = next;
+	}
 	return error;
 
 oom:
@@ -1049,19 +1130,7 @@ fts_err:
 /* selinux_restorecon_set_sehandle(3) is called to set the global fc handle */
 void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 {
-	char **specfiles;
-	size_t num_specfiles;
-
 	fc_sehandle = (struct selabel_handle *) hndl;
-
-	/*
-	 * Read digest if requested in selabel_open(3) and set global params.
-	 */
-	if (selabel_digest(fc_sehandle, &fc_digest, &fc_digest_len,
-				   &specfiles, &num_specfiles) < 0) {
-		fc_digest = NULL;
-		fc_digest_len = 0;
-	}
 }
 
 /*
@@ -1072,11 +1141,7 @@ struct selabel_handle *selinux_restorecon_default_handle(void)
 {
 	struct selabel_handle *sehandle;
 
-	struct selinux_opt fc_opts[] = {
-		{ SELABEL_OPT_DIGEST, (char *)1 }
-	};
-
-	sehandle = selabel_open(SELABEL_CTX_FILE, fc_opts, 1);
+	sehandle = selabel_open(SELABEL_CTX_FILE, NULL, 0);
 
 	if (!sehandle) {
 		selinux_log(SELINUX_ERROR,
@@ -1134,9 +1199,11 @@ int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
 	return 0;
 }
 
-/* selinux_restorecon_xattr(3) - Find RESTORECON_LAST entries. */
+/* selinux_restorecon_xattr(3)
+ * Find RESTORECON_PARTIAL_MATCH_DIGEST entries.
+ */
 int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
-					    struct dir_xattr ***xattr_list)
+			     struct dir_xattr ***xattr_list)
 {
 	bool recurse = (xattr_flags &
 	    SELINUX_RESTORECON_XATTR_RECURSE) ? true : false;
@@ -1157,7 +1224,7 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 
 	__selinux_once(fc_once, restorecon_init);
 
-	if (!fc_sehandle || !fc_digest_len)
+	if (!fc_sehandle)
 		return -1;
 
 	if (lstat(pathname, &sb) < 0) {
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index aba18a3..3ef3437 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -15,6 +15,7 @@ matchpathcon
 policyvers
 sefcontext_compile
 selabel_digest
+selabel_get_digests_all_partial_matches
 selabel_lookup
 selabel_lookup_best_match
 selabel_partial_match
diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
new file mode 100644
index 0000000..0c2edc6
--- /dev/null
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -0,0 +1,170 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fts.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#include "../src/label_file.h"
+
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-vr] [-f file] path\n\n"
+		"Where:\n\t"
+		"-v  Validate file_contxts entries against loaded policy.\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"-f  Optional file_contexts file (defaults to current policy).\n\t"
+		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
+		"This will check the directory selinux.sehash SHA1 digest for "
+		"<path> against\na newly generated digest based on the "
+		"file_context entries for that node\n(using the regx, mode "
+		"and path entries).\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, fts_flags;
+	size_t i, digest_len;
+	bool status, recurse = false;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *validate = NULL, *file = NULL;
+	char *paths[2] = { NULL, NULL };
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+	char *sha1_buf = NULL;
+
+	struct selabel_handle *hnd;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "f:rv")) > 0) {
+		switch (opt) {
+		case 'f':
+			file = optarg;
+			break;
+		case 'r':
+			recurse = true;
+			break;
+		case 'v':
+			validate = (char *)1;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+
+	paths[0] = argv[optind];
+
+	selabel_option[0].value = file;
+	selabel_option[1].value = validate;
+
+	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
+							     "handle.\n");
+		return -1;
+	}
+
+	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("fts error on %s: %s\n",
+		       paths[0], strerror(errno));
+		return -1;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_DP:
+			continue;
+		case FTS_D: {
+
+			xattr_digest = NULL;
+			calculated_digest = NULL;
+			digest_len = 0;
+
+			status = selabel_get_digests_all_partial_matches(hnd,
+							 ftsent->fts_path,
+							 &calculated_digest,
+							 &xattr_digest,
+							 &digest_len);
+
+			sha1_buf = calloc(1, digest_len * 2 + 1);
+			if (!sha1_buf) {
+				fprintf(stderr, "Could not calloc buffer ERROR: %s\n",
+					    strerror(errno));
+				return -1;
+			}
+
+			if (status) { /* They match */
+				printf("xattr and file_contexts SHA1 digests match for: %s\n",
+				       ftsent->fts_path);
+
+				if (calculated_digest) {
+					for (i = 0; i < digest_len; i++)
+						sprintf((&sha1_buf[i * 2]),
+							"%02x",
+							calculated_digest[i]);
+					printf("SHA1 digest: %s\n", sha1_buf);
+				}
+			} else {
+				if (!calculated_digest) {
+					printf("No SHA1 digest available for: %s\n",
+					       ftsent->fts_path);
+					printf("as file_context entry is \"<<none>>\"\n");
+					break;
+				}
+
+				printf("The file_context entries for: %s\n",
+				       ftsent->fts_path);
+
+				for (i = 0; i < digest_len; i++)
+					sprintf((&sha1_buf[i * 2]), "%02x",
+						calculated_digest[i]);
+				printf("generated SHA1 digest: %s\n", sha1_buf);
+
+				if (!xattr_digest) {
+					printf("however there is no selinux.sehash xattr entry.\n");
+				} else {
+					printf("however it does NOT match the current entry of:\n");
+					for (i = 0; i < digest_len; i++)
+						sprintf((&sha1_buf[i * 2]),
+							"%02x",
+							xattr_digest[i]);
+					printf("%s\n", sha1_buf);
+				}
+
+				free(xattr_digest);
+				free(calculated_digest);
+				free(sha1_buf);
+			}
+			break;
+		}
+		default:
+			break;
+		}
+
+		if (!recurse)
+			break;
+	}
+
+	(void) fts_close(fts);
+	(void) selabel_close(hnd);
+	return 0;
+}
-- 
2.20.1

