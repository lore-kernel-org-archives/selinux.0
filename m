Return-Path: <SRS0=Lq8N=TI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C28C04A6B
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 06:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2A21019
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 06:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfEHG2a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 May 2019 02:28:30 -0400
Received: from www.osadl.org ([62.245.132.105]:47282 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfEHG2a (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 May 2019 02:28:30 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x486R0jv016762;
        Wed, 8 May 2019 08:27:00 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] selinux: provide __le variables explicitly
Date:   Wed,  8 May 2019 08:21:17 +0200
Message-Id: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While the endiannes is being handled properly sparse was unable to verify
this due to type inconsistency. So introduce an additional __le32
respectively _le64 variable to be passed to le32/64_to_cpu() to allow
sparse to verify proper typing. Note that this patch does not change
the generated binary on little-endian systems - on 32bit powerpc it
does change the binary.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by an experimental coccinelle script to locate
patters that make sparse unhappy (false positives):

sparse complaints on different architectures fixed by this patch are:

ppc6xx_defconfig
  CHECK   security/selinux/ss/ebitmap.c
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64

Little-endian systems:

loongson3_defconfig
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64

x86_64_defconfig
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64

Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
little-endian) and ppc603_defconfig (big-endian).

On little-endian systems the patch has no impact on the generated binary 
(which is expected) but on the 32bit powerpc it does change the binary
which is not expected but since I'm not able to generate the .lst files
in security/selinux/ss/ due to the lack of a Makefile it is not clear
if this is an unexpected side-effect or due only to the introduction of
the additional variables. From my understanding the patch does not change
the program logic so if the code was correct on big-endian systems before
it should still be correct now.

Patch is against 5.1 (localversion-next is next-20190506)

 security/selinux/ss/ebitmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 8f624f8..09929fc 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -347,7 +347,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 {
 	struct ebitmap_node *n = NULL;
 	u32 mapunit, count, startbit, index;
+	__le32 ebitmap_start;
 	u64 map;
+	__le64 mapbits;
 	__le32 buf[3];
 	int rc, i;
 
@@ -381,12 +383,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 		goto bad;
 
 	for (i = 0; i < count; i++) {
-		rc = next_entry(&startbit, fp, sizeof(u32));
+		rc = next_entry(&ebitmap_start, fp, sizeof(u32));
 		if (rc < 0) {
 			pr_err("SELinux: ebitmap: truncated map\n");
 			goto bad;
 		}
-		startbit = le32_to_cpu(startbit);
+		startbit = le32_to_cpu(ebitmap_start);
 
 		if (startbit & (mapunit - 1)) {
 			pr_err("SELinux: ebitmap start bit (%d) is "
@@ -423,12 +425,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			goto bad;
 		}
 
-		rc = next_entry(&map, fp, sizeof(u64));
+		rc = next_entry(&mapbits, fp, sizeof(u64));
 		if (rc < 0) {
 			pr_err("SELinux: ebitmap: truncated map\n");
 			goto bad;
 		}
-		map = le64_to_cpu(map);
+		map = le64_to_cpu(mapbits);
 
 		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
 		while (map) {
-- 
2.1.4

