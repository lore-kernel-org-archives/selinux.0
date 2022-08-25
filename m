Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE5C64990
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiHYNmc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiHYNmb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 09:42:31 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 06:42:30 PDT
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B8B2492
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661434042; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=O2rB+LEiaefWlGbPUkWAaFktM1LcD0XUvdnXXSCOtqaj2li6J6FsKVDzZ6Zlp+9/rc+YGbggvmR8RPpGx4fweITHbcJ8nhX48P6P0Aj2eSbpz26NLQh319k90PQUx6+FSXiEXHEvo0YDQtAlI1TqsyWkwT6FYLGErhYGquRFrpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1661434042; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=1qZgDIDt25pRE5+EXbLbSSRkzjPpqP6nsW35Acsaf7M=; 
        b=Z42nrdKCz78b36ydCt4dW/ogwPXAYxJ991qs2gkL5zPcJXq9Y235segWJuGYEujD9CYaQAcm14vZ9G4Wh+P9Otc1dVsCX3tk9XXa/VHfszgmplmWvxcoMO9rsgaEZejAQcailY69hHPCuf73cl0CUjJQV+yx+KQqgIrrSXSpzR8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661434042;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
        bh=1qZgDIDt25pRE5+EXbLbSSRkzjPpqP6nsW35Acsaf7M=;
        b=fj14wBhLTC03PwZCZgP8ANTOtLJ+CR9YH54rXeQTE3H6dzegY9eXMEkrGlwy5JRW
        8jrycLNl6ZnwUotA7/C/cRsUtTtQB8uQSiPfhX2mODRL6hx1jn6oQ4SpR1fHtqsLDzR
        RzyG51XbcIBgYrnvhwTGe5KmDOOpQQMdRrN4HzZ8=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1661434040737153.12025910810894; Thu, 25 Aug 2022 15:27:20 +0200 (CEST)
Date:   Thu, 25 Aug 2022 15:27:18 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: fix missing double quotes in typetransition CIL
 rule
Message-ID: <20220825132718.jnuxg7oqkmm3dx2l@jmarcin-t14s-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL Reference Guide defines typetransition rule with double quotes
around object name, but those are not present in the format string.

This patch fixes this issue, so the CIL output produced by
sepol_kernel_policydb_to_cil() is in the correct format.

Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 libsepol/src/kernel_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 5a1336a3..ad4121d5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1894,7 +1894,7 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
 			src = pdb->p_type_val_to_name[bit];
 			rc = strs_create_and_add(strs,
-						 "(typetransition %s %s %s %s %s)",
+						 "(typetransition %s %s %s \"%s\" %s)",
 						 5, src, tgt, class, filename, new);
 			if (rc)
 				return rc;
-- 
2.37.1

