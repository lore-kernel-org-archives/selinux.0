Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73527C742DD
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1F20651
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 22:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZWfiz+WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfGLWiF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:38:05 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34471
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbfGLWiE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 18:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562971082; bh=3mg9AqEVjMk71jpt+X5SGAib4IHpFOA9r4Bth7a/DH8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZWfiz+WUTBolJgxmd5kueNH/ENShdmwapz6Aqw4tYasakB5zkAJx+XzQntYUgEde+dVvgT+sF7IUiXEm5bE6QkDbdXadCwI2MFnN0OA5ORfr0zzRMN4nWvgjKz8wqu/scwgS1D9HonRCroZX1ua4iNLYuZ1Q0QvjJM/8SM0IzL8fUtCSsTLtShT51z8RYg1faEdN6EfnywFVWSF7JSOzse+iGLt51gmAx7spO6Q1vS72dDTtzUbDJ28YFtUduTPOsOFzqC9ZfGScn7nEGPafMqbFIRW9C6+LLDvk+ytzku76b9ezeeRYQQOIvjBXfcY9eNubVLa9yw0venlLN5yCdA==
X-YMail-OSG: ioLLoqIVM1k2ejUtGo2lKWp7L3nj1ZWypxgK6d.JlMCf3GuzLDYBcQRhYXsNbwF
 bo7v0fnNMZDMZlHplDm8EYbE6opu1lhLClxBksUTj3mGyOIMvwauwYNlkIzwSdMnTxXR0TeXkFWQ
 2hoUKmfb1X3.4NdhUdbx4DhEjaXobr9HT9fNDpiKe35g5FOWdLzMjhZnp3iH2Zt595rcBu8Hcdn5
 GJ0K8Z5FManhgTlxuNRHWA2Gencr78IfwvAVpN_jHqpNooWCilS77t6tCxfmSGpXfmH1t3F2Y8bD
 UnaZ_YBEo2GFf0gIiIaZlJ2XmMSIBuhr_Nevvs98ly6FyOUuSZqY9Ie5k7uoeOm_5OCagVOV_X6v
 e9NhsrKP2MqoJxy8RenKaxAo2rA8xoyrLvWBtx3ON9r9SdWdPQb7SPLw2k9T5YY6eFwWuG8OxJgF
 jxpBMZyRTLSv_JqOA6WEv_7SQCzvuKTF52pDPQg5vyN32W95m9yBZbU2iPxj97olPP4fNBjeSoB4
 SW4R4QDHnrkjZBOXpQH0ttZzaaPZ6Mrn5qRT3qXJE1YLIlVKDE5ONKHRPAtS1G34ONuoPBWDpN05
 bDxanaXvqv0r0oboFOMgRd6UDRGS7_iPVsL_bVQg4kUrmWZb68uBY6vJrjtT5B1nqJEYIUeyfkKx
 bokOzjx_gyAW.Ub0aLo7Bg1A1fWri_6bHpRJi4eBoJnbvlejj59.ye8wI_HFLlN7xt2IWh.Qrz8M
 0Zo3cdgqcI8jdGj0NHi_PRwakLz9kJxuJp7GMw1jkXlUrl45UtmHfBT3g2WWf.1XSiz5bMyZNpI_
 hOaP_L1.RmhyNSzm0VIJjPSN5jAWgp_pKidrONjrJ7m8ZMqNQ3T7Twrr9NmANdlCYJuCJW8hwcB9
 .fuel.rje.1_gVrzI6ZMqcdwDz8My4S6.gZ_7v7wwz69qfPZl81k.sXHMX19BwF5l.VbL8vxGPVN
 Yq_5qf7kUjlSURcDz3iqYNzSOzBVYRtDvjTAST5RiU8xYBRmQ.4DyFmoV5C8MoR6eLMc4eey_Ace
 _8sWY4pKj3sFM9hAd2sVm1tJJ2e_b5IqsHqF7.d1cU2aCkcNnELmsORpGpyptwXmSR2_e9KJ73AV
 Z03Gao9VrPAFw9bElB6Fx6Wz8_SzS79lH5cjPhKy3h63dA0msnDNKKUsgYnGoBcB_nR5pn5mSW61
 ldESydOo2Nnsm0E0kfdV2wzbOq1aeCCfZm934jLqGuNjb9XkjSmNqrQtzBZfkgVNfs3NZVz81TI7
 xfBOjBPPCqP5Jk12_.imi5uTR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Jul 2019 22:38:02 +0000
