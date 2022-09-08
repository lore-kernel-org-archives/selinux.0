Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0BBC38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiIHSFq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiIHSFp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 14:05:45 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54846BC120
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662660343; bh=HFGmKwdtQQqYVX04M8e8m+HH1UKqL7TpmGhVYiIsZ3A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C2kl70HXngSyDnuPgCNKIJafps3GpzZu+aCsQ/1KvG7hwaB8PTQnoDMWglckxo6UlgnQf52/Y6QDb+4sYALQTmyJts4+uvJ9j4AhDqP3KtzzFP19lY+8BpsxuD7bUYoWYPOfGFC61mxgBK5K3/3fG0NAMt8GC/g61/Wa6gCac++xPGCf/+BMJSd7vDwSNIjBI3y/ZIUY/tiB/n/8/19p1oSqtVyKAbfdtKmkZ01AtGjy6UxvrX0VgKiKPg0EB3KQQpnNItzz9UWYv6MuyX1KWM8JJET5bxXiRYBOys+7vfHv+vURJipGb5JE0/uiIgmFNyLqczwaXD5JIPZwcTG2BQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662660343; bh=EjlZgZ5KKzsOjmrotgQkz0TqhjjOwsbulV1FlUMEhya=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CKgMrOMwrLdOznvkbu2t17kYlZj9rhtr0/HiKc+TNiNMIQhluWekkL/w9avpHUfYVagVAqgSERwzEG10FAjBUnF2vuI+M1ecGmZ6ePHgjBoxod8sng9zpDvOsHvTDPxrUYvxpBe+Sv2aLrF5xI99f8pM055ZS3ntUUy6V6V4YtigdTHbc1aCr80kq30JToAUqMfmQ5kG1Bci1Xv1ybi4dM6eECBoekKx0oiG29bx8OkhoBJT7vhYcQZFHW/G/uWN+HsaC82vIJUZtpAClh9bbosIG97U6Uvv8NKtUhPWC42tlLzM8RGfhpfjxb7TqYF2PlZYns9GQdHq3T4fCgLQQg==
X-YMail-OSG: .5bC.mIVM1ktBaUJooxvyy3xgk2UmQEeOltBy7Dsgbx288Z5Pz8EyTcTXgE96wq
 0DowgYTVDk4EDbxVu2CBHeig8a5CBrhBROnT.CnmjXW9EFB..BGHNjuFYFfKlNuJ9jXsLkVhmHrJ
 j.mljIgYOIq8SeEI0zn6zkScofOF85i1fskkscS61vkHHr6WXGS.JLBYw0Zy1BODyzutDVFo88em
 DqBqsMdeXkKEFLDYXXzig4k7aetl29wzj9QXcggRqjx_rs244ltj49JJqqxQlWhELARrgkwYvp1U
 kD5pfRzvbPOeQFo1ZonikxSP2dIEG4aGIEmPGjA0j3MyGDOJ1SbFMo9VcWAKVuDtDGB5mhsdF7tN
 1bhxo_Vn5PMMwPYOq5XSK9TP.lX6um1nwjlCl1hwjHJr1ferMNtdZ4NDHvQNQOUl0YMx8iTcCapg
 SziKPW2aCotT1AGwPt9QjRuIbn6SyHTem0X62eAoU8Vv_WYMcZCgtN08uGyqEP6FvRze3qRL8139
 TcJbYhof4W5rtzqU3sIjOQsieBmAjXFVrxfmOK1Sa81yWwsbWhfA5hPiy_kxfQ4Pz5IBVlnZ0Lp0
 atRunDDtoLwNLLztn00cSqi0SClc5MYGSTafmNM2G7JX3BixtAZayGrFQ5.17i.0lMGJXoIxFwiG
 mc1LXuqGh5GZYwkbg07NPxV1No4KilkVIxFE_emY_rx.idUtPa4vZBemWAXgjxCx5PhP4lUDXc75
 mw6cefPlxWxy36Y7ZUpGANmWHwpe2uxybiun2f.Nm5JHfCqqrkpG0l0h86HzCJRdU7pnF6ZOyKq_
 3i6xc37qO1rpxir6ydavByBS01ekyvHohACMin5W9groOEDHsF1rAmR9YSw6eGZ_HrX5RJk39.xX
 XdvAT8sEv21T2RqS5K7tisJ1cBpfPtR_NJWlOvrEGGbuDmXiuLQGegN6QBWOtVfALw_B9JJHgYNC
 4IfpDk8pl5g4HsYMUAOXq_feeGx2rpGUwBHT3VjzodYnwMCgAVPzUz_017Io3qEbMa6rspae_mys
 SUPla1AEnxh6cUs1C6Szl32zuevzSd.ALbnIUp6qJHzD_WnkXjZW.vFXahhGPAvMWFnnz0GgZFBZ
 DBoEATm_Ny0g1EDGbP9hjGc8LBZ2CXDtTKxJbP8fsTUfSundRvsULFqaOhE9CaJsqnDUrUg_S3P6
 h1SASS8_00yS2Gxf63FRJVikmfWGdGkmXZQ0XqxstbVomuGDAA.w8L04nvN7KoTeD4oZpzS1t7IF
 pi52M.vAhJl5T9buTU3XNBSg6yvidOKwaBPawwD97ILmpQVV3GDE9b2_fwYge2DuSHIJIGcclye9
 lROqsS1d5jw7SR1b4j.TXeVM1EItGihac4wOst4nf9bUQ4CarcYUe5ayERntOGAwP4tbZ8WPCjGB
 nqAqJNUBK3kK5PFoSG7bWmjQylB8U4rCSlkmacLzYp7QHmvg1Y13nlkaBnqCOBwaF_5sUnvXwNWf
 NGP8yTm9TQRBBMHrOm_M8hrn4LDR20xG9XaPejOSjoVBmb038jkFQiWsLJN3N2jQFtSMMdOAeCWd
 d6walMIrNuIYv0p61mBvYCCXQfwFrwzBnouRFERAY9yRThujokkF9gUGV7fwFOo1pVOoHcXctNGz
 dN7QOBzTqJgJfIKhSGQZY0XC_MkinCsTXZKRgogZwZAIbqExWEpSHkqB1D5oSRSomrtHTnA1.oml
 mb0kmJNqyYBomxWD4lui8Wf8oBE5oK9BINx4I714C_qN1p7D2UEjaVlAxWILDNll05vOU7uzCDrl
 YnLGsKvX56TDIRUguhwzjZm8HuPoV8lzl30R61J6CUYOzbCAOWnrkT4OrCyAs9mpUz6.005FFw13
 IlvobnSFgNcW9Z19XcENQy9DwYKP4DfWpgmE5LmipS661Kmwm_aNFaQLujnFgtAWokO7_rHoieWe
 l.APTZycQnkBSZq1eDiIXPQgLH83Jpqu8PEQ4feC6nO.vdGi0CCJ.1UlUIazWlRwndbWdCSxCdUd
 bJ94ag.UW7wv5kirO_ip8UhQ4K6gRUjIR3cGQrKpIWIoqjZUoPG4NHmQeVLPek_NRR1PqZuL1.Ct
 tivzT_7C8R1BHvxtZDy86qaulitmjc3FU2Ej_6cRKuugoDgNttq7stf85fWudUfAdguVo15Qezoe
 aw3DOQU_VAgEgF1lzDWf5BCwC23pH0g2N1_ddC2sGmZuMMYLc4saOHKx8bvlDVmLM9bbYifK9XAP
 qcFkXNAfVQP0XlL.iuYfK6ZFPS.3X4XB6aALL
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Sep 2022 18:05:43 +0000
Received: by hermes--production-bf1-64b498bbdd-8fbp7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 21eb8d097f42d735685a2100282399cf;
          Thu, 08 Sep 2022 18:05:41 +0000 (UTC)
