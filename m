Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D0C7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10720693
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PhBd2RIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfGPPD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:03:56 -0400
Received: from sonic314-21.consmr.mail.bf2.yahoo.com ([74.6.132.195]:38484
        "EHLO sonic314-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfGPPDz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jul 2019 11:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563289433; bh=fzViIG41dTBcCcKjTgr56kLNmIgIKrFNcPHHXqao3nQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PhBd2RIajrlbVE7QRMF6TgzwnXjWoh7TU3tRDAv24cuyXduG6on319fgbWyO6hp3Mwd9fmNh90O0eMJWQXp7cgV1PVcTL//dG+iyvkoAA0cpQuoc1ONrC2PB8BSI3AcTn78hcsrEyucxhpPywUYOTYLi4ifpIJqPRa+X3XJMqKFDvO/rYFUSwv6681T6gMjA88R/91DS4/SkZ0QfHrkcWppJxU0U3isxm3CBde3d7NTj6z5/Ux97+HRVmYH5sx7NUG3/M1Hxjw2GT1HXRpvI2SsUEL4ItivxEfFwRdEn8ttmARfhGg/Nj7/DPx84NzfBOdksh7CLNalBgRzbGL/iDw==
X-YMail-OSG: 07sKqMEVM1l.4ps8l.nLnibsP_N5MjnbDzr4er6UGUY4nmmlSPVmMIsVLxk3_Tc
 iqoJsbkmmgR_SPwEX0KTh6RG12kw.wX98F_ZvfzacfsLFwRCQqCoa.uK7iUv91She34DTEF7WIEL
 ylJPyG07EDi0rEad0JuQKBzq.Q7dws7MMLjYjPoJ6wJnBH.GY7tFRYQUVlfAzaExo1hWZgIKEAtm
 ejrScNyYBiAGQbBbp2hxKVp.UKi5NOFBPEWV1j8JuLe.07R3uus6kd8immx3wWWA1EsHUZ.ySV_C
 zfvDsZtbBiudwUqtGAFeGLPKCTutJCsi_CJa4ST467T9XT.XlSrhPK2a69AJgx2HDvshxVKWIxXB
 jZZOB9XlXE6.4yF_jMD9SUoSbXcSwtBtmIu4Vs5QGikwx94d9YVDO.OXTFbyUq4IPn5TQmW2owEG
 zItJjEvi5tNoeSGG3oX9umMbg5c0MfCxtmsvComuHtrOw3eTnoLxszKXEtya1P0jEaO8HD4QhZ.k
 CZmUrNnV8c6s2ujcLrhdmiBlUjJvvXy_T4167xyLS4Z2tpCjUnpxJ7_OikUL6vUnz7PTJVJVjq7y
 kOWdBi7c1vsVbgOg7u.XDQW_uE_R2J3hEBwAXqwK7iaW23gfO6RK3cDHt3xkdGkKP9WjoBPTlEfN
 fIzF5W5ygAxGZS_6v54mUO_DvU_mZel3iv3VFuzyz0gT_0OscJzlWgy1N8h0cx1lZ..83qYlEk9V
 6iWunhMLtL50Ubwc1FA8836nheBQYV7aRgdFLTjpfDzk7P.g1IQVbSShoS202.051VZLNHHmEaLb
 Up10ofi.CRyiRGvAx_etU_XeWWBlE1Z2Uq4Knxq3hK3oytBChAwBRxPPmvrUFugmXfMtcFK.7dmH
 BMj6F5Ow6wCY1MUfFFU5um4VcT_SxOTiWmmcSTTNW4w3IcY823RPoiXGkHpa17Bc7cXArrhe93WM
 fvTuAqi.tZaT8ujy3HGTW8t8foLonHZN8m1.Y0902gAEhWVP1jC_o1tRZpyEPDKDYNyQDiXh38mi
 3C8pXIH8llcwNzw4sOMJVF8MomsMj_VCmBMqLvQDB0NtHd7L4cI.OGUC2dKs3d1OZ9xYoUQZPaBp
 CU.juDei1KD5gzQyJSswEQ0wetenMFXISomB7LIPdSt9P8B4uBEH9U7ow_QR.1SBpDnK5JiaUozg
 tPo5tAFNnbiggMc.lqiEJNTVpWnr2KYUbCIXuBQjYELP9GUAhOm8QR_R0O0IH4eW6z9uDFYFmfOn
 .X2zyq6o0Ve8QPFjLFCeuRe_FX_gFrJMQj07aRbg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 16 Jul 2019 15:03:53 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 729149c0722efb19cf5af01a90ad1433;
          Tue, 16 Jul 2019 15:03:52 +0000 (UTC)
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        mortonm@chromium.org, casey@schaufler-ca.com
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <20190716140349.GA4991@mail.hallyn.com>
 <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <06966391-6a2c-3a42-cdae-bdae36ff5a87@schaufler-ca.com>
Date:   Tue, 16 Jul 2019 08:03:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/16/2019 7:21 AM, Andy Lutomirski wrote:
> On Tue, Jul 16, 2019 at 7:03 AM Serge E. Hallyn <serge@hallyn.com> wrot=
e:
>> On Fri, Jul 12, 2019 at 12:54:02PM -0700, Casey Schaufler wrote:
>>> On 7/12/2019 11:25 AM, Stephen Smalley wrote:
>>>> On 7/12/19 1:58 PM, Casey Schaufler wrote:
>>>>> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>>>>>> At present security_capable does not pass any object information
>>>>>> and therefore can neither audit the particular object nor take it
>>>>>> into account. Augment the security_capable interface to support
>>>>>> passing supplementary data. Use this facility initially to convey
>>>>>> the inode for capability checks relevant to inodes. This only
>>>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>>>> relevant to inodes will be addressed in subsequent changes. In the=

>>>>>> future, this will be further extended to pass object information f=
or
>>>>>> other capability checks such as the target task for CAP_KILL.
>>>>> This seems wrong to me. The capability system has nothing to do
>>>>> with objects. Passing object information through security_capable()=

>>>>> may be convenient, but isn't relevant to the purpose of the interfa=
ce.
>>>>> It appears that there are very few places where the object informat=
ion
>>>>> is actually useful.
>>>> A fair number of capabilities are checked upon some attempted object=
 access (often right after comparing UIDs or other per-object state), and=
 the particular object can be very helpful in both audit and in access co=
ntrol.  More below.
>>> I'm not disagreeing with that. What I'm saying is that the capability=

>>> check interface is not the right place to pass that information. The
>>> capability check has no use for the object information. I would much
>> I've had to argue this before while doing the namespaced file
>> capabilities implementation.  Perhaps this would be worth writing some=
thing
>> more formal about.  My main argument is, even if we want to claim that=
 the
>> capabilities model is and should be object agnostic, the implementatio=
n
>> of user namespaces (currently) is such that the whole view of the user=
's
>> privilege must include information which is stored with the object.
>>
>> There are various user namespaces.
>>
>> The Linux capabilities ( :-) ) model is user namespaced.  It must be, =
in
>> order to be useful.  If we're going to use file capabilities in distro=
s,
>> and distros are going to run in containers, then the capabilities must=

