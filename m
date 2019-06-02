Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A9F27987
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DtJQnXUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfFBQy1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:27 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:45356
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfFBQy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494466; bh=s293PbMAjW22h/8ubCAR0YEDBHbqaLOuUY2hFLr6/0s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DtJQnXUM9fnLeyeQMMl0aIZMAggikq7FHFPU3YhSwj/NY+x8WVSuSX/8A/dNCNUqsGuByaj0doiL+QrT9hN88G1KtnWmYIk51Fv71bqKlfGU+stTj9IdI1y7ScDmVulna5gUPGCUiO3N4ofO24WwesK+BupoS5pkvKe91Y+xwem6HKZ8CEbfUXzvPeqBNDQAlMhXtAh2V+92aRNHxjUc8nN9kxEFG9cOZ+/Pp5fCPTA8LQbXwg07CmosNzyxTtoAKwM9pnKnVp1A78eLh+GHlVCTQOyKuAZ+4tJlxZ94dlxw6AMJIkiNgFdNlzha6KDBcq6doIF6RwIYtjd5GOyUnw==
X-YMail-OSG: XfcXFqYVM1nKRc6FqRagebTuxsckWAV2i8gohIXBEVx1flzRqRhRrgozBGHQ0NN
 wf2nBQxcl_DIQML.5wW6O14W8mOdKJ4bAO24bqwr9FuiIIoKga5mzo3yoE6UmYIqGpa00h84e6Y8
 VskKuVy8HqhGngKKhi_h93gq0cexgidzzyqw_5r_BtyAADMK0lADzz7Ixz0WISVwPbN7XI7wNDZP
 ffKdVpAAGqQE4KsLjUN5tn3eIoDsEmbu1XajlTenei1TUj73_eRYC0oHNSyZ2if0F.9esYW8Z_GA
 Ydh6Hgl3styPUhN6uZG_hYhY3msLz4tU1Jo42TLMw8nAGjKIdfAVBwc5qn0ve56D6P9.HhozmY1F
 aqKvn5ko0fpl18KSta2plYWkqTJK6oIXXWfDwqn12b.7FkKjZsx9Uv0c5C5yivF57QW6VYrAOSFy
 psm1q13rBKr5DWarpa2zYBWdrkMun1VjtAcEZp.8o2hXhSpyxlw5Dm7gUaLZnaqhR3dJds7inwdj
 lgaBvkqw8dNX.EzXuD7i88W9xk3SDXtDIzuk9vPEKtcpz5.gukUpZc3y4Kc_L31ofoVUeu00LXOu
 MBvsMxthNFV1XosxBTTg14VTvCpueu.cU5shyMj3sOO.4PnKSQqEK4R7XOXD2WoDUFNVXUuFoH8H
 FGnk7SgI0WAFyqgAb7wuDtol3Wqq12qogzRsltq7jhtjv90yu1skyQLDB5fb7jU7QRb.tTlGc4Ix
 XCzrhZPZ37XlfMte5Qc2x.o2mY3ODD7dfM_KP8KkMlNAnyX87lBE0QzRxDu_BUU_tBdUeRFClXWr
 BEm5okgdyZVU7Cn1LLMQVeMeb2lmYzEPhkyz3YOwRr4S2TkhwwFlnQFAXm3du0Pl9NKBZeeoSzNi
 elH0Wg.wXDMSFpuTczgZAoOcgjrZPhQewjRVBaPR55DMaj3d4tnaTvXfl7ltrfg_8tshcO3XI_8w
 ypzCmemJOKmiDRXWOOYoTomcG8Fq7ZnEpJC1rP9DweY4yIrnZF6nT7N0xbTj6qQOdDBsk7KsoTg0
 zDUtqBr3RdwOrLaBV7ZCnkLV958ljlYMfwUXczFiuPkY9LfqyoL27Q10XxqhBK8eVslHz1Nu_Ew5
 uquYJ7ki0FG1e50_rfKvGmnCoSLIzyqjT3wylJRIlacWl18ncN6iGZO08dAKlnPGRfC8c_9IbOQS
 XQYhR_qtVRErCLOVYASY5Wd99zuyJ2FQqbStgwemmL5XoMXzeQ2If1HaVwPf.JL_mAYrDDssdr33
 FB8TqYzUolSNVuI.mk6W92Xgc_5A3G7.sf22Hdhaked8d4Idhe5FJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0b8226328c4965373e1d598ce42fc97b;
          Sun, 02 Jun 2019 16:54:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 53/58] kernfs: remove lsm_context scaffolding
Date:   Sun,  2 Jun 2019 09:50:56 -0700
Message-Id: <20190602165101.25079-54-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the parameters to kernfs_node_setsecdata from a
data/length pair to a lsm_context struct as both the function
it calls and the function that calls it want that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 4c7da446d210..d6e25cd7bf21 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -135,20 +135,15 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
+				  struct lsm_context *cp)
 {
-	void *old_secdata;
-	size_t old_secdata_len;
+	struct lsm_context old_context;
 
-	old_secdata = attrs->ia_context.context;
-	old_secdata_len = attrs->ia_context.len;
+	old_context = attrs->ia_context;
+	attrs->ia_context = *cp;
+	*cp = old_context;
 
-	attrs->ia_context.context = *secdata;
-	attrs->ia_context.len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
 	return 0;
 }
 
@@ -363,7 +358,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
+	error = kernfs_node_setsecdata(attrs, &lc);
 	mutex_unlock(&kernfs_mutex);
 
 	if (lc.context)
-- 
2.19.1

