Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF11C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E9B21655
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SP2fIhTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfLLNOe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:14:34 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:46455 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLNOd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 08:14:33 -0500
X-EEMSG-check-017: 37720690|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="37720690"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 13:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576156469; x=1607692469;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VSqEifq199WvB/njlsib+fDIiduLZxRXFBa5Tb/EU3s=;
  b=SP2fIhTXV26OmN7/EOPcov4K4kYoBbbJ8WTLwM2YJtAX0HgXzdzgEn91
   A/EEi+q9YzyA3rEV93QbFRDnYHNd+cztclJOp4lZ3jSVzyy9E1t7FcLMm
   5iTXWKG34gBgQu0Sn93DNXthmuQdRwN4QYHX08kmo7JIk61mVrJDGpDvQ
   bGkzLYoiKQiawIvGdf9QCIQSeP+NghnGsZJ4MLMzfL2bQwDwQ9VIe97fg
   270KoZTOkPN1IKawixaBVTgD2RFN8sdI6oQwS55PWUobvIhmEcthQL6iH
   Ew2Ei0bbPlrgm7ompMH8cw4fANPokTQoiQ/9Hg7wrin9bD8AeO3/moe3e
   w==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36656190"
IronPort-PHdr: =?us-ascii?q?9a23=3AMGPO6RBfXSBFkK2BPtTIUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/rsywAkXT6L1XgUPTWs2DsrQY0rGQ6vG/EjFYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAncsssbjYRiJ6ot1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAEyJs53RHfd+GHc5KW7RL4TuqRIDF4iXR4c7y8nxa/6VWsx+LzW8Wu0F?=
 =?us-ascii?q?tGszBJnsfDu3wTzRDf986KQeZn8Ei7wzaAzQXT5/lBIUAziKXUNYYswqU1lp?=
 =?us-ascii?q?oPqUTDGTL2mFnugK+WaEok/u+o5vz7Yrr8vJ+cNpJ0ihrkPqQvnMy/D+M4Mh?=
 =?us-ascii?q?MQUGeH4+i8yL3i8lH5QLVNlPE2lLXWsIvGKsgBo665AgtV3p4i6xa5ETimzM?=
 =?us-ascii?q?wVkWQIIV9KYh6Kj5XlN0vQLP33E/uzmUmgnC9ux//cP73hBpvNLmLEkLfkZb?=
 =?us-ascii?q?t98FNTyBEowNBD55NbFrEBIPXpVk/3r9zXFAU1MwOzw+b5ENl9zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqViI5ucoI+mXYo8aoiryJOY+6v70k3A2hF8dcrO13ZcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQeP2klKCSiBcZnapUqIn+j47CJipDZrNRoCpnrOBxj?=
 =?us-ascii?q?63EYFMaWxcFl+MFnLofZ2eW/gQcCKSPtNhkjscWLiiVYAuywquuxP9y7pgLe?=
 =?us-ascii?q?rZ4TEXtZL51Nhy4u3TlAwy9TluA8SayWGNQHl+nnkUSD8uwKB/vUt9x0+H0a?=
 =?us-ascii?q?h5hfxYCNNS6+pSUggkKZHc0vZ6C9HuWgPBZ9uJTVGmTci7ATE1UN082MEOY0?=
 =?us-ascii?q?ljFNW4lBzD3DSlA6UTl7OVAJw46KXc32L+J8xl0XbJyLEhj0U6QstILWCmhK?=
 =?us-ascii?q?t/9w/JB47TkkWZjL2ndaIG0y7I6miDzHCCvEZCUA5/Sa/FR2wQZlPKrdTl4U?=
 =?us-ascii?q?PPV6SuBqo9MgtO18GPMatKZcftjVVCRPbjPs7SbH62m2e1HRyI3K+DbJL2e2?=
 =?us-ascii?q?UB2yXQEFMEnB4X/XaHMwg+GyigrnnADDxhC13veVng8epgp3OhSE870QWKY1?=
 =?us-ascii?q?dm17qv9R4fneacRO8L3rIYpCchrC15HE6n0NLLD9qNvBJhc79BYdM5+VtH0G?=
 =?us-ascii?q?XZtwtnPpO+NaxtmlkecwFvtUP0yxp3EplAkdQtrH4yzgpyLqKY0FVbezOa2p?=
 =?us-ascii?q?DwOqfYKm/p/B+xba7bwU3R38yQ+qcI7vQ4qknssxutFkY473pn1NxV2WOG5p?=
 =?us-ascii?q?rWFAoSTY7xUkEv+hh/oLHaeDU954TS1X1pKqS7rj/C28guBOsgyxagYtJfPL?=
 =?us-ascii?q?mDFA/oHM0QH9KuJ/Aym1i1chIEO/hf9LYqMMOgePuGxa+rPOB5kDKlk2tH+o?=
 =?us-ascii?q?Z93VyI9ydnS+7ExpIFw/aG3gSZTTv8l02ussPqmYBefz4eBGy/xjb+CI5Tfq?=
 =?us-ascii?q?0hNboMXECoL9e6xJ1bgIXrUnVV9xb3AFYBw8mgche6dVHx3QRMk08QpCr0tz?=
 =?us-ascii?q?G/ymlPjzwxrqeZlBfLyuDmeQtPbnVHX0F+nFzsJs6ylNlcU0+2OVt63CC57F?=
 =?us-ascii?q?r3kvAI7J90KHPeFAIRInn7?=
