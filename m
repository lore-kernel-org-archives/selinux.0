Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EAAC47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2653E20B7C
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mufB4S8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJIS1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:27:21 -0400
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:61059 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfJIS1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 14:27:21 -0400
X-EEMSG-check-017: 21147934|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,277,1566864000"; 
   d="scan'208";a="21147934"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 18:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570645638; x=1602181638;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5je9TvXBK5qPRrHhc27YDlnSE5gT/7LqUciNwlAHC4s=;
  b=mufB4S8o0AkZRdoRlW6AI/nOzv4iCbzCU7M6JMBGk4AVHuEScAuFRKNR
   JPtN87w5Q0NyT5XRFvb8KmsFzOso3BAWe85TleLaMerUP2vEAbq2MO15Y
   0JdlAlH2eiAPRom3bNsExhHElTmLqaKmmIsb4e7MIKLlZwbViTluFd33H
   WJjMeIjPHXAyvOoaj5KrTA7oDzgzeA82NSdEIwDXWtVZaMuk5w7ibJUeu
   3b0A8X9x6WTA6s4JJUMSNtFta+PB90jtY3TGe9k1ltLJmpB/xvrdcGnqT
   Pf5voqCbktohHRMlKSpjrpzl075rgQ9MoK94sJLhwZ66UuG4VuwdJhKRR
   A==;
X-IronPort-AV: E=Sophos;i="5.67,277,1566864000"; 
   d="scan'208";a="28828564"
IronPort-PHdr: =?us-ascii?q?9a23=3AdWqEUBX9b4CwsfQenmMefC5P6NLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSGv6dThVPEFb/W9+hDw7KP9fy5AipeuN3Y6ClKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMXjId/Jao91w?=
 =?us-ascii?q?fFrmZVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhCufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00xLoGuZ?=
 =?us-ascii?q?uhcygLzpQq3wTfZOKafIiI+B3jSPydLit/hHJgYL6/iBey8VSgyu3hTca4yk?=
 =?us-ascii?q?pFri1AktTKq3sD1ATT59CaRvZy8UqtwzaC2x3J5u1aLk04i7DXJ4Mnz7UtjJ?=
 =?us-ascii?q?Qcq17DETXzmEjuia+WcVgr9faw5uT8Z7XmuoecN4hpigHiKqgumtKwAeA/Mg?=
 =?us-ascii?q?UWQ2iU4/681Lz+/U3iWrlKkv03nbXZsJDdP8gboLK2AxRJ3Yo57ha/DjOm3M?=
 =?us-ascii?q?wZnXkBMl1FZAqKg5XmNlzBOvz1Deqzj06ynDpk2fzKJKDtDo3ILnfZkbfheb?=
 =?us-ascii?q?h961RbyAo21d1f/I9bCqoaLfLvWk7+qNzYDhgjPwyy2OboEs9x1owZWWKRGq?=
 =?us-ascii?q?OZKr/dsUeU5uIzJOmBfJcVtyzgK/gh/PPulWU2mUIZfaWw2JsXb3e4Hu54LE?=
 =?us-ascii?q?mDfXXshdIBG38QvgUiVOzqlEGCUTlLana1WqI84So7CIS8AojfWI+gm6aB0z?=
 =?us-ascii?q?mmEZ1WfG9GFkqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU5Qh2g+qtA/7zbpnM+?=
 =?us-ascii?q?XV9zYGtZLsytd1/ffflRIs+jxuCcSSzWWNQ3tznmMSSD9llJx49HR011PL9K?=
 =?us-ascii?q?9/mfEQQcRa+vdhSg4nMdvZyOtgBpb5XQeXOp+uTlq8T9fuJDYqSNs6ztxGN0?=
 =?us-ascii?q?F4HM6khxvO9zCnD78ci/qAA5lioYzG2H2kHNpw03bL0uEailAiRsZefTm9ir?=
 =?us-ascii?q?VX6xnYB4mPlV6Q0amta/JPj2b26G6fwD/W7wljWwlqXPCABCtOaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CPAgDDJZ5d/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F0LGxSATIqhCOPKwEBAQEGgTaJeJEuCQEBAQEBAQEBASsJAQIBAYRAA?=
 =?us-ascii?q?oJPIzgTAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCZwEBAQEDIxVBEAsVAwICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz8BglIlD692dYEyhU2DLYFCBoEMKIwOGHiBB4ERJ4JrP?=
 =?us-ascii?q?oJhAgIYhFWCXgSMYYlGlxyCLIIvhFmOCwYbmUCOLYgikyUigUEPCCsIAhgII?=
 =?us-ascii?q?Q+DJ1AQFIVCim8lAzABgQUBAZATAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Oct 2019 18:27:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99IRFPa015426;
        Wed, 9 Oct 2019 14:27:16 -0400
Subject: Re: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <156936589827.661145.16998799838921887816.stgit@chester>
 <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
 <CAHC9VhQkwySJJecbZLh1bSNV-oMEy8Ch_ZmuujOHiu7UgeYYiA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d9248c65-d22c-4a4f-5fbd-8db9ed087d45@tycho.nsa.gov>
Date:   Wed, 9 Oct 2019 14:27:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQkwySJJecbZLh1bSNV-oMEy8Ch_ZmuujOHiu7UgeYYiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/25/19 11:22 AM, Paul Moore wrote:
> On Wed, Sep 25, 2019 at 5:06 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Wed, Sep 25, 2019 at 12:58 AM Paul Moore <paul@paul-moore.com> wrote:
>>> From: Paul Moore <paul@paul-moore.com>
>>>
>>> On a modern Rawhide system builds that include libbpf require libelf
>>> as well to avoid the following linker errors:
>>>
>>>   # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
>>>      client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o client
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getshdr'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_rawdata'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getscn'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_begin'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getrel'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_memory'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_end'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_strptr'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_nextscn'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getehdr'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_version'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getdata'
>>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getsym'
>>
>> This is a bug in libbpf. I filed a bug against the Fedora package [1]
>> and also opened a PR [2] against the upstream repo (which is a
>> modified mirror of the code in the kernel repo under tools/lib/bpf,
>> where the bug is not present), which I think should fix this problem
>> also in the Fedora builds.
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1755317
>> [2] https://github.com/libbpf/libbpf/pull/72
> 
> Thanks for tracking down the root cause and filing a report upstream;
> I didn't have time to sort out the "why", I just wanted to get the
> test working again :)
> 
> It looks like the best course of action is to hold off on this fix in
> hopes that it gets fixed upstream, or at least in Fedora.  If this
> issue persists for a week or two we can always go ahead and merge this
> fix, it shouldn't break anything if/when this gets fixed upstream.
> 
> Tests that fail to run made me sad :(

FWIW, this is still broken on F30 (don't know about F31).  Any chance we 
can get the updated package pushed to F30/F31 too?

