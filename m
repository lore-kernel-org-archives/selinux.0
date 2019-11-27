Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC9C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3133204FD
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gEg5YKtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK0PYA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:24:00 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:9892 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PYA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:24:00 -0500
X-EEMSG-check-017: 30682443|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="30682443"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 15:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574868239; x=1606404239;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HEGgHJ8HdeKqH/PWc9A0QpMLuQMRxyVfDhMwuyqhObw=;
  b=gEg5YKttIH3PvGrCqsUVPr/GNR2Ss6AmaIOIz1wQCjeine5Y+yfRCDsT
   R21vAAMZQKZbjDxa96eBnDURPwF1zPcKU0H7LD2scnb7iMSekVBuavwM7
   3Vx7SJFqxwz4YvgKOynhNYD81rvYu4tX7rgIogN/cy72zGYchyIzQnhZe
   Q/asQ4Thy/xE0yiPCPeM4rXTNCmrLhiMpx2DFaliWSNyDDWWj+i6YWWyq
   M2vD1GKYCeXez2o+Zu/LTuwujNFEOMo4Qe5asP2yPApuOGODkqwRvLSgb
   3ZLKKNn4f2ipANZjJBA0U1A1VyD8BJq6nHgXRneKXBk6kbk6ewYv2uQUk
   w==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="30559710"
IronPort-PHdr: =?us-ascii?q?9a23=3AIexYmxVjWNFTF7hVhHxY5dwgKUnV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRKPt8tkgFKBZ4jH8fUM07OQ7/m7HzVevN3e6jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIpiJ6o+yB?=
 =?us-ascii?q?bFvGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZErYBIPf0Wk/qstzXFAM2PBKvzub9Ftpyy4MeVniTAq?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v72l3A5hFsdcLKx3ZQNdXC4Gu1qI0?=
 =?us-ascii?q?CeYXrrmNcOD30GsRY5TOzvkFeCSyJcZ26uX6Ig4TE2EJmmApnHRoCshryBwS?=
 =?us-ascii?q?i6E4ZIZmBJFF+MC23kd4aaVPcWbiKdPMthniYDVbi7RI9ynS2p4Sj8x6BqLK?=
 =?us-ascii?q?Lx/TYevJnu15Ah4OjUjhc7/jFcFcmR02iRCWpzmzVMDwc/waQ3hEt60FrLhb?=
 =?us-ascii?q?BxnvhwDdVO47ZMVQAgONjXyOksWP7oXQeURcuEUFarRJ2dBDg1St8gi4sVb1?=
 =?us-ascii?q?1VB8SpjheF2TGjRbASierYV9QP7qvA0i2pdI5GwHHc2fxk1gJ3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BJAACplN5d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBGFUgEiqEK4kDhloGgRIliWmRRAkBAQEBAQEBAQEjFAEBg?=
 =?us-ascii?q?UyCdAKCJDgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCbQEBAQEDIxVBEAsOB?=
 =?us-ascii?q?wMCAiYCAlcGAQwGAgEBgl8/AYJSJbFmdYEyhU+DQ4FIgQ4ojDB5gQeBOAwDg?=
 =?us-ascii?q?l0+hBKDR4JeBJZjRpcQgjeCOYRkjjMGG4JAc5ZsjkiBQppjIoFYKwgCGAghD?=
 =?us-ascii?q?zuCbAlHERSOQ4ZpIwMwi3yCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 15:23:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARFNref016963;
        Wed, 27 Nov 2019 10:23:53 -0500
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <157486604069.70468.14139138243381994891.stgit@chester>
 <CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <574b6648-8698-65e0-23c4-5ddb096b36c6@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 10:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 10:21 AM, Ondrej Mosnacek wrote:
> On Wed, Nov 27, 2019 at 3:47 PM Paul Moore <paul@paul-moore.com> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
>> Add kernel module tests") require the kernel-devel package on Fedora,
>> make sure we list that in the README.md file.
> 
> Thanks, I should have thought of this when reviewing the patch :)
> 
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>   README.md |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/README.md b/README.md
>> index e845df8..4352796 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -53,6 +53,7 @@ similar dependencies):
>>   * attr _(tools used by the overlayfs tests)_
>>   * libbpf-devel _(tools used by the bpf tests)_
>>   * keyutils-libs-devel _(tools used by the keys tests)_
>> +* kernel-devel _(used by the kernel module tests)_
>>
>>   On a modern Fedora system you can install these dependencies with the
>>   following command:
>> @@ -69,7 +70,8 @@ following command:
>>                  lksctp-tools-devel \
>>                  attr \
>>                  libbpf-devel \
>> -               keyutils-libs-devel
>> +               keyutils-libs-devel \
>> +               kernel-devel
> 
> I'm wondering whether we should rather put kernel-devel-$(uname -r)
> here, to make sure that the right package is installed that
> corresponds to the running kernel version (which may not be the latest
> version that dnf will fetch). Or if the use of shell expansion feels
> too clever, then we should at last document that the command may not
> always install the version that is needed.

I'm often testing kernels I build myself and not via rpm.

> 
>>
>>   The testsuite requires a pre-existing base policy configuration of SELinux,
>>   using either the old example policy or the reference policy as the baseline.
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 

