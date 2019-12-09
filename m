Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76933C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417D62080D
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G8iRXLag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIRUc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:20:32 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44631
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIRUb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 12:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575912029; bh=Pbk7IW9GGRcX4NGbg4dMOzc/ixecYySg5lZoO3EXmDg=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=G8iRXLagRTUe+zdQSuubqkHFfDkb6pDQVZAENPknfmWJm0hfU8V3AocdZQoVqBMnOZL6WNaO9JJgrU7J0mLl86PeMJNQSXtFreCNYWmx7bJtEIjxfK6VgK3miJ5ExsVpiM+hwpxW0K1rTZKKqjUW/9fATSJmScVtkkxQow+yOXDmug4nM4n/eEJIzmuUw4GNpOkF3T81Z5x2Wa2YoudfA4uas3Xi72Hm01pxGdHsMczcXYdWKKTkkwK49s/eR7b4ot1C7K2+8p3k+rRypI9WuXcH/ERBDW6XJ44cyFZeFrLLlsQDL/l4NZmjyOpois97yjHYv8tFTtPRM9vAahTo2w==
X-YMail-OSG: ZTLKbzgVM1kEOlp7qNvitugRIJJN2lXmxLXfI9sj4wdBTgTertepPwTLWqNgd5h
 WfTlKvlSiBaQNo3JtlYesxOnJE782.LnD6lNKImdDcYoEaytMZCO3299aU2ZqFL0UoAX5udTMhzX
 WxCVOW1UlGPLX33dn_48POpFNgM5VaPOh.1k_ydZr0oxYNVE3GBAAKcCde65BZBz7m1p.JomFk8N
 PKTDxfQyiBIYKxqnKfCy7CmiVPyZyUreP9ZWslUua.ApOGZ4jRgrUp0uGYVtw3a1dciPRJKegjbI
 9DtWwYDBflHgl2olWsfO.8p23JV9v7ajLEGEiCAevMSNUfeNMQPpyVW1FzPyKuvuHMXrJuc4yw.B
 kmn5mb.03VzKY48RuWeP3nJMKNljvUzMSBEN6wLSUo2pfuMTMRQDlrc790_GM41DhRZ_.4puHfh_
 Lrq_mKXOor5gbcpvbXQyiAXFy2SR9rSFOtowlh83JrjqAQgItfNU_GZ9pbBTr7pH_6BK8bJwWArc
 NNVFYH9fuLOF4MAbzXA9Oc4SsnLV2JCQdfpiPSTcAdLg6KT2sXk_wGGipQn7nWtpNS5EzIze2ZBG
 H5vaWn0UKhfCC.LMpSKL0Jc69bB.AW574JaPzdi0CJUiJaysbtKmHpFsEiscIqytjAmqbRPcCRG0
 MTTJI4YYnz7jKfoNyHFW8Y9oBxnk1hH7wdPo1gtdInH8o.0LmS6gEj3QfIkwz.Xyi5m6i8majbSI
 a_UM0lY.l33_RQWG7Z4i_2qhvL8WoN7YrOqNXJIzhaJi0nOXSf7vYbTuF7XO3RxRw.eux4oAHP_g
 fZ9Wy2OtvXG9TZqZgJn_VvTKaViooSfEuTohCDIIGVnW0g_Nqgr5mBjv.fdI9QIW4BtauYmPZJ6S
 aPOM4oYFaVMCGESIrJbOZvxxDRSCcvMCGIXT3vE6a2CzCfm3_86F9mM1X_6Bzfz.LSt2x8qKse.X
 s5owdnu0kec7kN2zVQj5IjC39tj_55cnnee4wLQ_Z.1h7dZ2SMtCVry_na0w6u5Fsm_aFv6x52ly
 gZ5eqqdg0pyqaHAzwyb9E4vzOZvyiLfxvndlrRYHE9Hr.gs6PbDNbJBbH8X0ZCeBvAuOUKWz_YtS
 EypfgEbHG0Gn4RjDP2PzW8IRSsxWZ.qaJcthrcJ6_YXoZUAEieDqtg5DSJO82I96L5FzmI2KC3DC
 Qw9MgW0rP_psI.ddxaWBOHX3JEuTwqI4Vrm9hBqMVaK57RDowW.hSKT1pg3FuTvUHFw5vSGFnC5g
 dJH6g8z6gfoa0qwZymNzdlkvmNkVggX.vBiDd204RO7CRw.Xftk_GNTTy1Ydg5wkot8dbOqQyYWw
 NDdqXn1dvEg5ecxL50EfEhVim00JUffsGDJikgI2BhZZ5OBOUb_8CwmU1ZBVDdrD9hpMUv8AVrpr
 jfQ2Zxl4hyu.cx0.6pwRb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Dec 2019 17:20:29 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac0871ffa96363089ac7a0327b1fb80e;
          Mon, 09 Dec 2019 17:20:27 +0000 (UTC)
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <ecfd3846-b38f-4b85-4568-d64625c490ac@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <2fadcd3d-96d2-82bf-f221-a7961853be50@schaufler-ca.com>
Date:   Mon, 9 Dec 2019 09:20:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ecfd3846-b38f-4b85-4568-d64625c490ac@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/2019 5:58 AM, Stephen Smalley wrote:
> On 12/9/19 8:21 AM, Stephen Smalley wrote:
>> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LS=
M
>>> infrastructure to use per-hook lists, which meant that removing the
>>> hooks for a given module was no longer atomic. Even though the commit=