Received: by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2870adf885d5cb5589cb0731de51212f;
          Fri, 12 Jul 2019 22:37:57 +0000 (UTC)
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        serge@hallyn.com, john.johansen@canonical.com,
        mortonm@chromium.org, casey@schaufler-ca.com
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <acd5a734-0aa5-1a37-7100-e2512ca63edc@schaufler-ca.com>
Date:   Fri, 12 Jul 2019 15:37:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/2019 1:21 PM, Stephen Smalley wrote:
> On 7/12/19 3:54 PM, Casey Schaufler wrote:
>> On 7/12/2019 11:25 AM, Stephen Smalley wrote:
>>> On 7/12/19 1:58 PM, Casey Schaufler wrote:
>>>> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>>>>> At present security_capable does not pass any object information
>>>>> and therefore can neither audit the particular object nor take it
>>>>> into account. Augment the security_capable interface to support
>>>>> passing supplementary data. Use this facility initially to convey
>>>>> the inode for capability checks relevant to inodes. This only
>>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>>> relevant to inodes will be addressed in subsequent changes. In the
>>>>> future, this will be further extended to pass object information fo=
r
>>>>> other capability checks such as the target task for CAP_KILL.
>>>>
>>>> This seems wrong to me. The capability system has nothing to do
>>>> with objects. Passing object information through security_capable()
>>>> may be convenient, but isn't relevant to the purpose of the interfac=
e.
>>>> It appears that there are very few places where the object informati=
on
>>>> is actually useful.
>>>
>>> A fair number of capabilities are checked upon some attempted object =
access (often right after comparing UIDs or other per-object state), and =
the particular object can be very helpful in both audit and in access con=
trol.=C2=A0 More below.
>>
>> I'm not disagreeing with that. What I'm saying is that the capability
>> check interface is not the right place to pass that information. The
>> capability check has no use for the object information. I would much
>> rather see a security_pass_object_data() hook that gets called after
>> (or before) the security_capable() hook in the places where you want
>> the extra information.
>
> I don't see how that would work or be advantageous.=C2=A0 Within the ca=
pable hook, the security module(s) decide whether or not to allow the cap=
ability, and generate any relevant LSM audit records.=C2=A0 It is precise=
ly at those two points (deciding and auditing) that we need the informati=
on; both occur within the existing capable hooks.=C2=A0 Calling a separat=
e hook before the capable call and e.g. saving the information in the tas=
k security structure for later consumption during the capable call offers=
 only overhead, no benefit.=C2=A0 Calling a separate hook after the capab=
le call is too late to be of use - the decision and auditing are already =
done.=C2=A0 And both hooks would be invoked from precisely the same funct=
ion at the same point.=C2=A0 If the information wasn't already readily av=
ailable at the point of the hook call, it might be a different matter, bu=
t that isn't the case here.

If there's a problem with the audit system you should be
looking at fixing that rather than tacking information that's
useless for capabilities onto it's interfaces.

>>>>> In SELinux this new information is leveraged here to include the in=
ode
>>>>> in the audit message. In the future, it could also be used to perfo=
rm
>>>>> a per inode capability checks.
>>>>
>>>> I suggest that you want a mechanism for adding the inode information=