Message-ID: <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
Date:   Thu, 8 Sep 2022 11:05:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/2022 8:57 PM, Paul Moore wrote:
> On Wed, Sep 7, 2022 at 7:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2022 4:27 PM, Paul Moore wrote:
> ..
>
>>>   I
>>> just want an interface that is clearly defined, has reasonable
>>> capacity to be extended in the future as needed, and is easy(ish) to
>>> use and support over extended periods of time (both from a kernel and
>>> userspace perspective).
>>>
>>> The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
>>> string interface is none of these things.

That wasn't the proposal. The proposal was

"smack\0smack_label\0apparmor\0apparmor_label\0future_lsm\0future_lsm_label\0"

>> In this we disagree ....
> I think we can both agree that there is a subjective aspect to this
> argument and it may be that we never reach agreement on the "best"
> approach, if there even is such a thing.  What I am trying to do here
> is describe a path that would allow me to be more comfortable merging
> the LSM stacking functionality; I don't think you've had a clearly
> defined path, of any sort, towards getting these patches merged, which
> is a problem and I suspect the source of some of the frustration.  My
> comments, as objectionable as you may find them to be, are intended to
> help you move forward with these patches.

OK. Let's get'er done.

>>>   It is not clearly defined
>>> as it requires other interfaces to associate the labels with the
>>> correct LSMs.
>> The label follows the lsm name directly. What other association is required?
> You need to know the order of the LSMs in order to
> interpret/de-serialize the string.

