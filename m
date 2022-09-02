Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8BC6FA83
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 23:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIBXYY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBXYW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 19:24:22 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBFBBA
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662160462; bh=NGKB5xxS20CsL79VhDexO4BTw66cSF2vuwDVEajQfiM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kDKTJJakSEwxVse/HoTIXT4KPEPiE2fsedFx6zfh4ushhPEf7jup1oIflbGbuTuZPHJ68j7spu1XF1SccBUb9MSmePZsVffi1oKWdmpIyJi/SDMwPZvKX0pw+uMZCqOGpZW84phmxDCxb9kzRJSD8Zn0YGn85thD5xZhMpx84HRYTAzffYlV6Ge2AKmpqrQu8L9Q2Lczmv5aSSosXHlADxi1kYAiobHrWFbole0tTqsO3UkQjhVVb4UBjNbLt0ZP0M+BEfUFHbXrhguDnzf+DofG7t26z9jk3kZeXUk9m52FM2wM/WqmuDD46ShqC9XhBahBEkE9UvMEQrQ8dpJe5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662160462; bh=jMilGCUK7P3yg9cXLvgHv/EKYRz6QwxXM/bRGYs1haZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=km0unKIUV1UJ8BYZdZCeapI8QmmQm6a1TbHvhlmsiWdp0BFT4bN0FjTygJcXeXrhojlG87aQDvx8t+1tuQIH5PYAJVbS7HLImNw+0LXw9gYhygAJ88cGE0INCeJ34Hj/yEJsDmqiFBKg31CODUxGDZzArBYEMdXGjx2Akc6J6SOwhYpw5BWiN8748V6D/9PzI+DoCAtlKcHz9oO4TmYsI4ivzCo3B/19toaQGX1ZQROWOmM/IYaOcHe8Fs4L87amxhURidyZFHCmTFD3hpB4n83WJ+cDMBf9XKzbXEanA7NPcfbkYQeiEEqLF43E4jPtdcFeZ/nKuOt2bF5hNqpQrA==
X-YMail-OSG: TnuCztwVM1kwIC1LSNYJ5dwHk0fgo4AWX1X09dEj6F2IFwfe477YACG5FWb0opa
 xsCXFbMF42_GzriywdxpdLmCrJmM26xWbB.LSTL_1DI39UpQQxg_1w3jQvvqvSUSQ3C9al69lTaW
 e3tyM9NrjH.c3Ha.eWVaO1Gbe6ToyKgBUqR0klvtaSd.KDIZYpwyOOvNYXwYj.mR2MWmXl.7R0lD
 WlSSm2fKJhlFCRrxGrr0cNr4qW8gTuXBPC5o6lXDco21ZzRTGKbdI6Jh2ss7OPlvBeEQBjhmM288
 YiOcA5L.QwhwI1gv8lYdWvDrkgrJ74qRjxS6nV7EVflPIAKFmad05lwdbdHTLM4I_rQtuPoKPZIg
 YTlLsXXn9x8THpTNeroJAeeOEnD6E9JXhueltcElrSGpRj3MgwV0u6.6oZWeVUtFxzWiU2a5gC1D
 JnmmjDpgoLWV7JnpI6OSJ23_gkWvhpXqxhLdgnziYBRmFurZp2CGGrfSKWUT9S4KaXGw2pcsJ0PW
 1GW.JRmjAUDCNLivi9FI4SA5GU2jYvYdB08ZgDDHFZ_N6GBxvX3.ZSEqrI297xxL9AyQQHroLgdC
 CKA3YLGdmgf3Fu9S966A4N5GCVQ_40aAZedNt_pl7Y5ok.qHDUJV8e9yDTbK9qtXt8S1w4rSZWPG
 Hd5NdbmnEfPN9PH9yKp3w6RHXgPLB7OtLvC4B7hU7RAfj3MyRAQJIYg90hZW5Y7MUZpOcyOlUjkf
 3Eda.scI65nHo.vAYJcg45J3j9mSC_jOjO7f52bue.UPYPSyrfXT0qdGwYrOhGnEDnrgmxVfOfIY
 KVRHAPoKs09tZ_LYQZVRUH0gzHBn4MP5RCecbz5MBX93FOb3FOmpBnhvA18WnojzRpQThZjM6Ww2
 RPn6NjoiVwkpLlMe3DI8m_ZuNUocaPuyhDE9xj81i4lGUYWky409ey22xKxQDEctvr0ulCid7exC
 WTHfYocVzp4skbeL.nflM59eDq1yKmPCkL43aQYKQbVG.1urynNeBni9LtG86mu2ss.5AdU55ZkC
 0S64058MtWE196p8eeax_X3qfe9NMLVLPOhN4jzDiv5yCZ3Tx3EmH8rxLbgknxbPROMjrJ5nxELr
 qcMrGIIfVoIAB6l08kp70F56XMj3_1PUQ7WwJUw.wAW0FmP6rjRjGWsdxtTi.aLlcRvliG9KYEon
 xiLnoaMRnsROsgabqOIFySgyF3KfvYfsL7lB5L8iVrkX.Smw5YrOOV.7zdEpzxsfQ21A_hXvPX3U
 laZfLlyLq_OW_UfnUJ6ppX_eoLISQSNeY.aUWVe9VopTDY0xXPSqeTZxJfKUiLefElVNL28YlA3C
 chlsqu7wtDS9ZIo1ismKckCxgNGiuvdlc.aQ6ywfjc8fkfMMSQBZqrvcrTZzEcI5G3Gf2TEXpbY5
 nFgxenOtu6v9xgl93LoFCW16ErO9OezPEaE4zvHGmORkorBglQ.VqLcClv6yMjL.RnIhTCvZJlwV
 ee_89khmpJeRD4OhF27J0aeHRa3ud4MVzEbxlGXyoy_7u6jGqJ10bI7dwPdCWjel9fvA4EgSsRPE
 Cz5xLdxis864ZQLu00Pbnf3w9qzv1AizBLoqC8Y_BxkNnF9qx8Xlgzij2ipMZEvsRnVYGX2iR2oP
 ZbQ5mYdI8JE9I3epwiqfCv9v2qp3zmrKP7BIM8wyiGIfdMuo2SAZh_Wzqs0HYni2n6hOrg_k3YKJ
 3o8Gp.pblwplC_yH2WRwaHD7XduxEC7wc435_sirhT5za3MxYM05CYZDgu3Dzk1ZcGEJqcLNFAi5
 MDYQaYt0F1qCc41.jdDz36OWo.8vm.izNN.0dG6o5o4jnBG74c.DGDCj7IETg_LFpBEY01.gyVft
 XshGm_SS5Wl7tqjnQupVhuLWlVVUqkpzdJSZznOOojwBt30_bUWk4.wVHscn8Y4uj_hWuC5QA3.A
 JI_byvwMI.Zj0XoX10cmdsWrSmHnM3tTOzb4_wjzDzoecEZnQL.zALulsagQIZXmBBqyCKJnn4wo
 TYhZ1qFtSFsA92dEtjFoO6SNlPyupfzBJo.osp.fZlhh5COzTElKrdA5na9GAVs8Yh_W.8j6_tvN
 j8dNNqPhrgfnACJeln4LHQkw6kEA5kxBbk5hBXAfDyWAid5Oce59BImBTFp4sz0YgSOjcwq4MDza
 rsKvDi36OXSjwEzdF0hmMqOtV8Cij5z7Uw68G3AmdNQV.ATy0qYSExXeEpjXwQYlGv7eTh8wRBL.
 cqpMZehJSRYjQC7bSzlAhFJDbZWCbg9C1RRSsrGU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Sep 2022 23:14:22 +0000