>>>> to the audit record instead.
>>>
>>> That is part of what we want, but not the entire picture.=C2=A0 But w=
ith respect to audit, the problem today is that one sees SELinux dac_read=
_search, dac_override, etc denials with no indication as to the particula=
r file, which is unfortunate both from a security auditing perspective an=
d from a policy development perspective.
>>
>> I can see how that is a problem.
>>
>>> The only option today to gain that information is by enabling system =
call audit and setting at least one audit filter so that the audit framew=
ork will collect that information and include it in the audit records tha=
t are emitted upon syscall exit after any such AVC denial.=C2=A0 Unfortun=
ately, that is all disabled by default on most systems due to its associa=
ted performance overhead, and one doesn't even have the option of enablin=
g it on some systems, e.g. Android devices.=C2=A0 And even when one can e=
nable syscall audit, one must correlate the syscall audit record to the a=
ssociated AVC record to identify the object rather than having the inform=
ation directly included in the same record.
>>
>> None of which gives any rationale for adding the information
>> to the capability check. Sure, it's in the right place, but there
>> is no object interaction with the capability call.
>
> We introducing such an interaction - that's the point.

And I say that you're breaking the layering.

>>>> What would a "per inode" capability check be? Capability checks are
>>>> process checks, not object checks.
>>>
>>> Ideally it would be possible to scope dac_override and other capabili=
ties to specific objects rather than having to allow it for all or none.
>>
>> That would require a major overhaul of the capability scheme,
>> and you're going to get arguments from people like me about
>> whether or not that would be ideal. Besides, isn't that what
>> SELinux is all about, providing that sort of privilege granularity?
>
> It only requires passing the information to the security modules at the=
 point of the hook call, and then SELinux or other security modules can i=
mplement it themselves without any other changes to the kernel.=C2=A0 We =
aren't changing the way the base capabilities logic works.

If you're not changing how capabilities work you
shouldn't be adding parameters to its interface.

> We can't provide that degree of granularity without the additional info=
rmation.=C2=A0 Let's say domain A needs DAC override for files of type B =
and for nothing else.=C2=A0 To support this requirement, SELinux policy h=
as to include at least:
> 1) allow A self:capability dac_override;
> 2) allow A B:file { read write };
>
> Let's say that A also reads from files of type C and writes to file of =
type D.=C2=A0 So SELinux policy also has to allow:
> 3) allow A C:file read;
> 4) allow A D:file write;
>
> There are files within type C and within type D that are under differen=
t DAC ownerships or modes.=C2=A0 Only some of these files should be acces=
sible to A.=C2=A0 But because dac_override is global and not scoped to sp=
ecific sets of files, the combination of these permissions now allows A t=
o override DAC on files of type C and of type D; thus it can read all fil=
es of type C and write to all files of type D even though it has no legit=
imate need to do so.

Capabilities do not implement a fine grained policy.
This has been lamented ad nauseam regarding CAP_SYS_ADMIN.
It is also irrelevant to the issue here.=20

>>> Just because a process needs to override DAC on one file or one set o=
f files is not a reason to allow it to do so on every file it can access =
at all.
>>
>> That's an argument for privilege bracketing within the process.
>> Not something I recommend (the oft referenced sendmail problems
>> being but one example) but the only way to do it properly without
>> delving into path based controls.
>
> As you note, historically privilege bracketing hasn't worked so well, a=
nd fundamentally it puts the trust burden on userspace for something that=
 could be enforced at the system level quite easily and in a race-free ma=
nner.

I'm not arguing against that goal, I'm saying that you're
going about it the wrong way.


>>> If we want to apply least privilege, then this is a desirable facilit=
y.
>>
>> The capability mechanism is object agnostic by design.
>
> Some might argue that's a flawed design.

Might? Show me someone who's looked at capabilities who
doesn't think the design is flawed! The entire POSIX 1003.1e/2c
group knew it was flawed, which is the primary reason it never
got past DRAFT status. If capabilities had been perfect no one
would ever have been tempted to add domain enforcement.

But there it is. That is not an excuse to muddle it up
with pass-through parameters in an effort to wiggle around
the issues in other facilities.

>>> I understand that doesn't mesh with Smack's mental modelbut it would =
probably be useful to both SELinux and AppArmor, among others.
>>
>> I'm perfectly happy to have the information transmitted.
>> I think a separate interface for doing so is appropriate.
>
> As above, I don't see any way to do that that isn't just adding overhea=
d.

I'll see if I can squeeze some time into alternatives, but
my brain is already wrestling with audit issues of my own.


