Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192AEC35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5020702
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fp69LdGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBEP4N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:56:13 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:65102 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBEP4N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 10:56:13 -0500
X-EEMSG-check-017: 55062876|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="55062876"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 15:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580918167; x=1612454167;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pLFoiDFQ0p+4rt6tvRvR4HVvVAJkmT81Jugu8hRnU2o=;
  b=fp69LdGO6EGiEzputMaOOG0GOcHYzplYv3OnaSSo2F5F94lnqvyxmvzM
   A5LpuNR+IVbcnvLsZM6nvCKittaDjNq8KOmlWBCy+QAJxe3vHAGmyPhcj
   9+TyzCJowRR9RzAThvL0lRSeNFs8TlkQeTrmiBodr9x8KoA4yj7GLk2MZ
   tNeH2rcFrjyHDFlF/8Kwa1Dvlp62SoWqoDrnFnvlWMRlCNXyuFOr/3piM
   Sb66ngV3xrl8IW9bE7jOPtYo6BlNIFxipUKBCHLT9MVB/PociE3rmDlyU
   6rO6qLdXXktkY2hiuuolF3Rg5zoq+jqEdqW64dDOe/QLmffdSNawN3b84
   g==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="38703918"
IronPort-PHdr: =?us-ascii?q?9a23=3AyN5c4hNcEfLceqPxe6ol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/zzp8bcNUDSrc9gkEXOFd2Cra4d16yL6uu/CCRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKY8xg?=
 =?us-ascii?q?bGrnZKf+ld2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3KoNjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/ufLzd/gXJqYrO/hxCq/Eij1OL8TM+030?=
 =?us-ascii?q?hOriZfldnMrH8N2hrO4caEUvtw5lqt1DmA2gzJ6uxIPFo4mbTUJpI/2LI8i5?=
 =?us-ascii?q?weulnZECDsgkX5lqqWe10h+uiv9uvofK3rpoSZN49okgH+NbkumtCnDeQ4LA?=
 =?us-ascii?q?cOW2+b9Pyg1LL55035QahKjuYsnqnYtpDaK8MbprWnDABJyIoj9xa+ACum0N?=
 =?us-ascii?q?Qfh3UHKk5KeAmbgITzPlHOIfT4Ae++g1Sqjjhr2+jLMqDuD5jCNHTOkKrtca?=
 =?us-ascii?q?xj50NT1gY/181T64pRCr4bIfLzXkHxtMbfDh88KwG02PvoCM5m24MCWWOAHq?=
 =?us-ascii?q?+ZMKTIvV+O/eIgOfOAZIASuDbjM/Ql/eLhjWclmV8BeqmkxYUXaG6jHvl9PU?=
 =?us-ascii?q?WZYGDsgsscEWcNvws/TevqhEeeXj5UYna4R7g86S0jCIK6EYfDQZiggKef0y?=
 =?us-ascii?q?e/H51WYH1GC1+XHHf2eIWLRe0MZDiRIsB/iDwEU6auS4s72RGprg/6xKJtLv?=
 =?us-ascii?q?DI9S0AqZLjyN916vXLlR4o6Dx0C9+Q03mXQGFpmmMEXjo23Kd4oUxn1FiPy7?=
 =?us-ascii?q?R3g/tdFdZL/fNGTh86NYLAz+x9E939RBrBcc2TSFanWdWrGikxQcgrw98PeE?=
 =?us-ascii?q?Z9A9GigQrf0CW0GbMVkKaLBJNnup7bikb4PMd52j7vyqQ7jl9uFtVRLkW4h7?=
 =?us-ascii?q?Rj6g/BFYmPmEKcweLibqkY3SjQ5E+dwmeU+kJVSgh9VePCR39MSFHRqIHC+k?=
 =?us-ascii?q?7aT7KoQY8iOw9FxN/KfrBGcfX1nF5GQ7HlI92YbGWvzTTjTS2Uz6+BOdK5M1?=
 =?us-ascii?q?4W2z/QXQ1dyVEe?=
X-IPAS-Result: =?us-ascii?q?A2BoAAD25Dpe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BGFUgEiqEFYkDhmQGgTeJcIonhyQJAQEBAQEBAQEBKwwBA?=
 =?us-ascii?q?YRAAoJeOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMCAQUjFUEQCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjPwGCViUPrCWBMoVKg1OBOAaBDiqMPHmBB4ERJw+CXT6CZ?=
 =?us-ascii?q?AQahFmCXgSXOkaXZoJEgk6EfI5zBhuCSIxXi2otjjWIapRGIoFYKwgCGAghD?=
 =?us-ascii?q?4MnUBgNjiYaiGSFXSMDMAKOTQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2020 15:55:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015Fsvl2153965;
        Wed, 5 Feb 2020 10:55:04 -0500
Subject: Re: [PATCH v2] selinux: sel_avc_get_stat_idx should increase position
 index
To:     Vasily Averin <vvs@virtuozzo.com>, selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
References: <CAHC9VhR3oV=d7S+PELcCg+Qt7hjV_GJYGmqMdCNvsxAWCJYfHA@mail.gmail.com>
 <441c893b-5cfa-1675-c568-2c04b3bb841a@virtuozzo.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9a789c80-de00-b4d6-b31a-43da31d6af85@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 10:56:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <441c893b-5cfa-1675-c568-2c04b3bb841a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/1/20 2:47 AM, Vasily Averin wrote:
> If seq_file .next function does not change position index,
> read after some lseek can generate unexpected output.
> 
> $ dd if=/sys/fs/selinux/avc/cache_stats # usual output
> lookups hits misses allocations reclaims frees
> 817223 810034 7189 7189 6992 7037
> 1934894 1926896 7998 7998 7632 7683
> 1322812 1317176 5636 5636 5456 5507
> 1560571 1551548 9023 9023 9056 9115
> 0+1 records in
> 0+1 records out
> 189 bytes copied, 5,1564e-05 s, 3,7 MB/s
> 
> $# read after lseek to midle of last line
> $ dd if=/sys/fs/selinux/avc/cache_stats bs=180 skip=1
> dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
> 056 9115   <<<< end of last line
> 1560571 1551548 9023 9023 9056 9115  <<< whole last line once again
> 0+1 records in
> 0+1 records out
> 45 bytes copied, 8,7221e-05 s, 516 kB/s
> 
> $# read after lseek beyond  end of of file
> $ dd if=/sys/fs/selinux/avc/cache_stats bs=1000 skip=1
> dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
> 1560571 1551548 9023 9023 9056 9115  <<<< generates whole last line
> 0+1 records in
> 0+1 records out
> 36 bytes copied, 9,0934e-05 s, 396 kB/s
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/selinuxfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ee94fa4..ad5530e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1504,6 +1504,7 @@ static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
>   		*idx = cpu + 1;
>   		return &per_cpu(avc_cache_stats, cpu);
>   	}
> +	(*idx)++;
>   	return NULL;
>   }


