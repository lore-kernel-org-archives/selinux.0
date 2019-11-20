Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35958C432C0
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D4522519
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LBy6pbPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfKTNHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:07:48 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:18577 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbfKTNHs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Nov 2019 08:07:48 -0500
X-EEMSG-check-017: 28526938|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,221,1571702400"; 
   d="scan'208";a="28526938"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2019 13:06:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574255193; x=1605791193;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=hMRG4PAgrFeFG8ZsskyYjAuEDlQPc6Oj3rf/SbgB1Bw=;
  b=LBy6pbPoei5INhg/iwjcGpCHihwKgmHLL9wRQsRuegwTUGl0kQf58hRO
   Ap0SAbPuYGPqT8fNjgwTZ2AC4JF/C1XJuXhVk7DDFOnyL9HUkXVcBzFbK
   BHd+4hrOTrzJpN+y+RwICpqqgCd7TYOWsM1Kh5DNWlMseDJMLvt+dyVnG
   BQ3J1o2rERgNxKHQCD1yoMNgx2PchPajwJReBrJSQMmSvcuQb06Pz07pL
   gsIxiIASkyE31UTc3GUgWFksnh1Ie2HQX4dB7JRKeqVCmde5teY+8Kw+e
   0TLGSBTvb0iylCGBc41gc/pUUa0dFsXo5dPcD95iiCVMhn507rvFr5NjY
   g==;
X-IronPort-AV: E=Sophos;i="5.69,221,1571702400"; 
   d="scan'208";a="35763377"
IronPort-PHdr: =?us-ascii?q?9a23=3AI0a8AhOITnwWKOtwLVIl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/n/rarrMEGX3/hxlliBBdydt6sfzbOL6+u8BCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAXNusUZjoZvKrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1cQqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjYCgK0o4oxwDea/ycaoSH/hPjWPyWITdii3JpYKq/hhau8Uigze38UNO40F?=
 =?us-ascii?q?FQripKlNTHq3MD1wTL58SaRfZw8V2t1DaS2wzJ9O1JLl44mbDGJ5Mn37U+jI?=
 =?us-ascii?q?AcsV7ZES/zgEj2iaiWeVg69eWw8OTnZ6nmpoebN49plgHyKqQuldK7AeQ/Kg?=
 =?us-ascii?q?UOQ3KU+f691L3+5k31WqlKj/0qnanZt5DWP8IbqbKiAwBJyIoj7he/DzO+3N?=
 =?us-ascii?q?QZm3kIMk5FdQqag4XmNFzCOvD1Aeqlj1iynzpn2erKMqD5DpXINHfDkbPhfb?=
 =?us-ascii?q?hn605bzQo+1ctf6I9PCrwaPPLyWlP+tNzfDhMjNQy02PzoBM9y1oMZR2KDGr?=
 =?us-ascii?q?WZP7/KsV+U+uIvJPGBZJcRuDnnNvgl++TugmQjllIGZ6mmw4YYaHCiEfR6OU?=
 =?us-ascii?q?mWfX3sgtIZG2cQogU+VPDqiEGFUTNLfHa9QaY85jA9CIK7AobOXZ6tgLOf0y?=
 =?us-ascii?q?ehBJFWZX5JCkqKEXj2c4WIQfAMaDidIpwprjtRbbW9UccF3AyyrgXzwLovev?=
 =?us-ascii?q?LQ8zAEr5jq/MJ46+3aiVc58jkiS4yG3mWMSXxktn0HSiVw361lp0F5jFCZ3v?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXRVZE=3D?=
X-IPAS-Result: =?us-ascii?q?A2CmGgBNOdVd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsgQcqhCqPAVQGgTaBYIgGkUMJAQEBAQEBAQEBKwkBAgEBhEACgickOBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYJSJQ+wRYEyhE1BQIM3gUiBDiiMFRh4gQeBOIJrPoJohG2CXgSWXkaXC?=
 =?us-ascii?q?oI1gjeEY44vBhuDMZZjjkiIOJNlIoFYKwgCGAghD4MnCUcRFI9NhV0jAzCBB?=
 =?us-ascii?q?QEBji4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 20 Nov 2019 13:06:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAKD6UMa024366;
        Wed, 20 Nov 2019 08:06:30 -0500
Subject: Re: [PATCH] Travis-CI: Drop Python 2 from matrix
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191119104326.1572146-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cdbd96fa-004f-e395-373b-1a9b41e92236@tycho.nsa.gov>
Date:   Wed, 20 Nov 2019 08:06:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119104326.1572146-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/19 5:43 AM, Petr Lautrbach wrote:
> As a result of Python 2 sunset - https://www.python.org/doc/sunset-python-2/ -
> Python 2 code will not be supported in this project anymore and new Python code
> should be written only for Python 3.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   .travis.yml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 7a9e73ce55db..e9f86baa4e6f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -17,10 +17,8 @@ env:
>       - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=bfd
>   
>       # Test several Python versions
> -    - PYVER=python2.7 RUBYLIBVER=2.6
>       - PYVER=python3.5 RUBYLIBVER=2.6
>       - PYVER=python3.6 RUBYLIBVER=2.6
> -    - PYVER=pypy2.7-6.0 RUBYLIBVER=2.6
>       - PYVER=pypy3.5-6.0 RUBYLIBVER=2.6
>   
>       # Test several Ruby versions (http://rubies.travis-ci.org/)
> 

