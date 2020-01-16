Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F594C33CB6
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4902075B
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="adCYaTm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390377AbgAPXJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:09:25 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:41476
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729925AbgAPXJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 18:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579216163; bh=7MSSA1/9RFsMo4yh+OvezYx5UrFibmyZlUe167RYwvc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=adCYaTm8qIFex9XitNEuID0aY8qR0jYe0T54/9XN6Pku/y60ar2TB814iE8L63tY/2HYpwAuPGQDV4w/0WIyKEU9g+fsQs/PEu1Fla8gTuJHFpBHvATk6Ip5fyS6Z+uKGY+Rk8HjHDEEqfeJx1g8PFLVFPU6ZUJBNnWcicjVK+8+RtTUeQEiO5EjpLIUSbxkGIXk+zbauxyujIxwVLPHo/fvWWNxk4OCF9+Dq1vq5HRa3bw0xwCOernfgHcSVuU9ob4n8+1KA3nKXlJRDBc+eO9fHoqMg4KMpTrZGkx5SBPQojBxU66EhRsadCkmLmvqrMrvJs+NhJsxDd70d6ZhgQ==
X-YMail-OSG: rzVgafgVM1k1P36Rz5d3pBPGQt0hhYFiK78ttMsiEzqiehSaSXk3aHNVda723l9
 MifrnXQNRZWng4cnsnKRLgTbyjX.dLyltpPXZdpLzujmbDOZCuChnCUc0Jn.znAcHMG2K8TGeA4_
 Yd4Dh2jXAH9bZJGVuPuOkuM7_5vTrMIreg4adaxw850IMoBhY9m1qsNVOZsgJtS7B.bdnGfofw_e
 DaxlAF4mG6SpKEIrP6b6t7_5tkko4CGnrMOBVuR96t7b3_LSkusGGvILIFxlFIs4y_sw0vJXrOM5
 mZmj5EfGBH96E69rKxXNVUHXB9vnJzZNSB9g8LTAUgDDh.Ry7gRXWt36j10XNeOnVtLD2MgxcCzo
 S3mxXVafS5WTDya9PMrs8jPIKK2i4VJ9yQvIVsP6ueBmYPfW99YCxHBLTs.jaUpT7uGc71B34F0Q
 0nHMi9j3OAGWI1vKyejDxR_ENsYqsISspIz2NrHiR2JBcZYBklE8LJ0xE7LkfYT9VpImd7JRBoy1
 krvUKtwprVn9SIFqQBNRRfqBjbBPHrgl_OZMMa6GvmV.d3xe4UdcmwFo4c807RrEiSSdrAyxqqLY
 V81YDNRODbYJOnXXbbeHlPoC.FgephSazIuMl.fNM0ON0TbfB_D7tzaYJs.lWEsQ5RWIpAsPJ_ds
 N5yalFHPG6PCOBApEYBdEvqoPe8g.FQCyWYN6QzV4AM2d2G.Jg.EtSei3JboNYZXrtnVxzNErLvi
 ZlTMM.5PhIznyHrolCwIBD916oklwhgSbmEIzd1U7bKPLDNP2KDLQyAWUmgandd3Cj42Rw1tQTpO
 QFwdOTnuWh7_8vyrvnvjHAC7.ghu045KLNMeukHzlYZDo323tP5t3NECE9rDqVLc8D5VNSew86_p
 ljZBmfYAyifV1y7IevUfmej5vRHlJQ6i0a_NZ8aiNXaEe2V_BoRMkTHPmz08Fj.0U8d4lJb9j9NU
 h8CwuMcd1Nw03suxDEAFxJqi2l82ggcsaA.jrnnIRCCqW01FaMVxd0Lm1TNGPHzc73_0JsqynjMP
 M7_McvbmgK2Zog4wLQPsD45l0FkKk3MMuBCn5oMXT7_iXmU2oYoVvvRyDBjjRg6m1hTaVyuqdeb1
 K5RdgOa5xg8VaNh98cAk7k94sGEDhOIIL..oc0JAkorT_dizuNIuDHO0dg8KWg51GUtQleHxWLz8
 pNlWx4ew1lgtxz13plIeo861lXptiVPdm6CV0iZ6uXgtTCLEhBsGI4GIQuMRq4iWry1j6FlzS3v9
 HQbp1m0h0fKIqkh.mHmd48nRR7UvirvPYQrHM7jDo2Id_sl10.Ob6SkROC5WUurJdhURfLIzZchi
 PgDtMiOu2pNi0aLMbTZ6Sc9UCxrlmTyHY9xWdw.YNM5kxlV17_L9MGEYa9SnhJVmZK9EM748DrqL
 iQiOuepbS268OtSVAPV7gzE6QOD2la.4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jan 2020 23:09:23 +0000
Received: by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 82b3484b284491d08e76f2339772bfca;
          Thu, 16 Jan 2020 23:09:22 +0000 (UTC)
Subject: Re: [PATCH 0/6] selinux: Assorted simplifications and cleanups
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
References: <20200116120439.303034-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <bfa5a08c-9e72-5de5-4f57-c89debd94590@schaufler-ca.com>
Date:   Thu, 16 Jan 2020 15:09:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/2020 4:04 AM, Ondrej Mosnacek wrote:
> This series contains some simplifications that I discovered while
> working on another patch. I believe they also save some run time
> (although not in any perf-critical paths) and some memory overhead.
>
> The first patch is a cleanup in security_load_policy()

It's a real nuisance that the security server code uses the
prefix "security_". If you're making significant changes in
the security server it would be really nice to clean up the
namespace collision.


>  that avoids a
> pointless allocation during initial policy load. The rest are
> cleanups/simplifications of the booleans-related code - mostly
> converting linked lists to arrays.
>
> Ondrej Mosnacek (6):
>   selinux: do not allocate ancillary buffer on first load
>   selinux: simplify security_preserve_bools()
>   selinux: convert cond_list to array
>   selinux: convert cond_av_list to array
>   selinux: convert cond_expr to array
>   selinux: generalize evaluate_cond_node()
>
>  security/selinux/include/conditional.h |   6 +-
>  security/selinux/selinuxfs.c           |   4 +-
>  security/selinux/ss/conditional.c      | 252 ++++++++++---------------=

>  security/selinux/ss/conditional.h      |  27 +--
>  security/selinux/ss/policydb.c         |   2 +-
>  security/selinux/ss/policydb.h         |   3 +-
>  security/selinux/ss/services.c         |  95 ++++------
>  7 files changed, 160 insertions(+), 229 deletions(-)
>

