Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A30C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5441D206DD
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDTO0G convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:26:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:55418 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTO0F (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Apr 2020 10:26:05 -0400
IronPort-SDR: QEggjBIvtgk3OVaYgOGpgnUmkqWjerNqbGtJqTZHBChjfLuqCiJO4C4xGXvFVMP7zA7e9KDbIo
 SVdXf/q2rwtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:26:05 -0700
IronPort-SDR: 6Sa935ms/6ovKvXvUOSBnG80t3lzx3a2DKodlkPbElih9c6d0fcKuV9VQuytgZBkDzCOA5e4eF
 QhxnX77rzbjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="365019691"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2020 07:26:04 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.107]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 07:26:04 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH 1/1] libselinux/utils: remove unneeded variable in
 Makefile
Thread-Topic: [PATCH 1/1] libselinux/utils: remove unneeded variable in
 Makefile
Thread-Index: AQHWFlKvuPtUkMnC20GRXGKiqlE0q6iCEnmg
Date:   Mon, 20 Apr 2020 14:26:03 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED3B5C@ORSMSX101.amr.corp.intel.com>
References: <20200419135852.85888-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200419135852.85888-1-nicolas.iooss@m4x.org>
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
> On Behalf Of Nicolas Iooss
> Sent: Sunday, April 19, 2020 8:59 AM
> To: selinux@vger.kernel.org
> Subject: [PATCH 1/1] libselinux/utils: remove unneeded variable in Makefile
> 
> LD_SONAME_FLAGS is not used when building libselinux utils.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/utils/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> a5632b7c38ec..b018a08acbe0 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -36,8 +36,6 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-
> security -Winit-self -Wmissi
>            -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-
> overflow=5 \
>            $(EXTRA_CFLAGS)
> 
> -LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
> -
>  ifeq ($(OS), Darwin)
>  override CFLAGS += -I/opt/local/include -I../../libsepol/include  override
> LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
> --
> 2.26.0

Acked-by: William Roberts <william.c.roberts@intel.com>
