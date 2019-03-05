Return-Path: <SRS0=RVlB=RI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D4EC4360F
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350F720657
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="rERbfhtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfCEPxB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:53:01 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:47533 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfCEPxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Mar 2019 10:53:01 -0500
X-EEMSG-check-017: 683621274|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="683621274"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Mar 2019 15:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551801176; x=1583337176;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ySeodeN0sKQ7NzmKwxIfPAfqW5haIqMra+ls1Yd2I5I=;
  b=rERbfhtYT/bt22VOmrpMpqR2Qr1WF0h406IisF3YhtebWkuNZR9kTaOJ
   au9zzjcXjipugPWUD6tS7ozLr8+cMdBGu1tU/QVD+XiiXhnNN669iBj6/
   Os12hcp325Uge7kdsqKukfZbEJd6JvbJFJ8MVKy66nEWj8CCTas4RiAuO
   7qx13emXobHCXGHssREUUcnI3eMLu5VgxXWz1mjMwo4xbaVIuTL0FVijE
   PNHkRx05+4DgLrPPAzVNL3dn6m0kPHPu1rmwyOLHS1sZhdp3aUEi3fN4P
   PM7F0cAKRSExoqbFcI/stT+TycYowUiIsiGwXER+GMa8sfWl0frARcAoy
   A==;
X-IronPort-AV: E=Sophos;i="5.58,444,1544486400"; 
   d="scan'208";a="24629089"
IronPort-PHdr: =?us-ascii?q?9a23=3AXxsg6xKB+VRMXmYQGtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeLfrxwZ3uMQTl6Ol3ixeRBMOHsqoC07OempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffhlEiCChbb9vMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5ULAuYEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jky0kDdv3f/GI6HhAo/WIXfZi7rhZ6?=
 =?us-ascii?q?hy5FNcyAUp0dBT/Y5bCrYEIPjrQE/+qMTYDgMlMwyz2+vnE8ty1ocfWWKJH6?=
 =?us-ascii?q?+YP7jfsUGH5u0xOemAfowVtyjnK/gj+fHuiWU1mVgHfammjtMrbyWAE+h8a2?=
 =?us-ascii?q?GQfGb2iN4KES9epg43UfDwglSqSzNfZ3+uGak742d/QJmrCYbFW5CFnrOMxm?=
 =?us-ascii?q?G4E4dQa2QADUqDQlnycIDRYOsBcCKfJIdalzUAUbWwA9s62QqGqB7xy70hKP?=
 =?us-ascii?q?HdvCIfq8Swh5BO++TPmERqpnRPBMOH3jTIFjslkw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B0AAB0mX5c/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?WAFKmiBAyeECJNkTQEBAQEBBoEQJXyIQIlThRKBeygQAYRAAoQsIjYHDQEBA?=
 =?us-ascii?q?wEBAQIBAwIBbBwMgjopAYJmAQEBAQIBIxVRCw4KAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?wGBaAUIqjmBL4VEhGmBCyQBiycXeIEHgREnDIIqNYRKg0GCVwKJfwsGhlZMO?=
 =?us-ascii?q?1yRPgmHQ4srBhmCTJBbLYo4lBoBMYFWKwgCGAghD4MnCYIMAReJDYUvIQMwg?=
 =?us-ascii?q?QUBAY1Bgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Mar 2019 15:52:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x25FqtRH019250;
        Tue, 5 Mar 2019 10:52:55 -0500
Subject: Re: [PATCH v2] libselinux: Add security_reject_unknown(3) man page
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <pjdzhq9n0r9.fsf@redhat.com>
 <20190305093509.12760-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bb4979d7-5e8c-7186-f8b6-e2d59057eee9@tycho.nsa.gov>
Date:   Tue, 5 Mar 2019 10:44:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305093509.12760-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/5/19 4:35 AM, Petr Lautrbach wrote:
> Commit c19395d7 added a new interface security_reject_unknown() which needs to
> be documented.

