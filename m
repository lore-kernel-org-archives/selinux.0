Return-Path: <SRS0=YZSI=MQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CA1C64EB8
	for <selinux@archiver.kernel.org>; Thu,  4 Oct 2018 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32F52084D
	for <selinux@archiver.kernel.org>; Thu,  4 Oct 2018 19:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJECjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:39:13 -0400
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:3871 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727506AbeJECjN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Oct 2018 22:39:13 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 22:39:13 EDT
X-EEMSG-check-008: 149729074|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Oct 2018 19:34:53 +0000
X-IronPort-AV: E=Sophos;i="5.54,341,1534809600"; 
   d="scan'208";a="19067105"
IronPort-PHdr: =?us-ascii?q?9a23=3ATrGcSxSQTb+TJewnQMSjz5XoNNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69YxSN2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4ahuSB/wlCcGNyMy/3rQisNtjKNQvRatqhxjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQWwCwmxCu3sxDFHiHD50rE13e?=
 =?us-ascii?q?k6DQHL3hYtE84SvHnartj4MroZX+CvzKnPyDXOd+5Y2Svj54jQchAuv/eMVq?=
 =?us-ascii?q?9tf8rU00YvEwfFgUuQqIf4OD6VzfkCs3OA4up8VeOgl24nqwZrrjip3ccjkJ?=
 =?us-ascii?q?PFho0SylDa7Ch0xps+K96gSENjfNKpH5RduzuaOodrWM8uXW5ltDggxrEbv5?=
 =?us-ascii?q?OwYTIEx449xxHFbvyKa42I4hX+W+mPOTp4n3dleK6nhxa17Eig1vXwVsmq31?=
 =?us-ascii?q?ZOqSpIisXMuWoX1xzS98iHUeFx/luh2DmT1wDT7ftIIUYomqrAN5Et2Lswlp?=
 =?us-ascii?q?sXsUjbHy/2nlv5jLOOe0k59eWl5P7rb7X7qpOGKYN5hR/yPr4zlsCnBOQ3KA?=
 =?us-ascii?q?kOX2yV+eSm073j+FX0QK5Xgf0tiaTZrJDbKtgbpq6+GQNV1J0j5AylAzep19?=
 =?us-ascii?q?QYg2ELLEhZdxKfk4jpJ1bOLejjDfihh1SskTFrx+3JP7D6HJXNIWbMkK37cb?=
 =?us-ascii?q?Z+9UFc0gwzws5b555ODbEBOv3zCQfNs4nDAxs4NRGk6/joBc871Y4EX2+LRK?=
 =?us-ascii?q?iDP/D8q1iNs9kzLvGMaYldgzP0L/wo9ra6lnMisUMMdqmum50MYTa3GeowcB?=
 =?us-ascii?q?bRWmblntpUSTRChQE5VuG/0wWP?=
X-IPAS-Result: =?us-ascii?q?A2D8AwC2arZb/wHyM5BbHAEBAQQBAQcEAQGBZYFcKoFlh?=
 =?us-ascii?q?ByBRpJvTgEBAQEGgRCJE49YESAYAYQ2hDEhOBYBAwEBAQEBAQIBbCQEgjYMg?=
 =?us-ascii?q?xcKFXYCJgJsCAEBgl4/gXUNpRCBLoRAN4UagQuGA4QeF3mBB4E5DIgqgjSCV?=
 =?us-ascii?q?wKOWo59CZA6BheBPQEOhGKJPZc4IYFVKwgCGAghD4MokG8jgSsBAYxMAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Oct 2018 19:34:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w94JYpqs007907
        for <selinux@vger.kernel.org>; Thu, 4 Oct 2018 15:34:51 -0400
To:     selinux@vger.kernel.org
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Testing, please disregard
Message-ID: <70b9f419-4717-8573-a46e-f4d805a37e9d@tycho.nsa.gov>
Date:   Thu, 4 Oct 2018 15:36:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


