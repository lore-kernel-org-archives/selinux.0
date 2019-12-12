Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FAC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87580206DA
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cMaDR08d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLLR5C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:57:02 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:2441 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLR5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 12:57:02 -0500
X-EEMSG-check-017: 56895364|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="56895364"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 17:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576173420; x=1607709420;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8TwWbqDlhTB3Hw9Eir4MXcOc+ou+LbOnnNuJ38QK4Ug=;
  b=cMaDR08d3bjFe/W3fKY5Q8J17NcENc7Yv5iJz0/AjHV8V8+oKZOZbbJU
   Bs/UDdO1k/nIA+gt0zQG4fbxYrA2sgA0d2UGG8CjlBFvkCCmirG5VuRtq
   HTlJ6/BGB60xX/FNX3r/JClGsCpK5TJjyGDqjFuSaeK4lviKBN1Rgag78
   Ip8afgwCj+NhskkkKvespvTwgV1/Tdk1Y86aWBLu2njaClgvGuNWhwjTx
   ZNpXgi+BmJjvyZ4oofrf3FnFHvzvyi7OjmcN9Xk+geutEoAjEOgUmJriX
   woSFGJZBnCJzE1khFpsxfHoqR+grCDkmAe6RUT3ygUYhgvU61fBCL+DVi
   g==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36678931"
IronPort-PHdr: =?us-ascii?q?9a23=3ARsdjmBONd7itG5C7Bt0l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/j/r8bcNUDSrc9gkEXOFd2Cra4d0KyP4v+rADRfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAncsssbjYR/JqotyB?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHDIy8dY8PBPcfM+heoYf2ul8CoQK+CASoAe/izCJDiH3r0q0gy+?=
 =?us-ascii?q?kvDB/I3AIgEdwNvnrbotr6O6UOXu6616TI0TfOYulK1Tvh5oXFcBYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGR7ZjlqOsYzlPy2a1uIQuGaG6upvT+avi2o5pABxvzOiwdwshZ?=
 =?us-ascii?q?TSho8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQxlp?=
 =?us-ascii?q?oVv0TDGTT2l1vqg6OMakUl+vSn6+TgYrn8oJ+TK5R0hR3kPqQrm8y/Bfw0Mg?=
 =?us-ascii?q?kIX2eF5eSxzKDv8EL2TblQjvA6j7PVvI7VKMgFvKK1HhdZ0oM55Ba+Czem3s?=
 =?us-ascii?q?4YnX4CLF9dYxKIkpPpNkrSIPH4Efi/g1OsnC1tx/DdJLLtGJrNLn/dkLv5Z7?=
 =?us-ascii?q?Zy91ZcyBYvzdBY/59UEqsOIO/3WkLqrNzXFAI5Mwitz+biD9V90ZkeVnyVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuAi5/7rin85glkdcrO10pQJc324BOppLF?=
 =?us-ascii?q?iZYXX2ntcNC3sFvg07TObykl2NTSZTZ2quX6I7/jw0FJipDZzdSYGtm7GBxz?=
 =?us-ascii?q?u0Hp1MaWBbBFCMFWnnd5+dV/gQci2eONNukjsBVbK5UY8uyQmutBPmy7pgNu?=
 =?us-ascii?q?fU+TMXuoz41Ndp4O3TkhIy+CdoAMSdyWGNSGR0nmIVRz8zxqx/plZ9ylib26?=
 =?us-ascii?q?hin/NYDcBT5+9OUgoiMZ7czup6C839Ww7YZdeGVkqpQsi8ATEwUtIww8YCY0?=
 =?us-ascii?q?N6G9q/kxDD2zSlDqQLl7yEGpM06LjQ33vvKMZnzXbJyq0hg0MhQstVOm2snr?=
 =?us-ascii?q?R/+BTLB47Vj0WZkL6ndaYZ3C7K7meD12uOvFpDXQ52S6rFWG4QZkrModT+/E?=
 =?us-ascii?q?PCQKekCa47PQtZ1c6CNqxKZ8XyjVpYXvfjN8rRbnmxm2iqARaIwrONbIzwd2?=
 =?us-ascii?q?oB2yXdDVAOkxoP8naeKQg+GiChrnrFDDNwEVLvYkXs8fRxqX6gUE80wB+Fb1?=
 =?us-ascii?q?d727q25BEVn/qcRO0X3r4evychsTp0Fk6n393KE9qAuxZhfKJEbNM/51dH1W?=
 =?us-ascii?q?TZuxZ/PpynL6BtnFgecx9psEPozBh4Fp9Pkc4trHMszQp9NbiX0FdbezyE2p?=
 =?us-ascii?q?DwP6XdKnPu8xC3d67Wxlbe3c6T+qcI8vQ4t1LjvAesFkc573pn08NV03yZ5p?=
 =?us-ascii?q?XLEQoSVIj9UkEt9xh1v7vaeDUy55vI1X1wNqm5qifC1MwvBOsq1xagftFfPL?=
 =?us-ascii?q?qHFADsCc0aAdahKOgxlliodx4EOOdS9LAqMM+8bPuJwq2rPPt6nD28l2hH5p?=
 =?us-ascii?q?5y3liO9ypkGab02MM9yuycli6AUC3xxAO5u93zsZhNeDVXG2240yWiD4lUMP?=
 =?us-ascii?q?5cZ4EOXFyyLtW3y9M2vJvkX3pV5Rb3HF8d8NO4chqVKVrm1Etf0lpB8i/voj?=
 =?us-ascii?q?ex0zEhy2JhlaGYxiGbhr2/JRc=3D?=
