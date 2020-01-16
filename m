Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E4C33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A8206D9
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZkY9JQ1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAPQ2o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:28:44 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:38500 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAPQ2o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:28:44 -0500
X-EEMSG-check-017: 70582950|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="70582950"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 16:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579190835; x=1610726835;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FAFL3zojVEbyxaj5BzYPKguyy31satKu1h8LtVTT4AI=;
  b=ZkY9JQ1EXMAgbnVSRmn8TQqXEtRM3AF6/EQwcgnZUmcsxu3a80c8GXUT
   1skulrG1NJIG8+WsTCdZcKKdByQwkDnHuEWh+r+7UzXF+uc+1Or8cWmAO
   iS28yfN0G7PToFss6ENkuC9ivcuhmJiaoSeI2ozLPdTgT0t6Js6969IkO
   ZtBNqcht6MsWZY9uaNFkpTRUcTEZrSKMnimFbbnT+MDIvTp5DFgD//vHb
   fznAhUMHXxjHqyH1FT/Dt7/oogIHVy22+y+WEchSB0O+7hwAlqsFeerSi
   h/RxaioQg4E4Gncad94q2O20KOmUwKDp2S6EuCuSRrQeiTmc8SbPNi07L
   g==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="37880867"
IronPort-PHdr: =?us-ascii?q?9a23=3AvLzqvBLeXEB0bbUW1dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv79rarrMEGX3/hxlliBBdydt6sYzbKL+PC5ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo8yh?=
 =?us-ascii?q?TFr3hVd+9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVGKIB6?=
 =?us-ascii?q?+ZN7jSsVmS6e0zPeaBf5UVtyjgJPgl/fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfItd7nTwZUbisUJch2guztA/+0rZnK+?=
 =?us-ascii?q?3U+ioCtZ39ztR6++rTlRRhvQBzWuOb33uATSlRmXgOTjQ73+grpkl60VGK2q?=
 =?us-ascii?q?VQmfFUFdVPofhOV1F+fYXRy+18FsDaRA3MZJGKRUygT9HgBis+CpoJysIKK2?=
 =?us-ascii?q?N6HM+vxkTb1jeuK6ccirjOAZsz6K+a1H/0cZVT0XHDgZI9gkEmT80HDmivgq?=
 =?us-ascii?q?py5kCHHILSu1mInKatM6IH1WjC83nVnjnGh11RTAMlCfaNZnsYfEaD6I2it0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DSBADCiSBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoESJYlukUkJAQEBAQEBAQEBNwEBhEACgiY4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRUQsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVyWsIX8zhUqDVoE+gQ4ojDZ5gQeBOAwDgl0+Hoc7gl4ElzBGl1aCQ4JJk?=
 =?us-ascii?q?2EGG5pwjlydFSKBWCsIAhgIIQ+DJ1AYDYgNF45BIwMwjWwBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 16:07:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GG6YDW009335;
        Thu, 16 Jan 2020 11:06:35 -0500
Subject: Re: [PATCH] selinux: fix sparse warnings in policydb.c
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116131928.315533-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c26b26d4-9fcd-8802-bf3b-f5e0f75a0730@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 11:08:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116131928.315533-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 8:19 AM, Ondrej Mosnacek wrote:
> Two places used u32 where there should have been __le32.
> 
> Fixes sparse warnings:
>    CHECK   [...]/security/selinux/ss/services.c
> [...]/security/selinux/ss/policydb.c:2669:16: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2669:16:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2669:16:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2674:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2674:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2674:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2675:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2675:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2675:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2676:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2676:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2676:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2681:32: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2681:32:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2681:32:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2701:16: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2701:16:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2701:16:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2706:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2706:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2706:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2707:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2707:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2707:24:    got restricted __le32 [usertype]
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/policydb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index e369b0092cdf..2aa7f2e1a8e7 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2659,7 +2659,7 @@ static int role_trans_write(struct policydb *p, void *fp)
>   {
>   	struct role_trans *r = p->role_tr;
>   	struct role_trans *tr;
> -	u32 buf[3];
> +	__le32 buf[3];
>   	size_t nel;
>   	int rc;
>   
> @@ -2691,7 +2691,7 @@ static int role_trans_write(struct policydb *p, void *fp)
>   static int role_allow_write(struct role_allow *r, void *fp)
>   {
>   	struct role_allow *ra;
> -	u32 buf[2];
> +	__le32 buf[2];
>   	size_t nel;
>   	int rc;
>   
> 

