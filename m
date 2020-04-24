Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B9C55196
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC5B20736
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDXTqP convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:46:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:8629 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgDXTqN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Apr 2020 15:46:13 -0400
IronPort-SDR: 6aHI0K6XFw1ASHPyFLSsuGgOnE4/bmssp7UP3ExYIUVb/PmQTB9HC1wKt5/4FSVG/oxxISzraR
 ZXkkmuD+1dSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 12:46:13 -0700
IronPort-SDR: xXolYjbgg7WNrZDtl5sfMt8Z/xD+r4wwfDPufdcK7FGi+YMYEpwxgKW+RUO04AL9QsyHufx5W0
 tt5EERfgc/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="256491867"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2020 12:46:12 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.249]) with mapi id 14.03.0439.000;
 Fri, 24 Apr 2020 12:46:12 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] python/semanage: Use ipaddress module instead of IPy
Thread-Topic: [PATCH] python/semanage: Use ipaddress module instead of IPy
Thread-Index: AQHWGkkOu5/vbD973ES9vBgUW8pJgqiIrShA
Date:   Fri, 24 Apr 2020 19:46:12 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED77DF@ORSMSX101.amr.corp.intel.com>
References: <20200424145941.242949-1-plautrba@redhat.com>
In-Reply-To: <20200424145941.242949-1-plautrba@redhat.com>
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
> On Behalf Of Petr Lautrbach
> Sent: Friday, April 24, 2020 10:00 AM
> To: selinux@vger.kernel.org
> Cc: Petr Lautrbach <plautrba@redhat.com>
> Subject: [PATCH] python/semanage: Use ipaddress module instead of IPy
> 
> ipaddress python module was added to standard library in Python 3.3 -
> https://docs.python.org/3/library/ipaddress.html
> 
> seobject.py was the only consumer of IPy module so this dependency is not
> needed anymore.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  python/semanage/seobject.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index f2a139c970bd..c89c67e491b6 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -32,7 +32,7 @@ from semanage import *  PROGNAME = "policycoreutils"
>  import sepolicy
>  import setools
> -from IPy import IP
> +import ipaddress
> 
>  try:
>      import gettext
> @@ -1860,13 +1860,13 @@ class nodeRecords(semanageRecords):
> 
>          # verify valid combination
>          if len(mask) == 0 or mask[0] == "/":
> -            i = IP(addr + mask)
> -            newaddr = i.strNormal(0)
> -            newmask = str(i.netmask())
> -            if newmask == "0.0.0.0" and i.version() == 6:
> +            i = ipaddress.ip_network(addr + mask)
> +            newaddr = str(i.network_address)
> +            newmask = str(i.netmask)
> +            if newmask == "0.0.0.0" and i.version == 6:
>                  newmask = "::"
> 
> -            protocol = "ipv%d" % i.version()
> +            protocol = "ipv%d" % i.version
> 
>          try:
>              newprotocol = self.protocol.index(protocol)
> --
> 2.26.0

LGTM
<Reviewed-by: William.c.Roberts@intel.com>

I can give it an acked by if you give me testing steps.