For the kernel, checkpatch.pl requires that one specify at least 12 
characters of the sha1 followed by the one line summary log message 
quoted within parentheses, ala:
commit c19395d72295 ("libselinux: selinux_set_mapping: fix handling of 
unknown classes/perms")

selinux userspace obviously isn't bound by the kernel checkpatch.pl 
requirements but this is probably a good practice to follow so that 
reviewers don't necessarily have to look up the commit hash to have some 
idea as to what the commit was and so that there is less risk of ambiguity.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>   libselinux/man/man3/security_getenforce.3     | 15 ++++++++++++++-
>   libselinux/man/man3/security_reject_unknown.3 |  1 +
>   2 files changed, 15 insertions(+), 1 deletion(-)
>   create mode 100644 libselinux/man/man3/security_reject_unknown.3
> 
> diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
> index 29cf3de7..7b0a069f 100644
> --- a/libselinux/man/man3/security_getenforce.3
> +++ b/libselinux/man/man3/security_getenforce.3
> @@ -1,6 +1,7 @@
>   .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>   .SH "NAME"
> -security_getenforce, security_setenforce, security_deny_unknown, security_get_checkreqprot\- get or set the enforcing state of SELinux
> +security_getenforce, security_setenforce, security_deny_unknown, security_reject_unknown,
> +security_get_checkreqprot \- get or set the enforcing state of SELinux
>   .
>   .SH "SYNOPSIS"
>   .B #include <selinux/selinux.h>
> @@ -11,6 +12,8 @@ security_getenforce, security_setenforce, security_deny_unknown, security_get_ch
>   .sp
>   .B int security_deny_unknown(void);
>   .sp
> +.B int security_reject_unknown(void);
> +.sp
>   .B int security_get_checkreqprot(void);
>   .
>   .SH "DESCRIPTION"
> @@ -27,6 +30,16 @@ returned.
>   returns 0 if SELinux treats policy queries on undefined object classes or
>   permissions as being allowed, 1 if such queries are denied, and \-1 on error.
>   
> +.BR security_reject_unknown ()
> +returns 1 if SELinux rejects loading a policy which doesn't define all kernel
> +object classes and permissions. In this state SELinux treats policy queries on
> +undefined object classes or permissions as being denied.

I'm not sure if the last part is quite correct.  If 
handle_unknown=reject and the policy doesn't define all kernel 
classes/permissions, then the policy load fails, which leaves the system 
without a policy at all (or with its previously loaded policy if one was 
already loaded successfully). If the system is enforcing and this is the 
initial policy load, then init should halt the system due to the failed 
load.  Since no policy was ever loaded, security_reject_unknown() is 
still going to return 0 in that case, but security_deny_unknown() should 
be 1.

If handle_unknown=reject and the policy defines all kernel 
classes/permissions but omits some userspace classes/permissions, then 
the policy load succeeds and the behavior of the userspace object 
managers will vary depending on what interfaces they use and how they 
handle error conditions. If they use selinux_set_mapping() to map all of 
the classes/permissions up front prior to using security_compute_av() or 
avc_has_perm(), then selinux_set_mapping() will return an error and the 
object manager likely treats this as a fatal error during startup (e.g. 
dbus-daemon appears to exit in this case; XSELinux in contrast appears 
to just disable itself).  If they instead use selinux_check_access(), 
then it will return an error and the object manager likely treats this 
like any other permission denial (but errno will differ: EINVAL vs 
EACCES, so they could distinguish if they wanted). If they directly call 
string_to_security_class() and string_to_av_perm() prior to calling 
security_compute_av() or avc_has_perm(), then the string_*() functions 
will return an error on the undefined class/perm and the object manager 
likely treats that like any other permission denial.

> +
> +It returns 0 if SELinux allows to load such policy and policy queries are
> +treated according to
> +.BR security_deny_unknown(),
> +\-1 is returned on error.
> +
>   .BR security_get_checkreqprot ()
>   can be used to determine whether SELinux is configured to check the
>   protection requested by the application or the actual protection that will
> diff --git a/libselinux/man/man3/security_reject_unknown.3 b/libselinux/man/man3/security_reject_unknown.3
> new file mode 100644
> index 00000000..d59e5c2c
> --- /dev/null
> +++ b/libselinux/man/man3/security_reject_unknown.3
> @@ -0,0 +1 @@
> +.so man3/security_getenforce.3
> 
