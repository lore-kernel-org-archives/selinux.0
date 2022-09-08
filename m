Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE1C54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 22:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIHW6S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIHW55 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 18:57:57 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4C3A161
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662677802; bh=EEFe3TOjQIpoYi9BDXvcDefQqh7eeUGI+McVZ9ygYuI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SqVdP3yDNf3PXg3vRLRdiDhP1PNxD+tv9VqNAmnQ1qTD3uHgSME4/eeTvAfDOqBLxP8Q3GX+7jWULZ2aw/2Pa6UIbPoteKvusEIKDLkt1ZLejXmoywr3no89At4YBXvMAPtjs65DL9YbDv5f+XdeWeE90/U+50e5qayCfqB/0YSsgHIgNrKNUe9rcin5Hk/Z+2lLm6rhaWSa8rQtwmYhuqjDxNYVV47UJRI5b3Svv/G0Ngu82R0kvpaJrln9diKSH8f/03GVV9fTIaoXf6hJtOgSBPkYRID6/JzSapXI0VkiMp6Ed9wU5y+HdrPQ8fOswxJj5KS1EHcLp4F3ZVC6Yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662677802; bh=76/sN+3/FG6/VzUZZ+5+8zX9q01R8nPHIpg8KqGOtit=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RL/wF+fvjkyNr/00CECZePffmS99TtmtQ2QOF7seJHG5plGedn5HOeg9fCaL5kEgViUUojeJvNV5H5aFB0SQfLAfZ5Z5jX4Jtyt0mu44GmeinIAQRNRfrPSh70gT03Jtsv6NIq7a/qodltUX13RHq1nSSF8LV60dbasyoTdScd9tG8d17AYs9u+3ZsFYcYlAiE8w48wUzWENQYD31M8c72P3PYvkqQBSASvemUdukFEncIVz6Bn9GOaAyrYHz4umhdd9aDSUeQEJNWD/XTrg+trTJv63r+v3iJ2gSVb3PNUxa2AG/eRgPKgS9q4uAMafhoTWa2OfwqX4puAGubff4g==
X-YMail-OSG: vQi3zhQVM1lfcIUdkvFzErVch7yckKmDDXM6VdgIbtR2Nz_SSOjMGOUyRpcU5XJ
 8uKmrnz3l0BrP9tvWUUgV0VQmryzdsqEA_UCxR6CiFfVpduoAPU00WnkuD0Qzzrifwwpx190V7DA
 AKydpgThZmOiPy4XDOEKcsQcoO6EjkFHb5i9cnLwPnMXCevoBim7flk3aRFbAWJeE2Ut8h2bFNFy
 EIsvQZ8cw3edcRJJGMU0lY5j4zUzTxH05YCIQqtqNrbWsDJ4WkBdebvFgrhr.gzKSgDkoEeI0Nko
 TWwc3EJJ7n7dHExMHivfJcausxV3J4.Ew58wO1Fn6ZbIMtcen.lH50mB3dPT05.zkyCS9vv.z4dI
 odMMwJiSEXm37XKpFu677_v6PT_zS.AvyY1Z0n_fhfDZhZS0sIz0xmoQT2V24hDjJswDu0KdY5Hl
 g9tr4LPBFi23L9eMb4m2vykY9w1QNhg09Q8YsTb1EA9AnnzHmqrTGKKOSg5BNIMlG5ffTBYz4I9Q
 taocDsYncqtu_hQg2V.WVb4R7Gm45Hwkox3sg0xHX9gq0H.tO2qLtuI4oytXN0AhzEPHvyU5YpYX
 E1_GFj6TLCisqYTEtDWpWPH7XVbryUu1gLnwqTeP.a2PWg72TmvE2kgVUzvpxVIKLSCUwhsrexyb
 1075qdM8WONVjJ3DIXk5Txy8Ll_ogJAFjOCncjDVANu15v5fwtE.9x_A7KbW1dAjvK8Z3DvXAH7A
 arEfXrSbYoY2xkoNAKuSC7.mgTjxBdrHJd9ixsIXfKeG5vUnDyxHNZiUgBRp1gnuSbK1F1ZHfoOf
 WZnRqkolFJjpSDzdjEb9Pealy4UMgN0VvBUMLZPQ26xx4e5NqB7HdAOXHROZFHMGxvJfWRd7plX7
 zwVWRByLXNaQB900GzAYTn5ZnP93xGf8aXMOWcIEUxpYE81XcDv0JLK18R8nIy3mNPKhwH.xSnV9
 TWI94hm.C6fAS3io3doVqRS6Jg7FJKGO9OU2pRlyZ37ZDLjUwbP7mL.DNQirmQ0SqWSMowVnWp20
 TW1M4lBbBL4ajoy59vM2ttqvWwClQM4zNlTmKsHoBY214lkFy01NzaED0qVOIOXBVdOmLGLNMkoW
 xkBbAS64EF8j1P51MswDCXDYCDyA5L2RmFs.vJdbsYpPY7vesnZP.q.Tw3K5_yTFSq_sz4KsicWu
 WUi0uX5MCa1DRptnhb4WceUMyh0reflYsJoQBWTrJHY9sRQmQTtQppSSKBV95qQmu.KgrgxV2M7E
 ac5d0OeZk3ZN058qrK4X8tiIGyIBlJa44D1xfNLO9K.w4xY_bUPWLu0QswoQhHZsY3hg4uwpKAkP
 Mn8e0WvHKqIHh6OMCMgerjmgkHED9_uu7ORpy5uPwRxXSF2rub1yvxQkmm7hivsoWehbj6BpKMsL
 8TU8t061k77L_KSJmyiTBqyGOPPa5ulkWEwwJlGo6zfQ58Dl2t4Ek69_GtlK8vu9RF0E535ObeYz
 Cl_AJFjaeNZz68VDb0PfSYcZ4EfrQvkFHpNzWgwYBxdrIuhCuS8TCWu2VvoG1cXrEJTGgfIGEBWL
 qm0gxQfB_.afWjWV_LQAdp99tAgX9AeiCrYxQQBj0bue8opiLcTuN8XVTzgBwopOQ510e49i26zz
 9MhmqHoLeQlspUMzfwU5N5cR5tNPfhkrbOZ3OgqCSuvtMPh_73QBR1YjFoXLK5B5kPbAvLYBqUwW
 k_xQO6M1xASK_E4EBwIUUWl_fmoC7BUFEQjwoobjkuGbsXUUjof8K5fbsbx7gT2y9ZxrGyibHjtl
 t18OwY4X2dQsBblwfGpbFpuqT6tZFY.yWR39L2Yi25_T3AQ_3wcSDbktf4IlHF1nmUwyl_kQ_BcU
 4xSfN.q.tPIZIpB4mPfqdtJNGXMGGDdXfe8TkWx46EtQGRV_t7d1HWV5e2oqwhbX4oAaFBgMs6CX
 PM2t0hpTe8dI4oofF5EXbTSfg1FAa6jeWsGmZJPhqMwsinf4LQKHKTP79I_hCSoGhWiyCDTmKwbE
 2zqoV.CAUGzVMGwlqQv6cKDNXTjU2FzFYTMpESXfZHB0vfk.yk9NDj58_BHlZSTm1cY10nZKb6Tm
 eKopyP7OSu_hjee.FsoEqo_d5_tR6fkdAtnx38XwAPK5VLMXT2Ukz5tv4AYrQe5BdieHXwPqcAe5
 _k6ER_7EHEjVn.2IAtBkdmsLRtWqGS9Rn8LucqlB6CByTMG9njSkkEU8p3iOy0gmdu3YUtENzsuO
 plD94yJxMGHc2u_MF6T2DagWDGxF_EkTX6LPhzyenHd5etXyn1Dy4TqmVoYJbgXF4M9WoaZ5EOwf
 6RBVMx9sXdPHksw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Sep 2022 22:56:42 +0000
