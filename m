Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A0C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD8207FC
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pkk1vpxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfIRMzO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:55:14 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:40310 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfIRMzN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:55:13 -0400
X-EEMSG-check-017: 14918997|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="14918997"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568811311; x=1600347311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ydHt5IBy/oD+tvOin59ivJgw/zMq8yglkGKW98WMSvU=;
  b=pkk1vpxmTQ/IYnEW1U5aVazW8tMtXTd006Ql7xbzjUkGosopFk8O63ht
   st11YAmBO7zIgTWH9hFqXkmIU3LV0eS4NtjjeYna5RNTdlLsznFV7Qadw
   eLqQzM6s2SpxKYNhOZOMrc3ceFWErSLNZw5s41CcbWJwjAFuOHHjHP5uH
   Ndk+NFXqO+9cFbFSuqQB8e7iZwaev36tAZd7L2ByJU0OiH18zGJU0OMwf
   P39ajfbqB8B8f9mEJm2N7M3HRvKAeIqAEtzO4yOfLXLY/FXDbCkDorHFp
   HNeFLfu8S2ofh1HMkyKjuoU77hYKHypH8XtYhpB81TsKPHI22ILzKWZ9I
   w==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="32998420"
IronPort-PHdr: =?us-ascii?q?9a23=3AXX8xNhGV5yoJtqL048rSb51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zpM6wAkXT6L1XgUPTWs2DsrQY0rGQ6vCrBDJIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bKrXdFe+Vbzn5sKV6Pghrw/Mi98IN9/yhKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9YooT5olcDqwa1CwuxC+P10jJGhmH407A03e?=
 =?us-ascii?q?oiFg/J0wMuEskSvHnXttj5KL0fXfypwKTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiCxryO7CPr3gBJXNM3fCnaz/fb?=
 =?us-ascii?q?Zy9UFc0hA/zdNB6JJODLEOPvbzVlX2tNzCAR8zKxa0zPr/CNVhyoMeXnqCAr?=
 =?us-ascii?q?eDP6PPtV+F/fovLPORZI8RoTr9Lv8l5/n0jXAng1MSYa6p3Z5EIEy/S+xvPk?=
 =?us-ascii?q?GxeXPxhpIEFmAQs0w1S+m5pkeFVGtoe3uqX686rgo+AYaiAJaLEpuhm5SdzS?=
 =?us-ascii?q?y7GdtQfWkABVeSRyS7P76YUusBPXrBavRqlSYJAP38GoI=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAACyKIJd/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qgUAyKpQBAQEBBosqkSgJAQEBAQEBAQEBGxkBAgEBhD+DBSM3Bg4CDAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshTmCOimDIAFGgVGCYz+BdxSxeYVMgy+BSYE0AYcvhFkYe?=
 =?us-ascii?q?IEHhGGBDoQDhRYErHiCLIIukkkMG5kfAakoIoFYKwgCGAghD4MnUBAUgVoXj?=
 =?us-ascii?q?j4kAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Sep 2019 12:55:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICt9Gf018139;
        Wed, 18 Sep 2019 08:55:09 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: apply perltidy to infiniband test scripts
Date:   Wed, 18 Sep 2019 08:55:07 -0400
Message-Id: <20190918125507.10778-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The infiniband test scripts weren't compliant with perltidy so
make check-syntax was failing.  Fix it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/infiniband_endport/test | 2 +-
 tests/infiniband_pkey/test    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/test
index 0021e0d69af4..f071fbc18cf8 100755
--- a/tests/infiniband_endport/test
+++ b/tests/infiniband_endport/test
@@ -40,7 +40,7 @@ ok( $result, 0 );
 
 foreach (@denied_device_port) {
     @dev_port_pair = split( / /, $_ );
-    $result = system
+    $result        = system
 "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
 
     if ( $result >> 8 eq 0 ) {
diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
index 3ee4d13c8ffe..382c25913ca0 100755
--- a/tests/infiniband_pkey/test
+++ b/tests/infiniband_pkey/test
@@ -32,7 +32,7 @@ close($f);
 
 # The gid sysfs shows a fully expanded ipv6 address, just take the
 # top half.
-@tmp = unpack( '(a20)*', $gid );
+@tmp           = unpack( '(a20)*', $gid );
 $subnet_prefix = $tmp[0] . ":";
 
 @labeled_pkeys = split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS} );
-- 
2.21.0

