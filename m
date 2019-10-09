Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4515BC47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1362221835
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hg1M9Gzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJINxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:53:21 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:32850 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfJINxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 09:53:21 -0400
X-EEMSG-check-017: 33827464|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33827464"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 13:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570629197; x=1602165197;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SrSG2VSZOOyVdWmrI6qphsUrUsskcx7Jt28YeOPSQ3M=;
  b=hg1M9GzbCahS/1HYwoS3xOX0MAjVBUlooZeqikG3uuI9cOxl4oCRshxt
   teM5AhcUjxvqaB3GX62OlSV9rRgcG3BQ5LjLS/HDeFxFQEmFplWr22tT3
   oOpOJoeRgIsrbmfLEAwzmbwFaVtv9uJNkxdrnG14q3OM+9TWWQZHoB+iy
   UOjEEROrnlfaXxuaJOjaKgXYbm6U8PTS3uy4lyyhfd2x4pogsGMO5oKrv
   F6lzk08HgjfStUwUFUpc/98w0EsFVehqo7Nn5Devv27AKtGYcoWar6JCR
   oirAiPCt1Ri8Vv637l82zjWfp4g3SOX+1oyAb7eepMoMTaTKBVLC61nKs
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33953121"
IronPort-PHdr: =?us-ascii?q?9a23=3ACzLOixa+r7oseblXI765INL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs26bnLW6fgltlLVR4KTs6sC17ON9f65EjZfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrAjdq8YajZVgJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlsDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660GxRV3Zs46xukEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKHlJLmN0vBIPD/E/ezm06snytzx/DaIr3hBY3ALmDZn7f8eb?=
 =?us-ascii?q?Zw8FZcxxAuzdBb/p5UD7YBIPXpWkDvrtDXEhg5Mwmsyeb9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBN6PStFiI5vkpI+aWeIAapi3wK+I76PHzjX82g0MdcbO10psQbXCyBu5mLF?=
 =?us-ascii?q?mBYXrwntcBFn8HvhEgQ+zuiV2CVyNTZnmpUqIi6TE0FpimAZ3ARo+zmryB2j?=
 =?us-ascii?q?m0HplMamBBEFCMHiSgS4LRY/4RbGq3Jch7n3RQTbG8T6c53Ayq8Qr9zKBqaO?=
 =?us-ascii?q?HT/3tLm4jk0Y1O++DLlRw0vQdxBsCZ3nDFG3p4hUsUVjQ22+Z5ukU7xVCdh/?=
 =?us-ascii?q?sry8dEHMBesqsaGjwxMoTRmqkjVoH/?=
X-IPAS-Result: =?us-ascii?q?A2BNAgDd451d/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F0KoE/ATIqhCOPLQaBNol4kS4JAQEBAQEBAQEBNAECAQGEQAKCTyM4E?=
 =?us-ascii?q?wIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCaAEFIxVBEAsYAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?l8/gXcUsC+BMoVNgy+BSIEMKIwOGHiBB4E4gjY1PoEOgyCDJIJYBJYnlxyCL?=
 =?us-ascii?q?IIviXGIcwYbmUCpdCKBWCsIAhgIIQ+DJ1AQFJAxJQMwgQYBAZNdAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Oct 2019 13:53:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99DrGBI013883;
        Wed, 9 Oct 2019 09:53:16 -0400
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930131600.21473-1-omosnace@redhat.com>
 <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
 <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov>
Date:   Wed, 9 Oct 2019 09:53:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 5:30 PM, Paul Moore wrote:
> On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
>>> Add a test that verifies that SELinux permissions are not checked when
>>> mounting submounts. The test sets up a simple local NFS export on a
>>> directory which has another filesystem mounted on its subdirectory.
>>> Since the export is set up with the crossmnt option enabled, any client
>>> mount will try to transparently mount any subdirectory that has a
>>> filesystem mounted on it on the server, triggering an internal mount.
>>> The test tries to access the automounted part of this export via a
>>> client mount without having a permission to mount filesystems, expecting
>>> it to succeed.
>>>
>>> The original bug this test is checking for has been fixed in kernel
>>> commit 892620bb3454 ("selinux: always allow mounting submounts"), which
>>> has been backported to 4.9+ stable kernels.
>>>
>>> The test first checks whether it is able to export and mount directories
>>> via NFS and skips the actual tests if e.g. NFS daemon is not running.
>>> This means that the testsuite can still be run without having the NFS
>>> server installed and running.
>>
>> 1) We have to manually start nfs-server in order for the test to run;
>> else it will be skipped automatically.  Do we want to start/stop the
>> nfs-server as part of the test script?
> 
> My two cents are that I'm not sure we want to automatically start/stop
> the NFS server with the usual "make test", perhaps we have a dedicated
> NFS test target that does the setup-test-shutdown?  Other ideas are
> welcome.

I guess my concern is that anything that doesn't run with the default 
make test probably won't get run at all with any regularity.  For 
something that requires specialized hardware (e.g. InfiniBand), this is 
reasonable but that isn't true of NFS.  For the more analogous cases of 
e.g. labeled IPSEC, NetLabel, SECMARK, we already load and unload 
network configurations for the testsuite during testing.
