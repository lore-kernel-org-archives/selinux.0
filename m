Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B1C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 18:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7094F24125
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 18:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qcrreSa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRSRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:17:08 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:38536 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRSRH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 13:17:07 -0500
X-EEMSG-check-017: 78696294|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="78696294"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 18:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582049825; x=1613585825;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Tc52lhLNYa8bd7pCOVe7uKZXQYtLKCAkm9NuFfwGQmI=;
  b=qcrreSa5PylUR/QeGtlWiXJiiphTU34FenoyJUsWkgL8Atclx0f6Eway
   T5jroMIUItWR/gCKCTA6wsdEaZHk65/LdzIQEY0jU4/7qFCZUFpVbYQeb
   4ugDRwecZl82rcxmFS8XfdFNSVfWjbbU+PqjA4VzJWpwHydSoZOf2PjQg
   EbYL0K1m4G6sX/X4APxy8ntTBYbU5n8NThsvhldeQFbLT0q06VnoZtkhf
   xrq0XiqssYdq5FPesKKrpmVdjxbJZi2oLgeWa/qQ33KJfKnjUCN9C8rry
   jvvujCt+kHBM9z+pWe3M5xNVoFhEViybCD3vvL6BNC1gBCWrdqTG3yy4l
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39242243"
IronPort-PHdr: =?us-ascii?q?9a23=3AUR4GFBKh+D6vrPrRLdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvT7rarrMEGX3/hxlliBBdydt6sYzbWG+Pm5ACQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twfcu8oZjYd/N6o91w?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHf3jxztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq0XDHin4mEXxl6+ZaFkr9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLf3vQEDxr8LXDx8iPgyv3+nnCM9y1p4QWWKLHK?=
 =?us-ascii?q?CZKrrevkOS6e41P+aMY4oVsi7nK/c5//7ukWM5mVgFcKa1x5QXc263H/R8L0?=
 =?us-ascii?q?WCfXXsgs0OEXoEvgo6UuPqkkaPUT9VZ3auQa084is3B56hDYfGXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLElKMEXLvd4WeQfcMaTmSL9RnkjMeULiuVY4h2QuptA/gxLptNv?=
 =?us-ascii?q?DU9TEAtZL/yNh14PXelRUz9TxyEsSc3HiBT3pqkWwUWj82xqF/oVB9y1ua1K?=
 =?us-ascii?q?h4hOFXFcFX5/xXSQo6K5HcwPJgC9zoWQLOYM2JSFC4TdWiGz0xScgxw9AWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INjLyEGpg08qPa33jsKMdw0GjG1KY/gFk8WMdPNnOphr?=
 =?us-ascii?q?R59wfNA47FiUKZl7ylda4Exi7C6H+DzXaSvEFfSANwUrvKUm4EZkTKqtT54U?=
 =?us-ascii?q?DCQqSyBrQnKAtBzsuCKqpXat3sl1lGQ+3jONvGaWKrh2iwHQqIxq+LbIfyeW?=
 =?us-ascii?q?Ud2yXdCE4enwAR+naGNRIxBiG6o23ACjxjDk7gbFnq8el5rnO7T1M7wBuOb0?=
 =?us-ascii?q?F7y7W1/RsVj+SGS/wPxrIEpDshqzJsEValwd3WDdWApxdgfKVaeN8940lI1X?=
 =?us-ascii?q?jftwNjOpytNKFiikcacwRwoUPhyQ97Cp5ansgpsXMq1hB9Jbie0FxfbT+Y34?=
 =?us-ascii?q?jwMKXNKmbu5BCvd7LW2lbG3daO4KgP9fA4pk77vA6zC0oi92xr09xS03ub/J?=
 =?us-ascii?q?XFEhAeXo72UkYypFBGoOTxazIw9svv3n1lLKewvyWKj9kgH+Y04g2rf95CPq?=
 =?us-ascii?q?eJDkr5GosRAM34bKQhkkOkf1QfN+Bb6aAwMtmOdv2a1artN+Fl2HqkiGNd+o?=
 =?us-ascii?q?Fm+kSF8id9DOnS0NJNx/CewxvCTDr3kU2grtGynIdIeDUfNnSwxDKiB4NLYK?=
 =?us-ascii?q?B2O4ERBiPmOMCzx9Njl7bzVHNCsl2uHVUL3ImuYxXBQUb62FhryUkPoXGh0R?=
 =?us-ascii?q?C9xjhwniBh+rGTxwTS0u/ic1wBIWcNS2582wS/abOohswXCRD7JzMikwGosA?=
 =?us-ascii?q?OjnflW?=
