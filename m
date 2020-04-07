Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E77C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2904B20748
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDGU1N convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 7 Apr 2020 16:27:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:50498 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGU1N (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 Apr 2020 16:27:13 -0400
IronPort-SDR: bmUwuqZGvzvAD2TUi3DwVSLzEIjWhQXcML7LlHXztrHfSQ7GVDFrVuKrqOHMPLqMz/g53UR8rg
 AWLh5QOnso0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 13:27:13 -0700
IronPort-SDR: msxL9aYDGRrfvMNfRlViTVgQQ2fsk4qx0LSpOae3wW4Y9Nyw3hOBVowll8RDht0UpKTL2dEI+H
 bJ9Gkfu0t2jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="242170124"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga007.fm.intel.com with ESMTP; 07 Apr 2020 13:27:12 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 13:27:12 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.225]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.204]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 13:27:12 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     "aduskett@gmail.com" <aduskett@gmail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH 1/1] fix building against musl and uClibc libc libraries.
Thread-Topic: [PATCH 1/1] fix building against musl and uClibc libc
 libraries.
Thread-Index: AQHWDQxUJypi840W/ki7b0jYXJYVf6huGuoA
Date:   Tue, 7 Apr 2020 20:27:11 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
References: <20200407184239.2700998-1-aduskett@gmail.com>
In-Reply-To: <20200407184239.2700998-1-aduskett@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> -----Original Message-----
> From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> On Behalf Of aduskett@gmail.com
> Sent: Tuesday, April 7, 2020 1:43 PM
> To: selinux@vger.kernel.org
> Cc: Adam Duskett <Aduskett@gmail.com>
> Subject: [PATCH 1/1] fix building against musl and uClibc libc libraries.
> 
> From: Adam Duskett <Aduskett@gmail.com>
> 
> Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
> or uClibc. However, this is missing from utils/Makefile, which causes linking to fail.
> 
> Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
> compiling against uClibc and musl.
> 
> Signed-off-by: Adam Duskett <Aduskett@gmail.com>
> ---
>  libselinux/utils/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> 36150638..a5632b7c 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -45,7 +45,7 @@ endif
> 
>  override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS)
> $(PCRE_CFLAGS)  override LDFLAGS += -L../src -override LDLIBS += -lselinux
> +override LDLIBS += -lselinux $(FTS_LDLIBS)
>  PCRE_LDLIBS ?= -lpcre
> 
>  ifeq ($(ANDROID_HOST),y)
> --
> 2.25.1

If you want me to use the PR you have open, force push your branch to update the commit
message. Else I'll have to create a new-pr and close your old one.

Your open PR is here:
https://github.com/SELinuxProject/selinux/pull/193

Something like:
git pull --rebase origin master
git push aduskett HEAD:fix-musl-and-uclibc-builds

would be ideal.

Acked-by: William Roberts <william.c.roberts@intel.com>
