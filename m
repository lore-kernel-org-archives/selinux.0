Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6893C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A121736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Re7C7IxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDSAsq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:46 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:36046
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfDSAsq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634924; bh=j4aETVrf26rqIvvvKKp8/4QjDq2yhMOHprRedhXorzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Re7C7IxAY7CN2uDVEzC7pVgD+FeBikIfBGHn3WZ6t4BdqkGAcHtJRTRZuZz0+u5MbR7Ec2U6teMq3VabbGXVba/s/sLi5amWpviv5SS732q1YL2qe5tJ0GX+RsK8yfOxXH3BMMmPhMVefTEzyV4lgCYp9YZg//FI2NGSNWGvJHCroGGHuCcqLHE50OzLwq0ZpuFCWFNNqXeVg0WbxJ/6pU0cPGI/oWIUHj4T3WmSkg69O3k+Yhu852Alp1/ZyZj47KnXbCNeEe/TWAPglaMo+ThVxHhou80ja/2uEIVEJGPlpEWakK43C6DSHJVLfFq6VX3LI6jPjswwlcl7R0y7kg==
X-YMail-OSG: uWIX0pcVM1nkkPjxqKDAABlub7KxatRIV4QoYQqu6FRNeMe_JU75pbMvLtPLhen
 bqgfOXop86q9ZkVlLUQHczW768NbXAgfiYFij0JMTqBIOB66mw9Rs57ZWbsBMIgxeYLgQfW0ZhLL
 fbTM5yPHUOcAsUNDDeQSciHDVS7Rir1uo30Ru3Bi3VjYMkujNNS.eigtLJfIaalYA7bDkiOc5sEC
 SYdcTAqGiqY2nRt_qBtKN9KhL9UccAmShEhP3tsap8DX1bv5tQwWeHUU7ltELvKfZdJZYExXwmiA
 8dSxOepP9uboJaSVtuBS3K9SMQLeRraYIi.LsXIIPhSi3hXlZELK_b3h.tXHn.u5Uf.ZrcA63Dkx
 F55CEiN2_BzRFlunZZ9PcKZvr09Kav_cCL5tgkof8I8yjE..f8Omyu1DxT2HAZ7xfkwaGiAtyxcN
 3vfjFF4jb38n5h7gfrbsM9Mf5HyjmmvjyBNe3sYGnO0KPTHsfIpu4LNdo9p0kEW9LegkxaucmvYt
 fjE8LvnbZvASw8gwhPl2FMqKNUSYlJMIHiS3IOulHSHBQz0UQurhi.1r_jNutxkCOoUTJ12epu7G
 vvc2zSuH4AXfDoYE76LIYJJYrVvdY7wDy0Xf0UzEzmEfdmKbG2832cnBmDFB.eDb3UqlUUNwHFeJ
 VSLKGH11KoRTtOjmWcoZiX0J4EhetLptN6AkB7VG23z77sndtTnyvVJO_Rw5JPRQToYzMOEY6IUx
 y4k2ht9jkNksNI7H6UylUzEX_be0Fb1SQ7TY35z0YQLCCOsf.PlELuNXL6lcshmco3YrTIna7AXJ
 wabN2MKcqfn5CK6LNHVl.mPs.tDjQzEhIOe1jfu7r8ywKsZU2A.CJj_k9Py3qd26_XbPtXgdbMwP
 Jb4MgSeCm9.eap76456Uizkf.4l9Mx4U0cGGBzFzXvMXjTopUHl_bqDt5cvydl9WFrijwd9Y.6pZ
 1oGrF4keEqrb1zT8mxP4Naxt787CfyRz_ZlCx2fn4IZGDXRt24JG51nakeXO.98cAc5VWZWPxRyq
 fbkJQjHFtiElXFjcpNJXd87Dvhzd3DDz7.6B5YglpfeDmLJbPmoxoKeJ_oH0JRMYycs.W7xgOOHB
 hm0Xr2_q_qKCJV145f0ePu5YpUKjfb4E83p0AK4rlXAomkrszBaurm.pYwi7lw36gmqGK5lHlVeK
 JT4wEvBIh1BUb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33cedab91c06b09a1d8646eb41267569;
          Fri, 19 Apr 2019 00:48:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 60/90] LSM: Add secmark_relabel_packet to the set of one call hooks
Date:   Thu, 18 Apr 2019 17:45:47 -0700
Message-Id: <20190419004617.64627-61-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 0653f295897a..711f9b3eb265 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2048,6 +2048,7 @@ struct lsm_one_hooks {
 	union security_list_options secid_to_secctx;
 	union security_list_options secctx_to_secid;
 	union security_list_options socket_getpeersec_stream;
+	union security_list_options secmark_relabel_packet;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 4af99077572d..f99845aae595 100644
--- a/security/security.c
+++ b/security/security.c
@@ -456,6 +456,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		else if (hooks[i].head ==
 				&security_hook_heads.socket_getpeersec_stream)
 			lsm_base_one.socket_getpeersec_stream = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.secmark_relabel_packet)
+			lsm_base_one.secmark_relabel_packet = hooks[i].hook;
 		else
 			continue;
 		if (lsm_base_one.lsm == NULL)
@@ -2006,6 +2009,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		union security_list_options secid_to_secctx;
 		union security_list_options secctx_to_secid;
 		union security_list_options socket_getpeersec_stream;
+		union security_list_options secmark_relabel_packet;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
@@ -2041,6 +2045,17 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
 
@@ -2059,6 +2074,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		loh->secid_to_secctx = secid_to_secctx;
 		loh->secctx_to_secid = secctx_to_secid;
 		loh->socket_getpeersec_stream = socket_getpeersec_stream;
+		loh->secmark_relabel_packet = secmark_relabel_packet;
 
 		return size;
 	}
@@ -2305,7 +2321,7 @@ EXPORT_SYMBOL(security_inet_conn_established);
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
+	return call_one_int_hook(secmark_relabel_packet, 0, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
-- 
2.19.1

