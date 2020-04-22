Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2BFC54FCB
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723A220857
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDVVt7 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:49:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:27936 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgDVVt7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Apr 2020 17:49:59 -0400
IronPort-SDR: hyI/DJkGVECwsYdzjvcHMvLfH4oDCIVxk6NcSmFge/ThAUdBJhaVfMNWdaQHkqFNhTMc3FX0RV
 /lNI6BL2k/gA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:49:58 -0700
IronPort-SDR: 4R/qk0BkWtV4zPfC7+J4rmgYB1lGxsjF/jbe454SsfnXn8xj7UafPoSYJ5TopNq8ZCCuYb1uB3
 MCpPMzbApprw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="280177830"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2020 14:49:57 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 14:49:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.248]) with mapi id 14.03.0439.000;
 Wed, 22 Apr 2020 14:49:57 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     'Nicolas Iooss' <nicolas.iooss@m4x.org>,
        "'selinux@vger.kernel.org'" <selinux@vger.kernel.org>
Subject: RE: [PATCH 1/1] python/semanage: check rc after getting it
Thread-Topic: [PATCH 1/1] python/semanage: check rc after getting it
Thread-Index: AQHWFlL32UsRdfogH0KzuCPU/5nQ4aiCErGQgAOgisA=
Date:   Wed, 22 Apr 2020 21:49:57 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED498C@ORSMSX101.amr.corp.intel.com>
References: <20200419140055.86159-1-nicolas.iooss@m4x.org>
 <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
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
> From: Roberts, William C
> Sent: Monday, April 20, 2020 9:29 AM
> To: Nicolas Iooss <nicolas.iooss@m4x.org>; selinux@vger.kernel.org
> Subject: RE: [PATCH 1/1] python/semanage: check rc after getting it
> 
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org
> > [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Nicolas Iooss
> > Sent: Sunday, April 19, 2020 9:01 AM
> > To: selinux@vger.kernel.org
> > Subject: [PATCH 1/1] python/semanage: check rc after getting it
> >
> > This issue has been found using lgtm.com:
> > https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/4946f674a6
> > da9cc3
> > 68cc826f963aedd39b6a94cf/files/python/semanage/seobject.py?sort=name&d
> > ir
> > =ASC&mode=heatmap#x5c052fffe98aee02:1
> >
> > Fixes: 49706ad9f808 ("Revised Patch for local nodecon support in semanage
> (was:
> > Adding local nodecon's through semanage)")
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  python/semanage/seobject.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 0e9ce2900892..f2a139c970bd 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -1895,10 +1895,10 @@ class nodeRecords(semanageRecords):
> >          (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
> >          if rc < 0:
> >              raise ValueError(_("Could not create key for %s") % addr)
> > -        if rc < 0:
> > -            raise ValueError(_("Could not check if addr %s is defined") % addr)
> >
> >          (rc, exists) = semanage_node_exists(self.sh, k)
> > +        if rc < 0:
> > +            raise ValueError(_("Could not check if addr %s is
> > + defined") % addr)
> >          if exists:
> >              raise ValueError(_("Addr %s already defined") % addr)
> >
> > --
> > 2.26.0
> 
> Acked-by: William Roberts <william.c.roberts@intel.com>
> 
> We should probably add the checker so it comments on the PRs. It would have
> caught it Before it got in tree.
> 
> Completely unrelated, do you see these warnings?
> 
> swigging selinuxswig_python.i to selinuxswig_python_wrap.c swig -python -o
> selinuxswig_python_wrap.c selinuxswig_python.i
> ../include/selinux/avc.h:414: Warning 302: Identifier 'avc_cache_stats' redefined
> (ignored),
> ../include/selinux/avc.h:394: Warning 302: previous definition of
> 'avc_cache_stats'.
> ../include/selinux/selinux.h:143: Warning 451: Setting a const char * variable may
> leak memory.
> ../include/selinux/selinux.h:378: Warning 451: Setting a const char * variable may
> leak memory.
> 
> I created a ticket, so I don't lose them:
> https://github.com/SELinuxProject/selinux/issues/222
> 

Merged:
https://github.com/SELinuxProject/selinux/pull/223
