Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37FAC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950C52173E
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cetLhxVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfLLRjU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:39:20 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:35589 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLRjT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 12:39:19 -0500
X-EEMSG-check-017: 60048552|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="60048552"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 17:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576172355; x=1607708355;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VWcDD6uGE597t4nCsYH02TpGKhyT6pVdYLz3eObVGmc=;
  b=cetLhxViRk9eycL0Mb/W/94T+tB+cONw6nLoDHwjGhuGhv/ybydRxJkZ
   SzY/wrvr2vIwHHpu/3a6kdCUpI0eUj72j3oY6/IwsZVNRgerb8ArXCcxr
   7vLdB++BZUH7padX6L7Z4ZEQWbBUeU4WSDf2gGGSzc06aVqZZAs+SOQ7f
   brFnkcnsN0uQvszv8HWxRwgjOwgNaGo0aZ7dXLDoyWdwq62sNo3LeTqzG
   KOehq470tJpwPr7RJtdsoS50YXXwD4RNvXx63Ix7rTZLB2OfJkrqYzxXV
   zrq1hvEWZ0NcWjyyO3ou+a+APatf178Hx1bgO08Zaci3z+JwCPF9Jy5Rp
   A==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="31048702"
IronPort-PHdr: =?us-ascii?q?9a23=3APRWEzx8Mr48wk/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+MVIJqq85mqBkHD//Il1AaPAdyArasV1KGP6/qocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBiyrwjdudQajZd8Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlsDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X80sQ2ZtuCkgy70Gv4?=
 =?us-ascii?q?a2fCYUx5s92x7fduaHfJaT4h75VeaRJzF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7StlqI5uU0I+mKfoAapCjyJuM/5/HwkHA5mUUSfbWz0ZQLb3C4G+xsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxIiQ+Pwk12NTz5Sam2pX60g5jE0Ep+mDYnHRo+zmryNxT?=
 =?us-ascii?q?u0EYdMam9aDVCMFG/id5+YVPcUdCKSPshhnyQHVbe/VYAhzg2htAj9y7pkNe?=
 =?us-ascii?q?fb5i0YtYjk1Nhw5u3TiBQy+SZzD8SH3GGHV3t0kX8QRz8qwKB/plRwylOC0a?=
 =?us-ascii?q?h+nvxZGsVf5+hXXQgmKJ7c1e16C8zyWw7Ye9eJT0upQsiiAT4vVd8x3dAObF?=
 =?us-ascii?q?hnG9m4jRDMwTCqA7kLmLyPHpA09bjc33fpLcZn13nGzLUhj0UhQsZXN22mg6?=
 =?us-ascii?q?l/9xLJB47IiEWUjKCqer4Z3CHT9WeP122OvFtXUARoS6XKQWgfZlfKrdT+/k?=
 =?us-ascii?q?7CVKGhCa4oMgRf0sOCKrFFatntjVRGQvfvIsjRY2W0m22oHxaH2quMbJb2e2?=
 =?us-ascii?q?UaxCjdE1YLkwQS/XaAKAg/CTyso3zRDDNwD1LjeUDs/vdkqHO9UEA0yxuGb0?=
 =?us-ascii?q?p717q64hQVn+CTS+sP3rIYvycssy10E0yg39LSENeAvxBufLhYYd8k5VdH0m?=
 =?us-ascii?q?XZtxZjMZC6M69igVseeRxtv0zyzxV3FplAkc8yoXMoywpyKaSY3ElDdzOf3Z?=
 =?us-ascii?q?D/ILvXKnLs8xCpcKPZxkvR0NCR+qcJ6fQ3t0/svAWzGkU+9HVn1sFf02GA6Z?=
 =?us-ascii?q?XSEAoSTZXxX14y9xh9vbHafi4954XR1XB3Laa0siXC29UsBOsk1xages1TMK?=
 =?us-ascii?q?SeFA/9C8caHdShKPQ2m1i1aRIJJPhS+7AyP8OpavuG2airMP9jnD24l2RH5p?=
 =?us-ascii?q?5y0kaX+ip9U+LI25EFw++G0QedTDfzllShst3tmY9efz0SGHSwxTLmBI5JNe?=
 =?us-ascii?q?VOetMsD2u0Ls//49JlgZfmVn0QoFmmAEgA0cSkUQCfY1z0wUtb0kFB8lK9ni?=
 =?us-ascii?q?7t9CB5izEkqOKk2SXKx+nzPE4cNnVjWHhpjVCqJ5O9yd8dQh77PEASiBK56B?=
 =?us-ascii?q?OilOBgr6NlIjyWGBoZcg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DUAADVefJd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWgEASASKoQDiQOGbAEBAQEBAQaBEiWBAYhoj1+BZwkBAQEBAQEBA?=
 =?us-ascii?q?QE3AQGEQAKCLjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCw4KA?=
 =?us-ascii?q?gImAgJXBg0GAgEBgl8/glMlrnqBMoVPgymBSIEOKIwyeYEHgREnDAOBX0k1P?=
 =?us-ascii?q?oQDLgKDJoJeBI1pggiHEkaXJoI6gjyTNwYbmkGrGSKBWCsIAhgIIQ87gmxQE?=
 =?us-ascii?q?RSfBCMDMI1mgjIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2019 17:39:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCHcgMO128720;
        Thu, 12 Dec 2019 12:38:43 -0500
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
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
 <CAFqZXNsZvTfeL_ST7FSxbgM28E3RzKrF1f4JqYUhVY7++01NMw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a0fc6198-1a2e-0249-12cf-d2b6bdc9c647@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 12:39:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsZvTfeL_ST7FSxbgM28E3RzKrF1f4JqYUhVY7++01NMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 11:03 AM, Ondrej Mosnacek wrote:
> On Thu, Dec 12, 2019 at 2:14 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>>>>>> Instead of deleting the hooks from each list one-by-one (which creates
>>>>>>>> some bad race conditions), allow an LSM to provide a reference to its
>>>>>>>> "enabled" variable and check this variable before calling the hook.
>>>>>>>>
>>>>>>>> As a nice side effect, this allows marking the hooks (and other stuff)
>>>>>>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
>>>>>>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
>>>>>>>> for turning on the runtime disable functionality, to emphasize that this
>>>>>>>> is only used by SELinux and is meant to be removed in the future.
>>>>>>> Is this fundamentally different/better than adding if (!selinux_enabled)
>>>>>>> return 0; to the beginning of every SELinux hook function?  And as I noted
>>>>>>> to Casey in the earlier thread, that provides an additional easy target to
>>>>>>> kernel exploit writers for neutering SELinux with a single kernel write
>>>>>>> vulnerability. OTOH, they already have selinux_state.enforcing and friends,
>>>>>>> and this new one would only be if SECURITY_SELINUX_DISABLE=y.
>>>>>> Yeah, I agree here -- we specifically do not want there to be a trivial
>>>>>> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
>>>>>> be considered deprecated IMO, and we don't want to widen its features.
>>>>>
>>>>> In /etc/selinux/config SELINUX=disabled is documented as "No SELinux
>>>>> policy is loaded". How about if instead of blocking policy load and
>>>>> removing the hooks it just blocked policy load? It may be appropriate
>>>>> to tweak the code a bit to perform better in the no-policy loaded
>>>>> case, but my understanding is that the system should work. That would
>>>>> address backward compatibility concerns and allow removal of
>>>>> security_delete_hooks(). I don't think this would have the same
>>>>> exposure of resetting selinux_enabled.
>>>>
>>>> I think that comment stems from before runtime disable was first
>>>> implemented in the kernel, when the only option was to leave SELinux
>>>> enabled with no policy loaded.  Fedora didn't consider that (or
>>>> selinux=0) to be acceptable alternatives, which is why we have runtime
>>>> disable today.
>>>
>>> Do you happen to remember the reasons why it wasn't acceptable? We are
>>> ready to start pushing for disabling SECURITY_SELINUX_DISABLE in
>>> Fedora, but we're not sure why it is so crucial. Knowing what we need
>>> to address before disabling/removing it would help a lot.
>>
>> IIRC, they considered the selinux=0 kernel boot parameter to be
>> inadequate because of the difficulty in changing kernel boot parameters
>> on certain platforms (IBM?).  The no-policy-loaded alternative still
>> left a lot of SELinux processing in place, so users would still end up
>> paying memory and runtime overheads for no benefit if we only skipped
>> policy load.
> 
> Thanks, I was worried that there was also something more tricky than
> this. We could make adding-removing the kernel parameter easier on
> Fedora by creating and maintaining a tool that would be able to do it
> reliably across the supported arches. That shouldn't be too hard,
> hopefully.
> 
>>
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
> OK, so I'll put together another patch that removes all the
> security_delete_hooks() stuff and adds the checks.
> 
>>
>> NB selinux_enabled was originally just for selinux=0 handling and thus
>> remains global (not per selinux-namespace).  selinux_state.disabled is
>> only for runtime disable via selinuxfs, which could be applied per
>> selinux-namespace if/when selinux namespaces are ever completed and
>> merged. Aside from clearing selinux_enabled in selinux_disable() and
>> logging selinux_enabled in sel_write_enforce() - which seems pointless
>> by the way, there are no other uses of selinux_enabled outside of __init
>> code AFAICS.  I think at one time selinux_enabled was exported for use
>> by other kernel code related to SECMARK or elsewhere but that was
>> eliminated/generalized for other security modules.  So it seems like we
>> could always make selinux_enabled itself ro_after_init, stop clearing it
>> in selinux_disable() since nothing will be testing it, and just use
>> selinux_state.disabled in the hooks (and possibly in the
>> sel_write_enforce audit log).
> 
> Yes, that sounds reasonable.

And maybe we should rename selinux_enabled to selinux_enabled_boot for 
clarity and to match selinux_enforcing_boot (similarly renamed earlier).


