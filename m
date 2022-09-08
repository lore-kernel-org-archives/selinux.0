Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B68C54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 18:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIHSfc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiIHSfb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 14:35:31 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E8A599C;
        Thu,  8 Sep 2022 11:35:20 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A428D3FE6D;
        Thu,  8 Sep 2022 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662662118;
        bh=2YDp6ANOHSY/pfOcwedb0UMOggW+dTJfxmYKclcWSTQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=O1mB5CGlG8Ejt8ZvsZqNPptYh6NCej/TivdUj0HYtwGwsCll5YIgc1W6vzLurSda+
         zGvyvAJSB82Dhm5nyyCj9Hw8mB+VgpNgsAheRKDKY4eAZ8LtAse37FZRKSddmDHUae
         upCWB9qW4Z97yGWLdUzMtkoaPIyDfMhON03zXVdiB8YzEymfpBFURf+nWWFbY6XIN+
         VN4LtJUO6mfR9podcs4n7+CeQKbWqHKVpyy9WsE0MzoA16dCKaPudDEHGJApoGlMGr
         zm5bKAI4F1KllFyLZX1WV6YhA/5j8rhr/UTdj4psU2KE3SsYWe/FGcnyinVSK0D0Xy
         Mb+pbvF00fOJA==
Message-ID: <1d32fe80-7452-b2e7-3819-d631bd4f1524@canonical.com>
Date:   Thu, 8 Sep 2022 11:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/8/22 11:05, Casey Schaufler wrote:
> On 9/7/2022 8:57 PM, Paul Moore wrote:
>> On Wed, Sep 7, 2022 at 7:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/7/2022 4:27 PM, Paul Moore wrote:
>> ..
>>
>>>>    I
>>>> just want an interface that is clearly defined, has reasonable
>>>> capacity to be extended in the future as needed, and is easy(ish) to
>>>> use and support over extended periods of time (both from a kernel and
>>>> userspace perspective).
>>>>
>>>> The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
>>>> string interface is none of these things.
> 
> That wasn't the proposal. The proposal was
> 
> "smack\0smack_label\0apparmor\0apparmor_label\0future_lsm\0future_lsm_label\0"
> 
>>> In this we disagree ....
>> I think we can both agree that there is a subjective aspect to this
>> argument and it may be that we never reach agreement on the "best"
>> approach, if there even is such a thing.  What I am trying to do here
>> is describe a path that would allow me to be more comfortable merging
>> the LSM stacking functionality; I don't think you've had a clearly
>> defined path, of any sort, towards getting these patches merged, which
>> is a problem and I suspect the source of some of the frustration.  My
>> comments, as objectionable as you may find them to be, are intended to
>> help you move forward with these patches.
> 
> OK. Let's get'er done.
> 
>>>>    It is not clearly defined
>>>> as it requires other interfaces to associate the labels with the
>>>> correct LSMs.
>>> The label follows the lsm name directly. What other association is required?
>> You need to know the order of the LSMs in order to
>> interpret/de-serialize the string.
> 
> That's true for the string you included, but not for what I had
> actually proposed.
> 
>>>>    The ease-of-use quality is a bit subjective, but it does need
>>>> another interface to use properly and it requires string parsing which
>>>> history has shown to be an issue time and time again (although it is
>>>> relatively simple here).
>>> There was a lot of discussion regarding that. My proposed
>>> apparmor="unconfined",smack="User" format was panned for those same reasons.
>>> The nil byte format has been used elsewhere and suggested for that reason.
>> Based on what I recall from those discussions, it was my impression
>> the nil byte label delimiter was suggested simply because no one was
>> entertaining the idea of using something other than the existing
>> procfs interface.  It is my opinion that we've taken that interface
>> about as far as it can go, and while it needs to stay intact for
>> compatibility reasons, the LSM stacking functionality should move to a
>> different API that is better suited for it.
> 
> It's going to raise its ugly head again with SO_PEERCONTEXT for the
> SELinux+Smack case. But we can cross that bridge when we come to it.
> 

AppArmor too, I am working on revising the out of tree af_unix mediation


>>>> Once again, the syscall example I tossed out was a quick strawman, but
>>>> it had clearly separated and defined labels conveyed in data
>>>> structures that didn't require string parsing to find the label
>>>> associated with an LSM.
>>> True, but it uses pointers internally and you can't do that in memory
>>> you're sending up from the system. What comes from the syscall has to
>>> look something like the nil byte format. The strawman would have to do
>>> the same sort of parsing in userspace that you are objecting to.
>> Then we change the strawman.  That's pretty much the definition of a
>> strawman example, it's something you toss out as starting point for
>> discussion and future improvements.  If it was something much more
>> fully developed I would have submitted a patch .... sheesh.
> 
> Fair enough.
> 
>> In case it helps spur your imagination, here is a revised strawman:
>>
>> /**
>>   * struct lsm_ctx - LSM context
>>   * @id: the LSM id number, see LSM_ID_XXX
> 
> A LSM ID hard coded in a kernel header makes it harder to develop new
> security modules. The security module can't be self contained. I say
> that, but I acknowledge that I've done the same kind of thing with the
> definition of the struct lsmblob. That isn't part of an external API
> however. It may also interfere with Tetsuo's long standing request that
> we don't do things that prevent the possibility of loadable security
> modules at some point in the future. I will also mention the out-of-tree
> security module objection, not because I care, but because someone most
> likely will bring it up.
> 
> On the other hand, there's no great way to include two variable length
> strings in a structure like this. So unless we adopt something as ugly
> as the nil byte scheme this is supposed to replace I expect we're stuck
> with an LSM ID.
> 

well at a minimum we shouldn't export the kernel internal LSM_ID if its
exposed to userspace it needs to be something that can live with for a
long time

- Fixed length strings, which really are just a long LSM ID, Say 8 bytes.
   Can still even look human readable. For most* LSMs this could just
   be their name.

   * only safesetid and capability don't fit atm

- and certainly uglier, for variable length use an index for one of the
   variable length strings, with an embedded \0 inside the variable length
   string

{
   size_t lsm_id_len;
   size_t lsm_id_ctx_index;
   size_t ctx_len;
   unsigned char ctx[];
}

with access to lsm id being ctx[lsm_id_ctx_index]

