Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4684C4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97484222C0
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jNqu8zVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfIZMy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:54:56 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:37876 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:54:56 -0400
X-EEMSG-check-017: 32339499|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="32339499"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569502494; x=1601038494;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8VgAAHc0NbuPjIA5QuUu/c4xizSGUV35KYi4qh8mjMw=;
  b=jNqu8zVEc4/EtzOUZQxB108Ts04bNj8lB5GB7Z7VoB8dtzoLHMOvGGV7
   D9XySgipjU+MYi54QHXSuxEQNgG67gkUgTF9C7I5boDH3DU2lpKzD6R4p
   6G0pVHILvr6ogWVKvyS1YUgNdR7RMvU0ZlFQnNzjWpmhatOVS9qJzKd4D
   OtU7+VFkUwV3ZDSIwTb74c5c7BfQDYSP4aq1jCMxcLC8VAYr1BvGIIMCT
   l9fRgoCpjxXVFBCciZH5x7iaCcjs3Qk5Rjn/FqbGEuJX2ng06Y4Z2J7pL
   kqhgY7vdkgbCwqhvzcydSYmGD93IgMeeh8l3Ci3l68J03SqKsa7da8MBz
   w==;
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="33383522"
IronPort-PHdr: =?us-ascii?q?9a23=3ANZoAURzNofaSBDfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+ITIJqq85mqBkHD//Il1AaPAdyArakYwLeN+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanb75/Ixq6oAXfu8ILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUUSm?=
 =?us-ascii?q?pbWsZaSjJPDIWyYYASC+YNJOhVoo34q1YIsBCwBxSjBPn3xzFVmHH206003e?=
 =?us-ascii?q?cvHw7I0wMvHc4BvnvPodXpNqofS/y5wLXGwDjBaf5dxDfz6JLPchAkufyCQK?=
 =?us-ascii?q?5wftTJyUkvCQzFiEibp5HgPzyP0uQNt3aU7up9Xu+okG4othpxryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqiKUN5NuT88/TGxltzw2x70btZ?=
 =?us-ascii?q?KhYiQHx4orywTCZ/GBboOG+AjsVPyLLjd9nH9lfbW/iAus/kW40e38U9W00E?=
 =?us-ascii?q?5NripYjtnArnAN2ALX6siAUvZ94l2u2SyO1wDO8eFIO1w0lKrHJJ4hxb48jJ?=
 =?us-ascii?q?wTvljYHiDqgkn2ia6WdkE89uip7eTofKnmq4eBO4J7hQzyKKQjltGlDegmPQ?=
 =?us-ascii?q?UCQXKX9fmk2L3m50L5QbFKjvMskqnetZDXPd8bqbOiAwJOzoYi6wqwDzeh0N?=
 =?us-ascii?q?gCm3kHN0hKdAiIj4juJVHCOOr4Auung1SwjDdrwOjLPqXlAprXM3jDjK3hcq?=
 =?us-ascii?q?1n5ENH0go8081Q55JOBbEdOv78RkjxtNnABB8jLwO02/rnCMl61o4GQmKAHK?=
 =?us-ascii?q?uZMKLUsV+V6eMiOPeMZIALtzbnMfQl5ODhjWU/mVADeamlx5wXaGq3HqcuH0?=
 =?us-ascii?q?LMWXfwmJ8lGHoWpAA3R+yi3EWGWCNPfXy7d7gx6jEyFMStCoKVAsi2jbiA2j?=
 =?us-ascii?q?qrNoNZa3oACV2WF3rsMYKeVKQiciWXd/R9nyQEWL7pcIoo0RWjpUeu0LZ8Bv?=
 =?us-ascii?q?bF8S0f85T43Z564POFxkJ6ziB9E8nIizLFdGpzhG5dAmZtja0=3D?=
X-IPAS-Result: =?us-ascii?q?A2B/AQCDtIxd/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqbVMyKoQijw1NAQEBAQEBBoE2gmOHBA6RKAkBAQEBAQEBAQEjEQECAQGEP?=
 =?us-ascii?q?wKDMSM3Bg4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQUjFVELDgoCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYFqAwkUrw2BMoVMgzuBSIEMKAGKBYIGGHiBB4ERJ4JrP?=
 =?us-ascii?q?oIagXODQoJYBIxniD1ggTKVGUGCLIIuhFeKBYN6BhuDKJYDjhuKG5EKIoFYK?=
 =?us-ascii?q?wgCGAghD4MnCUcQFIJ1AQeIKIUKJAMwgQYBAYsgglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2019 12:54:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCspPv003902;
        Thu, 26 Sep 2019 08:54:51 -0400
Subject: Re: [PATCH] gui: Fix remove module in system-config-selinux
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190924191221.245789-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7cc0dfdc-f56d-15e9-f99b-a83908d51ec6@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 08:54:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924191221.245789-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 3:12 PM, Petr Lautrbach wrote:
> When a user tried to remove a policy module with priority other than 400 via
> GUI, it failed with a message:
> 
> libsemanage.semanage_direct_remove_key: Unable to remove module somemodule at priority 400. (No such file or directory).
> 
> This is fixed by calling "semodule -x PRIORITY -r NAME" instead of
> "semodule -r NAME".
> 
>  From Jono Hein <fredwacko40@hotmail.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>   gui/modulesPage.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> index cb856b2d..0584acf9 100644
> --- a/gui/modulesPage.py
> +++ b/gui/modulesPage.py
> @@ -125,9 +125,10 @@ class modulesPage(semanagePage):
>       def delete(self):
>           store, iter = self.view.get_selection().get_selected()
>           module = store.get_value(iter, 0)
> +        priority = store.get_value(iter, 1)
>           try:
>               self.wait()
> -            status, output = getstatusoutput("semodule -r %s" % module)
> +            status, output = getstatusoutput("semodule -X %s -r %s" % (priority, module))
>               self.ready()
>               if status != 0:
>                   self.error(output)
> 