That's true for the string you included, but not for what I had
actually proposed.

>>>   The ease-of-use quality is a bit subjective, but it does need
>>> another interface to use properly and it requires string parsing which
>>> history has shown to be an issue time and time again (although it is
>>> relatively simple here).
>> There was a lot of discussion regarding that. My proposed
>> apparmor="unconfined",smack="User" format was panned for those same reasons.
>> The nil byte format has been used elsewhere and suggested for that reason.
> Based on what I recall from those discussions, it was my impression
> the nil byte label delimiter was suggested simply because no one was
> entertaining the idea of using something other than the existing
> procfs interface.  It is my opinion that we've taken that interface
> about as far as it can go, and while it needs to stay intact for
> compatibility reasons, the LSM stacking functionality should move to a
> different API that is better suited for it.

It's going to raise its ugly head again with SO_PEERCONTEXT for the
SELinux+Smack case. But we can cross that bridge when we come to it.

>>> Once again, the syscall example I tossed out was a quick strawman, but
>>> it had clearly separated and defined labels conveyed in data
>>> structures that didn't require string parsing to find the label
>>> associated with an LSM.
>> True, but it uses pointers internally and you can't do that in memory
>> you're sending up from the system. What comes from the syscall has to
>> look something like the nil byte format. The strawman would have to do
>> the same sort of parsing in userspace that you are objecting to.
> Then we change the strawman.  That's pretty much the definition of a
> strawman example, it's something you toss out as starting point for
> discussion and future improvements.  If it was something much more
> fully developed I would have submitted a patch .... sheesh.

Fair enough.

> In case it helps spur your imagination, here is a revised strawman:
>
> /**
>  * struct lsm_ctx - LSM context
>  * @id: the LSM id number, see LSM_ID_XXX

A LSM ID hard coded in a kernel header makes it harder to develop new
security modules. The security module can't be self contained. I say
that, but I acknowledge that I've done the same kind of thing with the
definition of the struct lsmblob. That isn't part of an external API
however. It may also interfere with Tetsuo's long standing request that
we don't do things that prevent the possibility of loadable security
modules at some point in the future. I will also mention the out-of-tree
security module objection, not because I care, but because someone most
likely will bring it up.

On the other hand, there's no great way to include two variable length
strings in a structure like this. So unless we adopt something as ugly
as the nil byte scheme this is supposed to replace I expect we're stuck
with an LSM ID.

>  
>  * @flags: LSM specific flags, zero if unused

For an API shouldn't this be a specific size? u32? I'm not really
up to date on the guidance regarding which it should be.

>  * @ctx_len: the size of @ctx
>  * @ctx: the LSM context
>  */
> struct lsm_ctx {
>   unsigned in id;
>   unsigned int flags;
>   size_t ctx_len;
>   unsigned char ctx[];
> };
>
> /**
>  * lsm_current_ctx - Return current tasks's LSM context
>  * @ctx: the LSM contexts
>  * @size: the size of @ctx, updated on return
>  * @flags: reserved for future use, must be zero
>  *
>  * Returns the calling task's LSM contexts.  On success this
>  * function returns a positive number representing the number of
>  * @ctx array elements, which may be zero if there are no LSM
>  * contexts assigned to the caller.  If the size of @ctx is
>  * insufficient, -E2BIG is returned and the minimum required
>  * size is returned via @count.  In all other failure cases, a

s/count/size/ - but I get what you meant.

>  * negative value indicating the error is returned.
>  */
> int lsm_current_ctx(struct lsm_ctx *ctx, size_t *size,
>                     unsigned int flags);

This is a workable interface. Certainly more friendly than the
nil byte format.

>   It was also self-contained in that no other
> interface was needed to interpret the results of the syscall (well,
> beyond the header file definitions I guess).  Finally, it made use of
> flags and "reserved for future use" token values to allow for
> additional data to be conveyed in the future.
>> Can you describe potential flags or additional data? Planning for the future
>> is a good idea, but throwing fields on "just in case" seems contrary to
>> what I'm used to hearing from you.
> Adding flags to a syscall is a fairly common practice.  If you're
> making the mistake of confusing this with the discussion that is
> ongoing audit/fanotify discussion, you can think of the flags as
> similar to adding a type/length field to a struct (which I support).

OK. I can see potential.

I will head in this direction. A couple questions:

Would we want lsm_prev_ctx() as well as lsm_current_ctx(),
or should we use the lsm_ctx->flags to identify the provided
context? If we did that we should have an lsm_ctx() system call
that returns the current, prev, and whatever other security
module specific attributes might be associated with the process,
each identified in the flags field. While the "current" context
is usually what we're after, there may be cases where the other
attributes are desired.
 


