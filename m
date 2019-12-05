Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14BC2D0BF
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 18:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECE82464E
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ov72WEAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfLESKN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:10:13 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:24822 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESKN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 13:10:13 -0500
X-EEMSG-check-017: 54655794|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,282,1571702400"; 
   d="scan'208";a="54655794"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Dec 2019 18:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575569411; x=1607105411;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1Z/G79IJ+WjLvtCg79Ao6QelctMs346MXNOD1ExMezY=;
  b=ov72WEAL7+9YVmUHk2blLZgfTZfAzVxwETaT6/yKn9bp0+1hV1mFf939
   BNpjHcH7L/eQ3GNy86yIrbV/0eEAAo6CMgu5gMgs5v7CPz/aosEwKJrdO
   o/9wo++3lpfmstmPRdP0+p33z/DZmWrqItI0vHfIC21UJQZ26zH0pJVa7
   1IEvSpZbOMuLdMfr8I4rCl8Zuefo2fKpFsvTaXuLTfgbcfGFkI62fhjUY
   3kpNUYCtrHBmo0mJ64s27gfA6DheyIzrLfpg7FBfj3MzQUyeOZga7rEbc
   LSm1a9VGBZCAt7o1mDw9Hy+OdsAvKuVCY8iyv/vprghhmvmyqdZkNaSIw
   w==;
X-IronPort-AV: E=Sophos;i="5.69,282,1571702400"; 
   d="scan'208";a="36393756"
IronPort-PHdr: =?us-ascii?q?9a23=3AC4QM0B/cTI6x1f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0egVIJqq85mqBkHD//Il1AaPAdyArasU0qGP6/CocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi1sAndudQajZdhJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBH/Z1UF7UBLenrWkDrqdzYCgY1Mwmzw+bgEtVyyJkSVn6IAq?=
 =?us-ascii?q?+cKKnSq0OH5vozI+mQY48YoDH9K/0i5/71i382g0MScrey0JsNdn+3A/RmLF?=
 =?us-ascii?q?+FYXb2ntgBFmIKtBIkTOP2kF2CTSJTZ3GqUqI++D47BoymDZnYS4Cih7yB2y?=
 =?us-ascii?q?i7HplIaWxcFl+MFnLofZ2eW/gQcCKSPtNhkjscWLi6VYAh0RCutAnny7toNe?=
 =?us-ascii?q?fU5CIYuoz51NRv5O3ciwsy9TpqAMSZyW2NSHt0nmwQTT8swK9/uVB9ykuE0a?=
 =?us-ascii?q?Vgjf1YFNhT5/dSXwc5K5Hc1ep6BM72Wg7bedeJUlmmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtW6lB/Dwi6qA7oJmLyIH5E08bzT32L3J8ljz3bKzq4hj0MpQsFXL22pmr?=
 =?us-ascii?q?Z/9xTPB47Oi0iZjbqldbkH0S7T+2eM03COsFtbUAFuS6XFW24QZk/ModT+/E?=
 =?us-ascii?q?PCQKekCa47PQtZ1c6CNqxKZ8XrjVVBWvfsItLebHiym2qrChaIwbSMbIXue2?=
 =?us-ascii?q?oDxinSFE8EkwVAtUqBYDA3GyPphmXZFjEmQUrmfkfE6eBjrDa+SUguwkeBaE?=
 =?us-ascii?q?g3k/KS/BIPiP7UbvQI2LsPtSRp/zJxG0271tnbI8CNqwpoYONXZtZrs3ld0m?=
 =?us-ascii?q?eMjBBwJpytKehZg1cadwlm9xf12w5fFpRLkc9sqmgjigV1N/TLgxt6azqE0M?=
 =?us-ascii?q?WoafXsIW7o8UXqMvWH1w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BdAACHR+ld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGZAaBEiWJaZFECQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oI3OBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgm4BBSMVQRALGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+CUyWvG4EyhU+DLIFIgQ4ojDF5gQeBOAwDgl0+hDODJoJeBI0bC?=
 =?us-ascii?q?4I+hw1GdIcMjxOCOII5kxsGG5omjkqcNCKBWCsIAhgIIQ+DJ1ARFIxxGI5BI?=
 =?us-ascii?q?wMwkWgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Dec 2019 18:10:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB5I9uRV057721;
        Thu, 5 Dec 2019 13:09:58 -0500
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191122093306.17335-1-jeffv@google.com>
 <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
 <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
 <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov>
Date:   Thu, 5 Dec 2019 13:10:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/5/19 12:41 PM, Paul Moore wrote:
> On Thu, Dec 5, 2019 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
>> Thanks for the double check.  Unfortunately my kernel build locks my
>> test VM in early boot; it appears to be non-SELinux related and since
>> the test build is based on selinux/next+patches (which is based off
>> v5.4-rc1) I imagine there might be some unrelated problems in the
>> build.  I'm going to rebase my test build to Linus' current and try
>> this again.
> 
> Hmm.  I haven't done any debugging yet, but the BPF tests are failing
> (they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):
> 
> 1..15
> ok 1
> Failed to load BPF prog: Invalid argument
> not ok 2
> #   Failed test at ./test line 68.
> Failed to create BPF map: Permission denied
> ok 3
> Failed to create BPF map: Permission denied
> ok 4
> Failed to create BPF map: Permission denied
> ok 5
> Failed to load BPF prog: Permission denied
> ok 6
> Failed to load BPF prog: Invalid argument
> ok 7
> client: Using a BPF map fd
> client: Connected to server via ./test_sock
> server:  Accepted a connection, receiving message
> client: Sent descriptor, waiting for reply
> server:  Received a descriptor, fd=5, sending back 0
> client: Received reply, code=0
> client: ...This implies the descriptor was received
> ok 8
> Failed to load BPF prog: Invalid argument
> client: Using a BPF prog fd
> client: Connected to server via ./test_sock
> sendmsg: Bad file descriptor
> server:  Accepted a connection, receiving message
> server:  Received no descriptor, sending back 1
> not ok 9
> #   Failed test at ./test line 118.
> Failed to load BPF prog: Invalid argument
> client: Using a BPF prog fd
> connect: Connection refused
> ok 10
> client: Using a BPF map fd
> connect: Connection refused
> ok 11
> ok 12
> Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
> ok 13
> ok 14
> Failed to load BPF prog: Invalid argument
> Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
> ok 15
> # Looks like you failed 2 tests of 15.

They all pass for me (with your next-queue branch, using the 
selinux-testsuite defconfig fragment merged with the Fedora config).

The error above doesn't look SELinux-related; it looks like your kernel 
is rejecting the trivial bpf program used in the test code as being 
invalid for some reason.


