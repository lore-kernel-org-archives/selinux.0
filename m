Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A878DC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7693E214AF
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YOVO4MmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfLLSK5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:10:57 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:14755 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSK4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 13:10:56 -0500
X-EEMSG-check-017: 60912977|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="60912977"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 18:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576174255; x=1607710255;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WV/+8yIn0RRfbfZB2N0FkuJp5FI3hTi02vuLX9Y4H4w=;
  b=YOVO4MmJhZVWS30K2wGfMyVFMgh1+tzxMd6g649ziWc8THYJDJFbfK2e
   +vBYbxneUxjoQEvYAtMAx2qxqQPoVgH6Z3Mg0SivJ/y3DZWH+uEjercH/
   PIwJ0IPJlcDEB7FQsRTyWcbLJz4cpUUlOzocnL4dQihRImqae1u/V3Rap
   Of0zkwVpN2rl3qFoJ912+kHYqF4Zzb1VKEnhL8EBW6OgQ/uak6NmtRfXn
   6l4HBZ9wwTT8Red0vvfXyoXekAgwz8I9rQ1lWLfWu2ODwdFFKljsN7/v6
   wC8sY7fjw6Xr/SWnhoGKLz/FpQBU8hUSM27kWPLJGqSE1u5iK/SDRBz5h
   w==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="31051103"
IronPort-PHdr: =?us-ascii?q?9a23=3AbNTDoxRJt6S5LIa0ZhHG/2ex39psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YByAt8tkgFKBZ4jH8fUM07OQ7/m7HzVRvt3Y6CFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZmKKs9xQ?=
 =?us-ascii?q?bFrmdMdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
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
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfLrQEDxqdjYAwQhMwOu3ubnDMxx1oYZWWKIGK?=
 =?us-ascii?q?+WLrnevkOP5uIqO+OMfpMauC7hK/g54P7jlXg5mVoafamy25sYcmy3Eep9Lk?=
 =?us-ascii?q?WDf3Xjn9cBHn0WvgYkUOPqj1iCWyZJZ3muR6I8+i07CIW+AIjfXI+tm6KO3S?=
 =?us-ascii?q?egE51Nem9GCkqDEWrmd4WARfgMcjueLdN7nTAeSbehTIoh3wm0tADm07pnMv?=
 =?us-ascii?q?bU+ioAuJLgytd6+fbTmg019TxzDMSQyH2CT2FunmMPQj823b1/oUlnxleEy6?=
 =?us-ascii?q?h4jORSFcZP6PNRTgc6KZncwvR+C9DzXALBY9iIRE+9Qtq4HT4xU8gxw94SY0?=
 =?us-ascii?q?d9AtmiixfD0De3A78RibOGH4I08q3C0HjrPcp9yGjJ1LMnj1Y4RstDL2qmhr?=
 =?us-ascii?q?Rw9wLLHY7Gj12Zl7q2daQbxCPN9mKDzW2UvEFCUQ5wSr7IXXYFaUvTs9v551?=
 =?us-ascii?q?nOT7i0CbQoKgFB09KNKrNWat31ilVLXOzjN8rEY2K+hWi9HhaIyamIbIrue2?=
 =?us-ascii?q?Qd2j/RB1QDkwAW5XyGLxQxBj+9o2LCCzxjDUnvbF3o8el/rnO7U0A1whqUb0?=
 =?us-ascii?q?1uybW14AQZhf+CRPMJ2LILpiMhpy9zHFan0NLcE8CAqBZ5fKVAfdM9509K1W?=
 =?us-ascii?q?Detwx9OJysNaJihlkecwttuUPuzAt4CoNbnMc2tnwqyg1yKaSZ0FxdbTyY2Y?=
 =?us-ascii?q?r8NaHQKmn35BqvcbLZ2knC0NaK/acC8PE4q1L5vAG1EUoi9XBn3sJJ3Huc/J?=
 =?us-ascii?q?XKCw8SUZPsUkYy7RR6oKvaYiYl7YPOyXJsKbW0siPF298xHOsq1BCgf9hCMK?=
 =?us-ascii?q?OFEg/+Cs4aCNa0KOwshVepagkJPOFL+K4wOMOmaeWJ1LSwPOl6nzKmkH5H75?=
 =?us-ascii?q?pn3kKK6SVwUOzI345Wi82fizOOSjO0qVCmqM2/zZhNeDU6BmOizW3hA4lLa+?=
 =?us-ascii?q?t5eoNdTS+JJcGty9c2opn2XXdT+V3rU1QD39SvcBGfR0bw0Q1ZyQIcpnnxyg?=
 =?us-ascii?q?WiyDkhqC0ktqqS2mT1xu3mcBcWcjpQSHJKkUbnIY/yicsTGkevcV56x1Oe+U?=
 =?us-ascii?q?/myv0D9+xEJG7JTBINJnWnIg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BMAABRgvJd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbAEgEiqEA4kDhm4BAQEBAQEGgRIliWmPX4FnCQEBAQEBA?=
 =?us-ascii?q?QEBATcBAYRAAoIuOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVQRALG?=
 =?us-ascii?q?AICJgICVwYBDAYCAQGCXz+CUyWufoEyhU+DMYFIgQ4ojDJ5gQeBOAwDgl0+h?=
 =?us-ascii?q?AMuAoMmgl4Ej3GHEkaXJoI6gjyTNwYbmkGOS5xOIoFYKwgCGAghD4MnUBEUn?=
 =?us-ascii?q?wQjAzCNVw8XBIIXAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2019 18:10:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCIAcjB147489;
        Thu, 12 Dec 2019 13:10:38 -0500
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook>
 <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
 <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
 <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
 <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
 <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 13:11:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 1:09 PM, Paul Moore wrote:
> On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/12/19 12:54 PM, Paul Moore wrote:
>>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>
>>> ...
>>>
>>>>>> selinux_state.initialized reflects whether a policy has
>>>>>> been loaded.  With a few exceptions in certain hook functions, it is
>>>>>> only checked by the security server service functions
>>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
>>>>>> there is a lot of SELinux processing that would still occur in that
>>>>>> situation unless we added if (!selinux_state.initialized) return 0;
>>>>>> checks to all the hook functions, which would create the same exposure
>>>>>> and would further break the SELinux-enabled case (we need to perform
>>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
>>>>>> tasks and objects require delayed security initialization when policy
>>>>>> load finally occurs).
>>>>>
>>>>> I think what Casey was suggesting is to add another flag that would
>>>>> switch from "no policy loaded, but we expect it to be loaded
>>>>> eventually" to "no policy loaded and we don't expect/allow it to be
>>>>> loaded any more", which is essentially equivalent to checking
>>>>> selinux_enabled in each hook, which you had already brought up.
>>>>
>>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
>>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
>>>> might be the best option until it can be removed altogether; avoids
>>>> impacting the LSM framework or any other security module, preserves the
>>>> existing functionality, fairly low overhead on the SELinux-disabled case.
>>>
>>> Just so I'm understanding this thread correctly, the above change
>>> (adding enabled checks to each SELinux hook implementation) is only
>>> until Fedora can figure out a way to deprecate and remove the runtime
>>> disable?
>>
>> That's my understanding.  In the interim, Android kernels should already
>> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
>> choose to disable it as long as they don't care about supporting SELinux
>> runtime disable.
> 
> Okay, I just wanted to make sure I wasn't missing something.
> Honestly, I'd rather Fedora just go ahead and do whatever it is they
> need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
> they have a plan and are working on it), I'm not overly excited about
> temporarily cluttering up the code with additional "enabled" checks
> when the status quo works, even if it is less than ideal.

The status quo is producing kernel crashes, courtesy of LSM stacking 
changes...


