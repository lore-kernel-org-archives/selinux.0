Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316EC352A5
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A152085B
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lua1BZVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgBJScY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:32:24 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34781
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgBJScY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 13:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581359542; bh=V75GUvWnmS1U51tBGV5en7XJKGDhtgfj6rxxFl98OsM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Lua1BZVY+1JsF9P8FMTwNA2hH8U6g7+o4O5dfiZCf1xBcw57D+4yIts/iG0dOCtw2Z1yYr1ZAPxwK8boOaCCy3fc8Honswauq0oM+8rO3mOKm5RlpnxcEJ8VpeAuMhgsRUcaOJRoJDCeVbmKEca77b3TQqlqsC1UH6ncGXLS5+kxiF5ftepTi0pNWRoUfSmlWg0+wc3+xNUd24qYdU9kXW0fGFN5XnoXqIEukbLyEnu5GvWPxmzk9D7qNGluO6ALeHjaTXb6XGN1EhI/HIX9kxPY7N1iDiuc5fd1vV2A7f8vZqPXPN9bVg1xJt4MKplK+Sa8OgagAs0e/5z/NCMNiQ==
X-YMail-OSG: rGZ77u4VM1kZtFFRI.tmuIQvaP7udseGAsgz4HxrL6Ir_QOdbQkKJE6CXEnNBrW
 DhGiOVCEoZyMofjctRco5zc3tLyujxf0f4OwsR7qp0PtU2E27B630qYcKrd1_Y.GI3rrqqwCo3lK
 anAIXZd8LwPKV7i0qpMj3ohCVEHqogdRO4d9MZz81SQz10ur1HgqatTmGilhhofVLU_84eZNUvB_
 xlixzIKrpOzXgz_SsCo3SRXJdrVknxGeT9U7rIbHtcjFe1I95smrX1dSEH4k4gII0A04M_Fh4HLe
 c9yOZ57DNnh8nGYRVtVH3kVxQPlXhM8XIbUuxXmNHvel2hanWAgASk4hEBFtIIJhzeRKiMpMbc_q
 XVJrwmWE1h.n5SuELEEGyjHhkdKSQpehMD8bw81qeLi.PC7Ezmj4uAJTVF3_p9O6kmLYIcfVesRq
 QIfqnlY4K22hTs669LDLJP8JOCD1uAzYYfAniBs.CR0evJjeVqEc5jwBLpVWO2yqLUnOkqGk3vnn
 0wbXHmULKsaH15Jga1DxZq8Gk5O.A5tQ4ry4lLoNgYMikfOkaMsVRSJ2GrXqu.JJddvGkc8._I6M
 qHO7AQR_PQn54MNqNEOnm0x_D3QZi_SbBGzHMlmTJr412kbQ7eh_u9_BGKuz5nPHhJdkHhdvGBic
 yLWAOud402WVwxV9RYgCcyTTztbPcD0vjMwAMIgZa9L2.tgMZhK_9oxrQhZ_680PGOO06zXJ6fSN
 QsxJ1jDKl_SsNxLU7KLRAKArlY2La8EMLeoiv0BoFm6O5qyp9L_cTmxSr.lTz7zKlQo9e.G97gAX
 kz2AaQAQbQpKlbhcmef0v562XK68fRHvKz5zSggr1tunrD5culI.FgyxK.GL7Wc19pns023LQ1_p
 B6_HHnJ9NcYoj.6P8jcXqyAGzpkDeqM8T7.esHzEeZp4mOZvDiGLgNTfJOLtmrIssJBM4v1sohbV
 o.bcbjw7FNltQOKmB7EJ5aYl2MynFc7KZWK9.0XjaI8bpNnCB3Cr7UZrIl6LtyqQJsb1HADImdix
 rNi5oIcCWH06AdYBSt6xq8.5UvUFepUXO.WJDLMaxpxPdiVLbBQiV5XBGaN8HoEkCIlZ_2M181w_
 BKe4HRnJDlSRRa5aX4CfXD4880SHMNtrueO.R7tmD0RmNdk4Oq5grLXvq2hkP58ZjXn3EUUuEQjN
 YD1HzlaF.4zq3iEHfSksKiQQrFUbBVgD3Bpu.1hlB9FXWwVJf0P0zTqBuKrePHMijxJLwSRGD6tK
 YsMoSWcVMer0iiaslllWl21kE5BLHpHo5J6w95eFvJZrTz7yafNQkkcyApgkclwjeH9JUBc95FWj
 ZlCNKR47hXFcksGMboSow_WUdkiwJbSjZwZbYthAhAxJ3SaO5IOvZqFaodiXabM.qr5m0fPHHyo3
 xkEEOTsv_ujkBU3e0T8rW6wg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 10 Feb 2020 18:32:22 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a343312223e28bbb19c1974a86500903;
          Mon, 10 Feb 2020 18:32:19 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
 <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
 <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <37fa9076-6f15-0261-3bcf-1883236f9c3f@schaufler-ca.com>
Date:   Mon, 10 Feb 2020 10:32:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/2020 6:55 AM, Stephen Smalley wrote:
> On 2/10/20 8:25 AM, Stephen Smalley wrote:
>> On 2/10/20 6:56 AM, Simon McVittie wrote:
>>> On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
>>>> The printable ASCII bit is based on what the dbus maintainer request=
ed in
>>>> previous discussions.
>>>
>>> I thought in previous discussions, we had come to the conclusion that=

>>> I can't assume it's 7-bit ASCII. (If I *can* assume that for this new=

>>> API, that's even better.)
>>>
>>> To be clear, when I say ASCII I mean a sequence of bytes !=3D '\0' wi=
th
>>> their high bit unset (x & 0x7f =3D=3D x) and the obvious mapping to/f=
rom
>>> Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F).=
 Is
>>> that the same thing you mean?
>>
>> I mean the subset of 7-bit ASCII that satisfies isprint() using the "C=
" locale.=C2=A0 That is already true for SELinux with the existing interf=
aces. I can't necessarily speak for the others.
>
> Looks like Smack labels are similarly restricted, per Documentation/adm=
in-guide/LSM/Smack.rst.=C2=A0 So I guess the only one that is perhaps unc=
lear is AppArmor, since its labels are typically derived from pathnames?=C2=
=A0 Can an AppArmor label returned via its getprocattr() hook be any lega=
l pathname?

Because attr/context (and later, SO_PEERCONTEXT) are new interfaces
there is no need to exactly duplicate what is in attr/current (later
SO_PEERSEC). I already plan to omit the "mode" component of the
AppArmor data in the AppArmor hook, as was discussed earlier. I would
prefer ASCII, but if AppArmor needs bytestrings, that's what we'll
have to do.

>
>>> I thought the conclusion we had come to in previous conversations was=

>>> that the LSM context is what GLib calls a "bytestring", the same as
>>> filenames and environment variables - an opaque sequence of bytes !=3D=
 '\0',
>>> with no further guarantees, and no specified encoding or mapping to/f=
rom
>>> Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
>>> but nobody knows which one, and they coould equally well be some bina=
ry
>>> encoding with no Unicode meaning, as long as it avoids '\0').
>>>
>>> If I can safely assume that a new kernel <-> user-space API is constr=
ained
>>> to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friend=
ly
>>> APIs for user-space features built over it. If that isn't possible, t=
he
>>> next best thing is a "bytestring" like filenames, environment variabl=
es,
>>> and most kernel <-> user-space strings in general.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 smcv
>>>
>>
>