Received: by hermes--production-bf1-64b498bbdd-gdn7j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9fb43f7856e68ca532e9aa822ec5de89;
          Thu, 08 Sep 2022 22:56:38 +0000 (UTC)
Message-ID: <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
Date:   Thu, 8 Sep 2022 15:56:37 -0700
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
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/8/2022 12:32 PM, Paul Moore wrote:
> On Thu, Sep 8, 2022 at 2:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2022 8:57 PM, Paul Moore wrote:
>>> On Wed, Sep 7, 2022 at 7:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/7/2022 4:27 PM, Paul Moore wrote:
> ..
>
>>>>>   The ease-of-use quality is a bit subjective, but it does need
>>>>> another interface to use properly and it requires string parsing which
>>>>> history has shown to be an issue time and time again (although it is
>>>>> relatively simple here).
>>>> There was a lot of discussion regarding that. My proposed
>>>> apparmor="unconfined",smack="User" format was panned for those same reasons.
>>>> The nil byte format has been used elsewhere and suggested for that reason.
>>> Based on what I recall from those discussions, it was my impression
>>> the nil byte label delimiter was suggested simply because no one was
>>> entertaining the idea of using something other than the existing
>>> procfs interface.  It is my opinion that we've taken that interface
>>> about as far as it can go, and while it needs to stay intact for
>>> compatibility reasons, the LSM stacking functionality should move to a
>>> different API that is better suited for it.
>> It's going to raise its ugly head again with SO_PEERCONTEXT for the
>> SELinux+Smack case. But we can cross that bridge when we come to it.
> There are also problems with IP_PASSSEC/SCM_SECURITY that we've never
> fully resolved (and have gotten a bit lucky over the years); it very
> well could be time to add support for IP_SECURITY as the multi-LSM
> replacement for SCM_SECURITY.  We could leverage the same LSM context
> structures as in the other multi-LSM interfaces.  Existing
> applications could continue to use SCM_SECURITY; in fact I believe we
> could have both SCM_SECURITY and IP_SECURITY in the same message for
> maximum compatibility.