Received: by hermes--production-ne1-544744cc75-zkxbp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d18f4464a4a65be7b05a18f79c78d2e9;
          Fri, 02 Sep 2022 23:14:19 +0000 (UTC)
Message-ID: <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
Date:   Fri, 2 Sep 2022 16:14:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/2/2022 2:30 PM, Paul Moore wrote:
> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>>> patch set in the LSM next branch for 6.1. The audit changes have polished
>>> up nicely and I believe that all comments on the integrity code have been
>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>>> There are serious binder changes, but I think they address issues beyond
>>> the needs of stacking. Changes outside these areas are pretty well limited
>>> to LSM interface improvements.
>> The LSM stacking patches are near the very top of my list to review
>> once the merge window clears, the io_uring fixes are in (bug fix), and
>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
>> and SCTP stuff can be finished up in the next week or two.
>>
>> Since I'm the designated first stuckee now for the stacking stuff I
>> want to go back through everything with fresh eyes, which probably
>> isn't a bad idea since it has been a while since I looked at the full
>> patchset from bottom to top.  I can tell you that I've never been
>> really excited about the /proc changes, and believe it or not I've
>> been thinking about those a fair amount since James asked me to start
>> maintaining the LSM.  I don't want to get into any detail until I've
>> had a chance to look over everything again, but just a heads-up that
>> I'm not too excited about those bits.
> As I mentioned above, I don't really like the stuff that one has to do
> to support LSM stacking on the existing /proc interfaces, the
> "label1\0label2\labelN\0" hack is probably the best (only?) option we
> have for retrofitting multiple LSMs into those interfaces and I think
> we can all agree it's not a great API.  Considering that applications
> that wish to become simultaneous multi-LSM aware are going to need
> modification anyway, let's take a step back and see if we can do this
> with a more sensible API.

