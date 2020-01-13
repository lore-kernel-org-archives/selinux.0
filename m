Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B5BC33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DC3214AF
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CyyQ3lax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMTAV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:00:21 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:23243 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgAMTAV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 14:00:21 -0500
X-EEMSG-check-017: 65628967|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="65628967"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 19:00:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578942017; x=1610478017;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=hwwe8p/hBThCpGwbHGDw1LNLxRq+ovEBBOwL/n4oxvg=;
  b=CyyQ3laxZ9rsQh2qRX0gj/DE+TEl7gtWFZr6gj0BtIqLQh8/eIKQJpKu
   3nhaKfeZRTis6m6SfN0P/AcWXsBNHHJ0ABwrLxV2vm82qZzucSAJvViJQ
   I0balPaPKVJLuNHzmd21ZUTuJnCogHCz2o+NUH3Z9Pn1P97A2cCYWorQs
   EI9a42hQo031/dszo/EPmGNvRV9yqo10c/7yqsIIriAcRXKdE0IEklFTx
   SM9TOg6rUkB02obJ3+RCbdi7JzkGvELRoaL0pOU2cPCgpUJdUzsszX1H7
   2rgFvFTlP0oGGfOFOr5Q9sbAS0ukQhOAGalVG2scwGap8xBVF2XtF19hF
   w==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37703140"
IronPort-PHdr: =?us-ascii?q?9a23=3A6SDluxMZMQ/+9CkwFl4l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/j4rarrMEGX3/hxlliBBdydt6sfzbCJ6+u5ADFIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQjTqsUajpZuJrsxxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBWzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2L8wlp?=
 =?us-ascii?q?wdsUTEBS/5hln5gLWKdkQk5ueo6+Pnbq/gppCALI97lhvyMqEvmsy7Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkybHu8kL0TK9Kg/EriKXVrp/XKdoBqqKkGwNV15ws6xe7Dzeoyt?=
 =?us-ascii?q?QYmnwHIUpeeB2alIjkIE3OIfDkAve/hFSgijFrx+vcMbH7DZXNKWbDnK/7fb?=
 =?us-ascii?q?lh805c1BYzzddH6pJOC7EOPPLzVVXrtNPFFhA2LxS7w+b9B9V80IMRR3mPD7?=
 =?us-ascii?q?SCP6POsF+I4P4vLPeWZI8Tpjn9N+Ip6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?6ZbmTogtcAF2cKowU/Qff0iF2NTzFTfWy+X6Ei6TEhDoKpE4PDSpqqgLyb0y?=
 =?us-ascii?q?foVqFRM1pHAVCFC3ugV4yFXfoXIHaII8RhmyYIYrOWS4Yg0xy1nAXmyrx7I/?=
 =?us-ascii?q?DS9zFevpXmgpw9/ODXlBcv5RRqAMmHlWKAVWd5miUPXTBl8rp4pBlG1lqb0a?=
 =?us-ascii?q?V+y8ddHNhX6uIBBhw2LrbA3ud6DJb0QQuHcdCXHgX1Cu66CC08G4pii+QFZF?=
 =?us-ascii?q?xwTpD71UHO?=
X-IPAS-Result: =?us-ascii?q?A2CMAgCBvRxe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhAyJA4ZtBoE3iW6RSAkBAQEBAQEBAQE3AQGEQAKCHDgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjFVELGAICJgICVwYBDAYCAQGCYz+CSwMJJ?=
 =?us-ascii?q?asDgTKFSYNOgT2BDiiMM3mBB4E4D4JdPoIbhT6CPCIEjXyISGFGl1GCQYJIk?=
 =?us-ascii?q?18GG5psjludByKBWCsIAhgIIQ+DJ1AYDZZlIwMwjR8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 19:00:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DIxcRO132390;
        Mon, 13 Jan 2020 13:59:38 -0500
Subject: Re: [PATCH V3 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
 <20200112192432.862800-2-richard_c_haines@btinternet.com>
 <02e4c12e-7cf9-2b10-cc3e-f1570a0c35c0@tycho.nsa.gov>
 <5c01146696d7e5e5e9132c10b9121a2830758914.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d68f2230-38da-ef6a-fa67-5631fb88f9a0@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 14:01:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5c01146696d7e5e5e9132c10b9121a2830758914.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/13/20 1:32 PM, Richard Haines wrote:
> On Mon, 2020-01-13 at 10:45 -0500, Stephen Smalley wrote:
>> On 1/12/20 2:24 PM, Richard Haines wrote:
>>> Test filesystem permissions, setfscreatecon(3), file { quotaon }
>>> and
>>> changing file context via 'name type_transition rule'.
>>>
>>>   From kernels 5.5 filesystem { watch } is also tested.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> Aside from the travis-ci build failure when trying to build the test
>> policy against upstream refpolicy, this looks good to me.  NB you
>> can
>> reproduce such failures yourself by creating your own github clone
>> of
>> selinux-testsuite, enabling travis-ci on your clone, and pushing
>> your
>> change to a branch of our clone.
>>
>> Possible room for improvement (but I won't insist) might include:
>> - test non-name based type transition rule with a different type and
>> confirm that both files are createdi in the right type (i.e. make
>> sure
>> we are actually matching on the component name),
>> - test two different name-based type transition rules that only
>> differ
>> in name (similar),
>> - add tests for the new mount API, fsopen(), fspick(), fsmount().
>>
>> These could all be done as separate patches later.
> 
> If you are in no hurry for these tests I'll do them for V4.
> 
> I found a helpful example in samples/vfs/test-fsmount.c for fsmount and
> fsopen. Also see they were added in 5.1

Up to you; they can always be done as a separate follow-up patch later.
The new syscalls don't appear to have been wired up until v5.2.
