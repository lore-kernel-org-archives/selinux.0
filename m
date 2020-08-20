Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C3C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E332086A
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dxvx1Pdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHTPl7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:41:59 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:39766
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728549AbgHTPl5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597938116; bh=CJC6uDfDe7aNG8Muf9uEprGrVQFoWUE1SLtOGy6OjxA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dxvx1Pdw296KlolnnYfseRahxuGexsV7jCXqa7dTJtDjqKJIBxthkFtFixKEZpUak8kIBBMSb/hvfyrSsx4KrDFpcI3S+cY002n7WQKCa7Ls63wvg8CcSY3p3IPihXCUs9vXKobM7IocvI/m5kWYzm2VNC+tSbuoL+4rllBzIsZO0o5PMIiwYeS1YApNmYqbE6e7viHj/cukv+GuWynsusuRm94ENgCpald26xLLcB3PjsfPeogvNSLVgNedXrIIicdNgyMHBTbxruV4pcb1g+lCY8Kniwde5elcgEzH2aUdm2sdzv5R3yW9F8+YLGWdL4zTiwoJ+RVwHJnqEnSnIQ==
X-YMail-OSG: SKLhGC4VM1kUBYYJe6c4d4tCXtechIE0lmtg_MUF_4oJ1p1MXt7cDPvDaNflHD4
 F8t.SVzgKg4fotzX2pj40vJBkt..nPU88iG_u7Tky8QgZYBAj22gzP9V3tmvCIWse9FruDxZ.1tu
 Y1yu9IU41eQvbM59uOKqzvFmNgaapLuiLxWJSz8DyzT2igFLE8BnUvFusSVepBlTSwkzCvEi863i
 UAIsO5vzixfrLyHysxh.uIy87zNSTufK2bMB3O7bDO3uRXd4EkJkpWl_.JsdQoxvKTAH0eI7GKPQ
 dxVupF4V3kXzB.Uc2WJMYSNUFVQmogTnWFOud94EGUkVA7fljIM5PYQ14eyaiuCvDtYnx_j2Z9wK
 qMPAoRvjfpSjc1WMTtJ9Ri_Xtnzz8Cob6t9OTpMz7ChwxIL926zg4FSEz.O6JsMfmGn.nAMI7oVQ
 2pSJYbfPPPlsFThxyuiUBFAec3YdYVBY3LEp7YE_LeX5wF8TEdTw0fJcUiO1ofZHlO2_JNHL2ij.
 bLTYzicE.eZQbuF69D5E.x91ZzIJZX7.jXgpiRXsntbSmEktw8Ou6JWLwFsDEIkd21w67zlNym.m
 HYd47LLGr.ooo31EyugeHNl2hURIdrVrK.Y.Jd0tY2ExwajVg5kKJVL8HMbVXHqIqUeuwne3bzvk
 zhMVC3hJnCRebedi.LSZSw_QAh1COl1ncIbiz7CUJ39mibeFCNX7rKNoE0izdlZzgSsrgkX1PUCQ
 APO5IGKa6rcRHTCHDAeyCAoD58Z_9sbFCfz_IeKZcKbVd3Vra_6JjRGUl3em2ve7O1aST5jI2Q98
 2AB4D4d2C3WJsYPuXBjH2HA.9vIc06iVTf6Q7JigG205uBhlzElmVNRMX7xvSth_dF0QaWJnh7AO
 VSYcJmFc6DkL032ZyY7oHb7DvPN9PoRtmu1N1hQAbkrGX42iXnWgFhwYqwot77qWbPBoZwmYg4MF
 sARGZtwU_8koa9SXR4fxFy.R0mnteyUNH_XV.q3ev656lXTG8Cyu55MGsCrRa4uMEPQ4btTVhwtK
 zyEm7s1F07.KsLiPk4v_26hkd1baQTXZsEBwhFQJ2EZQW6pAI5wqcfOqbsFYloIZu2xV.gj24fwL
 72xBh2Od_fpfi.B2YhGS4_dIT8BUVfCjLtcZgpt6DXILx4c_m7KP8OrAqkLE_nL1v.S7MZopRnKZ
 KbzXSThevbOqIXDgJy5gxRwJTLOOHC8uo__cpv1T0dimSzVzw2IcWUVP2YD7X_V8mpWmj2brit9X
 .mIHIcBNDjviw.UPlmqiAhmpEygChVzDsZpA8NEEHoZtkoIZXXZT1ZjdnRwqMnLa3BLcg48gupt8
 gMJzhlYhDn4kb12QHe56BouUZ7Sp4uvbGlKSqKbO1J5jvKO4H7zUnHHGi_iIK7M0nRBryNP4nYAY
 BEW4s3owlqnXVu4MOY8ETE0dFa6JMJhIRei_q5y2fHPVSeLApxvbPNqKGTo6yCg9Ai7rIZR74nee
 aWZA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Aug 2020 15:41:56 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c26ea734821eb196ebafd46403ed5499;
          Thu, 20 Aug 2020 15:41:55 +0000 (UTC)
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain>
 <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAEjxPJ6Kw8i_z_i2Y0A3HcK23DMoazWUZxMtNa7ErQv_bjm=QQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <df31e943-167e-cd18-f3ec-29d033e91f28@schaufler-ca.com>
