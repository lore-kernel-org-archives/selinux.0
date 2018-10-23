Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC01C7112C
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A672207DD
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 14:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A672207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeJWWbN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:31:13 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:7576 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbeJWWbN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 18:31:13 -0400
X-EEMSG-check-008: 225301871|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Oct 2018 14:05:34 +0000
X-IronPort-AV: E=Sophos;i="5.54,416,1534809600"; 
   d="scan'208";a="19762085"
IronPort-PHdr: =?us-ascii?q?9a23=3ANc8CRxSzgZKXVCC3W/hwtiEJGdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yZxKN2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujaPrzuHpXNKWTDkLf6cL?=
 =?us-ascii?q?Zy7k5T0gszzdRF651IDbEBJer5WlXtu9zAEh85Lwu0zv78CNpj0oMeWGSPAr?=
 =?us-ascii?q?KWMa7Jr1+I6fwgI/OWaI8Wpjn9Mf4l6ODqjXMjnl8dZ6apjtMrbyWEE/guH0?=
 =?us-ascii?q?KFYTK4nscdFnsKlgU7Re3uzlaFVGgASWy1WvcH+jwjCI+gRbzGT4Spja3JiD?=
 =?us-ascii?q?y3BbVKd2tGDRaKCn6ueIKaDaRfIBmOK9Nsx2RXHYOqTJUsgFT37lf3?=
X-IPAS-Result: =?us-ascii?q?A2BCAwDjKc9b/wHyM5BjHAEBAQQBAQcEAQGBZYFbKoFlK?=
 =?us-ascii?q?IN1lDVSBoEQJYkIkAc4AYRAAoUqITgWAQMBAQEBAQECAWwogjYkAYJfAQEBA?=
 =?us-ascii?q?QIBIxU2CxALDgoCAiMDAgJGEQYNBgIBAYJeP4F1BQimM4EuhTuEZ4ELilcXe?=
 =?us-ascii?q?YEHgTgMgl+IAYJXAo5MQo9CCZBuBheQMJhFIYFVKwgCGAghDzuCbJBzIzCBB?=
 =?us-ascii?q?QEBjCYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Oct 2018 14:05:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9NE5WGo031411;
        Tue, 23 Oct 2018 10:05:32 -0400
Subject: Re: cil mlsconstrain
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@tycho.nsa.gov>, selinux@vger.kernel.org
References: <CAFPpqQHvYnbX8YVU0rbZQE4T1EesyJt6BQb7nW=jrv5aWayBNg@mail.gmail.com>
 <e52fa402-8d43-04a8-4f00-3550b7fbf89f@tycho.nsa.gov>
 <CAFPpqQGH5cnLU4rgvnw9m-4_2wCLoge3P85tJoGnq04AYJTUPw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2b6c54c8-8e83-9f2f-4062-e4ce2a3750a1@tycho.nsa.gov>
Date:   Tue, 23 Oct 2018 10:07:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFPpqQGH5cnLU4rgvnw9m-4_2wCLoge3P85tJoGnq04AYJTUPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/23/2018 09:56 AM, Ted Toth wrote:
> 
> 
> On Tue, Oct 23, 2018 at 8:39 AM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 10/23/2018 09:33 AM, Ted Toth wrote:
>      > Is it possible to modify/replace an existing mlsconstrain? In
>     playing
>      > around I created multiple instances of a mlsconstrain and
>     variations of
>      > mlsconstrains but haven't figured out how to clean them up as I get
>      > "Error: Unknown keyword delete' when trying to delete my experiments.
> 
>     Possibly I misunderstand, but can't you just remove or replace the
>     module that defined it previously?
> 
> 
> We make some changes to several 'x_*' mls constraints which as far as I 
> know are not part of a module.

They have to live in some module, base or otherwise.
You can extract the CIL for the module in which you defined them via 
semodule -cE <module-name>, e.g. semodule -cE base.  Then you can edit 
them in that base.cil or other file and re-insert the updated one.


> 
> 
>     BTW, selinux mailing list has moved to selinux@vger.kernel.org
>     <mailto:selinux@vger.kernel.org>.
> 
> Thanks for the reminder now I just need gmail to remember :(