X-IPAS-Result: =?us-ascii?q?A2DHAADyKUxe/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwBIBIqhBSJA4ZgAwaBEiWJcJFKCQEBAQEBAQEBATcEAQGEQAKCJ?=
 =?us-ascii?q?zgTAhABAQEFAQEBAQEFAwEBbIVDgjspAYMBAQEBAQIBIwQRQQULCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgmM/glcFIK0MdX8zhUqDaYE+gQ4qiDCEDnmBB4E4DAOCXT6ES?=
 =?us-ascii?q?4MQgl4EjWSJCmRGiDePO4JFglCUAwYcmyaObZ1PIoFYKwgCGAghDzuCbFAYD?=
 =?us-ascii?q?Y4pF45BIwMwkGkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 18:16:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IIFlBC111055;
        Tue, 18 Feb 2020 13:15:48 -0500
Subject: Re: [PATCH v15 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-23-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fa270db3-1e4c-c524-5983-06c2c6f73d79@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 13:17:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214234203.7086-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 6:42 PM, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:
>          lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-api@vger.kernel.org
<snip>
> ---
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index aadf47c808c0..faec18e7e7d1 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -199,3 +199,25 @@ capability-related fields:
>   -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
>   
>   -  ``fs/proc/array.c``::c:func:`task_cap()`
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require.
> +
> +The infrastructure does provide an interface for the special
> +case where multiple security modules provide a process context.
> +This is provided in compound context format.
> +
> +-  `lsm1\0value\0lsm2\0value\0`
> +
> +The `value` is a nul terminated bytestring. It may contain
> +whitespace or non-printable characters.

Slight ambiguity above as to whether the NUL byte is part of "value" or 
a separator between "value" and "lsm2" or both (e.g. two consecutive NULs).

> +
> +The special file ``/proc/pid/attr/context`` provides the security
> +context of the identified process.
> +
> +The special file ``/sys/kernel/security/lsm`` provides a comma
> +separated list of the active security modules.

nit: To me at least, "special file" means device file and I think that's 
the common usage for UNIX-like systems.  So I wouldn't use that term for 
these files.  Could just drop "special".

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2bf82e1cf347..61977a33f2c3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1321,6 +1321,12 @@
>    *	@pages contains the number of pages.
>    *	Return 0 if permission is granted.
>    *
> + * @getprocattr:
> + *	Provide the named process attribute for display in special files in
> + *	the /proc/.../attr directory.  Attribute naming and the data displayed

Ditto.

> + *	is at the discretion of the security modules.  The exception is the
> + *	"context" attribute, which will contain the security context of the
> + *	task as a nul terminated text string without trailing whitespace.

I guess you didn't like the kernel-doc description I offered (aside from 
the printable ASCII bit).  At least be explicit above about whether the 
returned length should include or omit the terminating NUL and make sure 
all modules conform.

> diff --git a/security/security.c b/security/security.c
> index a66786c255aa..89b635277245 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2100,6 +2140,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   		return -ENOMEM;
>   	}
>   
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "context", &cp);
> +			if (rc == -EINVAL || rc == -ENOPROTOOPT)
> +				continue;

I'm guessing the -ENOPROTOOPT test is a leftover from trying to handle 
getpeersec_stream as well as getprocattr?  AFAICT, that is only returned 
for getpeersec_stream.
