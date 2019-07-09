Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F22C73C53
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA22087F
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KTrdmwMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGIRwH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:52:07 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:35153
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbfGIRwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 13:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562694724; bh=SFr7GZgtqTjlZJ6mi1zFKGVmIi1pk3RpKatJ/hlGVIw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KTrdmwMsAHPl5S6+x8gFksO6txZgQ4geSEQBBqT/8VJZsPYpt19hHTythxzZizoDrJgrVH4o1V01KnX43/QGIq7ZgjRFdVSt/V7lkQnzRxUi97q4t3jMW39iDuwaSeMP1PkCKD5fEu3lz7+NQDh4DFizJ5aU484oBvX2SxrEHF3Uq+Ab0kWSEtwI3xlg1Sv8KuLDBW2KyMyaes4on8ESRZ4JSUlNvihsTxKi5R2SS6Qo+gRftuVEnmaMiTVAGhx6Gyr0JLQCIainVancWuTy2zPy8j5HX0gukIsFnZ7bgHNt+gXISf12qQJU/xdKhr2xSmAy9njr14TCiNlWLYjGKQ==
X-YMail-OSG: zr.xYkUVM1n4X__tS0DGqPtDKSo.27McNm2tQx5JREUzKD0eL8Vq8d_1N7aqERS
 RI9BOjUNpkb43fwFWhg9muTyhL3wXpvnsP5VblYO39BwK2CyJSNYIT0G6VYHdpkePZ92ziq9a8DE
 6x_U7DW4V3KwjG1NLxiBE0qn8l9kudM0nx428.W8uvwS2UljwL41vgnbJSVXdcOdyqsBDdXcsJGE
 p_jaTY66XdxCi5UTtj6SjF3SOog1WLPj0WCFACsA2jJTo50IVRC.LM.HiWXnufyQV82ESSyc89HF
 RcfA4BUey2U2.v.JvjjlsbrbxSzF8LC36o4cqBcuMJmGGHKTjigAJdaSvEG.fAgAAhyQT6mgCg5F
 9axDqXDwzQMNBcIUnC_mTKx_M0HPnIkLxTVCDQAhnSC3Ay3BH18SOXXzf3jIHJyHiDyGOefp6JfA
 Uemix1KOY.BTvpCx19FsvNGK9W90pepAiGTqMEgsibEgEyRxWsutQFDwZiLvGbuPE8uLtgoEv8b_
 U.ETSrermSYuZ.0AJB0JNkbRAuQcYW3oIwnWdEk2_oNaaMZSP6fWpb_YWN9JYEHHuysytmzIfE_V
 LguynejjKX1rqjgoWajkwM.ddiZEvLqGhw6JrifEJ0DzI6RNRLLSJMFzSb6CdV9nVHbbsNv5u4La
 nQhWHYrhRq6pPrj6p.OEG3AcxP.almnoSQaDGvUh3ag2wKg6eex4wnF.G_nJV.k8tCZKvdRtmRPt
 kX5cC5OqJWILZAIIUEx7zeWezznherYziiHDQetpFlCoPhjkg4cyyttnArHevjRVavr2j.satrr2
 7.RVWPnRCfRIq2ypm6S7sHZ0hewWEESyyLcIfCC549tzyrOg8QldsGzZggSeFO7oN01Tra40xJVN
 xAwl61QQEHe1L_EaJANB16wB2VFQsDQjiNsbqfbO6CtFAD1drt1iub6DGFP2HsVrgtDYYjhaC3XO
 8Mc7ucjkr0a0v1CJLZQ.mu9wAxqV.OkU9WXKLqEzd6KeFkxfHHP6RQAevKVaA7vEra.5yLJ3mVjf
 Q3rDhN4XwmeN_3wZB2IvjRX9wxLLB5sGmJUu_aLLfAR1SrwnE3OUrzCrCG.J7V.xaGg7ODteKyRu
 0DeeEiRqsuBgoIS9BUiiJJyuNzws6dqK.nQ34OVIfr2EuEbLPq91RfJ93vYtYB.RYETUu.XynzZh
 OHrfaVKf.8afcniHkmwbWmqEwBFZjUAa.UJzNEGB5lJdU0r2HUxWmstzCTAbgzFTF5SvkYhy82rg
 _vSKm2sBJONnjx_898iRZSzPebikYl8ozIcLRO0PGwPDPLxQh1x4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 9 Jul 2019 17:52:04 +0000
