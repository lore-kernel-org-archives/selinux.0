Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD73C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACCE206C2
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aaI4yrBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfIPTue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:50:34 -0400
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:65164 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbfIPTue (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:50:34 -0400
X-EEMSG-check-017: 28442044|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28442044"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 19:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568663424; x=1600199424;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eyj30OA5tFZGgvE36QhYjDMMap2EVFSexRcu6zzfr0g=;
  b=aaI4yrBeRGd+16NwMFbJEDtbCXsJqK0/QzSjYhlKiLNmn3tr0PXu4EgH
   yEFtlVyLw2GoCHtaf9zx067BWiQMljBQ2LlzoMP4MQHe/ek01VXrb81SD
   d/D+pQ9UjdVXVhjXvAhlMEKaVRZnMEzQGZm547908ZMXge8eEZ1v/9wvo
   wjI+mdCkxWChjEkK2z+tbC6Az8baOUVPOpObjwbWxf+toMnMePDHqNZno
   geykKgkl32og4kYOJOUd6tp/tql4ndRPEPVqUjt479xH5Ga/3MMkdY1b8
   uYKNNesm3Fepcq8oMBSPFa6lzJl+D0wWFnFhZmmd91Y6LUYRDj3F8UaMM
   g==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27970508"
IronPort-PHdr: =?us-ascii?q?9a23=3AZ9ybbh3MzmztF8vFsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPzxwZ3uMQTl6Ol3ixeRBMOHsqkC0rGd6vy6ESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4N6o8xB?=
 =?us-ascii?q?TFrmZHduhI2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodXxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdq5boMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN5N0iw7iMqQundazAeIkPQ?=
 =?us-ascii?q?gVQ2eX4+G81Lzn/UHhQbVKiOM5krXBvZzHKskWqbS1Dg9I3oo59RqyACmq3M?=
 =?us-ascii?q?4FkXUfKVJKYhOHj4znO1HUJ/D4CO+yg0+xnzdw3P3GIr3gDYnNLnjEirvhe6?=
 =?us-ascii?q?195FRGxAo8ytBf+YpYCqsdL/LrRk/xqNvYAwchMwOu3ubnDM5w1psEVmKSBq?=
 =?us-ascii?q?+VKabSsViP5uI1PeaAfpMauDH4K/I9/f7hkWc5mUMBfamuxZYXbG64Hu58LE?=
 =?us-ascii?q?qCf3XjnswMEX0UsQUjTOzlkkGCXSRPaHa1WqI2/is7B56+DYffWoCth6SM3D?=
 =?us-ascii?q?ylEZ1SZ2BGDE2MEHjzeoWaVPcDdjiSLtVikjMaT7ihTZEu1RW0uA/90bpnIb?=
 =?us-ascii?q?mcxipNjZv+0JBQ4OrJmFlm7TVpC+yF2nyJCmRzmXkFATQx2fY76WV00FCFmY?=
 =?us-ascii?q?d/gvBVEZQH7vhGVQY2OLbA3ud6DJb0QQuHcdCXHhLuZsilCCp5cMg4ydIFKx?=
 =?us-ascii?q?J5Bc+rhB3I9zCnD78ci/qAA5lioYzG2H2kHNpw03bL0uEailAiRsZefTm9ir?=
 =?us-ascii?q?VX6xnYB4mPlV6Q0amta/JPj2b26G6fwD/W7wljWwlqXPCABC1Oaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BdAABj5n9d/wHyM5BmHAEBAQQBAQcEAQGBUwcBAQsBg?=
 =?us-ascii?q?W0qgT8BMiqEIYgchzoBAQEBAQEGgTaJc48sgXsJAQEBAQEBAQEBNAECAQGEP?=
 =?us-ascii?q?wKCbyM0CQ4CDAEBAQQBAQEBAQUDAQFshTqCOikBgmcBBSMVQRALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+BdxStWYEyhUyDN4FJgQwoAYt3GHiBB4E4gms+h0+CWASVc?=
 =?us-ascii?q?ZZ5giyCLpJMBhuZGY4Jmnw4gVgrCAIYCCEPgyeRIyQDMIEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 19:50:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GJoLGc027705;
        Mon, 16 Sep 2019 15:50:21 -0400
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
To:     Paul Moore <paul@paul-moore.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Lukas Vrabec <lvrabec@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
 <CAHC9VhQqrgR7+qakF+bz-i0tL9fN0YQSSmXMyGL-TeLnkNpBkQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <86cf3ab6-1a31-f6bf-ad8c-e0c8e3fef331@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 15:50:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQqrgR7+qakF+bz-i0tL9fN0YQSSmXMyGL-TeLnkNpBkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/27/19 1:14 PM, Paul Moore wrote:
> On Wed, Jul 10, 2019 at 9:40 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>
>> Added a suite to test permissions for setting inotify and fanotify watches
>> on filesystem objects. Tests watch, watch_with_perm, and watch_reads permissions.
>>
>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>> ---
>>   policy/Makefile              |   4 ++
>>   policy/test_notify.te        |  74 ++++++++++++++++++++++++
>>   tests/Makefile               |   4 ++
>>   tests/notify/Makefile        |   5 ++
>>   tests/notify/test            | 101 +++++++++++++++++++++++++++++++++
>>   tests/notify/test_fanotify.c | 105 +++++++++++++++++++++++++++++++++++
>>   tests/notify/test_inotify.c  |  43 ++++++++++++++
>>   7 files changed, 336 insertions(+)
>>   create mode 100644 policy/test_notify.te
>>   create mode 100644 tests/notify/Makefile
>>   create mode 100755 tests/notify/test
>>   create mode 100644 tests/notify/test_fanotify.c
>>   create mode 100644 tests/notify/test_inotify.c
> 
> FYI, I'm still waiting on the new permissions to show up in the
> Rawhide policy so I can test this and verify everything is working
> correctly with a "released" policy.
> 
> I also had to perform a number of fixes to get 'make check-syntax' to
> run cleanly.

Anything we could/should do to help this along?


