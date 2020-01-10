Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2364C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B489D20721
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QkTaoczD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAJOxt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:53:49 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:63024 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgAJOxt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:53:49 -0500
X-EEMSG-check-017: 42988705|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="42988705"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 14:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578668026; x=1610204026;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EOr+qBSvnHaLM/rvHWK/b5+k2/irRv5MRkquyh8rwTc=;
  b=QkTaoczDbu1OL8jzonjVPiOBX5mxdH9wVEz5YdE/g6ci/YaaEKfjDHlt
   1lN1EUGrxzS8pKJrMDw9bsmYRsUcz34VsHKTf+Ut3JI2rWnczKBpEDvZb
   dlQUDhw81Rihy8G6osBh2/tl49iVNFPt2Y28/jmwtkNxz8z6DUPEfEpET
   aJG7mWoWgwoE/6di0SJBjLAP8FoQRoqixQyNZEBq0RGXRP/CHHSJU1lpR
   RATUaVG1wVA+GPahUajiFFm+0CNQiMilEnSyD1FkgBJG5IpLCIdvNwR08
   Y4q0kMRtk5rKyjaywI6ZUK1MN7mHWQq67CnL9VtMvHR2c4PLnYgxaMpKt
   g==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="37604639"
IronPort-PHdr: =?us-ascii?q?9a23=3AcTHgDxKF1T26/9BdkNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfL/vxwZ3uMQTl6Ol3ixeRBMOHsqkC0bSN+P68EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rAvcusYXjIZtN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcrytBf4pVUCqoHIP3pRkD+qsfVDgUnPAOpw+boEsl92pkCVmKIB6?=
 =?us-ascii?q?+TKLnSvkOQ5uIzP+mMY5cYuC3jJPgh5v7ui2I5mFAGcKm30psYdmq4Eu5lI0?=
 =?us-ascii?q?qHe3rshMkOEWMQsgo5Vuzqh0WIUSRPaHaqQ6I8+jY7BZq+DYjYW4CthryA0z?=
 =?us-ascii?q?29HpBNfGBJFE2DEXfyeIWYQfsDdCWSIsoy2gADAJ+nR5Us11mLsxT8wrFqLa?=
 =?us-ascii?q?KA/SgfrpTq39Vd/eDflRguszdzCpLZm3qAS2Byg3MgWTA7xuZ8rFZ7x1PF1r?=
 =?us-ascii?q?J30NJCEtkG3O9ESgc3M9bnyuV+D93jElbacsyhVEetQtLgByo4CN023YldMA?=
 =?us-ascii?q?5GB9y+g0WbjGKRCLgPmunOXcdl/w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DtAACrjhhe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwBIBIqhAmJA4ZjAQEBAQEBBoE3iW6RSAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCFjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JXJat6gTKFSYNJgT2BDiiMM3mBB4E4D4JdPoQjgzaCXgSNM?=
 =?us-ascii?q?IlzRpZZdYJBgkiTXwYbmmqOWp0FIoFYKwgCGAghD4MnUBgNoTMjAzCOboJCA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 14:53:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AEr8R8039638;
        Fri, 10 Jan 2020 09:53:09 -0500
Subject: Re: [PATCH testsuite] tests/prlimit: avoid invalid limit combinations
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Bunyan <pbunyan@redhat.com>
References: <20200110143756.20101-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f0a648c5-c105-f239-c6cc-7f827987a638@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 09:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110143756.20101-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 9:37 AM, Ondrej Mosnacek wrote:
> There is a bug in the prlimit test that causes invalid limit
> combinations (soft > hard) to be created, leading to false failures.
> 
> Consider for example an old setting of X for both soft and hard limit.
> In such case the hard limit test tries to set the limits to X (soft) and
> X/2 (hard), which always fails with -EINVAL.
> 
> This patch fixes the logic to clamp the soft limit to keep it from
> exceeding the hard limit. In such case the soft limit will also be
> changed, but this can't be avoided.
> 
> Fixes: 0782228ef06b ("selinux-testsuite: Add tests for prlimit(2) permission checks")
> Reported-by: Paul Bunyan <pbunyan@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   tests/prlimit/parent.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
> index be320f0..11c0c25 100644
> --- a/tests/prlimit/parent.c
> +++ b/tests/prlimit/parent.c
> @@ -147,6 +147,12 @@ int main(int argc, char **argv)
>   				newrlim.rlim_max = 1024;
>   			else
>   				newrlim.rlim_max = oldrlim.rlim_max / 2;
> +			if (newrlim.rlim_cur > newrlim.rlim_max)
> +				/*
> +				 * This will change also soft limit, but
> +				 * what else can you do in such case...
> +				 */
> +				newrlim.rlim_cur = newrlim.rlim_max;
>   		}
>   	}
>   
> 

