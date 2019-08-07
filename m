Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83627C41514
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593D5217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dih5+u/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfHGWnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:01 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:40778
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388681AbfHGWnA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217779; bh=6n13r+TGuRrCgC6xMf8Ht0oQXK5h6JL9/vz8UiExqsE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dih5+u/Jm+Ac74/E2AppKYjjX7+ve0FuWskbUkWQ3lDZpKvF7KUA+uEoyOsu6H6zP6ia1uaCvhmhS6rX7/KUZAcWFVA64MqPcLWv1NNAXDVWEwJ61q/wIkFDRdOvQ5rj6f44g5jfuJriCGy4cenHB6amgoc5ib6bo8/IVyn+zJvrIOI5cRt7KTNet3PKc8Fr1Cw32fjcRuVK20qcTChECdayMxf7GXjXY7TVboNWfZmY6m4Z64+YAwuFVUIptlA9WZXbJQuSGAJ3dNFs2nTpdb+KLMvxExL85VWBKoPoJtQGIF2yN2Ywgw6bj6mgXN44JNo+4QF8wYT/kejJ2bJeMg==
X-YMail-OSG: .EHJt2YVM1muOdznfEYeSKsASUwX6gwdyTRtbSqW2UshQydxm3R_2dHNuNReTlE
 7poA63lSPWvauqvHF5UsRbTzaa1ymAy6m89DepfLrTOYbh2x0JEH326uRahE1IAxnqU4wFPl06jk
 _wKj81FqsN1.v4.iUvp5oh8oem81e6CFdZEgZfkbpbd62dbV8YgFf1cU.yOhkYQnEs7YW8iQvZcc
 EdAoBp7tRIIWvMqQCzxAzLoCPt74__y5lZHnlGTkGlTTkBCB6eVhawAwKO4z1s8G6WiD7gDaWb_Y
 abHyj3YFO_GH0Qdx6eUpj0a4zbe7TihwW_kPGrP_YIcgjqVvMwrZcN5iplgejhB2Xw_de.dSiSHz
 NTM_I6I3TigZLzkp8EnC7jfPck_WnyUAQ1OlEAbeaH.8NJ7DAdf83w3Ld6.djEAyu6jRTwVDuWNJ
 yESPg9U8pLoeBtYG7BHpzR7ybo7sRSZaelpf4hfqgpKBA8KA1LqnsFouyop7Di.MAYydJxTdN9gy
 Au.H6u6HMltdjFpo_kngkwQR8FV_CJbzEqaB_CVn5NrT0Hp5eOTjPNuNkOGX4vRn1ufyKqIzPbjB
 UYTqgiGw2LVB8TtThyNx_Zft0HM0SQ2gl2wzZnG1DQhZBPs1xBt.iH1EacEraFFy6KrpdPwoQXd3
 XS89Jdij_Q.RILlv6qGQI7XM8GFEPYhihzOdZwTTKSfV6jSWAWFMgmiUB3QxbCJVj5qlKoPXVP3i
 ukaLUfidxhfO3XaIgREdtlpNjG._u04axz2LMhKJIgF0XVD7M_110BJ1j1QlB3LJlk5LcIsyIRd8
 0Ormim4tlpoSL5VsigU8iBgiFTJfDm87ZCVbJExQL3jrHbWnvpXddEQWEsMPhiby1dcqgz_nkWJF
 f7nMs0iU7l2EWkwJ6KG_YNC3YuOIMCwtyTJKSeFGKKxVoccH3OWjdTjfvK_LR.IPCmsiWxtVzqGK
 nMfF6sVzMbbhOKnc4CF9SdIKLPoLDyIGr_WDimZ2tqpJQwyKD_gNc8fybdkkmjO38D0mlbJ1yMiD
 ct54iUL_8rF8h.WLVz77kIMQBYJ0U0e2OEMWKuTTHD5VEzM8KcZMhy6p3nQKfIjQMAOAmY0qR_87
 l7xx8LCG8.0bNIrSvozMIHKklr_08lGdwJVrDBDM.h4drJ4rwoYjm5J2kkzP1Rw68TMCsuoHzFZJ
 _u1.evBCN_ZCX.FwpsGDPttfooaBMoOluh5LbuJ83JqvCExvqQaDIYXFwGy.wSHBVbawVakGHUqv
 QGSa96fgMJ9880D_jNgwJqxy3K6aY9DIsJXhziMXKBKQT87sjnS6e_Sd4mIpsNuZ_BbsJrpQN3Kz
 .0hGN8acU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:59 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a922c1f55dc5f6c930e3c4333b468534;
          Wed, 07 Aug 2019 22:42:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 04/16] LSM: List multiple security attributes in security_inode_listsecurity
Date:   Wed,  7 Aug 2019 15:42:33 -0700
Message-Id: <20190807224245.10798-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Listing security extended attributes is extended to the case
where there is more than one security module that provides them.
The same format used in other xattr list providers:
	name1\0name2\0name3
is used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index a58e60970035..87cb3562646b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1475,9 +1475,34 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
+	struct security_hook_list *hp;
+	bool first = true;
+	int finallen = 0;
+	int len;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, 0, inode, buffer, buffer_size);
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_listsecurity,
+			     list) {
+		len = hp->hook.inode_listsecurity(inode, buffer, buffer_size);
+		if (len < buffer_size) {
+			if (buffer)
+				buffer[len] = '\0';
+			buffer_size -= len + 1;
+		} else {
+			buffer = NULL;
+			buffer_size = 0;
+		}
+		if (first) {
+			finallen = len;
+			first = false;
+		} else
+			finallen += len + 1;
+		if (buffer)
+			buffer += len + 1;
+	}
+	return finallen;
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-- 
2.20.1

