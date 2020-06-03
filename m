Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1161C433E1
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6E20734
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GP5601dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgFCWAL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:00:11 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:35263
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgFCWAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591221609; bh=8LwJDdrkweLdLX1B42xsPq5fDeLfELUP35H51/4SqbE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=GP5601dYXIn/F+y1qvynDdjoLK0ydos97uH7ZJ5njNx9MOVlj1BotTCBGZQhKJ09BXqp12t1Qwm6ixLSx4BQ9U50esscu3bGYEGYDur9CE1BlEXEzotzmERm4tIMVVr0sZ5wUAbVtunHK2bPhnPkGaUacarbs6dM0GBePw7m9Ft00z6VNu7n9r4YmMGjoQ7iC4lrqKutfnHj3zvbYxizmJLqMi6iBuvkDGEhmtgpD4F9aqwkSfgx3EUENW1wWuaNZ+3FNJ5VGZNxLH0xKG8FbZmZh0eZudj0fIu7y27FQtm1IBLyb1bQDB1EvRKHPcZbgNXdIxFTmC30tRJOET8F8Q==
X-YMail-OSG: jGx7g00VM1m3YJrWONE_m6ybH1spZjI5VtL5cUlwSSN4lfqYMDT1Ee3yUi_3xQd
 jMSLQV2feevPu49ZieohUAD9I3miJw1sRpCM4fSq_t2oUnYo02nqTKwG1dKpqVET83QnAF8gyiFk
 LmYavKVjndJEFthb1Z0jY5pqPJIAzZaMOr2dtcXs6XckfOpbVyopoYaRR_VRl9JrHK8jvlnh.f.U
 yfdmN0R5SogLZj1pND4lykdqqe5hsAv9TAbYhLmfeuo44KqkpvFpph0OPnG29xBjoZcNjV0usE6V
 0eTHC7ClSTxQCRAnyRsNtO57R906XMJKfwdRG4fuIHdKwmjZTbptFSLBFXcArMWK5LimLvj1VA3h
 uFviyfyRD6yHd3v_aldnXwNUw_NvpcHpAc2M5I0z2y3ffOWlnxyvQgOIo1Mmjpe677._nyQIEgb4
 8u7RbuctPsRQHL67pXYT68ikju0jWy.2Uz4s.mpAnlrnYSziJJAEa_C0PHgSmbGG_eWPqlUAVzHa
 Ti4spadKv_dLqaGAnQecPtHTQiMKVUx5cnFt_VtpgMYYenffvcm.FFeh3PejcdBgrguWMGS4RozV
 oD8KxyUce4pccEqbVPuzHTkNjpkbTBlGmYvRF73su6ExyvaQL3GpVY_s_udvXsRu9_JFUTmWI8IT
 1wjo9jKDXkmjLi8oq5Kd3WotRz4x_rRE_.b4I.7qfzz6zQiCQajJdSXJUUlC57KpBDIPdlIvUGXg
 tIUMQ8ONPp2sVcL_Xjf8PuGNvho7RcN4cyA7s2ayjUSb5tNdRFgUJKeU9vsFuj7JG.pyU4A.U4KQ
 LOdUCuFHLrteMSo_fXOoeY1Kwb19e7KJDZSbWQcfFX3pN9WOslBdOvxlrotHYbWyc1Vg_Tw1U1v2
 fqmsIh.ZDo8m1t3zqHVtvzy8.DsQkW8niLzVOAL23KDQAkkqEdSqUEnRFl6o3H9MLvvydOevuZtP
 NY.fTJTh8AQLyKu7qzielDq6XZIxnashZDAibHthr5e_9PqNYhxay301MmOeQJWGUEkOSrwUf4Pn
 yUq9VS0dKPDdjmMiwJvz2LZyu96vh2aU_6Ix7GZT5NvMz2tuLp.eO7lglqRp_bSR74uiqmLG_tkn
 FGEGC8AMc2G8YcBid.A5e4ejd3iz1sF0C4rf5ohARALuwMXaY9u3NDFzJSPhPHNBMqd66XbZmmJq
 l4_2_NO7z.fJiVhF.S9BAl96bumhiYabeOkQ6VPTQHrOuyAMETT8B6ayCL66KB9KaHHP8ButkUPY
 vx8bRaLbmIb9lHRd4PnL75IVwXxTl9GnSwWQbf.sR3rnKXE2SS7aM8iKGEVw5F9erTdIEILVxzDV
 4Vu_OJ8BMHh8yAPnI4FOaNrR2LoTT56KJ67KjLj1MbDt1cQGQQmsSAesWKEYfrIPNSHgc_4gn9.Q
 IJt9ywfH2YW5rF2NanpbRaPY7UxZoicHI2VTRMBzUZQuZUyf9QtZWo0ADbHcI7fFWxBVpVjXqp8W
 wNL5S1tz5P3FxlkiNymHeQ_HNcfvuA7kpnb43KdTPm69J2gcJm_lSPvmydvx7l.Q-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jun 2020 22:00:09 +0000
