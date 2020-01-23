Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0226C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 20:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29921734
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qRw9nvLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAWUjK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:39:10 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:26164 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWUjK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 15:39:10 -0500
X-EEMSG-check-017: 49079484|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,355,1574121600"; 
   d="scan'208";a="49079484"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jan 2020 20:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579811947; x=1611347947;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TbhYpwp13jy1d7hCOTFhxKXU2hN76tk9UV/9TvOgVL8=;
  b=qRw9nvLr9NBMwUyUSCnLzSoXRQTgHsdgv407buxMXUBwZ54T6CC/M1GM
   3cG4mzVUIb9qWDJ4VqLB3+CTzefbQ60A5YuC4OgDEhO4CfuKV+B9Rr1y3
   A3iLlL986KCBAOWPmjUE1mBVxq02bSf6raJzTkkgIbtlT2d5Em99PbK+b
   4nyXVCivqzN8wKR0+SI71TDS+QWC2A06SGK+z5k2gobbtjAkDCzZQ21gZ
   Otmh9qgjBPXvXGEx3/2KDvWHTsGzmCz2mspMdCS/cZuhW/fhdgJjvCLM+
   owIIWuMAKxpmqjzphg+CasxHrDTtyX/+WfyXlp3lprO/0seRJouheUlt0
   A==;
X-IronPort-AV: E=Sophos;i="5.70,355,1574121600"; 
   d="scan'208";a="38180693"
IronPort-PHdr: =?us-ascii?q?9a23=3As5kPIBwnbvW+yr3XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+ofIJqq85mqBkHD//Il1AaPAdyHragewLqI++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMn4duNKk9xx?=
 =?us-ascii?q?jIr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y63SfckeRW?=
 =?us-ascii?q?FcQMhfUSJPCZ64Y4cWD+cMOeNUoo/grFUMsBS+HxGhCuPxxDFViHH43qo03O?=
 =?us-ascii?q?suHwzdwAAtHMgDvGjOodnpKKsfV/2+wqnSzTXEavNbwTPz55LNch8/uvGHQK?=
 =?us-ascii?q?x9ftDLyUkzCQzFlEibpIvnPzKbyusCqXKb7/Z+We+0l24mqx1+ojioxss2jI?=
 =?us-ascii?q?nJnZgaxkrL9SV+3oY4PNu1Q1N4b968CJZcqi6XOoRsTs4iXm1kojg2x7IYtZ?=
 =?us-ascii?q?KhYSQHzoksyQTFZPydaYeI5wruVOOWIThlmn1oYKm/hxOu8Ui4ze38S9W03E?=
 =?us-ascii?q?5KriVbltnMsWgA1wDJ5cidS/t941yh1SyO1wDV5OFEJls0mrTHJJI73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJN0IYi5QqwAC280N?=
 =?us-ascii?q?QEg3UKN05FeRKbgIjpPFHCOvb4DeyljFi2nzdrwO7GMqX7AprRNnjDjKvhfb?=
 =?us-ascii?q?Fl5k5H1gUzydFf55RJCrAOO//zREDxu8LCDhMjMAy73fznCNNj2YMaQ26PBb?=
 =?us-ascii?q?WZMKyB+WOPs/kiJ+iKeZ89pjnwMb4m6uTogHt/nkUSLoez2p5CSnm9E+8uCE?=
 =?us-ascii?q?yDfXf2yoMDDmwDpBZkZPD7g12FFzhIbjC9WLxqtWJzM56vEYqWHtPlu7eGxi?=
 =?us-ascii?q?ruW8AHaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CEBQCBAype/wHyM5BlHgELHIFwC4F4BYFtIBIqjRWGc?=
 =?us-ascii?q?gMBAQaLJo9OgXsJAQEBAQEBAQEBGxwBAYcENQgOAhABAQEEAQEBAQEFAwEBb?=
 =?us-ascii?q?IVDgjspgygLAYIXgmc/glclrkIzhUqDNYE+gTiHPoVsgQeBETaDG4QSgQSFI?=
 =?us-ascii?q?QSBPwGVE4Enl1oGgj2WKAwbmnYBLas1ATaBWCsIAhgpgWiBTlAYDYgNFxWOL?=
 =?us-ascii?q?CMDMIsBgkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Jan 2020 20:39:03 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00NKcKwk250980
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 15:38:21 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: Fix bug in cil_copy_avrule() in extended permission handling
Date:   Thu, 23 Jan 2020 15:40:04 -0500
Message-Id: <20200123204004.25600-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When copying an avrule with extended permissions (permx) in
cil_copy_avrule(), the check for a named permx checks the new permx
instead of the old one, so the check will always fail. This leads to a
segfault when trying to copy a named permx because there will be an
attempt to copy the nonexistent permx struct instead of the name of
the named permx.

Check whether the original is a named permx instead of the new one.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_copy_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 7af00aaf..67dd8528 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -827,7 +827,7 @@ int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((u
 	if (!new->is_extended) {
 		cil_copy_classperms_list(orig->perms.classperms, &new->perms.classperms);
 	} else {
-		if (new->perms.x.permx_str != NULL) {
+		if (orig->perms.x.permx_str != NULL) {
 			new->perms.x.permx_str = orig->perms.x.permx_str;
 		} else {
 			cil_permissionx_init(&new->perms.x.permx);
-- 
2.21.1