>>> clearly documents that modules implementing runtime revmoval of hooks=

>>> (only SELinux attempts this madness) need to take special precautions=
 to
>>> avoid race conditions, SELinux has never addressed this.
>>>
>>> By inserting an artificial delay between the loop iterations of
>>> security_delete_hooks() (I used 100 ms), booting to a state where
>>> SELinux is enabled, but policy is not yet loaded, and running these
>>> commands:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 while true; do ping -c 1 <some IP>; done &
>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo -n 1 >/sys/fs/selinux/disable
>>> =C2=A0=C2=A0=C2=A0=C2=A0 kill %1
>>> =C2=A0=C2=A0=C2=A0=C2=A0 wait
>>>
>>> ...I was able to trigger NULL pointer dereferences in various places.=
 I
>>> also have a report of someone getting panics on a stock RHEL-8 kernel=

>>> after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting=

>>> (without adding "selinux=3D0" to kernel command-line).
>>>
>>> Reordering the SELinux hooks such that those that allocate structures=

>>> are removed last seems to prevent these panics. It is very much possi=
ble
>>> that this doesn't make the runtime disable completely race-free, but =
at
>>> least it makes the operation much less fragile.
>>>
>>> An alternative (and safer) solution would be to add NULL checks to ea=
ch
>>> hook, but doing this just to support the runtime disable hack doesn't=

>>> seem to be worth the effort...
>>
>> Personally, I would prefer to just get rid of runtime disable altogeth=
er; it also precludes making the hooks read-only after initialization.=C2=
=A0 IMHO, selinux=3D0 is the proper way to disable SELinux if necessary.=C2=
=A0 I believe there is an open bugzilla on Fedora related to this issue, =
since runtime disable was originally introduced for Fedora.
>
> Also, if we have to retain this support, it seems like this ought to be=
 fixed in the LSM framework especially since it was a change there that b=
roke the SELinux implementation.

Agreed, mostly. Deleting an LSM is fundamentally something the infrastruc=
ture
should handle *if* we allow it. Should we decide at some point to allow l=
oadable
modules, as Tetsuo has advocated from time to time, we would need a gener=
al
solution. We don't have a general solution now because only SELinux wants=
 it.
The previous implementation was under #ifdef for SELinux. At the time I u=
nderstood
that there was no interest in investing in it. The implementation passed =
tests
at the time.

I propose that until such time as someone decides to seriously investigat=
e
loadable security modules* the sole user of the deletion mechanism is
welcome to invest whatever they like in their special case, and I will be=

happy to lend whatever assistance I can.

---
* I do not plan to propose an implementation of loadable modules.
  I leave that as an exercise for the next generation.


