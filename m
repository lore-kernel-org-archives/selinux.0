Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF4C433E2
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F672068D
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UC4FetQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFCSFf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:05:35 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:34735
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgFCSFf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591207534; bh=dzoKgB6tefv0VPdCaIHVUdRueQmqdTUmcJ2wnZ3S4g8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=UC4FetQKzfTU52DZ88k3bzuyMcuHjHHVM4bgN8Mxa+p9dZgr2KBlNBF5EbmmLyVlhEMhcpbNmE7l9bNf6xw9u2VGutGhtLT8+dRYn9utKhr2l1u7rplvE/9AJAD23REd/hpmuhsfulrLaRt+IjIGNKSsG+xlHBrppMyV9QJsfX9oLnj1vxMTLS+aiEWv/5HHsaUpGHOon9uOXutPObCvfrJE2OS7LBMcCJjVpmLSCgn4odvpt0FDmMglXPzz2loL2qrdLxcx51xa+MQkR4w+QmV4fNtNOp60k+m7TKXaBck2mbTJabTucEVL/3jOra/DOoOmdXn5y032PvVdmKWYaA==
X-YMail-OSG: vXczkysVM1nq_fy4EDygsamTgeacdQ9VhBpkFayvs0nay2ikI6E81UvfPpeVaID
 jfXDcQAYH.8lhMO706ZQh.px26wNlhFWtE1hEC2olI4sySMbhfJvWdVKee0oDP32kStpPuZVd3rv
 oEJWxwkD8uCtLF_qBup8uSDgu5QH_xDYQRzdmQFr_vKm_xP8Xs1k5a9B5A4n_FoVgFClMGE.tFOM
 Gg6GTBqxs6JLRu0cdsUcg5z6cIW0j58vyCDtUoHArTLvT5JkzT2mB8dAySHIna7ZqF1gnMe0K8a0
 2mxL02CAKBbCntnG.Ufj99NmMorv8rJcQkbB05RbUVgvqyFOSxZWuXvT8wvhrQM6vJn_uYsoCOP9
 tT8zItzngTjMjvqpP5Qw.bfDoSO5cy3mUaaFufDdMgdstez8OMdV4.8NlX3ZtdqQFhS2mhNTtTiV
 HKb62XLxntPks9HdALgmw0ilDKuv5aj2ZzuwlRk7kboj8shTBuexPYONo9atwVKauyKyhoF5lGHE
 7.wEd8i5pFRV.iVuREpVvU_XusUPf.XAImS_h3I1ySGKqNtf9gTDDgFiyM28y4msvM1aY6rdRUGf
 ezAn.ZeimwfDtRJW9XkDG.Z.PficpLk.JaeeiCoQ8mSo91RNC69sTMvL87F_PsVQ.K_VsCMA1s1Q
 LkSIIopeUjUMDI3RjlZRkXZSS9rE6O009I6rP15LlPOTLdhszF6U6J2a82GY5mPYvAZDoRXuRtld
 uLHYlQ.qcHSY4BXNL9ySBMtduKvJN2ykUvjbMXfnQjB8TC_ObC74beR6T6ib9YBVrbAl5JoAOc6l
 ZMVVUKGzHtbvDefWsFIFIVcKOeizIjmmu0SLvpzjRc484I.RDC4wTgz9h967LT7tGrl_oKa_5TDd
 dO30Nm5law3oYuh49Hv37LQsxp.a8Z44Bodcx3VKbdnaSnykupEGoS9tHS8uwi9lbkGIdDBIA0Vz
 jsGOUGdY5MrYZq3.14Rc0uW4vPCe_5yli4IaTcSxcwex_Z7qvvEd0kQdV7CErsyS8DLLgdzJGboa
 ckThd5yJwweRGmsLzy22fKy_trexVib1cuZyY6M_NEKkD2LnTai5ugFlkpjvrFJhvT29MU1kwI.F
 CDWQD7VPl8Tvy2xCMFqNuJRjB9qleJ9unowq8vPgy1ckq7Y4jZKKDBaAASfp4SvfKs.c_AQ02hzg
 8Af2fI4aOKk5JARHtjUCj3biF.5dYnU5ubNY8IFLDbs_fpKds524HaiODcfnuolvKWLeeeVAJTNj
 Q5cYQizW9uUxpsMy.bv6.EowCLlYRJ5oPM5ZlOA2_Gug7nE7WxFuYsSvEco7Kq8kjCaCD1BF.1Mv
 3wh2eVr6RAfGQW1gh.ViCN.StCrKcVwAgbz6AuTg9Mxzil94IgpTRxgGLDg4nMUUX9.WsReFMae3
 YWZ1ru6K5IXD3Bha0RDA7TUBU6UpYMMIXDizl8VM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jun 2020 18:05:34 +0000
Received: by smtp418.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ea674d31d8d9f1749682b76b618089f7;
          Wed, 03 Jun 2020 18:05:32 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <90feeea2-26b5-0552-f763-5f327a313669@schaufler-ca.com>
Date:   Wed, 3 Jun 2020 11:05:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/3/2020 10:37 AM, Linus Torvalds wrote:
> On Wed, Jun 3, 2020 at 10:20 AM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> We could have inode->i_security be the blob, rather than a pointer to =
it.
>> That will have its own performance issues.
> It wouldn't actually really fix anything, because the inode is so big
> and sparsely accessed that it doesn't even really help the cache
> density issue. Yeah, it gets rid of the pointer access, but that's
> pretty much it. The fact that we randomize the order means that we
> can't even really try to aim for any cache density.

Well, it was a thought.

> And it would actually not be possible with the current layered
> security model anyway, since those blob sizes are dynamic at runtime.

The model would have to change. The dynamic blob size is an artifact
of the model, not a driver.

> If we had _only_ SELinux, we could perhaps have hidden the
> sid/sclass/task_sid directly in the inode (it would be only slightly
> larger than the pointer is, anyway), but even that ship sailed long
> long ago due to the whole "no security person can ever agree with
> another one on fundamentals".

Not to mention that the security landscape keeps changing.

> So don't try to blame the rest of the system design.

That wasn't my intent. Apologies.

>  This is on the
> security people. We've been able to handle other layers fairly well
> because they generally agree on fundamentals (although it can take
> decades before they then end up merging their code - things like the
> filesystem people standardizing on iomap and other core concepts). And
> as mentioned, when there is agreed-upon security rules (ie "struct
> cred") we've been able to spend the effort to architect it so that it
> doesn't add unnecessary overheads.
>
>              Linus