Received: by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 929d82f55add3792720f7b353fd8d42a;
          Tue, 09 Jul 2019 17:51:59 +0000 (UTC)
Subject: Re: [PATCH v5 15/23] LSM: Specify which LSM to display
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        casey@schaufler-ca.com
References: <20190703212538.7383-1-casey@schaufler-ca.com>
 <20190703212538.7383-16-casey@schaufler-ca.com>
 <6f593ae9-4c79-7a04-41a3-c04ebd689658@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a3537a96-84d7-ad82-f76e-af0f44331c1b@schaufler-ca.com>
Date:   Tue, 9 Jul 2019 10:51:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6f593ae9-4c79-7a04-41a3-c04ebd689658@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/9/2019 10:13 AM, Stephen Smalley wrote:
> On 7/3/19 5:25 PM, Casey Schaufler wrote:
>> Create a new entry "display" in /proc/.../attr for controlling
>> which LSM security information is displayed for a process.
>> The name of an active LSM that supplies hooks for human readable
>> data may be written to "display" to set the value. The name of
>> the LSM currently in use can be read from "display".
>> At this point there can only be one LSM capable of display
>> active. A helper function lsm_task_display() to get the display
>> slot for a task_struct.
>
> As I explained previously, this is a security hole waiting to happen. I=
t still permits a process to affect the output of audit, alter the result=
 of reading or writing /proc/self/attr nodes even by setuid/setgid/file-c=
aps/context-changing programs, alter the contexts generated in netlink me=
ssages delivered to other processes (I think?), and possibly other effect=
s beyond affecting the process' own view of things.

I would very much like some feedback regarding which of the
possible formats for putting multiple subject contexts in
audit records would be preferred:

	lsm=3Dselinux,subj=3Dxyzzy_t lsm=3Dsmack,subj=3DXyzzy
	lsm=3Dselinux,smack subj=3Dxyzzy_t,Xyzzy
	subj=3D"selinux=3D'xyzzy_t',smack=3D'Xyzzy'"

Or something else. Free bikeshedding!

I don't see how you have a problem with netlink. My look
at what's in the kernel didn't expose anything, but I am
willing to be educated.

>
> Before:
> $ id
> uid=3D1002(sds2) gid=3D1002(sds2) groups=3D1002(sds2) context=3Dstaff_u=
:staff_r:staff_t:s0-s0:c0.c1023
> $ su
> Password:
> su: Authentication failure
>
> syscall audit record:
> type=3DSYSCALL msg=3Daudit(07/09/2019 11:52:49.784:365) : arch=3Dx86_64=
 syscall=3Dopenat
> =C2=A0success=3Dno exit=3DEACCES(Permission denied) a0=3D0xffffff9c a1=3D=
0x560897e58e00 a2=3DO_
> WRONLY a3=3D0x0 items=3D1 ppid=3D3258 pid=3D3781 auid=3Dsds2 uid=3Dsds2=
 gid=3Dsds2 euid=3Droot s
> uid=3Droot fsuid=3Droot egid=3Dsds2 sgid=3Dsds2 fsgid=3Dsds2 tty=3Dpts2=
 ses=3D6 comm=3Dsu exe=3D/usr/bin/su subj=3Dstaff_u:staff_r:staff_t:s0-s0=
:c0.c1023 key=3D(null)
>
> After:
> $ id
> uid=3D1002(sds2) gid=3D1002(sds2) groups=3D1002(sds2) context=3Dstaff_u=
:staff_r:staff_t:s0-s0:c0.c1023
> $ echo apparmor > /proc/self/attr/display
> $ su
> Password:
> su: Authentication failure
>
> audit record:
> type=3DSYSCALL msg=3Daudit(07/09/2019 12:05:32.402:406) : arch=3Dx86_64=
 syscall=3Dopenat success=3Dno exit=3DEACCES(Permission denied) a0=3D0xff=
ffff9c a1=3D0x556b41e1ae00 a2=3DO_WRONLY a3=3D0x0 items=3D1 ppid=3D3258 p=
id=3D9426 auid=3Dsds2 uid=3Dsds2 gid=3Dsds2 euid=3Droot suid=3Droot fsuid=
=3Droot egid=3Dsds2 sgid=3Dsds2 fsgid=3Dsds2 tty=3Dpts2 ses=3D6 comm=3Dsu=
 exe=3D/usr/bin/su subj=3D=3Dunconfined key=3D(null)
