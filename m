Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D871FC432C0
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49342251D
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pEvQ7HdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfKTNG1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:06:27 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:48252 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfKTNG1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Nov 2019 08:06:27 -0500
X-EEMSG-check-017: 51734439|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,221,1571702400"; 
   d="scan'208";a="51734439"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2019 13:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574255166; x=1605791166;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aP9+1DuzLHV1as0Oxfkkzy7bSkdLu50aV4ssNMTeces=;
  b=pEvQ7HdTXKq8tpwxKL9TvxraJqG9UqbzqU6+3a1fYvyjYm5JWoWw+KxH
   bSG377qPT8VWV60chsn8Yv2rlBWRCXBQgNjykPKF1O8MQ9Ra0dKPSrLCu
   SHJiyTJTGOWdOVzNPr5cEkDcL3uUTsbsnFY6BY5V+TLkF/+qR4nC82dvo
   e5kS9JNhJvpoaxU3AGVU6hImd9WAr975KPKWMo9aLtFpCMLiodyM5Y8PT
   1c/ez9iwWlucwQdEiRYUwSXcleyPZjva7I6D5kYiIUqMyBovyFQ8/GMN9
   8NJLkeLFNZxKrogsOYh7ZkCKFUTlzDFVsbxqeGfnBJSxq+ApyTyxG0mBn
   g==;
X-IronPort-AV: E=Sophos;i="5.69,221,1571702400"; 
   d="scan'208";a="30305099"
IronPort-PHdr: =?us-ascii?q?9a23=3A+mk9XR2FRif7trehsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeIvad9pjvdHbS+e9qxAeQG9mCsLQd1rKd7/yocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi2sQnducYbjIR/Iast1x?=
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
X-IPAS-Result: =?us-ascii?q?A2CzAADcONVd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsbIEHKoQqjwFUBoE2iWaKH4ckCQEBAQEBAQEBAScNAQIBA?=
 =?us-ascii?q?YRAAoInJDgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjBBFRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfPwGCUiWwVH8zhU6DNIFIgQ4ogRKLAxh4gQeBOIJrPoQOg?=
 =?us-ascii?q?0eCPCIEjRyIYWFGdJYWgjWCN4Rjji8GG5oULYQhiXqcHSKBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?wlHERSGfo4sIwMwgQUBAYtugkABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Nov 2019 13:06:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAKD63lf024363;
        Wed, 20 Nov 2019 08:06:04 -0500
Subject: Re: [Non-DoD Source] [PATCH] dbus: Fix FileNotFoundError in
 org.selinux.relabel_on_boot
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191115145425.1460016-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <47cc6bd0-009b-33bb-62b6-d22ced25c211@tycho.nsa.gov>
Date:   Wed, 20 Nov 2019 08:06:03 -0500
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

