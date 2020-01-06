Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ED0C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A439620731
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FvWLLXkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAFSqC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:46:02 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:41994 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSqC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 13:46:02 -0500
X-EEMSG-check-017: 68198295|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="68198295"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 18:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578336344; x=1609872344;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RYG5Okrhv9azH+AJfIigWq0Gonv7tbcVZE/+6vKzKkI=;
  b=FvWLLXkmpJ7lzVjSV5ZjWdprh1honKb+oOZEPaSWx+BJhY7adY09wgbm
   wDOd2MUFslkW7Q0ddbZ/eOjd4pSkeJjAkm9LBn7lhk7G1ltaiH0nelqDh
   bA7Llj1VlXmSugoTBp57QmGft4S3g+sAOy5uAvoZoyAdiybCwjChJ554I
   qHAX4YXB+W+RP/GTG+tAFviGYXUaEM+3uk/3u5q5Ep89GT+IdgYgwjG8w
   x1maOEHU7DK8k1TfD1RGVBhfYt4HlMwMgL7/hpjuPEwtIUB2+PzEoLIqI
   meIOUKMbgU6pKvxDtI4qwgnjOW1UwAQNDEsVVfSVfVgFZwtNoV10hsvjL
   A==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31637839"
IronPort-PHdr: =?us-ascii?q?9a23=3A7bMBABRGqBYweeYaJoY7C0mU6dpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBGEt8tkgFKBZ4jH8fUM07OQ7/m7HzZdud3Y6S1KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYZiNqo9xQ?=
 =?us-ascii?q?bFrmZIdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHePixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq0XDHin4mEXxl6+ZaFkr9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLf3vQEDxr8LXDx8iPgyv3+nnCM9y1p4QWWKLHK?=
 =?us-ascii?q?CZKrrevkOS6e41P+aMY4oVsi7nK/c5//7ukWM5mVgFcKmy2JsYdG64E+96LE?=
 =?us-ascii?q?WeZXrshs0OHnwNvgokVuPmkkGNUTlWZ3yqRaIz+ik7CJ66DYfEXo2inKaO3D?=
 =?us-ascii?q?ylEZxWfGxGEUyDEXfyeIWZVfcMbDydItV6nzwFU7ihV5Eu1RW0uADmzLpnK/?=
 =?us-ascii?q?Le+jcEupL7yNh1++rTmAkw9TxxCMSdyXuNT2Bvnm4TQT85xqV/rlJ8yluZ1q?=
 =?us-ascii?q?h4mfNYH8RJ5/xVSgc6KYLcz+tiBtD2WwLBeMqJSVm/TtW9Hz4+Us8xw8UPY0?=
 =?us-ascii?q?ZhG9SulxXD3y23DL8Ik7yEGoc58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcH4TJiVmWl762daQA2y7A7HyDwnSKvEFZVg5wTKrEUGsBZkvZs9v5/F?=
 =?us-ascii?q?nOT7ywBrQ9NAtO18qCJrFNat3zglVMXO3jN8jGY2Kth2ewAg6FxrCSY4X0YG?=
 =?us-ascii?q?USwCLdCE8Hkw0I4XmGNRI+BiCko2LfETxuEEjjY0T28elxsHm7VFM7zxmWb0?=
 =?us-ascii?q?190Lq44hwVhfucS/MVxL4EuiAhqzVuE1a7xNLZFdyAqhF9c6pGZ9M951FH1W?=
 =?us-ascii?q?PFuANnOpysNbxthlkbcw5vpUPhyw13CplckcgttH4q1BR9KaSX0FNcdjOY24?=
 =?us-ascii?q?n8Or7JJWno+hCgdarW10rf0NqP/qcP7+o4pEv5sAGyDEUi8Ghn08NP3HeG4J?=
 =?us-ascii?q?XFEhAeUZDpUkwv7Rh1u6naYjUh54PTzXBsKbO7siLG298yHOsq0Augf9NGPK?=
 =?us-ascii?q?OBEw/yFNcaCNa0JOM2nFipa0FMAOcH36cvMtLuTPCG0bOlOOt61GathH9K8a?=
 =?us-ascii?q?hm2UKF6iR4R/SN1J9DyPadiE/PbDb5i1Hpl8vJmJxYZDxaSnG6wjbMD4lVYq?=
 =?us-ascii?q?R4epwCT2ypJpvk6M95gsvWR3NA9FOlT2gD0cutdAvaO0fxxiVMxE8Xpjqhgi?=
 =?us-ascii?q?L+wDtqxWJ65pGD1TDDlryxPCEMPXRGESw70Abh?=
