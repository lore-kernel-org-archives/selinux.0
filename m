Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F93C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C943B20838
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c540yf3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgAJO3g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:29:36 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:54863 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgAJO3f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:29:35 -0500
X-EEMSG-check-017: 64774024|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="64774024"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 14:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578666573; x=1610202573;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4Q3wv0JiTJJM/Po+xdDrXSDxpMizCnZtj2RM4ul2VOE=;
  b=c540yf3xnQd97PIzBP/WI9kGSOy8HeEawPcH7MpIxBc7508Sy88rvkom
   mRjIy4/Sy7Z/l/UY6s4RX3JlheLL+9afcr1ldla6B68zBCRMJB51tM1wj
   L62CYIQF8oilAlxqBdALeC+IVkziD3iDOmfQKKBCBTq8cZJW7r6gQS65N
   soTbWk4EkkJ+vKR3jh61LZnMI7+sTCE3NFVvwqk/WcK6ywvA56i71dYqF
   qvisX6+jVIN61spB4y943sxaHyR6vvaByzrEZ0LdxrhqFKkm/0uVG504O
   dus1beXuai5etrg2vbpIPt65opLcquAcYdaQNfxq6wvd4aejw8My2WC3Z
   w==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="37603353"
IronPort-PHdr: =?us-ascii?q?9a23=3AURz65BJQVB1PzT5Q69mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeLfrxwZ3uMQTl6Ol3ixeRBMOHsqkC0bSN+P2xEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rAvcusYWjIZmN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByzYrZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JcUMhPWSxPAoCyYYUBAOUOP+lXs4bzqkASrRa9HwSgGP/jxzFKi3LwwKY00/?=
 =?us-ascii?q?4hEQbD3AE4AtwOrGrbrM31NKgMV+C+0bTGzTDZYPNS3Tfy9ojJeQ0mrPGXQL?=
 =?us-ascii?q?1watHcyVUvFgzZjlWQrpbpPzWO1usXqWSb4O1gVfy2hmMhtgp/oSCvy98xho?=
 =?us-ascii?q?TGiY8Z0FDJ+ThjzIorKtC0VlR3bcOiHZBNrS+VLZF2TdknQ2xwvSY6zaAJto?=
 =?us-ascii?q?CjcSgRzZQn2wbfa/uac4iU+h7jVPieITN/hH99ZLKwnQyy8Um9yu3nTMW00V?=
 =?us-ascii?q?BKriRCktnXqH8Cywbf6tSHS/Rh/keh3iyD1wbP5eFfPU84j6/bK58lwrIol5?=
 =?us-ascii?q?oTt1rMHjPulUnrg6KbeV8o9+i15+j9fLnrqYGQO5Vphg3mN6QhgM2/AeA2Mg?=
 =?us-ascii?q?gUWGib/Pyx1Kb+8k3iW7hKkv03nbXZsJDdP8gboLW5DBVP3oYs7Ba/ES+q0M?=
 =?us-ascii?q?4EknkfMFJFZBWHgpD1NFHBIfH4CvG/jEq3kDpwyPDGObrhAprJLnfdlbfuZ7?=
 =?us-ascii?q?d960pGxAUvytBf4opeCqsdL/LrRk/xqNvYAwciMwOqx+bnCdN91p4RWG+UHK?=
 =?us-ascii?q?+ZP73dsUWS6uIsPeaMfokVtyj5K/Q/4P7ul3A5yhchevyC3YEWc2y5F/JRDN?=
 =?us-ascii?q?uFfWHngtpJRWwFrA04QffCh1qFXjpeYn+zW+Q34TRtTMq9AIPCQJ29qKKO0T?=
 =?us-ascii?q?39HZBMYG1CTFeWHiTGbYKBDswQZTqSL8kpqTkNUbysWsd1zh21nBPrwLpgaO?=
 =?us-ascii?q?zP82sXsoy1h4s93PHaiRxnrW88NM+ayWzYCjolkw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BTAwDhiBhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQJiQOGZAEBAQEBAQaBN4EBiG2KJIckCQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oIWOBMCEAEBAQQBAQEBAQUDAQFshUOCOymCegEBAQECASMECwEFRgsLGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCYz+CSwMJBSCqenV/M4VJglINY4E9gQ4ojDN5gQeBEScPg?=
 =?us-ascii?q?ig1PoIbghiDJoJeBI0wiRKBJ5dOgkGCSJNfBhuCR4xFi14tji2dBSKBWCsIA?=
 =?us-ascii?q?hgIIQ+DJ1AYDZJbF45BIwMwkTABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 14:29:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AESuiO021892;
        Fri, 10 Jan 2020 09:28:56 -0500
Subject: Re: [RFC PATCH 2/3] libselinux: add
 security_is_policy_capabilty_enabled()
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200110141509.21098-1-cgzones@googlemail.com>
 <20200110141509.21098-3-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7a4f539c-496d-ad3b-f937-604fda594ee3@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 09:30:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110141509.21098-3-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 9:15 AM, Christian Göttsche wrote:
> Allow userspace (e.g. object managers like systemd) to obtain the state of a policy capability via a library call.
> ---
>   libselinux/include/selinux/selinux.h          |  3 +
>   .../security_is_policy_capability_enabled.3   | 27 ++++++++
>   libselinux/src/polcap.c                       | 64 +++++++++++++++++++
>   libselinux/src/selinux_internal.h             |  1 +
>   libselinux/src/selinuxswig_python_exception.i |  9 +++
>   5 files changed, 104 insertions(+)
>   create mode 100644 libselinux/man/man3/security_is_policy_capability_enabled.3
>   create mode 100644 libselinux/src/polcap.c
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index fe46e681..b46f152d 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -354,6 +354,9 @@ extern int security_disable(void);
>   /* Get the policy version number. */
>   extern int security_policyvers(void);
>   
> +/* Get the state of a policy capability. */
> +extern int security_is_policy_capability_enabled(const char *name);

