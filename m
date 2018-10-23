Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB692C46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9582075D
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 13:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9582075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeJWWCX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:02:23 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:43855 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWWCX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 18:02:23 -0400
X-EEMSG-check-008: 783390403|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,416,1534809600"; 
   d="scan'208";a="783390403"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Oct 2018 13:38:52 +0000
X-IronPort-AV: E=Sophos;i="5.54,416,1534809600"; 
   d="scan'208";a="19760004"
IronPort-PHdr: =?us-ascii?q?9a23=3AeHw1URHXviT0Hd+ZnTqtTZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zocWwAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS93x/HJIr3hBYnNLnjYnbfueL?=
 =?us-ascii?q?Zy8U9cyA4pwd9D4JJUD6kLIOjvVU/pqNzYEhg5PhSvw+n5DNV914UeWX+AA6?=
 =?us-ascii?q?KCLqPSvkGH5vg1L+mPeoAVojD9JOYh5/L0in85g1AdLuGV2s4rZXzwIvN6Iw?=
 =?us-ascii?q?3NfWrwhcsBOWgPtws6CuftjQvGGQV+Q3e0QrJ0sio2DIOgEJfrWpGmgLvH2j?=
 =?us-ascii?q?yyWJJReDYVJEqLFCLTa4icW/oKIBmXK8tlny1MAaOtUKc9xBqus0n80LMhIe?=
 =?us-ascii?q?3KrH5L/an/3cR4srWA3So58iZ5WoHEiTmA?=
X-IPAS-Result: =?us-ascii?q?A2CWAAAlJM9b/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?QKBWSqBZSiDdZQ1UgaBNYkIkAc4AYRAAoUqITkJDAEDAQEBAQEBAgFsKII2J?=
 =?us-ascii?q?AGCYAEFIxU2CxALDgoCAiYCAlcGAQwGAgEBgl4/gXUNpi6BLoU7hGeBC4pXF?=
 =?us-ascii?q?3mBB4E4gmuIAYJXAo8Oj0IJkG4GF4FDjm2YRiCBVSsIAhgIIQ87gmyQcyMwg?=
 =?us-ascii?q?QUBAYwmAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Oct 2018 13:38:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9NDcj1x026251;
        Tue, 23 Oct 2018 09:38:45 -0400
Subject: Re: cil mlsconstrain
To:     Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
References: <CAFPpqQHvYnbX8YVU0rbZQE4T1EesyJt6BQb7nW=jrv5aWayBNg@mail.gmail.com>
Cc:     selinux@vger.kernel.org
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e52fa402-8d43-04a8-4f00-3550b7fbf89f@tycho.nsa.gov>
Date:   Tue, 23 Oct 2018 09:40:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFPpqQHvYnbX8YVU0rbZQE4T1EesyJt6BQb7nW=jrv5aWayBNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/23/2018 09:33 AM, Ted Toth wrote:
> Is it possible to modify/replace an existing mlsconstrain? In playing 
> around I created multiple instances of a mlsconstrain and variations of 
> mlsconstrains but haven't figured out how to clean them up as I get 
> "Error: Unknown keyword delete' when trying to delete my experiments.

Possibly I misunderstand, but can't you just remove or replace the 
module that defined it previously?

BTW, selinux mailing list has moved to selinux@vger.kernel.org.

