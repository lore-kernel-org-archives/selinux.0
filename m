Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8EC433DF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E4420738
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FewulDbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFCRUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:20:33 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34834
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgFCRUd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 13:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591204831; bh=ZnoiOhwCK+Kwl7pAW92+upmoqhIiqz1UGmJLWZRXaS8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FewulDbvcnR4CGpWUKq6qUoFE46f9iR2h/KJloj1MTNY/L3Kf5DuwB9aJ79vAIXIIweI3L5QLbmZOFddiDxW/u7MGMkLEzKP/mPuvAojvVJnJFh8O+8mtE1ikh9iUQP5wX/LtT5QhuRCKz9/F8PKeM8G13wtDj6ZMMxwwD95fkg+OTFavEOHzywA9yMgbZ3Cbk9v0bFBL8kmB0ah8hM18U/jDkV1Uu7cuibROJbanIJz+hNruZ3TosmNZfkhl4OYrl9M/ddXn4bXntdwGMyxVpLEPangAMxGitg/oGz5ASecdV3QMm6Qoik1k4Vo3GMBwyfUcpngPZr08cqjfum43w==
X-YMail-OSG: fhfZrhgVM1nTIKU4k.6VTMNr0nSPhjnwZ_fIX_PTuFS0yVVuBnXIZDcoMBNU_4z
 20nKU9Zl9hiWqH270.XiqOgHVT1rrd4_LTen5nfocxMXmOpRdJaLak.O9h8iBJf_0exC3WafrxMP
 W6A.hlaYvoSeRDFJX4bseZvQbz1kuP7HMeq5ZN76xdSlZOEGW.NkGBNQJlgSAOyKxZIGI5tpYiVW
 LB0ZxXLdmybB3.xDfQQEsDBzPKdbIyPKbtW_Lt8NHUng5jM3kHZsNERXG76yHdFsXT7pcBEil7EQ
 MAbzZvhMrQH7PH4mBzIjgqxGYAYzSy8TrQ7AuySXXpmJWC23ABgSS7B2exLAqwmAJA8SBc0EprRl
 b8xPfdwvxA_a0SYpkDK.QutFfRHVnSjCu43f8chF8T2CVhH.HYglI.nFB4dNIloiviYe4_4pz9z3
 xiGUa19Fc48F4qYj0wrU56zTtsQ211aAi94k0M8T7I6BlUFX5S_eO46tP..4nQiLsVw2ffmkZZMH
 PcEpEltFJpz3ANB8KxEsjDJytMMhYbRcyl5VuRAd630NW1hfOwKWmsYS5BUZwOxIgPpiF_TukWZk
 eFMIZBO6UTjhSNddPA4sgoTAVqYKIYXZTIRMLYVNluGmX5qo2Iew1O5pHnBtGuzqtPMvNaYeSBFQ
 zqEmlLzqn_hPJBqPVpsi5i_QLxzMAjFcdOUm8UW8rQYqa45COEfQ4CqtkQbk4xKMlhu15nyiiMH.
 zLMeZin6_IId1X6DzWux1stg9F1_Z92O69mBOhU51AUvcXwBLrSFHWRw0l7HUwxEt.Cb3Pf3u1lG
 q3weKgzCRv7al7vrtljRw218UkhBv2GUChEpUTSobv25GpqvpI0bleUfm9DzG0hYzHfATpQF18YQ
 r9jZX6G_3zVVlb5NdKddGNofG42QnOIO7GC7PpaDfaRhUPgg7yvldNZhar.ajS_ohpx2u_YuXHRU
 EQb_Bp8e4b79dQV_mWwKxO43F4lXlzwzYN2fpCvk8Z98KstViuWz1rNnOYcp6jRcL52KwzhyYC0G
 9Lw_i6OB.F1Z3OZXbpZikU55saocg2HFb5W60XqrecnDDNUZ827fm5620mMUXORz7pu35p9nM9hU
 4zE5NO8ztbJxGFRE3ip3ib4jirrqcRCewxIvOCh7GwGAeRmpyhr6EAACQN_G6XIXUUjdS9V.lGih
 nEQdcK0HbUl9M4mXZjhLZwe5_gisPKgvc1obxfxGDLqhxnmaB4sKYFrkoL.Djf1toghLzx9skDrt
 MlamrAcPoZ0PvKv4XN1ce3U9_gGOryQ93j.5mCyMFnC.z2.vfFHwksfUt21L830vOH12YtNaeYy_
 3KHtGReeUsjtNtCkaeX2TGjBn31XHAM7FNsqJCt.6iNM7GFmIG1HwclgZT9hkjQcQRR3meh5aWKi
 58aByQZpHratg9wHukVnr.jhUFz_P8Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jun 2020 17:20:31 +0000
Received: by smtp411.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a463f301f4e3a24c8326d0acd4ca0a11;
          Wed, 03 Jun 2020 17:20:31 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
Date:   Wed, 3 Jun 2020 10:20:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/2/2020 5:31 PM, Linus Torvalds wrote:
> On Mon, Jun 1, 2020 at 6:07 PM Paul Moore <paul@paul-moore.com> wrote:
>> - A number of improvements to various SELinux internal data structures=

>> to help improve performance.  We move the role transitions into a hash=

>> table.  In the content structure we shift from hashing the content
>> string (aka SELinux label) to the structure itself, when it is valid.
>> This last change not only offers a speedup, but it helps us simplify
>> the code some as well.
> Side note since you mention performance work: in the past when I've
> looked at SELinux performance (generally as part of pathname lookup
> etc VFS loads), the biggest cost by far was that all the SELinux data
> structures take a ton of cache misses.
>
> Yes, some of the hashing shows up in the profiles, but _most_ of it
> was loading the data from inode->i_security etc.

The whole security blob scheme is based on the 20th century notion
that security beyond user identification lives in the realm of the
lunatic fringe. The use of security modules was expected to be rare.
Clearly we've moved on from that. A system without a security module
is the exception, not the rule.

> And the reason seemed to be that every single inode ends up having a
> separately allocated "struct inode_security_struct" (aka "isec"). Even
> if the contents are often all exactly the same for a large set of
> inodes that thus _could_ conceptually share the data.

There's state information as well as the access control attributes
in the SELinux and Smack blobs.

> Now, it used to be - before being able to stack security layers -
> SElinux would control that pointer, and it could have done some kind
> of sharing scheme with copy-on-write behavior (the way we do 'struct
> cred' for processes), and it would have caused a much smaller cache
> footprint (and thus likely much fewer cache misses).
>
> These days, that sharing of the i_security pointer across different
> security layers makes that sound really really painful.

Dealing with shared creds is reasonably painful, too.

> But I do wonder if anybody in selinux land (or general security
> subsystem land) has been thinking of maybe at least having a "this
> inode has no special labeling" marker that could possibly avoid having
> all those extra allocations.

The fine granularity of SELinux policy isn't conducive to that.
There's also the state information to deal with.=20

> Because it really does end up being visible in profiles how costly it
> is to look up any data behind inode->i_security.

We could have inode->i_security be the blob, rather than a pointer to it.=

That will have its own performance issues. I proposed doing just that in
2013, to the resounding sound of crickets.

I am painfully aware of the performance considerations that influence
the way we've had to implement security modules. But these
considerations have always emphasized the performance when security
modules are *not* being used, not when they are. I am encouraged to see
that being questioned. I believe that we can do better, but that some
of the constraints we've had to work under need to come off before we
can do a good job of it.

>                Linus