Adding IP_SECURITY seems sensible. Having both at the same time leaves
us with the question of which security module's value to put in SCM_SECURITY
when there are multiple choices. I assume we'd use the first available
value, as determined by the LSM list order, or the interface_lsm if we're
supporting that concept. And again, that's a problem for the complete
stacking round.

> https://github.com/SELinuxProject/selinux-kernel/issues/24
>
> For SO_PEERSEC, we should probably just introduce SO_PEERSEC2 or
> similar, using the same multi-LSM context structures as the other
> interfaces.

Also sensible, although I think SO_PEERCONTEXT or SO_PEERCTX is a better
name than SO_PEERSEC2. Also a problem for complete stacking and it is
way to early for me to get into bikeshedding.

>>> In case it helps spur your imagination, here is a revised strawman:
>>>
>>> /**
>>>  * struct lsm_ctx - LSM context
>>>  * @id: the LSM id number, see LSM_ID_XXX
>> A LSM ID hard coded in a kernel header makes it harder to develop new
>> security modules.
> There is so much precedence for defining a token scalar value to
> represent a "thing" that I don't know where to begin.  Look at IANA,
> there are entire organizations that exist to map "things" to numbers.
>
> If you're objecting to assigning LSMs fixed integer numbers you've got
> to give me some very explicit reasons (complete with examples) as to
> why that would be a mistake.

I talked myself out of the objection below. Thanks for listening.

>> The security module can't be self contained. I say
>> that, but I acknowledge that I've done the same kind of thing with the
>> definition of the struct lsmblob. That isn't part of an external API
>> however.
> I'm not following you here.  See my comment above about better examples.
>
>> It may also interfere with Tetsuo's long standing request that
>> we don't do things that prevent the possibility of loadable security
>> modules at some point in the future.
> I already replied to Tetsuo's email, and while this particular point
> about LSM ID numbers wasn't directly addressed, my response there
> seems to apply equally well here: it's not so much about loadable
> LSMs, it's about out-of-tree LSMs.  These are two very different
> things, with different solutions.

Agreed.

>> On the other hand, there's no great way to include two variable length
>> strings in a structure like this. So unless we adopt something as ugly
>> as the nil byte scheme this is supposed to replace I expect we're stuck
>> with an LSM ID.
> I don't like making general comments, but when in doubt, consider me
> not-a-fan of string-based identifiers in APIs.  Give me token scalar
> values instead.

Works for me.

>>>  * @flags: LSM specific flags, zero if unused
>> For an API shouldn't this be a specific size? u32? I'm not really
>> up to date on the guidance regarding which it should be.
> Enh, sure, whatever.  You'll remember my initial comment about not
> being a syscall stylist; if the discussion has moved to seriously
> discussing the syscall prototypes we should likely start a new thread
> and bring in the syscall folks ... I vaguely remember there was a
> mailing list for syscalls and API changes ...

Good idea. I'm reading the official how-to-write-a-syscall documentation.


>> I will head in this direction. A couple questions:
>>
>> Would we want lsm_prev_ctx() as well as lsm_current_ctx(),
> I'm not sure I'm following your thinking, what would lsm_prev_ctx() do?

Instead of the values in /proc/.../attr/current you'd get the
values from /proc/.../attr/prev.


>> or should we use the lsm_ctx->flags to identify the provided
>> context? If we did that we should have an lsm_ctx() system call
>> that returns the current, prev, and whatever other security
>> module specific attributes might be associated with the process,
>> each identified in the flags field. While the "current" context
>> is usually what we're after, there may be cases where the other
>> attributes are desired.
> I don't understand what you mean by "prev"{ious} attributes.  I'm
> thinking of lsm_current_ctx() as a multi-LSM replacement for
> /proc/self/attr/current.  If, for example, we wanted something for
> /proc/self/attr/exec I imagine we would create lsm_current_exec(), or
> something similarly named, with a similar prototype.
>
> Or perhaps we try to stick a bit closer to the procfs naming and go
> with lsm_self_cur(...) and lsm_self_exec(...).  All things to discuss.

I'm thinking that a syscall lsm_self_attr() would get all of the attributes
that are available from /proc/.../attr today. Flags would identify what
kind of attribute they are:

	LSM_ATTR_CURRENT	0x0001 /* Current security context */
	LSM_ATTR_PREV		0x0002 /* Previous security context */
	LSM_ATTR_EXEC		0x0004 /* Exec security context */
	...
	LSM_ATTR_SOCREATE	0x0020 /* Socket creation context */