>
> NB The subj=3D field of the SYSCALL audit record is longer accurate and=
 is potentially under the control of a process that would not be authoriz=
ed to set its subject label to that value by SELinux.

It's still accurate, it's just not complete. It's a matter
of how best to complete it.

>
> Now, let's play with userspace.
>
> Before:
> # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dstaff_u:staff_r:=
staff_t:s0-s0:c0.c1023
> # passwd root
> passwd: SELinux deny access due to security policy.
>
> audit record:
> type=3DUSER_AVC msg=3Daudit(07/09/2019 12:24:35.135:812) : pid=3D12693 =
uid=3Droot auid=3Dsds2 ses=3D7 subj=3Dstaff_u:staff_r:passwd_t:s0-s0:c0.c=
1023 msg=3D'avc:=C2=A0 denied=C2=A0 { passwd } for scontext=3Dstaff_u:sta=
ff_r:staff_t:s0-s0:c0.c1023 tcontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c=
1023 tclass=3Dpasswd permissive=3D0=C2=A0 exe=3D/usr/bin/passwd sauid=3Dr=
oot hostname=3D? addr=3D? terminal=3Dpts/2'
> type=3DUSER_CHAUTHTOK msg=3Daudit(07/09/2019 12:24:35.135:813) : pid=3D=
12693 uid=3Droot auid=3Dsds2 ses=3D7 subj=3Dstaff_u:staff_r:passwd_t:s0-s=
0:c0.c1023 msg=3D'op=3Dattempted-to-change-password id=3Droot exe=3D/usr/=
bin/passwd hostname=3Dmoss-pluto.infosec.tycho.ncsc.mil addr=3D? terminal=
=3Dpts/2 res=3Dfailed'
>
> After:
> # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dstaff_u:staff_r:=
staff_t:s0-s0:c0.c1023
> # echo apparmor > /proc/self/attr/display
> # passwd root
> passwd: SELinux deny access due to security policy.
>
> audit record:
> type=3DUSER_CHAUTHTOK msg=3Daudit(07/09/2019 12:28:41.349:832) : pid=3D=
13083 uid=3Droot auid=3Dsds2 ses=3D7 subj=3D=3Dunconfined msg=3D'op=3Datt=
empted-to-change-password id=3Droot exe=3D/usr/bin/passwd hostname=3Dmoss=
-pluto.infosec.tycho.ncsc.mil addr=3D? terminal=3Dpts/2 res=3Dfailed'
>
> Here we again get the wrong value for subj=3D in the USER_CHAUTHTOK aud=
it record, and we further lose the USER_AVC record entirely because it di=
dn't even reach the point of the permission check due to not being able t=
o get the caller context.
>
> The situation gets worse if the caller can set things up such that it c=
an set an attribute value for one security module that is valid and privi=
leged with respect to another security module.=C2=A0 This isn't a far-fet=
ched scenario; AppArmor will default to running everything unconfined, so=
 as soon as you enable it, any root process can potentially load a policy=
 that defines contexts that look exactly like SELinux contexts. Smack is =
even simpler; you can set any arbitrary string you want as long as you ar=
e root (by default); no policy required.=C2=A0 So a root process that is =
confined by SELinux (or by AppAmor) can suddenly forge arbitrary contexts=
 in audit records or reads of /proc/self/attr nodes or netlink messages o=
r ..., just by virtue of applying these patches and enabling another secu=
rity module like Smack. Or consider if ptags were ever made real and merg=
ed - by design, that's all about setting arbitrary tags from userspace.=C2=
=A0 Then there is the separate issue of switching
> display to prevent attempts by a more privileged program to set one of =
its attributes from taking effect. Where have we seen that before - sendm=
ail capabilities bug anyone?=C2=A0 And it is actually worse than that bug=
, because with the assistance of a friendly security module, the write ma=
y actually succeed; it just won't alter the SELinux context of the progra=
m or anything it creates!
>
> This gets a NAK from me so long as it has these issues and setting the =
display remains outside the control of any security module.

The issues you've raised around audit are meritorious.
Any suggestions regarding how to address them would be
quite welcome.

As far as the general objection to the display mechanism,
I am eager to understand what you might propose as an
alternative. We can't dismiss backward compatibility for
any of the modules. We can't preclude any module combination.

We can require user space changes for configurations that
were impossible before, just as the addition of SELinux to
a system required user space changes. Update libselinux
to check the display before using the attr interfaces and
you've addressed most of the issues.


