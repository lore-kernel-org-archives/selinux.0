Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7D6C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596E820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="esdE+WiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfB1WU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:27 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:45789
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731915AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=d2yi6kashfnbxR/7bzB8UE4jUy5Q3Uozsr8ymRFgpzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=esdE+WiDA4RzoQUeABPp42ZoPlN/z0LAUF7mFhLVwVYGJ+vs079GBNzrmej5QKa5b9tfeJTfjTE4UJpiYlU5SpD/lr8E2L9iPl3wjM2bkPyaCcMMzNpshS3bLL4l3xsAHVCE0IsR7dEO0/88FS+fIVz2yLAekpS3CNUvEYhn56D6qBKnzwe7S/TzcQomEls9wXvON3aTzqDRNyN1KCoDx4UB4n+HF/Kzl5ABu5MWbR/4MSYuMpb8MaDvd5u7tEvH7c+uOir8yxEB1yLgQ5YkfgQeKk2fZ/h8ZduXygZSyWOOnvldY2qY1t2zkh4tBrHC0HNnokPSVjsd0eSefrBWEw==
X-YMail-OSG: xDCnwuEVM1kdFQHyrt2rMiHX2elhodWSgnFHlCQjvOh8LfzZrMLWhMDPJ2j5W4g
 sDn1J4LlntfmnagvGMZAY4e3XJRU15vHt3Ubfl5DbemyaHgxPtB4S88zozfYBgf.oEmUekcoCBg1
 s0iet0qWCpqb65Cy9KzKLjrydztPXjfZjse5gUQnTQMm3Xre8BPskIxP6loJ.oOsdtXdXHdiR4AW
 _vVIhz1qlc2qIuxCD9BC62AnnaZuUeQB1OPn5rDcNMz4KrwetaoeSMDMb2sJ9t2ldH74a6qTI0eV
 ry6s4iG8bCNo1QmMxUDu7oZvj0jdK7XvjfW21n52m9uR2WBaLI8nwNScq1WbxNIWbGYm0HrAMe9H
 WNjQNd6_rED9qms8K.1jSefvr0.ZyaIn3Yzj28gaQ7nQSnfgkSOp1uIXyFd.QlBKrMDzVR5RagHo
 xRg6okVFBI33aZMYrxauOElJby7Mvytj.TneAXHFOLzUftq0nmpGUzRu.bC0YAwnZ_v35CGoO6Rb
 CcL1SPcgwBiUeiBC6qHPRWnItykS47vDEndaZDro6gcz_fwsWGUJLX6ckFxBfMFcyNjnmNHvhgBF
 E7AYxCngjki5N0VDzeX1u6RanGiS0393nch0BiGSZ4Z.YOYJ9cX5D3Ylg4ZbGL._yBsfYMI2vuh0
 mGNdWVHQoxTOktPKN.aexOS1YSVqsdYO4IKcEoJO0N.Ebnzor7dgo1zKTSYfwKsSadSK95hqJQHj
 fQeZF0.s4vXZ5VTMAs.Un_pYNUW0TlGFBtX8x52SNW8XAbQqqWHiGcgbvYz1t22QZ4AdRgwq6hln
 ARS9FcVyowDzITQgVW5Rz6wvL2a4G3YrYodCagGLjCtDaqi24UoZ.7isbil41GXTlq_CzW7BuXoU
 82qdtPsuYLHwc5IVbln7qZWm.8.0tfaXp0xIZBZ2L6pbmMsv1BEsZBQm.d3E4G9FXbc838A1aBDK
 LQT789kzjsRB0FSgUIlupGg_SpMt3xWYRXeHbyT8xVGmbbbeyfzA1QcVY5ga5S4WGlC7R1YUcNKi
 UKQdVSub8qoGJWuhuahlt9h1Z7DU5V2FcizmUQFP56xN8or9r0hypPIBMzaIpAFtkBiK69BOHDjn
 wG01e.xfZncJ7Kg6L0EvT9.AY._Kr9tY_7KXO4MKskg62Nj7n
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 66/97] LSM: Add secmark_relabel_packet to the set of one call hooks
Date:   Thu, 28 Feb 2019 14:19:02 -0800
Message-Id: <20190228221933.2551-67-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secmark_relabel_packet hooks are dependent on the results
of secctx_to_secid hooks. Add secmark_relabel_packet to the set
of one call hooks, as the secid use will always match the
LSM providing the secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  1 +
 security/security.c       | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fc2a44e04d8e..e76e5cd05180 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2028,6 +2028,7 @@ struct lsm_one_hooks {
 	union security_list_options secid_to_secctx;
 	union security_list_options secctx_to_secid;
 	union security_list_options socket_getpeersec_stream;
+	union security_list_options secmark_relabel_packet;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 1259b3f50066..024601db215e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -469,6 +469,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		else if (hooks[i].head ==
 				&security_hook_heads.socket_getpeersec_stream)
 			lsm_base_one.socket_getpeersec_stream = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.secmark_relabel_packet)
+			lsm_base_one.secmark_relabel_packet = hooks[i].hook;
 		else
 			continue;
 		if (lsm_base_one.lsm == NULL)
@@ -2018,6 +2021,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		union security_list_options secid_to_secctx;
 		union security_list_options secctx_to_secid;
 		union security_list_options socket_getpeersec_stream;
+		union security_list_options secmark_relabel_packet;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
@@ -2053,6 +2057,17 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 				break;
 			}
 		}
+		secmark_relabel_packet.secmark_relabel_packet = NULL;
+		hlist_for_each_entry(hp,
+				&security_hook_heads.secmark_relabel_packet,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secmark_relabel_packet = hp->hook;
+				found = true;
+				break;
+			}
+		}
 		if (!found)
 			return -EINVAL;
 
@@ -2071,6 +2086,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		loh->secid_to_secctx = secid_to_secctx;
 		loh->secctx_to_secid = secctx_to_secid;
 		loh->socket_getpeersec_stream = socket_getpeersec_stream;
+		loh->secmark_relabel_packet = secmark_relabel_packet;
 
 		return size;
 	}
@@ -2317,7 +2333,7 @@ EXPORT_SYMBOL(security_inet_conn_established);
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
+	return call_one_int_hook(secmark_relabel_packet, 0, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
-- 
2.17.0

