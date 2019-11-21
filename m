Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B2C43215
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9E20692
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hswr3ZjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKURIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:08:35 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:46542 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKURIf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 12:08:35 -0500
X-EEMSG-check-017: 28917760|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="28917760"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 17:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574356114; x=1605892114;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=gUJuDg8lA4E5lTcYhQQca8hlDSJ51NZzd57ATmeJ5xs=;
  b=hswr3ZjFfzuWqeAWr6QgTuUyNUiVm0CXugxNNCZZmG6+b4wtSaudB1bk
   wRSLaJrp6QvVxdNUxraDGCvhaMmydEnq7wZSzhuAvLFIDfvZs5ckIiGUX
   9jdsxxmui0IYFuw+DUbDcsXUi142Rr6loC7j2Zi9e8RsMq5zandnUo/Dy
   7JEIoOUjP9esJC+GXEN9TCQWksQlDVDGhmgjSiL0jMujIibfFhN14ISEL
   V/fU8h9r+fP4NkzIl5lQoM1PYDjBUnSm0IjwcwV5DsbREjt/2A5mptWCq
   nb9wHxDVmLxs8EgqWuZGoY6Al6nnGrEfJEOgN96tNrcbE0M9ZaeIKMemf
   A==;
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="30373321"
IronPort-PHdr: =?us-ascii?q?9a23=3A5CUVjB0dAbc3ss0EsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeIvad9pjvdHbS+e9qxAeQG9mCsLQd1rCd4v+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi2swnduc0bjIl/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5GBJa0p045hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGo3NLnzZn7f8Yb?=
 =?us-ascii?q?Z98VVTxxAowNBF+Z1bF7EBL+jvWkPrqNPYCRo5ORSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?+CLqzStV6I5uQyI+iDf4IVpjn9JOY/5/L0jn82h0Udfa+30psTcny4Ge5mI0?=
 =?us-ascii?q?rKKUbr1+8MDX1CmgMjUPbggVaCGWpLY3+vQ7g27xkhBY6mBJuFTYeo1vjJxy?=
 =?us-ascii?q?q/H5tLdkhYBV2WV3TlbYOJX7ELci3BDNVml2k/SbW5S4InnSqrvQv+xqsvev?=
 =?us-ascii?q?HY4QUEpJnj055z/OSVmhYso28nR/+B2n2AGjkn1lgDQCU7ieUm+h1w?=
X-IPAS-Result: =?us-ascii?q?A2AnAAAnxNZd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzLGxVMiqEKo8EVAaBEiWJZ4ofhyQJAQEBAQEBA?=
 =?us-ascii?q?QEBJw0BAgEBhEACgigkNwYOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjB?=
 =?us-ascii?q?BFRCw4KAgImAgJXBgEMBgIBAYJfPwGCUiWuPH8zhU6DNoFIgQ4oAYERiwQae?=
 =?us-ascii?q?IEHgTgMgl8+hA6DR4I8IgSNHYhhYUZ0lheCNYI3hGOOMAYCGZoYLYQhiXqcH?=
 =?us-ascii?q?COBWCsIAhgIIQ+DJwlHERSVLCMDMIEFAQGNfoJAAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Nov 2019 17:08:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALH8SCE014542;
        Thu, 21 Nov 2019 12:08:28 -0500
Subject: Re: [PATCH] dbus: Fix FileNotFoundError in
 org.selinux.relabel_on_boot
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191115145425.1460016-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <78268016-4e9a-b288-19aa-019d65f929ba@tycho.nsa.gov>
Date:   Thu, 21 Nov 2019 12:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115145425.1460016-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/15/19 9:54 AM, Petr Lautrbach wrote:
> When org.selinux.relabel_on_boot(0) was called twice, it failed with
> FileNotFoundError.
> 
> Fixes:
>      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:1
>      method return sender=:1.53 -> dest=:1.54 reply_serial=2
>      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:0
>      method return sender=:1.53 -> dest=:1.55 reply_serial=2
>      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:0
>      Error org.freedesktop.DBus.Python.FileNotFoundError: FileNotFoundError: [Errno 2] No such file or directory: '/.autorelabel'
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.  I applied the travis patch first so that this one 
shouldn't break it.

> ---
> 
> Note: This is python 3 only code and it fails in travis with PYVER=python2.7 RUBYLIBVER=2.6:
> 
> $ PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
> 
> Analyzing 187 Python scripts
> 
> ./dbus/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError'
> 
> ./installdir/usr/share/system-config-selinux/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError'
> 
> The command "PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited with 1.
> 
> 
> 
>   dbus/selinux_server.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index b9debc071485..be4f4557a9fa 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -85,7 +85,10 @@ class selinux_server(slip.dbus.service.Object):
>               fd = open("/.autorelabel", "w")
>               fd.close()
>           else:
> -            os.unlink("/.autorelabel")
> +            try:
> +                os.unlink("/.autorelabel")
> +            except FileNotFoundError:
> +                pass
>   
>       def write_selinux_config(self, enforcing=None, policy=None):
>           path = selinux.selinux_path() + "config"
> 

