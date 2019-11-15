Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD4C432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA3B20674
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="f0EKd7Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKOPBU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:01:20 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:63746 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfKOPBU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:01:20 -0500
X-EEMSG-check-017: 31306147|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="31306147"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2019 15:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573830076; x=1605366076;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ih98zDuzg+FBi38GXzHfC7tVVsYGUScEsteLX2M0gLk=;
  b=f0EKd7PeWjr4WRWXFkmeKhPqIwCuGvCPWqeZYjsOUTOlr1ZPSV3JWp0W
   AZELfacN7K3c+BJbyOHVEaHB3e0+dtyee9tZ+A0Sl/GubFjGoj1usE2aI
   QpRE1ioEXf4zCJldwFsbneitrbRjuJsD5OpogovHamF+MAtDpBh9J/rVY
   1aN7PdBAyg0v5U6TINLXIN6Og+vOLlgxLzYBQQ3dqilYawubNwUdEO/QF
   vpBNXKvZ/KwFVqkd5R9QpzKcfjSsUBkZ93qOwf5Bjx7ePHs8wvaVtXp6G
   75TuPgQPNxZdAyBajh0hnAzRfaFVmx3b1k1Y8Jua68zISLOFSbhjBI8uj
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="35583395"
IronPort-PHdr: =?us-ascii?q?9a23=3AxH0tgxI1k+caB43llNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvTxwZ3uMQTl6Ol3ixeRBMOHsqkC0rGL+P+4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7owXcusYUjId+N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43VLnjHirjhYK?=
 =?us-ascii?q?p961RHxwUp1t1f/YxbBawBIP3pRk/9rsDXDhg8Mwas2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZK73dsVuJ5uIpPumNa5QYuCjyK/c7/f7il3w5lkEHfamvw5QXbGq0HvN8I0?=
 =?us-ascii?q?WWMjLQhYI5HHsQ9i43UfDwglSJUXYHf3K7Qr4m7DgTEo+qDY7fAIuqherFlD?=
 =?us-ascii?q?y2GpxQe3BuFF+BCzHrep+CVvNKbzidceF7lTlRbqSsU48s01mVsQb+z7d2Zr?=
 =?us-ascii?q?7P9jYwqYPo1N8z4fba0x4162onXIymz2iRQjQszSszTDgs0fU6+Bcsxw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DnAACavM5d/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsbFUyKoQpjwlRAQEBBoERJYlmih+HJAkBAQEBAQEBAQEnD?=
 =?us-ascii?q?QECAQGEQAKCIyQ4EwIOAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbQEFIwQRUQsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCXz8BglIlr1l/M4VOgzyBSIEOKIESiwMYeIEHgTgMg?=
 =?us-ascii?q?l8+hA6DR4I8IgSNGohdYUZ0lhOCNII3hGKOLgYbmg4thCGJepwZIoFYKwgCG?=
 =?us-ascii?q?AghD4MnCUcRFJ9+IwMwgQUBAY4fgkABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Nov 2019 15:01:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAFF1FZr029924;
        Fri, 15 Nov 2019 10:01:15 -0500
Subject: Re: [PATCH] dbus: Fix FileNotFoundError in
 org.selinux.relabel_on_boot
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191115145425.1460016-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6ce96a14-0be8-5829-7fa4-e84d7f33c678@tycho.nsa.gov>
Date:   Fri, 15 Nov 2019 10:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
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

Hmm...given that, do we want to defer it until after 3.0 final release, 
or are we going to switch travis over to only test with python3 now?

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

