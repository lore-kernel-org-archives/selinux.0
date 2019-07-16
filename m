Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C26C7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87E20880
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BJQAj7rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGPOna (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:43:30 -0400
Received: from sonic309-21.consmr.mail.bf2.yahoo.com ([74.6.129.195]:41098
        "EHLO sonic309-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbfGPOn3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jul 2019 10:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563288207; bh=3CttenegfN3lwpKn6k9WlvAVbO9Pyfz3HZrjg+SlAIU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BJQAj7rXdvFASR5GFH33gkACiT3r0p3JrrAxolEYqqD3C6aJjl94V0O8UmoNaLiDNDeM0wK/5mSmSUE9O3TUFas6dioFURrkiHJU2h/RpCCl1f+oWqQotfyyJq6icDeWR7LFqeyUotn4eRYU8PkY/ZINyvslP9h9eDYao+ugk3m1QuK9R38U7saDuygbqJJvmn7dpc2Av/UA0hpterMql1gwgaQMD8NgqsaokZncC2ZYBa+lmOf+aDuoBxskmB8PSobTGqKdJlKJnnqjgDxS3c+dYb0zv8QAokOvERy+wwuzwn5GL1AbX2DzWPWOxG/kAuiKOeqwhNbhzpsNVvbxXg==
X-YMail-OSG: .y5Kx8oVM1mn_naNt_18LticIQREeV0uHMisbEyHQ6IyQrd7Slb7Yq5rtmNWMYu
 eJxntGWC_S01H0l0i9WS5IwnGrXL6aE2QnvlufcnUZrwPlSFsLgj4f5.V1BohNa93hd_1MkNTMnS
 7mqnsadgtvHRa1R.bHI0p9MqhIPc2EZvqsABGxBbR9J142lC0aS0MVzjGb_ebVHIuAJ13H94TE1_
 5BqJYGUeNzNRZ6FVW8Lccoc7HHaDwIg62CM0suzVxw2YqIxhnoKHWyK5BsHpuDTw7eVkPQap2ero
 Gph3FUkX_jQchjb3dB49h1EQ3dvzmJ9PknlCK41WbN8eTZtrtvIHdmzq.I6QPOqJ_A883lS2Zs9B
 DrNYIm2DPO8l9r9Pc8tx2AthjxxxNsJK7x6UxaCgwrZYBfWpoHQyHOlxJkgmWT88JhzIMEphAcQj
 EsqVV1kiPPCK1xOY5Y0WWqmDs9UKmHGVAgFGOfNITYM7.6XsvQKS8Ufn.7JhlwnH3WkKAFHZYaAN
 ykWwzUzEUCvGNS_ntO1gWWwmVuIxJhfr0Yz_suFAT.sIhVjBDeMmSqbCdJSQYAq6f54RT1pK05fp
 5kI8G1BusMALfOGT390_RlKhe.hhyWHI0hekqC2wGM9REY3qf.ZyCF1UfuUGVweXxqJ4s7hWjFys
 wDkHhjY0n2W5Bv.3cRNmixe2MEhDGGGhZwIGlkNQybmm7y6HenMOvbLW_FeK7ChxnJmSdjtP58XL
 Sk__ogkl9sa653AS0Qjm8tBZWP2Vj4Ikm7JzmpVUu1wo_E_nsKVq1oTA_p.4Vj_5mhUzB9q1sYoK
 UKXez5_AD.aLuAyOkA2SBJsnyrfJqf8ygkyucd5zOcgJzVj0SQ3Ne7a.1Ikczc7d5xRQg2PmmK8z
 l4az5mngkOeNu5qy9UrEZQ4HsnsrTVyQHQXAxGU8JH9FxEZjXpJQX2cwWojGCxaqdqI6rWWF35V1
 e_a_c1uSyhath4AzRVLEt6Z.Hz_FDAvc0Q6M5PnkFE1V99FSQ6W6koSPyFEobCHQqmu4uP9qmB1y
 ioh._ugNcqRg2yM_Q7zGo3HL.d24wGYwFFtVUmMDNmtfHB9YL2mohfDqPl5aR548aKJAnRXh3X23
 gS4ZuQALf.qjhNsmdprpAPy9PVe36yStyWwqgjhsL.d__58C7zlzWeo5pblc8V2oxlecgaAgRVZo
 RRniFMtTpn8g_GYDkLWVIsqnCdfSEmvlXpgntPD5rRnT6HwCIsyazgrThorkr_.wgD_AhASBCR7q
 _xzHsywfrTAr6eClN5sI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 16 Jul 2019 14:43:27 +0000
Received: by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a7020b17923d72c0f8a06da34a8d9f67;
          Tue, 16 Jul 2019 14:43:24 +0000 (UTC)
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, mortonm@chromium.org
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <20190716140349.GA4991@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <03835ff9-7891-d8da-45c6-f110a7e3be5b@schaufler-ca.com>
Date:   Tue, 16 Jul 2019 07:43:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716140349.GA4991@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/16/2019 7:03 AM, Serge E. Hallyn wrote:
> On Fri, Jul 12, 2019 at 12:54:02PM -0700, Casey Schaufler wrote:
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
>>>> This seems wrong to me. The capability system has nothing to do
>>>> with objects. Passing object information through security_capable()
>>>> may be convenient, but isn't relevant to the purpose of the interfac=
e.
>>>> It appears that there are very few places where the object informati=
on
>>>> is actually useful.
>>> A fair number of capabilities are checked upon some attempted object =
access (often right after comparing UIDs or other per-object state), and =
the particular object can be very helpful in both audit and in access con=
trol.=C2=A0 More below.
>> I'm not disagreeing with that. What I'm saying is that the capability
>> check interface is not the right place to pass that information. The
>> capability check has no use for the object information. I would much
> I've had to argue this before while doing the namespaced file
> capabilities implementation.  Perhaps this would be worth writing somet=
hing
> more formal about.  My main argument is, even if we want to claim that =
the
> capabilities model is and should be object agnostic, the implementation=

> of user namespaces (currently) is such that the whole view of the user'=
s
> privilege must include information which is stored with the object.
>
> There are various user namespaces.
>
> The Linux capabilities ( :-) ) model is user namespaced.  It must be, i=
n
> order to be useful.  If we're going to use file capabilities in distros=
,
> and distros are going to run in containers, then the capabilities must
> be namespaced.  Otherwise, capabilities will not be used, and heck, sho=
uld
> just be dropped.
>
> The only way to find out which user namespace has privilege over an ino=
de
> is to look at the inode.
>
> Therefore, object information is needed.
>
> Until now we've sneaked around that by doing things like capable_wrt_in=
ode_uidgid()
> and rootid_from_xattr().
>
> Again, this crucial: IMO, you have to be able to use a distro the same =
way in a
> container and not.  Either we support using capabilities in a user name=
spaced
> container, or we drop capabilities support will not be used, and we may=
 as
> well drop the module.
>
> Now, yes, if someone tries to extend this stuff to do pathname parsing,=
 then we
> might have to put our footsies down.  But we've been dancing around thi=
s for a
> long time anyway, so passing the inode in so we can do better logging g=
ets a +1
> from me.

I shake my head and sigh, but as I don't have a better
solution, nor the time to go looking for one, I'm not
going to place obstacles. That, and it's entirely possible
that my view is wrong.

>
> -serge

