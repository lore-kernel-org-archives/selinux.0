Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C9C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397524679
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 22:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ix0oMkNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0Wt5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:49:57 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:39687
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgA0Wt5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 17:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580165395; bh=OB6oq26JcQdeGX+qqJgLVR8R92O1og4aqbN12ClRmzw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ix0oMkNpB1NDARtDHlBzAliyLaWPmTsweMu0ut4noqLSDlVptQ7B6iuk6yqWF07ZecdYAvPnXll74FLiXHQzRlACoQshXwjLXeB4Flj5KArwnIqDc4J9TX5qTU8oqaEORwy3lMJtJfEyRoxQNDq3X9NklyaOBufw5enRegNykdrmqUJSsxe5oolGwvPNsimwAiG3+7w1W1R1Tis7hMnY45ci5N29jksgSGgrCIGAcv4gZfW5ptCx2rfmneSi+HFU8Z3jzv6qnE5XneC/mZ5s717SSvNXLwHoo1jky+ENMQwIpJBOB+8nlgn/vXdHX0BsY3RJwRt1IxoYxO6rBpAm2Q==
X-YMail-OSG: StsAZP8VM1mA3zFeu0FqHly2IAdw0ek8bINe3BSSoKxbR7fFiWboKo9X6noY02h
 BwfczlxdMT5EDisLE50l.KDG9.HCGSeNIXCOzHVG_p2eQGLy9lYcPEUUXQwm_ahDXOkNU_Wk9FBu
 _2fmzkvu1fT.2sP7i5lut9CQpLm5ag.OjV4VKaDzrtpJ3_PcJSPcu4PrbJ4EFLVQflyNfM.tsFam
 STjApRhuNBQN1LU4I4Xsynh_pBmsck29O5jF4Lo1r_hAxO6Q23eKldLJJ86A5Ro_cVVB3SgIKquC
 kgdrPPvRmU3ojQRHgHaq1ppM29exHg8XV7mgxHPhoLIXUg_QlK687_G5SOLj.oYjZWqSWCOTyryd
 NTIJs2QYtE2ICPmQADUd_uirVp9T5kxoptyqMAMx6T6itSk_gjmSgcegZpYiyiQZF2O.mKF5yGzS
 mY0wmwjYxjF9JwKdGcsw9yVCxpPT09hhozi_faHUYczIfrAuz_iq5EQIU8pcYsDVTzW6iXsCVWuo
 ucx2EPsf2Irh4vhZWUf5TTWlb7VA.KyOYp0aNLIFoeacSPknMUU8Bv.o1Txr52RNjQwuDpnSIdmS
 4HFfqJC0Tz5k2PnMWEL89bcJqFWFOsh2Utl6aC_lhjTR8WWFeo8VS1eNxglzsnONkSSWdvM6OsOd
 ZredkxHv4xbXHcqKd09tDPczzm4VOKBbrFx2BRugBQ7bFnYqBIs7PqmhjJ5JAmeuCMc.sMq1JU6B
 lnPXZ1weQaG9jps4Eg6CCME2d3WWU4BMwr0dd_ssruVlpEmtmP9aI7wfH_L93rnHqhXeHkhd0JR1
 Ab7vpsENZLWddJbub2c3mcmOtzKw7fBSfmUM_jX8hsLscFAiTQ6XY.6ji7Vk2RMZSS0K71AUWXx9
 GzVxWPiDrS0z5Hska2wT2W5R1iIdKoQxcF6EgviDyOoCV5Z0U2LVdtTwGnf7R47f8jkO0Nxog3Sm
 HOLVYvESrGi3JOemMAy0fIWkcgnMphUmrOuojeFt1SbulFvuzKu_opSV7MQtbsy97cHAtVaY2kqT
 BI7imGp0kP7fzLYONWVd9N0pHmqYhlnN3q.31aN6O_HvPdUQPnva6tGpVHU2GzZRY2fgsHtbvhe.
 xtgSgzBmVfJ0qe6BQC7np3gACzY7NYueE2XGhoi9.padC1uM05HgP82LDnaVkB.ljGwyP.GnZ9A4
 sksBYtIBKOzDbbqJsTf.YJ_sZs6y_g43y6Mpvej1MkZrd63x.3xjPBHvRVpCbitxMxsqPR1WhTsP
 V.hYL_7A4TeQnMTOREtB4nf.vHDSCKgfJ0CRqXrqnM.S2HR5tVkHfz7iZB8.vLQ_JYQArjYhWoIZ
 XakanJXXWTDPrSsgH2Iof9JjNrc9Qieu4O2ffMVcFy8H3PoXo_renHNZJcuhx0pn6pIzZTLVzSGg
 8vy80GXQTK1fDrVIaskhMpVpuV_fMblnPwjBZl4bvxE0GA64ifqhH1g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Jan 2020 22:49:55 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33d15866c576c075e9dadf21b71e321c;
          Mon, 27 Jan 2020 22:49:53 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <fa300128-0371-d588-17f0-525c6d118a13@schaufler-ca.com>