X-IPAS-Result: =?us-ascii?q?A2DPAAD6O/Jd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWgFIBIqhAOJA4ZrBgaBEiWBAYhoj1+BZwkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCLjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxVBEAsOCgICJ?=
 =?us-ascii?q?gICVwYNBgIBAYJfP4JTBSCsSXWBMoVPgyyBSIEOKIwyeYEHgREnDAOBX0k1P?=
 =?us-ascii?q?oQDLgKDJoJeBI1pggiHEkaXJoI6gjyTNwYbmkGrGSKBWCsIAhgIIQ87gmxQE?=
 =?us-ascii?q?RSfBCMDMI1zgjIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 13:14:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCDE1Bu006282;
        Thu, 12 Dec 2019 08:14:03 -0500
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 08:14:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>>>> Instead of deleting the hooks from each list one-by-one (which creates
>>>>>> some bad race conditions), allow an LSM to provide a reference to its
>>>>>> "enabled" variable and check this variable before calling the hook.
>>>>>>
>>>>>> As a nice side effect, this allows marking the hooks (and other stuff)
>>>>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
>>>>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
>>>>>> for turning on the runtime disable functionality, to emphasize that this
>>>>>> is only used by SELinux and is meant to be removed in the future.
>>>>> Is this fundamentally different/better than adding if (!selinux_enabled)
>>>>> return 0; to the beginning of every SELinux hook function?  And as I noted
>>>>> to Casey in the earlier thread, that provides an additional easy target to
>>>>> kernel exploit writers for neutering SELinux with a single kernel write
>>>>> vulnerability. OTOH, they already have selinux_state.enforcing and friends,
>>>>> and this new one would only be if SECURITY_SELINUX_DISABLE=y.
>>>> Yeah, I agree here -- we specifically do not want there to be a trivial
>>>> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
>>>> be considered deprecated IMO, and we don't want to widen its features.
>>>
>>> In /etc/selinux/config SELINUX=disabled is documented as "No SELinux
>>> policy is loaded". How about if instead of blocking policy load and
>>> removing the hooks it just blocked policy load? It may be appropriate
>>> to tweak the code a bit to perform better in the no-policy loaded
>>> case, but my understanding is that the system should work. That would
>>> address backward compatibility concerns and allow removal of
>>> security_delete_hooks(). I don't think this would have the same
>>> exposure of resetting selinux_enabled.
>>
>> I think that comment stems from before runtime disable was first
>> implemented in the kernel, when the only option was to leave SELinux
>> enabled with no policy loaded.  Fedora didn't consider that (or
>> selinux=0) to be acceptable alternatives, which is why we have runtime
>> disable today.
> 
> Do you happen to remember the reasons why it wasn't acceptable? We are
> ready to start pushing for disabling SECURITY_SELINUX_DISABLE in
> Fedora, but we're not sure why it is so crucial. Knowing what we need
> to address before disabling/removing it would help a lot.

IIRC, they considered the selinux=0 kernel boot parameter to be 
inadequate because of the difficulty in changing kernel boot parameters 
on certain platforms (IBM?).  The no-policy-loaded alternative still 
left a lot of SELinux processing in place, so users would still end up 
paying memory and runtime overheads for no benefit if we only skipped 
policy load.

>> selinux_state.initialized reflects whether a policy has
>> been loaded.  With a few exceptions in certain hook functions, it is
>> only checked by the security server service functions
>> (security/selinux/ss/services.c) prior to accessing the policydb.  So
>> there is a lot of SELinux processing that would still occur in that
>> situation unless we added if (!selinux_state.initialized) return 0;
>> checks to all the hook functions, which would create the same exposure
>> and would further break the SELinux-enabled case (we need to perform
>> some SELinux processing pre-policy-load to allocate blobs and track what
>> tasks and objects require delayed security initialization when policy
>> load finally occurs).
> 
> I think what Casey was suggesting is to add another flag that would
> switch from "no policy loaded, but we expect it to be loaded
> eventually" to "no policy loaded and we don't expect/allow it to be
> loaded any more", which is essentially equivalent to checking
> selinux_enabled in each hook, which you had already brought up.

Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled) 
return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook 
might be the best option until it can be removed altogether; avoids 
impacting the LSM framework or any other security module, preserves the 
existing functionality, fairly low overhead on the SELinux-disabled case.

NB selinux_enabled was originally just for selinux=0 handling and thus 
remains global (not per selinux-namespace).  selinux_state.disabled is 
only for runtime disable via selinuxfs, which could be applied per 
selinux-namespace if/when selinux namespaces are ever completed and 
merged. Aside from clearing selinux_enabled in selinux_disable() and 
logging selinux_enabled in sel_write_enforce() - which seems pointless 
by the way, there are no other uses of selinux_enabled outside of __init 
code AFAICS.  I think at one time selinux_enabled was exported for use 
by other kernel code related to SECMARK or elsewhere but that was 
eliminated/generalized for other security modules.  So it seems like we 
could always make selinux_enabled itself ro_after_init, stop clearing it 
in selinux_disable() since nothing will be testing it, and just use 
selinux_state.disabled in the hooks (and possibly in the 
sel_write_enforce audit log).
