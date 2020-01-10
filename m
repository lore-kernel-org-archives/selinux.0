Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B2C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E1820721
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="A1H+PYKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgAJO6S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:58:18 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:32196 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgAJO6S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:58:18 -0500
X-EEMSG-check-017: 70625215|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="70625215"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 14:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578668296; x=1610204296;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=A39meMn8N2yodvsbFERew5lQSWpNMaoxKjePpoeApO0=;
  b=A1H+PYKY9GdOSQRwrod9wZjFkKlGRcs76k8TunlAd0DS1xjdOw+MwKUM
   65Pr9mNnShSreGNqqJGUTdVIqwyl8/IOmREXQhenZe8udZy2rZTYxmxio
   TPbne0YwLfJ9hCrOokynrbx7AZd/0OO3YIAhmRt0iCNRaEdE1JHMI0Usr
   mEf9smrhttkN1rVffuufbNH1wWKPf9UVLLgALcqoz8xrBqBk3sTDkVOTG
   V6KiJemd3xIcWYb+QnUO1ggY/zc1Ix966KZ5YfHI+DuxolGiozkgKrWln
   6Bw3ADbYJ8hOaoqvjWfaAu3OsXVvMIsQYOh6XLeyx6qnDLuTl/oyS1YTJ
   A==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="31812225"
IronPort-PHdr: =?us-ascii?q?9a23=3AEBVIVxcr5RuYMHulKxqbRoznlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSybR7h7PlgxGXEQZ/co6odzbaP6Oa6BzdLv8rJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQXj4ZuJac8xx?=
 =?us-ascii?q?TUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbIybMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTzFPDJ2yb4UPDOQPM+hXoIb/qFQSohWzHhWsCeD1xzNUmnP706833u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzJotXpKqgSSeC1w7fOzT7ecv1W3C3y6IzMch8/ofCHQL?=
 =?us-ascii?q?V9cdHMxkk0DA7FklWRppDlPzOSzOgNtXOb4PB6WeKgjG4ntRh8rz6yzckijY?=
 =?us-ascii?q?nJg5gaylHC9Shhz4Y1JMG4SE5mYdG/CpdfqyaaN45wT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I7w74wkJ?=
 =?us-ascii?q?QTsUPYHiDohEr6lrOWd0U49eio7OTreLPmqYOHN4BokA3+N6UumsinDeQ5NA?=
 =?us-ascii?q?gBQXSb9Pyh2LDs8kD1WrVHguAsnqXHv53WO94XqrOhDw9QyIkj6hK/Dzm80N?=
 =?us-ascii?q?QfmHkKNElFdw+cj4XyJ1HPIOz3Dfe4g1i2ljdr3OrJMqfuApXKMHjPiK3hcq?=
 =?us-ascii?q?pl605A1AozyshS6I5bCrAAJ/LzXFH+tMfDAx82NAy0xOnnCNFj2YMbQ22PA6?=
 =?us-ascii?q?uZPLnOvl+P4+IlO/OMa5MNuDbhN/gl4ObjjWQnll8ZfKmp24YXaX+jE/R4LE?=
 =?us-ascii?q?WWf2Dsjs0CEWgUpAo+SvLliFmYXT5UfXayUPF02jZuI4K8DJzfR4mrt5MfwD?=
 =?us-ascii?q?ugFZ1bLjRNBUKLF3rzX4qDXPgIZSebI8snmTsBA+uPUYgkgCqyuRf6xrwvFe?=
 =?us-ascii?q?/d/ikVpNq3z9Ruz/HCnhE1szpvBoKS1H/bHDI8pX8BWzJjhPM3mkd60FrWlP?=
 =?us-ascii?q?Mpjg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BbAwBykBhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqECYkDhmQBAQEBAQEGgRIlgQGIbYokhyQJAQEBAQEBAQEBLwgBA?=
 =?us-ascii?q?YRAAoIWOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspgnoBAQEBAgEjBAsBBUEQC?=
 =?us-ascii?q?xgCAiYCAlcGDQYCAQGCYz8BgkoDCQUgD6p5dX8zhDQBgRSCWg1jgTcGgQ4oj?=
 =?us-ascii?q?DN5gQeBEScMA4IoNT6CGzAZAQEChHGCXgSWQoEnl06CQYJIhHOObAYbmmotl?=
 =?us-ascii?q?weUKyKBWCsIAhgIIQ+DJ1AYDZZCinEjAzAKkSYBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2020 14:58:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AEveVn040630;
        Fri, 10 Jan 2020 09:57:40 -0500
Subject: Re: [RFC PATCH 2/3] libselinux: add
 security_is_policy_capabilty_enabled()
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200110141509.21098-1-cgzones@googlemail.com>
 <20200110141509.21098-3-cgzones@googlemail.com>
 <7a4f539c-496d-ad3b-f937-604fda594ee3@tycho.nsa.gov>
 <CAJ2a_DfK4BjJOmQfjbg0zXcFxWB2B+7_p9gvp6tEKd=fzOuS+g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bf835427-93c4-1490-8bbd-f7a82ab61b75@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 09:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DfK4BjJOmQfjbg0zXcFxWB2B+7_p9gvp6tEKd=fzOuS+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 9:43 AM, Christian Göttsche wrote:
> Am Fr., 10. Jan. 2020 um 15:29 Uhr schrieb Stephen Smalley <sds@tycho.nsa.gov>:
>>
>> On 1/10/20 9:15 AM, Christian Göttsche wrote:
>>> Allow userspace (e.g. object managers like systemd) to obtain the state of a policy capability via a library call.
>>> ---

>>> diff --git a/libselinux/man/man3/security_is_policy_capability_enabled.3 b/libselinux/man/man3/security_is_policy_capability_enabled.3
>>> new file mode 100644
>>> index 00000000..18c53b67
>>> --- /dev/null
>>> +++ b/libselinux/man/man3/security_is_policy_capability_enabled.3
>>> @@ -0,0 +1,27 @@
>>> +.TH "security_is_policy_capability_enabled" "3" "9 January 2020" "cgzones@googlemail.com" "SELinux API documentation"
>>> +.SH "NAME"
>>> +security_is_policy_capability_enabled \- get the state of a SELinux policy
>>> +capability
>>> +.
>>> +.SH "SYNOPSIS"
>>> +.B #include <selinux/selinux.h>
>>> +.sp
>>> +.BI "int security_is_policy_capability_enabled(const char *" name ");"
>>> +.
>>> +.SH "DESCRIPTION"
>>> +.BR security_is_policy_capability_enabled ()
>>> +returns 1 if the SELinux policy capability with the given name is enabled,
>>> +0 if it is disabled, and \-1 on error.
>>> +.SH "NOTES"
>>> +The parameter
>>> +.IR name
>>> +is case insensitive.
>>
>> Why support case-insensitivity?  It complicates the implementation and
>> seems unnecessary.
>>
> 
> sepol_polcap_getnum() does it:
> https://github.com/SELinuxProject/selinux/blob/5bbe32a7e585dcd403739ea55a2fb25cbd184383/libsepol/src/polcaps.c#L25

Not sure why though.  One difference is that sepol_polcap_getnum() is 
only used for capability names specified in policies, while 
security_is_policy_capability_enabled() will be used in application 
code.  It seems reasonable to require application writers to use the 
right case for the capability name?

> 
>>
>>> +
>>> +If the the current kernel does not support the given policy capability \-1 is returned and
>>> +.BR errno
>>> +is set to
>>> +.BR ENOTSUP
>>> +\&.
>>> +.
>>> +.SH "SEE ALSO"
>>> +.BR selinux "(8)"
>>> diff --git a/libselinux/src/polcap.c b/libselinux/src/polcap.c
>>> new file mode 100644
>>> index 00000000..801231cf
>>> --- /dev/null
>>> +++ b/libselinux/src/polcap.c
>>> @@ -0,0 +1,64 @@
>>> +#include <dirent.h>
>>> +#include <errno.h>
>>> +#include <fcntl.h>
>>> +#include <limits.h>
>>> +#include <stdio.h>
>>> +#include <string.h>
>>> +#include <sys/types.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "policy.h"
>>> +#include "selinux_internal.h"
>>> +
>>> +int security_is_policy_capability_enabled(const char *name)
>>> +{
>>> +     int fd, enabled;
>>> +     ssize_t ret;
>>> +     char path[PATH_MAX];
>>> +     char buf[20];
>>> +     DIR *polcapdir;
>>> +     struct dirent *dentry;
>>> +
>>> +     if (!selinux_mnt) {
>>> +             errno = ENOENT;
>>> +             return -1;
>>> +     }
>>> +
>>> +     snprintf(path, sizeof path, "%s/policy_capabilities", selinux_mnt);
>>> +     polcapdir = opendir(path);
>>> +     if (!polcapdir)
>>> +             return -1;
>>> +
>>> +     while ((dentry = readdir(polcapdir)) != NULL) {
>>> +             if (strcmp(dentry->d_name, ".") == 0 || strcmp(dentry->d_name, "..") == 0)
>>> +                     continue;
>>> +
>>> +             if (strcasecmp(name, dentry->d_name) != 0)
>>> +                     continue;
>>> +
>>> +             snprintf(path, sizeof path, "%s/policy_capabilities/%s", selinux_mnt, dentry->d_name);
>>> +             fd = open(path, O_RDONLY | O_CLOEXEC);
>>> +             if (fd < 0)
>>> +                 goto err;
>>
>> If you weren't trying to support case-insensitivity, you could just
>> directly open() the capability file and be done with it.
>>
> 
> Would we need to check for directory traversals in that case?
> char *tainted_userdata = "../../../../etc/passwd"
> security_is_policy_capability_enabled(tainted_userdata)

No, we aren't crossing a trust boundary here and any sane application is 
going to hardcode the policy capability name, not take it from an 
untrusted source.
