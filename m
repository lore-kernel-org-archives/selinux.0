Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8FC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D4E2071E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gO+P9kfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbgAXTck (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:32:40 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:32910 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbgAXTck (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:32:40 -0500
X-EEMSG-check-017: 73158916|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="73158916"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 19:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579893911; x=1611429911;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y6RGAG5oIIcupFA5ZXA0UWU6cH3omQ4th6mLPIIrOUw=;
  b=gO+P9kfJP9ZnQYBNPqP7nT9VSYHZsEqkF1vfaImK9jzL7CSrvwlQKbwS
   JjU6rXbVXXubeHDTLrS0b1zer52QVc6faKg8fvNyysAqLTqg4aUCClem3
   vbXSB33+pUtgx1sbgekGBLh51t8bHCvF3t7FhDyu5vfgObPFC8kgWpAIu
   wXYhSGNn5ZJpmoWqiDDTVFTz8Cqq5iIWGJpVy4tOblUlYTtkTJ5oRiqah
   /tCVAwv3/R7CLQEfLVtNHQJoIkn3+auqaHXioaAiUCGK1OqWqNTmY6gCF
   a6Jygrj9kLVIkxzNoZextcW+7ft1mHHjdslu2MV6qXRUurwpeVefwOeMp
   g==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="38228693"
IronPort-PHdr: =?us-ascii?q?9a23=3AM9xs0RxpDEmgtjjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoSKfad9pjvdHbS+e9qxAeQG9mCt7Qe16GP6fmoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF8Jqs+xR?=
 =?us-ascii?q?fFv2VEd/lLzm9sOV6fggzw68it8JNt6Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjZotH4OKIUXOuozqfH0C/DYutL1znj5ojGchMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1UYhGhjZjliSs4HpIy+Z2+oPvmWd8uFuVfivi2kiqwxpvzav2tkjip?=
 =?us-ascii?q?HJho0LzFDP6Dh3wIMvKt28TE50f96lG4ZXuiGBKoR2WdgvQ31ouSkmyr0Gvo?=
 =?us-ascii?q?S3fC4RyJs93RLfZPuHc5aR7x/lSe2fIi94iWp4dL+wiBu+60itxvDmWsWq31?=
 =?us-ascii?q?tGsDBJnsTKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOakUr4PKo6+X6YrX9vJOcNol0ig/5MqQ1hMOwHf40Mh?=
 =?us-ascii?q?QOXmeH+eS806fv/UvlT7VRkvI6iKzZsJHeJcgDp665BRFa0po75hqiADqr38?=
 =?us-ascii?q?4UkHkaIF5fZh6KgJblN0vTLPzgCPewmVWskDNlx/DcOb3hB43ALmPen7f6Zr?=
 =?us-ascii?q?t9905dxxYzzdBY/Z5UDKoBL+jpVk/+s9zYEAc1MxaozOb/FNV9yoQeVHqXAq?=
 =?us-ascii?q?CDLaPStUSF5vo1LOmRYI8ZoTP9K/8i5/70k3A1g0MSfa6s3ZEPcnC3AuxmI1?=
 =?us-ascii?q?mFYXrrmtoBC2YKsRY+TOPwkl2NTCZcaGqqUKI8/D47CYSmApnYRo22m7OBwC?=
 =?us-ascii?q?a7HptKZm9YEFCMF2nnd5meV/gQbyKSJ9drkiYYWri5V48hyRauuRfhy7V5Ku?=
 =?us-ascii?q?rU+ysYtY/s1dVu+e3Tmg899SZuA8SezW6NVWd0kX0MRzMs26B/u0N9wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwc9MJ7cyPd6C9boVQ3dYNiEU0ymTcu7DjExVN0x38UCbF?=
 =?us-ascii?q?p6G9Wn3Vj/2H+SCqIR35mMA4Y5uvbE1mX1D9501nKD0a4mlVRgScxKYz6InK?=
 =?us-ascii?q?l6ojPPCpbJnkPRrKOjcaARzWaZ72uY5Xaft0FfFghrWOPKWm5JNRielsjw+k?=
 =?us-ascii?q?6XF+zmMr8gKAYUjJfZe6Y=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwAgA9Qyte/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z5BoESJYlvkUkJAQEBAQEBAQEBNwEBhEACgkY4EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGCegEFIxVBEAsYAgImAgJXBg0GAgEBgmM/gksDC?=
 =?us-ascii?q?SWuLIEyhUqDO4E+gQ4qjDF5gQeBEScMA4JdPoIbhT6CPCIElzRGl16CQ4JMk?=
 =?us-ascii?q?2UGG5p8q34igVgrCAIYCCEPgydQGA2JKAEHjTUjAzCNVgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 19:25:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OJOSDG111108;
        Fri, 24 Jan 2020 14:24:28 -0500
Subject: Re: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-3-richard_c_haines@btinternet.com>
 <8467a014-e9aa-c148-ebc3-25c79c1853c5@tycho.nsa.gov>
 <CAHC9VhTkhrdTPfhBMD=tBqVbCZBGdQS+fPHO1y4k79-CQrAPiw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <693e8b96-32a6-6854-eb12-cff93f470ae4@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 14:25:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTkhrdTPfhBMD=tBqVbCZBGdQS+fPHO1y4k79-CQrAPiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 2:17 PM, Paul Moore wrote:
> On Fri, Jan 24, 2020 at 10:12 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 1/20/20 6:11 AM, Richard Haines wrote:
>>> Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
>>> fspick(2) and fsmount(2) api's introduced in kernel 5.2.
>>>
>>> Also tests move_mount(2) using open_tree(2).
>>>
>>> These tests use common code from tests/filesystem.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> Only question I have is whether we want to enable the move_mount test
>> unconditionally and let it break on kernels with the regression.  Otherwise,
> 
> Historically we haven't broken the test suite for older kernels, but I
> will admit that testing older kernels is no longer a priority for me.

If it were a new permission, I'd agree that we definitely want it 
conditional on the appropriate kernel version.  Since it is a fix for a 
regression in checking an existing permission, it wasn't as clear to me.
Won't matter for RHEL because the fs_filesystem tests are only enabled 
for >= 5.2 since the new system calls weren't added until then, so none 
of these tests will run on RHEL regardless.  It would only show up on 
Fedora kernels from 5.2 through 5.5 that don't have the fix back-ported.