Not sure if this should be security_ or selinux_.  Historically, we 
originally used security_ as the prefix for security server interfaces 
(e.g. security_compute_av), avc_ as the prefix for AVC interfaces, and 
no prefix at all for various other interfaces (e.g. getcon, getfilecon). 
  Then people pointed out the potential for name collisions (even more 
so in a multi-LSM world) and we started using selinux_ prefixes (but not 
consistently).  I'm ok either way but thought I'd mention it.

> +
>   /* Get the boolean names */
>   extern int security_get_boolean_names(char ***names, int *len);
>   
> diff --git a/libselinux/man/man3/security_is_policy_capability_enabled.3 b/libselinux/man/man3/security_is_policy_capability_enabled.3
> new file mode 100644
> index 00000000..18c53b67
> --- /dev/null
> +++ b/libselinux/man/man3/security_is_policy_capability_enabled.3
> @@ -0,0 +1,27 @@
> +.TH "security_is_policy_capability_enabled" "3" "9 January 2020" "cgzones@googlemail.com" "SELinux API documentation"
> +.SH "NAME"
> +security_is_policy_capability_enabled \- get the state of a SELinux policy
> +capability
> +.
> +.SH "SYNOPSIS"
> +.B #include <selinux/selinux.h>
> +.sp
> +.BI "int security_is_policy_capability_enabled(const char *" name ");"
> +.
> +.SH "DESCRIPTION"
> +.BR security_is_policy_capability_enabled ()
> +returns 1 if the SELinux policy capability with the given name is enabled,
> +0 if it is disabled, and \-1 on error.
> +.SH "NOTES"
> +The parameter
> +.IR name
> +is case insensitive.

Why support case-insensitivity?  It complicates the implementation and 
seems unnecessary.

> +
> +If the the current kernel does not support the given policy capability \-1 is returned and
> +.BR errno
> +is set to
> +.BR ENOTSUP
> +\&.
> +.
> +.SH "SEE ALSO"
> +.BR selinux "(8)"
> diff --git a/libselinux/src/polcap.c b/libselinux/src/polcap.c
> new file mode 100644
> index 00000000..801231cf
> --- /dev/null
> +++ b/libselinux/src/polcap.c
> @@ -0,0 +1,64 @@
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "policy.h"
> +#include "selinux_internal.h"
> +
> +int security_is_policy_capability_enabled(const char *name)
> +{
> +	int fd, enabled;
> +	ssize_t ret;
> +	char path[PATH_MAX];
> +	char buf[20];
> +	DIR *polcapdir;
> +	struct dirent *dentry;
> +
> +	if (!selinux_mnt) {
> +		errno = ENOENT;
> +		return -1;
> +	}
> +
> +	snprintf(path, sizeof path, "%s/policy_capabilities", selinux_mnt);
> +	polcapdir = opendir(path);
> +	if (!polcapdir)
> +		return -1;
> +
> +	while ((dentry = readdir(polcapdir)) != NULL) {
> +		if (strcmp(dentry->d_name, ".") == 0 || strcmp(dentry->d_name, "..") == 0)
> +			continue;
> +
> +		if (strcasecmp(name, dentry->d_name) != 0)
> +			continue;
> +
> +		snprintf(path, sizeof path, "%s/policy_capabilities/%s", selinux_mnt, dentry->d_name);
> +		fd = open(path, O_RDONLY | O_CLOEXEC);
> +		if (fd < 0)
> +		    goto err;

If you weren't trying to support case-insensitivity, you could just 
directly open() the capability file and be done with it.

> +
> +		memset(buf, 0, sizeof buf);
> +		ret = read(fd, buf, sizeof buf - 1);
> +		close(fd);
> +		if (ret < 0)
> +			goto err;
> +
> +		if (sscanf(buf, "%d", &enabled) != 1)
> +			goto err;
> +
> +		closedir(polcapdir);
> +		return !!enabled;
> +	}
> +
> +	if (errno == 0)
> +		errno = ENOTSUP;
> +err:
> +	closedir(polcapdir);
> +	return -1;
> +}
> +
> +hidden_def(security_is_policy_capability_enabled)

The hidden_proto/hidden_def declarations are for libselinux functions 
that are called by libselinux itself, to provide an internal symbol for 
it and thereby avoid the cost and confusion of supporting libselinux 
using some other .so's definition of it.  So unless you put a call to it 
somewhere inside libselinux, you don't need this.

> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index 8b4bed2f..7ca1c329 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -9,6 +9,7 @@ hidden_proto(selinux_mkload_policy)
>       hidden_proto(security_disable)
>       hidden_proto(security_policyvers)
>       hidden_proto(security_load_policy)
> +    hidden_proto(security_is_policy_capability_enabled)

Ditto

>       hidden_proto(security_get_boolean_active)
>       hidden_proto(security_get_boolean_names)
>       hidden_proto(security_set_boolean)
> diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
> index cf658259..bd107295 100644
> --- a/libselinux/src/selinuxswig_python_exception.i
> +++ b/libselinux/src/selinuxswig_python_exception.i
> @@ -665,6 +665,15 @@
>   }
>   
>   
> +%exception security_is_policy_capability_enabled {
> +  $action
> +  if (result < 0) {
> +     PyErr_SetFromErrno(PyExc_OSError);
> +     SWIG_fail;
> +  }
> +}
> +
> +
>   %exception security_get_boolean_names {
>     $action
>     if (result < 0) {
> 