Received: by smtp430.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 433d9c5022010f076d164eebe28720f1;
          Wed, 03 Jun 2020 22:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
 <20200603210202.thwuv2ye672ifwim@ast-mbp.dhcp.thefacebook.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d0ce1c02-4838-4299-457e-bf5e63875873@schaufler-ca.com>
Date:   Wed, 3 Jun 2020 15:00:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603210202.thwuv2ye672ifwim@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/3/2020 2:02 PM, Alexei Starovoitov wrote:
> On Wed, Jun 03, 2020 at 10:37:47AM -0700, Linus Torvalds wrote:
>> On Wed, Jun 3, 2020 at 10:20 AM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>>> We could have inode->i_security be the blob, rather than a pointer to=
 it.
>>> That will have its own performance issues.
>> It wouldn't actually really fix anything, because the inode is so big
>> and sparsely accessed that it doesn't even really help the cache
>> density issue. Yeah, it gets rid of the pointer access, but that's
>> pretty much it. The fact that we randomize the order means that we
>> can't even really try to aim for any cache density.
>>
>> And it would actually not be possible with the current layered
>> security model anyway, since those blob sizes are dynamic at runtime.
>>
>> If we had _only_ SELinux, we could perhaps have hidden the
>> sid/sclass/task_sid directly in the inode (it would be only slightly
>> larger than the pointer is, anyway), but even that ship sailed long
>> long ago due to the whole "no security person can ever agree with
>> another one on fundamentals".
> Also there is bpf_lsm now that we're going to run it in production,=20
> so performance is as important as ever.
> Traditional lsm-s have per-lsm per-inode blob.
> For bpf that doesn't work, since progs come and go at run-time and
> independent from each other.

The inode blob is for attributes associated with the filesystem object.
There are cred and task blobs for program information.
If you need separate per-task data you should put it there.

> So we need per-program per-inode blob.
> To maintain good performance we've proposed:
> @@ -740,6 +741,10 @@  struct inode {
>  	struct fsverity_info	*i_verity_info;
>  #endif
> =20
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct bpf_local_storage __rcu	*inode_bpf_storage;
> +#endif
>
> https://patchwork.ozlabs.org/project/netdev/patch/20200526163336.63653-=
3-kpsingh@chromium.org/
>
> but got pushback, so we're going to use lsm style for now:
> +static inline struct bpf_lsm_storage *bpf_inode(const struct inode *in=
ode)
> +{
> +       if (unlikely(!inode->i_security))
> +               return NULL;
> +
> +       return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> +}
>
> which means extra kmalloc for every inode, extra pointer deref, global =
var
> access, and additional math just to get to 'inode_bpf_storage' pointer.=

>
> We have similar pointer in 'struct sock' already:
> #ifdef CONFIG_BPF_SYSCALL
>         struct bpf_sk_storage __rcu     *sk_bpf_storage;
> #endif
> that is used by variety of networking bpf programs.
> The commit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> has benchmarking data for it:
>   hash table with 8-byte key -> 152ns per bpf run=20
>   sk_bpf_storage -> 66ns per bpf run
> Hashtable suppose to be O(1) with L1$ hit, but it turned out
> to be noticeably slower than sk_bpf_storage.
> We expect to see similar performance gains for inode_bpf_storage
> vs hashtable approach that people use now.
> Eventually we'll add task_bpf_storage as well.
> Right now every other bpf tracing script is using pid as a key
> in a separate hash table to store per-task data. For high frequency
> events that adds up. task_bpf_storage will accelerate that.

Why aren't you using a task blob? We have support for what
you need.=20

> Another way to look at it is shared inode->i_security across
> different inodes won't work for us. We need something really
> cheap like single 'inode_bpf_storage' pointer that is zero
> most of the time and for few inodes bpf progs will keep their
> scratch data in there.
> For now lsm style bpf_inode() approach is ok-ish.
> But we will come back when we collect perf numbers to justify
> why direct pointer in the 'struct inode' is a win.

It would be really helpful if instead of "the regular mechanism
is too slow, so we abandoned it" we could do "the regular mechanism
was to slow, so we made it better". I appreciate that every bit of
performance matters. That's true for all of the security modules,
which is why I object to special case tricks to boost the performance
of one module at the expense of everything else.


