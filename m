Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C8C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC728217F4
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XmId4PVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBERJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:09:18 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:21828 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBERJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 12:09:18 -0500
X-EEMSG-check-017: 55117977|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="55117977"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 17:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580922554; x=1612458554;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p7T4GL4vPQexBPSFkFLBqTiKZ9G8RDnvpQvbAn4GwcM=;
  b=XmId4PVC3bJLkWeQY9alezzZD8MqNNGFMmWh1yncecsALANGEG7MflB7
   HjFoifOFG8imzFq213IW4ecjGJfyuXQBK+6BjfObqeDznRUFIHkTvtPsJ
   wAtuIGe3qm3FqvmC6tWdNBgmYWFg9LQNniZskvagquz9zKdGqE43pFz50
   9ZehRRzDIQp9d/8X5ckyuNFUCa0V6ehDyQXGeQXYiT7VpceHMANhvVkil
   e/tq7R4jipqpWi34R+fp/fPTWLJwAZQheLpHQrnG81tu855YLAXpkVMa0
   tfNyDDyzs7SbpgmEVWqnYYTN9uMGhhcLsQ3VQ+wiFhtvWKBXbPZJ7abGV
   g==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="38709388"
IronPort-PHdr: =?us-ascii?q?9a23=3AgLXYRhLstklnTjziodmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv7/rarrMEGX3/hxlliBBdydt6sYzbeP+PG5ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Kqs91x?=
 =?us-ascii?q?TFr39Vd+9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYN0VRX?=
 =?us-ascii?q?BFXs1MSSJPBI2yZJYLA+YYM+tVq4zxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNuS+aMI52TdkjQ2FuoCs6xbwGuY?=
 =?us-ascii?q?K7fCgX05sr3QLQa/uCc4WO/xntV/6RLC9liH9qd7+znRa//VW6xuHiWcS4zk?=
 =?us-ascii?q?xGojdDn9LRrH4CzQbT5dKCSvZl+0eh3iuA2B7L5+FfJEA0ibLbK5k8wr4sjp?=
 =?us-ascii?q?YTsVrMHivxmEjukK+ZbF8k+um16+T8eLnmp5mcN4FzigHlLKshhtazAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv/8k3iXLpGlPg2kqjdsJzCJMQboLC2AxNN34o+5BuyAC2q3d?=
 =?us-ascii?q?QFkXUdMl5IdwyLg5L0N13WJfD3F/a/g1CikDdxwPDGO6XsAo7QIXjYi7rhYb?=
 =?us-ascii?q?Z85FJcyAo019xf4YlUBasbLPL8XU/xqsTUDgUlPAys3+bnFNJ925sGWW2VH6?=
 =?us-ascii?q?+ZNLjfsUeS6eIyJ+mAfYoVuDH6K/g/+fHil2M2mVgYfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfsmckOEWMLvgo4Uezrh0aPUSBcZ3msRaIw/DI7B5y8DYfFWI+thKaN3C?=
 =?us-ascii?q?ChHp1ZfmpGEEyDEW/0d4WYXPcBcCWSIspmkjwfU7iuUZMu2g+1uQ/g1bVoM+?=
 =?us-ascii?q?rU9TcEtZ75yNd14OjTnwko9TNoF8Sdz32NT2Zsk2MSRj85wKB/rlZnylieya?=
 =?us-ascii?q?d3n+RXFdxJ6PNIVAc1K4XcwvdhBNDuWwLBeMuJR0i8QtWgHz4xUsg9zMMJY0?=
 =?us-ascii?q?Z4SJ2eiUXb1jeuK6ccirjOAZsz6K+a1H/0dOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9oX0?=
X-IPAS-Result: =?us-ascii?q?A2B0AACG9Tpe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8gRhVIBIqhBWJA4ZjBoESJYlwj1CBewkBAQEBAQEBAQErDAEBhEACg?=
 =?us-ascii?q?l42Bw4CEAEBAQQBAQEBAQUDAQFshTcMgjspgwMBBSMVQRALGAICJgICVxMGA?=
 =?us-ascii?q?gEBgmM/AYJWJQ+tGoEyhUqDUoE+gQ4qAYw7eYEHgTgMA4JdPoJLGQKBLIEGg?=
 =?us-ascii?q?kOCXgSXOkaIMI82gkSCToR8hUaJLQYbg0CXSZdMlDYDL4FYKwgCGAghD4MnC?=
 =?us-ascii?q?UcYDZIQhAiCSYQgIwMwjAyCQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2020 17:09:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015H8MRh195206;
        Wed, 5 Feb 2020 12:08:22 -0500
Subject: Re: [PATCH v3 2/2] testsuite: add further nfs tests
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
References: <20200130202239.11498-1-sds@tycho.nsa.gov>
 <20200130202239.11498-2-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 12:10:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130202239.11498-2-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/30/20 3:22 PM, Stephen Smalley wrote:
> In addition to testing full NFS security labeling support,
> make sure that context mounts continue to work independent
> of whether the mount was exported with security_label, and
> add a simple test of the default NFS file labeling.
> 
> With the previous changes, this completes addressing
> https://github.com/SELinuxProject/selinux-testsuite/issues/32
> 
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v3 moves nfs.sh under tools/, updates README.md, and fixes nfs.sh for
> the relocation.  As before, these patches depend on the previous one
> ("testsuite: enable running over labeled NFS") in order to allow the
> testsuite to pass on NFS mounts.
> 
>   README.md    |  5 ++++-
>   tools/nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 1 deletion(-)

Both are now applied.

[...]