As you suggest above (with a touch of modification) lsm_self_current()
gets just the LSM_ATTR_CURRENT values, lsm_self_exec() gets the
LSM_ATTR_EXEC values. It would be easy to add new attributes and implement
library functions to filter them out rather than have to create new
syscalls every time a new attribute is added.

It might also be useful to have a flag value (See? You were right) for
the syscalls LSM_ATTR_INTERFACE_LSM which instructs the syscall to only
return the attribute values for the interface_lsm. Hmm. How about allowing
the caller to specify which security module they want the values for by
LSM ID? That could be useful although certainly not necessary. It could
make the user space processing more efficient. It would make converting
libselinux and libsmack to use the syscalls a little bit easier. I'm not
wedded to the LSM ID filter as the caller can always ignore data from
security modules it doesn't care about.

What about lsm_self_attr_set()? This seem rife with peril. Setting a group
of security attributes on a process could fail halfway through and then
require unwinding the preceding successes. I could see having this syscall
if it was only allowed to set a single attribute at a time.

lsm_pid_attr() would be like lsm_self_attr(), but would take a process id as
an additional parameter and get the values for the specified process. This
could make a bunch of dbus' /proc accesses unnecessary. It would have to be
quite a bit more complicated than lsm_self_attr() because it would have to
verify that the caller has appropriate access to the target process. We can
debate whether Smack can deny access to another process' SELinux context.
We can also debate whether an incomplete operation (you can get the SELinux
context, but not the AppArmor context) is an error.

I am going to start playing with these syscalls. Please help me understand
where I have suggested something stoopid.

Thank you.