This is a compound problem. Some applications, including systemd and dbus,
will require modification to completely support multiple concurrent LSMs
in the long term. This will certainly be the case should someone be wild
and crazy enough to use Smack and SELinux together. Even with the (Smack or
SELinux) and AppArmor case the ps(1) command should be educated about the
possibility of multiple "current" values. However, in a container world,
where an Android container can run on an Ubuntu system, the presence of
AppArmor on the base system is completely uninteresting to the SELinux
aware applications in the container. This is a real use case.

I have chosen to use /proc interfaces for the stacking work for several
reasons. First and foremost, there are a painfully large number of system
applications that will never be modified to support multiple concurrent
LSMs, but that can be used successfully with the interface_lsm "hack".
Another is that it will take years to get a significant number of the
applications that can be changed updated. No one is even going to start
on that until kernel support is upstream.

> I think it's time to think about a proper set of LSM syscalls.

At the very least we need a liblsm that preforms a number of useful
functions, like identifying what security modules are available,
validating "contexts", fetching "contexts" from files and processes
and that sort of thing. Whether it is built on syscalls or /proc and
getxattr() is a matter of debate and taste.

>   We
> have avoided this in the past for several reasons, but over the past
> couple of decades the LSMs have established themselves as a core part
> of Linux with many (all?) major Linux distributions shipping and
> supporting at least one LSM; I think we can justify a handful of well
> designed syscalls, and with Landlock we have some precedence too.
> While I realize syscalls are not the only kernel/userspace API option,
> but given the popularity of namespaces I believe a syscall based
> kernel/userspace LSM API has a number of advantages over the other
> options, e.g. procfs/sysfs, netlink, etc.

You can't script syscalls. A syscall interface is fine if you can also
update the entire system service application base for your distribution.
I don't see that as an option.

> Further, I think we can add the new syscall API separately from the
> LSM stacking changes as they do have standalone value.

I agree, but unless the new system calls take stacking into account
from their inception they're just going to be another interface that
makes stacking harder to accomplish.

>   This would
> help reduce the size and complexity of the stacking patchset, which I
> believe would be a very good thing.

The /proc interfaces interface_lsm and context are really pretty simple.

The addition of multiple subject labels to audit would be the same regardless
of /proc or syscall interfaces. We'd still need multiple LSM data in most
security blobs. The conversion of LSM hook interfaces from secids to lsmblobs
would still be required. As would the conversion from string+len pairs to
lsmcontext structures.

> Introducing the syscall API
> sooner would also allow any applications wanting to make use of the
> crazy new stacked-LSM world a head start as they could be modified
> while the kernel patches were making their way through the
> review/update/merge/release process.