Date:   Mon, 27 Jan 2020 14:49:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/2020 12:16 PM, Stephen Smalley wrote:
> On 1/24/20 2:28 PM, Casey Schaufler wrote:
>> On 1/24/2020 8:20 AM, Stephen Smalley wrote:
>>> On 1/24/20 9:42 AM, Stephen Smalley wrote:
>>>> On 1/23/20 7:23 PM, Casey Schaufler wrote:
>>>>> Add an entry /proc/.../attr/context which displays the full
>>>>> process security "context" in compound format:'
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsm1\0value\=
0lsm2\0value\0...
>>>>> This entry is not writable.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Cc: linux-api@vger.kernel.org
>>>>
>>>> As previously discussed, there are issues with AppArmor's implementa=
tion of getprocattr() particularly around the trailing newline that dbus-=
daemon and perhaps others would like to see go away in any new interface.=
=C2=A0 Hence, I don't think we should implement this new API using the ex=
isting getprocattr() hook lest it also be locked into the current behavio=
r forever.
>>>
>>> Also, it would be good if whatever hook is introduced to support /pro=
c/pid/attr/context could also be leveraged by the SO_PEERCONTEXT implemen=
tation in the future so that we are guaranteed a consistent result betwee=
n the two interfaces, unlike the current situation for /proc/self/attr/cu=
rrent versus SO_PEERSEC.
>>
>> I don't believe that a new hook is necessary, and that introducing one=

>> just to deal with a '\n' would be pedantic. We really have two rationa=
l
>> options. AppArmor could drop the '\n' from their "context". Or, we can=

>> simply document that the /proc/pid/attr/context interface will trim an=
y
>> trailing whitespace. I understand that this would be a break from the
>> notion that the LSM infrastructure does not constrain what a module us=
es
>> for its own data. On the other hand, we have been saying that "context=
"s
>> are strings, and ignoring trailing whitespace is usual behavior for
>> strings.
>
> Well, you can either introduce a new common underlying hook for use by =
/proc/pid/attr/context and SO_PEERCONTEXT to produce the string that is t=
o be returned to userspace (in order to guarantee consistency in format a=
nd allowing them to be directly compared, which I think is what the dbus =
maintainers wanted),

The getprocattr() hooks are already required to provide a nul terminated =
string.

The behavior of /proc/self/attr/current with regard to trailing whitespac=
e or
the terminating nul is left to the security module.

The behavior of /proc/self/attr/context is new, and as such it can be def=
ined
to be reasonable and consistent.

> or you can modify every security module to provide that guarantee in it=
s existing getprocattr and getpeersec* hook functions (SELinux already pr=
ovides this guarantee; Smack and AppArmor produce slightly different resu=
lts with respect to \0 and/or \n), or you can have the framework trim the=
 values it gets from the security modules before composing them.

Changing "every security module" turns out to be trivial, really.
The security_getprocattr() interface doesn't change, the getprocattr
hooks get a bool argument indicating if newlines are allowed, the
AppArmor code changes to check the bool and security_getprocattr()
sets to bool specially for the "context" case.

The getpeersec() interface use for SO_PEERCONTEXT isn't any more difficul=
t.
The security modules are free to include a terminating nul or not in
the existing use case, but a bool can tell them what the behavior must
be when we get to that interface.

It's not like there are all that many security modules to bring in line
at this point. Establishing sane rules of behavior is overdue. With the
current set of new modules sniffing at the door it really is time to
tighten these up.

> =C2=A0 But you need to do one of those things before this interface get=
s merged upstream.
>
> Aside from the trailing newline and \0 issues, AppArmor also has a whit=
espace-separated (mode) field that may or may not be present in the conte=
xts it presently returns, ala "/usr/sbin/cupsd (enforce)".=C2=A0 Not sure=
 what they want for the new interfaces.

Using '\0' as a field terminator addresses that issue. That's a
primary motivator.


