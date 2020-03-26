Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C738C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67102073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SbqisuRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgCZP0b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:26:31 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:65064 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgCZP0b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:26:31 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 11:26:31 EDT
X-EEMSG-check-017: 68384865|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="68384865"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 15:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585235964; x=1616771964;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DnBYISG0I+SCZFKxqVLKaOV2PM/R9AiwHzcuZeAT9VA=;
  b=SbqisuRvk8Z/lIEfBIXJ9KoQEh4FCOpO/gkz7hZGnc8vm3Lc69s/0Y+m
   cmtvn9n+qzj5F05r5fiFK4FhBu7HlafHyO/QpfCaBYva2jCKHO5VkfnZg
   1bNKSZ35qj9bHRCCAwdCnjqhXrTDzm+PeI5oqBdBJqXes6KGLS4FwnUmC
   15XevbGuZdD9yOJjnBrfot449PxDD7meP/SUME8sMIzezIdo3cAGvIOfE
   2a3C9Lc5tKU26hmvD1IlZazpGBsiR2AOrfAna1At2J+JHkg9KWMRslOHM
   XMqdVxirISzN44JXybaU6hEOtLdYEI90WebI4KvnE6uNAK7cFtM5oARgE
   g==;
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="34634062"
IronPort-PHdr: =?us-ascii?q?9a23=3Av4soERwU+fkJ3zrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uITIJqq85mqBkHD//Il1AaPAdyHrasZ1KGO4ujJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+Ngi6oAXTu8UZnYdvLrs6xw?=
 =?us-ascii?q?fUrHdPZ+lZymRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jI?=
 =?us-ascii?q?YTsETfES/2n0X6lqmWeVk/+ue08ejnZ7TmppuEO491jAHxLLgul9SiDek3PQ?=
 =?us-ascii?q?UCRWiW9fmm2LH98kD1Xq9GguAunqncqp/aJMAbpqCjAw9S14Yu8w2/ACq90N?=
 =?us-ascii?q?kDgXkGLE5KeBKAj4TzPVHOO+r3Ae2wg1Srjjdn3+rGMaH5ApXRMnjDl6/sfa?=
 =?us-ascii?q?x860FAyAo818pf6I9MBb4dOP3zWlX+tN3eDhAnKAy52P3oCMl81oMYRWKAHL?=
 =?us-ascii?q?WZMKXMvl+U/O4gP+6MZIoNsjbnN/cl/+LujWM+mVIFZqmmw58XaHG+HvR7LE?=
 =?us-ascii?q?SUemTsgtgfHmcQpAY+T/LliEeEUTFNY3a+RaU85is0CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWfWVGBUqMEHfoaYqFVewBaDiMLcB8kjwLT6ShR5U92hGpsQ+pg4Zge9?=
 =?us-ascii?q?DV8S0Rr56r9NF04eDI3UUo9Dd0Bt6R5Gq6T2h1mG4TbzUq3aZjrFZ7x0vF2q?=
 =?us-ascii?q?991bgQDtFX5vVUQi8kOpPGie93Edb/XkTGZNjaZkyhR4CdHTwpTt83i+QLak?=
 =?us-ascii?q?J5FsTq2gvPxAK2ErQVkPqNH5Vy/aXCiSuib/1hwmrLgfFyx2ItRdFCYCj/3f?=
 =?us-ascii?q?9y?=
X-IPAS-Result: =?us-ascii?q?A2AHAADRxnxe/wHyM5BmGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgWkCAQEBAQELAYF8LGxVMiqEGo9RBoE3iXqFfYlVgXsKA?=
 =?us-ascii?q?QEBAQEBAQEBIxEBAgQBAYREAoIvJDYHDgIQAQEBBQEBAQEBBQMBAWyFVgyCO?=
 =?us-ascii?q?ykBgn8BBSMVQRALGAICJgICVwYBDAYCAQGCYz8BgksDCSWtbYEyhUuDXoE+g?=
 =?us-ascii?q?Q4qAYwuGnmBB4E4D4JePoIbMIURgjwiBJgAmFWCRoJWhQmPJAYdgjsBmSOEU?=
 =?us-ascii?q?IpBnXYHK4FYKwgCGAghD4MnCUcYDZhhhCAlAzCBBgEBjh0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Mar 2020 15:19:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QFJhHN082786;
        Thu, 26 Mar 2020 11:19:44 -0400
Subject: Re: [PATCH V2 2/2] selinux-testsuite: Use native filesystem for tests
 - Part 2
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     smayhew@redhat.com
References: <20200325130900.15047-1-richard_c_haines@btinternet.com>
 <20200325130900.15047-3-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a932f3c7-ed7a-0e55-6f17-ad9e5ead757a@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 11:20:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325130900.15047-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/25/20 9:09 AM, Richard Haines wrote:
> Use the filesystem type that the selinux-testsuite is running from to be
> used for tests/fs_filesystem.
> 
> Add tests/nfs_filesystem to run tests only via tools/nfs.sh. This allows
> tests on initial NFS mounts.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