A liblsm based on the /proc interfaces would address that as well.
Just as libselinux abstracts the /proc interfaces now.

> Thoughts?

I wish you'd suggested this three years ago, when I could have done
something with it. If stacking has to go on a two year redesign because
of this it is dead. We've spent years polishing the /proc interfaces.
Changed the names, the content, even bent over backwards to accommodate
the security module that refused to adopt an attr/subdir strategy. 

> To help make things a bit more concrete, I put together a quick
> strawman this afternoon to get the discussion started.  I'm definitely
> not a syscall stylist so please consider this more as an idea and
> discussion starter at this point; if we agree there is value in going
> this direction I can put together a proper patchset to introduce the
> new API ...

I'm not objecting to this proposed API. I am objecting to the idea that
stacking can't progress without it.

>
> /* LSM_ID_XXX values 32 and below are reserved for future use */
> #define LSM_ID_SELINUX 33
> #define LSM_ID_SMACK 34
> #define LSM_ID_TOMOYO 35
> #define LSM_ID_IMA 36
> #define LSM_ID_APPARMOR 37
> #define LSM_ID_YAMA 38
> #define LSM_ID_LOADPIN 39
> #define LSM_ID_SAFESETID 40
> #define LSM_ID_LOCKDOWN 41
> #define LSM_ID_BPF 42
> #define LSM_ID_LANDLOCK 43
>
> /**
>  * struct lsm_mod - LSM module information
>  * @id: the LSM id number, see LSM_ID_XXX
>  * @flags: LSM specific flags, zero if unused
>  */
> struct lsm_mod {
>   unsigned int id;
>   unsigned int flags;
> };
>
> /**
>  * struct lsm_ctx - LSM context
>  * @id: the LSM id number, see LSM_ID_XXX
>  * @flags: LSM specific flags, zero if unused
>  * @ctx_str: the LSM context string
>  */
> struct lsm_ctx {
>   unsigned in id;
>   unsigned int flags;
>   char *ctx_str;

   const char *ctx_str;

or even

   const char *ctx;

err, and there are problems with passing this to a syscall.

> };
>
> /**
>  * lsm_enabled - Return information on the enabled LSMs
>  * @lsm: individual LSM definitions
>  * @count: the number of @lsm elements, updated on return
>  * @flags: reserved for future use, must be zero
>  *
>  * Return information on the different LSMs enabled in the kernel.
>  * On success, this function returns a positive number representing
>  * the number of @lsm array elements, which may be zero if none are
>  * enabled.  If the size of @lsm is insufficient, -E2BIG is returned
>  * and the number of enabled LSMs is returned via @count.  In all
>  * other failure cases, a negative value indicating the error is
>  * returned.
>  */
> int lsm_enabled(struct lsm_mod *lsm, size_t *count,
>   unsigned int flags);

Easy to implement in liblsm by parsing /sys/kernel/security/lsm.

> /**
>  * lsm_current_ctx - Return current tasks's LSM context
>  * @ctx: the LSM contexts
>  * @count: the number of @ctx elements, updated on return
>  * @flags: reserved for future use, must be zero
>  *
>  * Returns the calling task's LSM contexts.  On success this
>  * function returns a positive number representing the number of
>  * @ctx array elements, which may be zero if there are no LSM
>  * contexts assigned to the caller.  If the size of @ctx is
>  * insufficient, -E2BIG is returned and the required number @ctx
>  * elements is returned via @count.  In all other failure cases, a
>  * negative value indicating the error is returned.
>  */
> int lsm_current_ctx(struct lsm_ctx *ctx, size_t *count,
>   unsigned int flags);

Your lsm_ctx struct won't do here. Where do the context strings go?
You can't have an unallocated pointer in a structure you pass to a syscall. 
This is the problem that led to the "lsm\0context\0lsm2\0context2\0"
version of attr/context.

... and you can fill this from /sys/kernel/security/lsm and
/proc/self/attr without using interface_lsm, so it can be implemented
today.

So while I agree that syscalls might be better, they are unnecessary
to support application updates. A liblsm that uses the file based interfaces
that are already there will work as well.