>> be namespaced.  Otherwise, capabilities will not be used, and heck, sh=
ould
>> just be dropped.
>>
>> The only way to find out which user namespace has privilege over an in=
ode
>> is to look at the inode.
>>
>> Therefore, object information is needed.
> Agreed.  The concept in the kernel is "capability over a namespace."
>
> That being said, sticking a flexible object type into ns_capable()
> seems prematurely general to me.  How about adding
> security_capable_wrt_inode_uidgid() and allowing LSMs to hook that?
> The current implementation would go into commoncap.  The obvious
> extensions I can think of are security_dac_read_search(..., inode,
> ...) and security_dac_override(..., inode, ...).  (Or dentry or
> whatever is appropriate.)

Would you have an LSM interface for each capability then?
security_sysadmin()? security_chown()? Or do you want to add
security_hey_look_here_is_yet_another_special_case() for
each if () in the kernel?

Sorry, I got carried away. I've been wallowing in the LSM
for too long not to be sensitive to just how fragile the
whole thing is. Adding a bunch more single use interfaces
isn't going to help it be useful in the long run. Please,
let's not go hog wild adding LSM functions. Please.

>
> If this patch were restructured like that, the semantics would be
> obvious, and it would arguably be a genuine cleanup instead of a whole
> new mechanism of unknown scope.

