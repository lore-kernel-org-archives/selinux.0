Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A5C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A89206C3
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 18:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="D5YyDgra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfLLSsQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:48:16 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:27171 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbfLLSsP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 13:48:15 -0500
X-EEMSG-check-017: 34945011|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="34945011"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 18:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576176492; x=1607712492;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uQYmEfnxTCNjJGNxf085y90zDfsMOKJddGMRtz2EQrY=;
  b=D5YyDgraNmFpikNzjM2vq+4c4FCImsZKwfQSbAQGr8rfQJFBM/FoVcXI
   kZ4CA6RaGa23jhYVr2vqYucGzv2bjskFLB4vmDDv9v2A6No6oqXmnFGV7
   Hzh4tOTX1AP9bXpCjP8AqH4ej6tXwnqAIIu0zHJcGSjWo6Ph169UGgyCc
   NLdCQVfeG4J1rPxaqL49ewAybxXSXntTW6HPVj0TAT2ga9KWx6X8MfwE7
   h4y+W2A4i6WOhUIGGQvzj6PLi4Bsx9wM6TQOIrlDvLYqRRQg9iFRl1yz7
   IAzcW3THrjZmVv2iDhYAej+qQ9Bx0c73pRnk0aVbgezERAGoqbgYuo8Za
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36682929"
IronPort-PHdr: =?us-ascii?q?9a23=3AbLFxHxBxJsvSAh662A1+UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/o8SwAkXT6L1XgUPTWs2DsrQY0rGQ6vG/EjVZvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu80UjIdtN6o91x?=
 =?us-ascii?q?nEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenBQShAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzY0gwuH9wAs3rao9v6O6gQTe+7w7LFzSnBYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3Gg3YklWft5TlPzOL2eQLrmOV8u9gWviri24jtQ5woiWky8A3io?=
 =?us-ascii?q?bUnYIY0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1uyg60qULtY?=
 =?us-ascii?q?O0cSUF0pgqxwPTZ+aZf4WH/B7vTvudLDFlj3x/Yr2/nQy98U24x+35Ucm7zU?=
 =?us-ascii?q?hFozJektnJqnANzxvT6tWbSvdl/keuxzKP1wfL5+FYO080j6vbK4M6wrIql5?=
 =?us-ascii?q?oTt0rDHijtmErokKCabFkk++i05OTnZbXqvJmcOJNvig7iKKgun82/AeAgPg?=
 =?us-ascii?q?gPWWiU5/i82aX+8UD2T7hGlP07nrTDvJzEKskXuLS1DxJN3oYm8Rm/DjOm0N?=
 =?us-ascii?q?oCnXkAKVJIYAmHgJXyO1zVPPD5Deuwg1SrkDtxwfDGJafuDo/CLnjEjrftZa?=
 =?us-ascii?q?x95FJEyAov0dBf4IpZCqkbL/LuXk/8r8TYAQUkMwyw2urnDdJ91oQEWW2RGK?=
 =?us-ascii?q?OWLKTSsVqQ7OI1P+aMfJMVuCr6K/U94P7uiHg5mUQbfaazwZQYdmu1Hu54LE?=
 =?us-ascii?q?qEYXrjmMsBHX0WsQo5SezgkEeCXiJLZ3auQ6I84Sk2B568AofYWI+sgKeM3D?=
 =?us-ascii?q?ynEZ1WfG9GF16MEXP2eIWeQvsDdDidLtV9nTwDULirU5Uh2g22tA/m17pnKf?=
 =?us-ascii?q?LZ+i4Gup39z9h6++rTlRYx9TFvE8ud03uNT2ZxnmMJWj822bpzoUtnyleMya?=
 =?us-ascii?q?J4meBXFcRP5/NVVQc3LZrcz+18C9DvVQPNZ8yJR0i6TdW7GzExT84xwt8Xb0?=
 =?us-ascii?q?Z4HNWtkw3D3y60DLIOibyLC4I78rjG03jyOcl90XDG27clj1U8RctPL2KmjL?=
 =?us-ascii?q?Zl9wfPH47Jj1mZl6GyeKQe2S7N832DzXCPvEFDSwNwV7/KXXUBaUvXt9j54V?=
 =?us-ascii?q?nCT7C2A7Q9LgRB0dKCKrdNatDxllVJWu3jONvAbG+qm2e/HxKIxreMbYrsYW?=
 =?us-ascii?q?kSwCLdCE0cmQAJ4XmGLRQ+Bjumo2/GFzxhC1bvY0Lq8eljp3K2VVE0zw6UYE?=
 =?us-ascii?q?17zba1+QAaheaaS/wN2rIIoiAhqy97HFylxdLZF8KApxZ9fKVbed494lBH1W?=
 =?us-ascii?q?LftwBnPJygKKBiiUQYcwRsoUzu0Q56BZlansgsq3MqygtyJr6C31NFbT+XwZ?=
 =?us-ascii?q?fwOrjPIGno4B+vc7LW2k3Z0NuO/6cP7+44q0nkvAGvE0ov6Glo09lP03ub45?=
 =?us-ascii?q?XKDRcSUZfrXkYw7Rh6qKnQYjMh6IPMyX1sLa60vyfa2903AuslxQugf9ZZMK?=
 =?us-ascii?q?+dFw/9DdcaB86wJ+wugFWpbwsIPORV9K4qIcyqbeCG17SoPOZ9hjKpl35L4I?=
 =?us-ascii?q?Zj3U6W9Sp8Ur2A45FQ+/iF2kOiUDDmgR/1qsnqnahcbCwWW2+4zjLpQoVWY/?=
 =?us-ascii?q?shU5wMDDKVP8Cvxth4z6XoUnpc+U/rU0gKw+e1aBGSaBr7xgQW2kMJ9y/00R?=
 =?us-ascii?q?CkxiB5xml65pGU2zbDlqG7KUsK?=