Date:   Thu, 20 Aug 2020 08:41:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6Kw8i_z_i2Y0A3HcK23DMoazWUZxMtNa7ErQv_bjm=QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/2020 12:16 PM, Stephen Smalley wrote:
> On Wed, Aug 19, 2020 at 3:07 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>> I've used kernel built without CONFIG_SECURITY_SELINUX_DISABLE from Ondrej's COPR
>>> https://copr.fedorainfracloud.org/coprs/omos/drop-selinux-disable/ and tried few
>>> scenarios:
>>>
>>> 1. selinux=0 on kernel command line
>>>
>>> everything works as expected
>>>
>>> 2. SELINUX=disabled in /etc/selinux/config
>>>
>>> system boots, userspace considers SELinux disabled, /sys/fs/selinux is not
>>> mounted. The only noticeable change
>>> is in process list:
>>>
>>> $ ps Z
>>> LABEL                               PID TTY      STAT   TIME COMMAND
>>> kernel                              552 pts/0    Ss     0:00 -bash
>>> kernel                              574 pts/0    R+     0:00 ps Z
>> Hmm...is ps checking is_selinux_enabled()?  Or just always reading
>> /proc/pid/attr/current (or calling getpidcon(3))?  Under what
>> conditions was it displaying "-" here before?

The ps utility reads /proc/pid/attr/current directly. As a result,
it works for Smack as well as SELinux. Adding an SELinux state check
would have to be done carefully so as not to break the Smack functionality.
The id utility does an SELinux check that unnecessarily prevents the -Z
option from working with Smack.

>>
>>> If I get it right, SELinux is enabled but it's not initialized and SELinux
>>> checks are not processed - always return 0 as allowed. So there should be no
>>> real externally visible difference between selinux=0 and SELINUX=disabled
>> There are some corner cases currently, e.g. you can't remove the
>> security.selinux xattr if SELinux is enabled currently, and there are
>> various hardcoded error cases in the SELinux hook functions that could
>> potentially occur.  Beyond that there is the memory and runtime
>> overhead.  Getting people to start using selinux=0 if they want to
>> disable SELinux is definitely preferable.
> We could try to eliminate those error cases by checking early for
> selinux_initialized(state) in more of the hooks and bailing
> immediately with success in that case, but we'd have to go through and
> identify where we need that.
>
>>> 3. no /etc/selinux/config
>>>
>>> SELinux is disabled in userspace but /sys/fs/selinux in mounted. It's due to
>>> check in libselinux which doesn't umount /sys/fs/selinux when there's no config
>>> file. Maybe this could be improved.
>> Yes, we should fix that.
>>
>>> So I my findings are correct, it should be quite straight and easy change for
>>> the distribution. Even though userspace tools like anaconda and ansible still
>>> uses /etc/selinux/config to disable SELinux, it will have similar effect as
>>> selinux=0. But it doesn't mean we will not try to change them to set selinux=0.
>>>
>>>
>>> So I've started to compose Fedora Change proposal
>>>
>>> https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
>>>
>>> It's not complete yet, but I believe it contains basic information. I'd
>>> appreciate if you can help me with text, phrases and references so that it would
>>> be easy to sell it as security feature to Fedora community :)
>> I'd simplify the Summary to be something like "Remove support for
>> SELinux runtime disable so that the LSM hooks can be hardened via
>> read-only-after-initialization protections.  Migrate users to using
>> selinux=0 if they want to disable SELinux."
