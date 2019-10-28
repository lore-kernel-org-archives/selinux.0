Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575DCA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CDF21721
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 17:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="NA3GjMBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbfJ1RGj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:06:39 -0400
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:11815 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfJ1RGj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 13:06:39 -0400
X-EEMSG-check-017: 43873940|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="43873940"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2019 17:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572282397; x=1603818397;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=2lhjUq5K+nb3kfqvKpiM+xAhRwcynr56Px7OqzQAY/I=;
  b=NA3GjMBavY4cfMaoF3kDJZTft17VafLxbpWSSi4A9fhHOvTsK1fdSw6s
   F5349DVZv075Ovx0k58u5HlmtUzLB9fCrbllxA50BFDA14UBISElTGnrB
   lV+USmmtgDvXxN2rba0Ovb6uA0jtyFkNOvhnJ4ClaoUDatyJEeeFtbLP1
   X8ijrLV2tsVLtoIa/Ei+yaMKIacVO+EwPmiB/8RaPTCh75uIgxFg+wo6Z
   2Fet/+/i8itRVuiTbXGF9mcCIx7DLUxAw8QE1zTfCKl6zSyXjUlNlHozm
   TiU1mYkNt7mhmTu9MmUySwLJIQ8tDGV9QYvJxfPOz9GBVNb9sOsk3HBGS
   A==;
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="34767247"
IronPort-PHdr: =?us-ascii?q?9a23=3AEpPdphfIIqWtJcsHsBXthcgdlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW7YB7h7PlgxGXEQZ/co6odzbaP6OaxCCdRvN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twHcu80ZjYZmKqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jfkLfher?=
 =?us-ascii?q?N95FRHyAYp1dBQ+Y5UBasAIfPyXU/xst3YAwQiPAyzxObnFNF91oIYWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTEAL0q1Cp484TQyE8qeAJvKVJKqhr3JiD?=
 =?us-ascii?q?u7GZhffSZeB0yFA2XvcYSsUfALdCaTJIlqlTlSEfC6Rosg0wy+nBH1xqAhLe?=
 =?us-ascii?q?fO/CAc85X524tb/erWwCou+CR0AsLV6GSES2V5jytcXDMt9Lxuqkx6jFGY2O?=
 =?us-ascii?q?53hOIORo8b3O9ATgpvbc2U9Od9Ed2nH1uaL9o=3D?=
X-IPAS-Result: =?us-ascii?q?A2BOAADyHrdd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYFzLGxVMiqEKIgjhmJUBoERJYljjzaBewkBAQEBAQEBAQEjEQECAQGEQ?=
 =?us-ascii?q?AKDSiQ0CQ4CDAEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIxVRCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/AYJSBSCwGXWBMoVOgzuBSIEOKAGMDhh4gQeBOAyCK?=
 =?us-ascii?q?jU+h1WCPCIEljaXMoIugjOEXY4YBhuDLpYsjj+bQjmBWCsIAhgIIQ+DJwlHE?=
 =?us-ascii?q?BSDPokggQyDfiUDMIEFAQGPTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Oct 2019 17:06:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9SH6aPT006738;
        Mon, 28 Oct 2019 13:06:36 -0400
Subject: Re: [PATCH libselinux 1/2] libselinux/src/Makefile: don't use ln
 --relative option
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        selinux@vger.kernel.org
References: <20191025134304.12666-1-thomas.petazzoni@bootlin.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f942a0b3-de30-3043-2993-40be6cfc7910@tycho.nsa.gov>
Date:   Mon, 28 Oct 2019 13:06:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025134304.12666-1-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/25/19 9:43 AM, Thomas Petazzoni wrote:
> The ln --relative option is not available in fairly old versions of
> ln, which are still in use in older Linux distributions.
> 
> Since the two use of ln --relative can very trivially be implemented
> differently in libselinux/src/Makefile, let's do so.

This changes where the libselinux.so symlink is created (from LIBDIR to 
SHLIBDIR), and yields a broken build for make DESTDIR=~/obj install.  As 
a result, the travis build breaks.

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>   libselinux/src/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2b1696a0..dc675a49 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -170,12 +170,12 @@ install: all
>   	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>   	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> -	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> +	cd $(DESTDIR)$(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
>   
>   install-pywrap: pywrap
>   	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
>   	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
> -	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> +	cd $(DESTDIR)$(PYTHONLIBDIR) && ln -sf selinux/_selinux$(PYCEXT) _selinux$(PYCEXT)
>   
>   install-rubywrap: rubywrap
>   	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL)
> 

