Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB7BCA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508D420731
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgELTkZ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:40:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:13683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgELTkY (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 12 May 2020 15:40:24 -0400
IronPort-SDR: /cYVNVRl/6nz/pPqii+kZ08yStXwpTNIAdtepMG3oFS+KuoN5Hlur95Z+4WtzD6nVjZeXAC8+z
 XZRqlbUfpi9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 12:40:23 -0700
IronPort-SDR: 0nnZPglaRmCV4bhYZ0KXtF51IRfQBM+nWkN3HcQ8q59jKSSKXXfwXY45efUeYv94jCi8NPGFcf
 cebl/EJYf0hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="251004456"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 12:40:23 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 12:40:23 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.195]) with mapi id 14.03.0439.000;
 Tue, 12 May 2020 12:40:23 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] python/sepolicy: silence new flake8 warnings
Thread-Topic: [PATCH] python/sepolicy: silence new flake8 warnings
Thread-Index: AQHWKJPCxPjO2rhkUUGMuZom8AeJIqik2Mpg
Date:   Tue, 12 May 2020 19:40:22 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EDD4EF@ORSMSX101.amr.corp.intel.com>
References: <20200512192957.112866-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200512192957.112866-1-nicolas.iooss@m4x.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
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
> Sent: Tuesday, May 12, 2020 2:30 PM
> To: selinux@vger.kernel.org
> Subject: [PATCH] python/sepolicy: silence new flake8 warnings
> 
> pyflakes 2.2.0 improved the way format strings are analyzed, which triggers new
> warnings in flake8:
> 
>     python/sepolicy/sepolicy/manpage.py:1046:23: F999 '...' % ... has
>     unused named argument(s): type
> 
>     python/sepolicy/sepolicy/manpage.py:1225:23: F999 '...' % ... has
>     unused named argument(s): user
> 
> Remove the unused arguments in order to silence these warnings.
> 
> This fixes failures in Travis-CI such as
> https://travis-ci.org/github/SELinuxProject/selinux/jobs/686230518#L5153
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/sepolicy/sepolicy/manpage.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/manpage.py
> b/python/sepolicy/sepolicy/manpage.py
> index 442608191cc8..3e8a3be907e3 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -1074,7 +1074,7 @@ If you wanted to change the default user mapping to
> use the %(user)s_u user, you
> 
>  .B semanage login -m -s %(user)s_u __default__
> 
> -""" % {'desc': self.desc, 'type': self.type, 'user': self.domainname, 'range':
> self._get_users_range()})
> +""" % {'desc': self.desc, 'user': self.domainname, 'range':
> +self._get_users_range()})
> 
>          if "login_userdomain" in self.attributes and "login_userdomain" in
> self.all_attributes:
>              self.fd.write("""
> @@ -1245,7 +1245,7 @@ Execute the following to see the types that the SELinux
> user %(type)s can execut
> 
>  .B $ sesearch -A -s %(type)s -c process -p transition
> 
> -""" % {'user': self.domainname, 'type': self.type})
> +""" % {'type': self.type})
> 
>      def _role_header(self):
>          self.fd.write('.TH  "%(user)s_selinux"  "8"  "%(user)s" "mgrepl@redhat.com"
> "%(user)s SELinux Policy documentation"'
> --
> 2.26.2

I just hit this issue in the CI, good timing.

Acked-by: William Roberts <william.c.roberts@intel.com>
