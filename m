Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC56C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919D1206DD
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDTO3A convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:29:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:5599 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgDTO27 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Apr 2020 10:28:59 -0400
IronPort-SDR: kxynNrlfi2NiLAYnPoXGvEsqnw1rNEcaSJIoWjNyXntSj1T8elidTfYbXyIGUQZqWcZ9n6KMA8
 lNJp4hWoFFPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:28:59 -0700
IronPort-SDR: rFRpQdEf8EOzpA73Xuz/ujPe+DDEX2Eb2m06Et7oa2O4PoUoumix9cccp8IKXRhePaXkMQIfX+
 W/EQYDwoiDOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="246907898"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 07:28:59 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 07:28:58 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.116]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 07:28:58 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH 1/1] python/semanage: check rc after getting it
Thread-Topic: [PATCH 1/1] python/semanage: check rc after getting it
Thread-Index: AQHWFlL32UsRdfogH0KzuCPU/5nQ4aiCErGQ
Date:   Mon, 20 Apr 2020 14:28:57 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
References: <20200419140055.86159-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200419140055.86159-1-nicolas.iooss@m4x.org>
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
> Sent: Sunday, April 19, 2020 9:01 AM
> To: selinux@vger.kernel.org
> Subject: [PATCH 1/1] python/semanage: check rc after getting it
> 
> This issue has been found using lgtm.com:
> https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/4946f674a6da9cc3
> 68cc826f963aedd39b6a94cf/files/python/semanage/seobject.py?sort=name&dir
> =ASC&mode=heatmap#x5c052fffe98aee02:1
> 
> Fixes: 49706ad9f808 ("Revised Patch for local nodecon support in semanage (was:
> Adding local nodecon's through semanage)")
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/semanage/seobject.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 0e9ce2900892..f2a139c970bd 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1895,10 +1895,10 @@ class nodeRecords(semanageRecords):
>          (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
>          if rc < 0:
>              raise ValueError(_("Could not create key for %s") % addr)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if addr %s is defined") % addr)
> 
>          (rc, exists) = semanage_node_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if addr %s is defined")
> + % addr)
>          if exists:
>              raise ValueError(_("Addr %s already defined") % addr)
> 
> --
> 2.26.0

Acked-by: William Roberts <william.c.roberts@intel.com>

We should probably add the checker so it comments on the PRs. It would have caught it
Before it got in tree.

Completely unrelated, do you see these warnings?

swigging selinuxswig_python.i to selinuxswig_python_wrap.c
swig -python -o selinuxswig_python_wrap.c selinuxswig_python.i
../include/selinux/avc.h:414: Warning 302: Identifier 'avc_cache_stats' redefined (ignored),
../include/selinux/avc.h:394: Warning 302: previous definition of 'avc_cache_stats'.
../include/selinux/selinux.h:143: Warning 451: Setting a const char * variable may leak memory.
../include/selinux/selinux.h:378: Warning 451: Setting a const char * variable may leak memory.

I created a ticket, so I don't lose them:
https://github.com/SELinuxProject/selinux/issues/222