X-IPAS-Result: =?us-ascii?q?A2BpAQALgBNe/wHyM5AaAUsbAQEBAQEBAQUBAQERAQEDA?=
 =?us-ascii?q?wEBAYF8AoF7gWwBIBKEM4kDhmMBAQQGgTeJbpFICQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oINOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjFUEQCxgCAiYCA?=
 =?us-ascii?q?lcGAQwIAQGCXz+CUwUgj2CdJXWBMoVPgyeBPYEOKAGMMnmBB4E4D4JdPodZg?=
 =?us-ascii?q?l4EjXiJHkaWSHWCQIJFk08GG4JGh32QGC2OJpxqIoFYKwgCGAghD4MoTxgNm?=
 =?us-ascii?q?3YjA48XAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 18:45:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006IioeO034870;
        Mon, 6 Jan 2020 13:44:50 -0500
Subject: Re: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-24-casey@schaufler-ca.com>
 <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
 <20200106172949.GA80652@horizon>
 <1a392962-8a2d-a3f3-5cc1-a51e82ada41b@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f906ab41-cccd-a14c-ad82-738ac0ddf574@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 13:45:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1a392962-8a2d-a3f3-5cc1-a51e82ada41b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/20 1:03 PM, Casey Schaufler wrote:
> On 1/6/2020 9:29 AM, Simon McVittie wrote:
>> On Mon, 06 Jan 2020 at 12:15:57 -0500, Stephen Smalley wrote:
>>> On 12/24/19 6:59 PM, Casey Schaufler wrote:
>>>> The getsockopt SO_PEERSEC provides the LSM based security
>>>> information for a single module, but for reasons of backward
>>>> compatibility cannot include the information for multiple
>>>> modules. A new option SO_PEERCONTEXT is added to report the
>>>> security "context" of multiple modules using a "compound" format
>>>>
>>>>           lsm1\0value\0lsm2\0value\0
>>>>
>>>> This is expected to be used by system services, including dbus-daemon.
>>>> The exact format of a compound context has been the subject of
>>>> considerable debate. This format was suggested by Simon McVittie,
>>>> a dbus maintainer with a significant stake in the format being
>>>> usable.
>>> Since upstream AA does not currently ever set the peer label info, there is
>>> no need for this support for stacking upstream AA today, and there is no way
>>> to test this functionality with more than one module present currently in an
>>> upstream kernel.  Either fix AA to actually implement the functionality so
>>> it can be tested properly, or drop it from this series please.
> 
> I agree that SO_PEERCONTEXT can be deferred until such time as we have
> AppArmor upstream support for SO_PEERSEC.
> 
>>>    I don't
>>> understand why AA continues to keep this kind of basic and longstanding
>>> downstream functionality out of tree.
> 
> Not everyone has the resource commitments of the world's largest
> government. :(

How hard is it to upstream code that is a) entirely contained within the 
AA security module, and b) already shipping in Ubuntu kernels for quite 
some time? Seems to be more of a lack of an upstream-first philosophy 
than a resources issue...

> 
>> Alternatively, a pair of tiny in-tree or out-of-tree stackable LSMs
>> that don't make any security decisions, and label every labellable
>> process/socket/thing with something predictable, would make it really
>> easy for both kernel and user-space developers to test this and the
>> user-space code that uses it (D-Bus and others).
> 
> Sounds like a fun and educational project. Maybe one of our lurkers
> could do something clever.
> 
>>
>> For example, they could label process 1234 and all sockets created by
>> process 1234 with "contexttest1\0pid1234\0contexttest2\0process1234" or
>> something like that.
>>
>> I'd love to see AppArmor in upstream kernels support SO_PEERSEC and
>> SO_PEERCONTEXT, but setting up a development machine to stack AppArmor
>> and SELinux (and still be able to boot, without one or the other LSM
>> forbidding something important) seems likely to be harder than setting
>> it up to load some toy LSMs.
> 
>>
>>      smcv
> 

