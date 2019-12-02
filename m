Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD88C432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B420833
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n4txF+hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLBRVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:21:24 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:44388 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRVY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 12:21:24 -0500
X-EEMSG-check-017: 53354165|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="53354165"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Dec 2019 17:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575307280; x=1606843280;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8sUDpPS6So6KDfR8kcDMKvQm71FJUmXMBut/5GAZsQw=;
  b=n4txF+hQr9AGEuvZPqft/a9wlA8My/7CZT52+S3mzTlsXdhpyAXaVPJp
   kyO7n+y8GVnRCihPAE2jubjP9fvKLEhvQvsDCsRJ6VwX7IK09Lptp0ss0
   Nr9xTeFIBYq7xremi5zsCFOgF7TaKWVFSelhCLJHM/fuScbIxMC12yql2
   rki5Nw7x/ufaT0lCdNYB/SOdsGBldeS8TTawgPQOcCfqpjcHIAM7kUJJu
   Q9gznpNCpLbqLybF8olbANiUzitdMGufQa6tcTTSZgUNREXz8IiLAVqlQ
   gvTdE1NTNVRU9DLQh8zF5nJrTfLhXdoMILKiVWUWZg/8pWAULpPZxnQ+o
   A==;
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="36199333"
IronPort-PHdr: =?us-ascii?q?9a23=3Ae+cVrRxf8+iS7EjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uoVIJqq85mqBkHD//Il1AaPAdyArasb1qGP6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi0rQjdudQajZd+Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBH/Z1UF7UBLenrWkDrqdzYCgY1Mwmzw+bgEtVyyJkSVn6IAq?=
 =?us-ascii?q?+cKKnSq0OH5vozI+mQY48YoC39JOYh5/7vi385hFAccLK33ZsYdn+4BO5qI0?=
 =?us-ascii?q?aHbnr2hNcOD2MKshA5TOzwh13RGQJUMk67QqZ0wzY8Eo/uWZ/KW4SFmLWc2G?=
 =?us-ascii?q?K+GZpMayZNDVXaVT/zeoGFXeocQDydL9UnkTEeU7WlDYg72kKArgj/noF7I/?=
 =?us-ascii?q?LU9ytQjpfq0Nx49qWHjh0p3SBlBMSalWeWRid7mX1eFGx+57x2vUEokgTL6q?=
 =?us-ascii?q?N/mfENUIUItv4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AVAQA5ReVd/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gRhUASASKoQriQOGVwEBAQEBAQaBN4lpkUQJAQEBAQEBAQEBIxQBA?=
 =?us-ascii?q?YRAAoIvOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQEBAQMjFVELFQMCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/AYJSJbIudYEyhU+DJoFIgQ4ojDB5gQeBOA+CXT6EE?=
 =?us-ascii?q?oNHgl4ElmdGlxGCOII5hGWONQYbgkFzlm+OSoFCmmYigVgrCAIYCCEPO4JsC?=
 =?us-ascii?q?UcRFJRhhmkjAzCPB4JBAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 02 Dec 2019 17:21:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB2HLAHR069547;
        Mon, 2 Dec 2019 12:21:10 -0500
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <157486604069.70468.14139138243381994891.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <13bfd1ea-3f1c-7de4-9d8f-344d1a74ca8f@tycho.nsa.gov>
Date:   Mon, 2 Dec 2019 12:21:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157486604069.70468.14139138243381994891.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 9:47 AM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
> Add kernel module tests") require the kernel-devel package on Fedora,
> make sure we list that in the README.md file.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Thanks, applied.

> ---
>   README.md |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index e845df8..4352796 100644
> --- a/README.md
> +++ b/README.md
> @@ -53,6 +53,7 @@ similar dependencies):
>   * attr _(tools used by the overlayfs tests)_
>   * libbpf-devel _(tools used by the bpf tests)_
>   * keyutils-libs-devel _(tools used by the keys tests)_
> +* kernel-devel _(used by the kernel module tests)_
>   
>   On a modern Fedora system you can install these dependencies with the
>   following command:
> @@ -69,7 +70,8 @@ following command:
>   		lksctp-tools-devel \
>   		attr \
>   		libbpf-devel \
> -		keyutils-libs-devel
> +		keyutils-libs-devel \
> +		kernel-devel
>   
>   The testsuite requires a pre-existing base policy configuration of SELinux,
>   using either the old example policy or the reference policy as the baseline.
> 