X-IPAS-Result: =?us-ascii?q?A2DPAADnivJd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWwBIBIqhAOJA4ZtAQEBAQEBBoESJYlpj1+BZwkBAQEBAQEBAQE3A?=
 =?us-ascii?q?QGEQAKCLjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxVBBQsLG?=
 =?us-ascii?q?AICJgICVwYNBgIBAYJfP4JTBSCuDXWBMoVPgzGBSIEOKIwyeYEHgTgMA4JdP?=
 =?us-ascii?q?oQDLgKDJoJeBI9xhxJGlyaCOoI8kzcGG5pBqxkigVgrCAIYCCEPgydQERSQL?=
 =?us-ascii?q?BeOQSMDMI1XDxcEghcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 18:48:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCIleW0166286;
        Thu, 12 Dec 2019 13:47:41 -0500
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
 <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov>
 <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <83af5f0f-d3ec-7827-92e5-2db0997b9d22@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 13:48:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 1:18 PM, Paul Moore wrote:
> On Thu, Dec 12, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 12/12/19 1:09 PM, Paul Moore wrote:
>>> On Thu, Dec 12, 2019 at 12:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/12/19 12:54 PM, Paul Moore wrote:
>>>>> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>>>>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>>> selinux_state.initialized reflects whether a policy has
>>>>>>>> been loaded.  With a few exceptions in certain hook functions, it is
>>>>>>>> only checked by the security server service functions
>>>>>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
>>>>>>>> there is a lot of SELinux processing that would still occur in that
>>>>>>>> situation unless we added if (!selinux_state.initialized) return 0;
>>>>>>>> checks to all the hook functions, which would create the same exposure
>>>>>>>> and would further break the SELinux-enabled case (we need to perform
>>>>>>>> some SELinux processing pre-policy-load to allocate blobs and track what
>>>>>>>> tasks and objects require delayed security initialization when policy
>>>>>>>> load finally occurs).
>>>>>>>
>>>>>>> I think what Casey was suggesting is to add another flag that would
>>>>>>> switch from "no policy loaded, but we expect it to be loaded
>>>>>>> eventually" to "no policy loaded and we don't expect/allow it to be
>>>>>>> loaded any more", which is essentially equivalent to checking
>>>>>>> selinux_enabled in each hook, which you had already brought up.
>>>>>>
>>>>>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
>>>>>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
>>>>>> might be the best option until it can be removed altogether; avoids
>>>>>> impacting the LSM framework or any other security module, preserves the
>>>>>> existing functionality, fairly low overhead on the SELinux-disabled case.
>>>>>
>>>>> Just so I'm understanding this thread correctly, the above change
>>>>> (adding enabled checks to each SELinux hook implementation) is only
>>>>> until Fedora can figure out a way to deprecate and remove the runtime
>>>>> disable?
>>>>
>>>> That's my understanding.  In the interim, Android kernels should already
>>>> be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may
>>>> choose to disable it as long as they don't care about supporting SELinux
>>>> runtime disable.
>>>
>>> Okay, I just wanted to make sure I wasn't missing something.
>>> Honestly, I'd rather Fedora just go ahead and do whatever it is they
>>> need to do to turn off CONFIG_SECURITY_SELINUX_DISABLE (it sounds like
>>> they have a plan and are working on it), I'm not overly excited about
>>> temporarily cluttering up the code with additional "enabled" checks
>>> when the status quo works, even if it is less than ideal.
>>
>> The status quo is producing kernel crashes, courtesy of LSM stacking
>> changes...
> 
> How prevalent are these crashes?
> 
> This also only happens when disabling SELinux at runtime, yes?
> Something we've advised against for some time now and are working to
> eliminate?  Let's just get rid of the runtime disable *soon*, and if
> we need a stop-gap fix let's just go with the hook reordering since
> that seems to minimize the impact, if not resolve it.

Not optimistic given that the original bug was opened 2.5+ years ago, 
commenters identified fairly significant challenges to removing the 
support, and no visible progress was ever made.  I suppose the hook 
reordering will do but seems fragile and hacky.  Whatever.

> I'm not going to comment on the stacking changes.