X-IPAS-Result: =?us-ascii?q?A2DPAADQffJd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWwBIBIqhAOJA4ZsAQEBAQEBBoE3iWmPX4FnCQEBAQEBAQEBATcBA?=
 =?us-ascii?q?YRAAoIuOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVQRALGAICJgICV?=
 =?us-ascii?q?wYNBgIBAYJfP4JTJa8IgTKFT4MqgUiBDiiMMnmBB4E4D4JdPoQDLgKDJoJeB?=
 =?us-ascii?q?I9xhxJGlyaCOoI8kzcGG5pBqxkigVgrCAIYCCEPgydQERSfBCMDMI1mgjIBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 17:56:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCHufQG138113;
        Thu, 12 Dec 2019 12:56:41 -0500
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 12:57:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 12:54 PM, Paul Moore wrote:
> On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> 
> ...
> 
>>>> selinux_state.initialized reflects whether a policy has
>>>> been loaded.  With a few exceptions in certain hook functions, it is
>>>> only checked by the security server service functions
>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
>>>> there is a lot of SELinux processing that would still occur in that
>>>> situation unless we added if (!selinux_state.initialized) return 0;
>>>> checks to all the hook functions, which would create the same exposure
>>>> and would further break the SELinux-enabled case (we need to perform
>>>> some SELinux processing pre-policy-load to allocate blobs and track what
>>>> tasks and objects require delayed security initialization when policy
>>>> load finally occurs).
>>>
>>> I think what Casey was suggesting is to add another flag that would
>>> switch from "no policy loaded, but we expect it to be loaded
>>> eventually" to "no policy loaded and we don't expect/allow it to be
>>> loaded any more", which is essentially equivalent to checking
>>> selinux_enabled in each hook, which you had already brought up.
>>
>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
>> might be the best option until it can be removed altogether; avoids
>> impacting the LSM framework or any other security module, preserves the
>> existing functionality, fairly low overhead on the SELinux-disabled case.
> 
> Just so I'm understanding this thread correctly, the above change
> (adding enabled checks to each SELinux hook implementation) is only
> until Fedora can figure out a way to deprecate and remove the runtime
> disable?

That's my understanding.  In the interim, Android kernels should already 
be disabling CONFIG_SECURITY_SELINUX_DISABLE and other distros may 
choose to disable it as long as they don't care about supporting SELinux 
runtime disable.


