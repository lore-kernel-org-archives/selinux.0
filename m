Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464BC433E2
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870E520776
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SBiTn4kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgE0P5P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:15 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:42957
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730906AbgE0P5L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 11:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590595030; bh=aS82V6kxKg54XgsMZiRIuOGcGsquTWw+tog/a3lXb5c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SBiTn4kNP7DLsMxceH9sA0CL1+UhjbyDE02A7hmOqT2N3/rNDAISuE2sBekkMAfmdNg/rNr2JXPQkV+jinN3sE46IpUOOX7YYcoXZBf3dS6MeF3OmLius2T+Lmxcnts7jK08x7VXzfZjIo6xUeiamFABsn7zh0hYO3o0ihHAnDYp/7wrQxlclCFOW5oevTInlEzIqIP2JL1ZkOXlIP/TtqFaWkPQYSnNasjL3mej7b4pc9EyP2Fdnb7B1q37b1gMCIvVM6t5ncXtsiBW8rqXvkEBN3159BZkfjYP4ZybIHez6doMWYlRbTDOpTPQrqbRd9coLSMQNNbY8szpnVUSIQ==
X-YMail-OSG: ZLhoryUVM1kyNE0qyNgS156jwGpJDg0_x4X9CfqyCIp3oz9NVAKMvYPlo5xcoW8
 yz6RSnypir4jwWtuYHv4hXxOCLAg9HAH78RfueJceHRU2Xp8Nr6piLyY1o6oOtwfurRc9O5QxvGE
 HMNz5FsILLz4unz0YaAvLhllEH8o4qROTaFTLA72mflZOERc0U3qOFSTqYKLQ6kxI.uaAxZ31ymy
 i_VFYV60Za.3PS0QNIEo9mt52ZQ3aYdJryjrtlMayPN36Uwy55Lflia5kj1OBLKuMjyMpgpG.w_x
 Cqk4_ZSXPfHffZ9iINutp3SuJNUMnF2lTT0emtBn1Jw_oqaofU8Wwn0FY2E9BBGwaGeya8TotNCi
 ji0UKEFTiNzPQ7Pw11W9UVwgj0GpT0.1qcMVvwEW5_7CT0LO4W1XB0zUnSagdKS.znA4w6267WqL
 Dbnri.rFwjQSS84fur1n0WLTWdag3FWGBRQx6ZhBxuUq5RpBx_Lcg4RUFMKi7NNDkM7Vepr9CNix
 GlDiurXFAoiEZPfqha5MW_D6GcTk0Pjx9WnOn9Fmot9AuhZgMO2Bq6WFiq2KOKLBmyJQAleC.OfI
 _vMvLsxncoRqD_AxaVo4ccR06W3mlEgtxui8Q5fw8DKCj9MCZ0Z12ZVgcmmKT9dPPmEt.cOhn2tH
 q0oxSjgl7OQ2M1I8DN18rShnKbkc9l5T_rgsbCU7.P1rbnf8D9MFnPnPd7Pm2Gzmcl7B5z4Et49C
 cm3bcoEEnlDPBXOOwaDDIJCYgzYSpAF4vNU0YknsvSwmRLqCiRvyTD21Lcfg7ZIndXpSOd9x2LU1
 thdaaWnqOlE1C7zPfLbkXqz6ORt3cSVxyKe3tLf3ayjVuOCtOLV5SCdIetzOcDclfBxw3munQbju
 h.TXAr.DwBs67fX.i69T8v2RoELBXHdmgSBE.d9eY6FXf3Lx.oE1v0ZKU9bfBwvsz_axQI7oNA9u
 xhBWENvaMEYZqoGlROmCKVUy16ZNsbxVv7MMbUZwxPPQMAV1OgFwxJNIhGHpoHUmSWrAcUNG2FRE
 cPpckBJmq_PtBuDaat5CaEZeo6wNA01POAvIQvYmHmuHX6bBlR7dBROy9OS6wMNccWFSj092Bq2c
 66L4npDH40vmzy60K5GZXW_Mqe3Hx36mWs_j7My7fSFJBBrYMY.tXSsN4xObI9uHanE8gApDxvdH
 YIkjALR9p6znZvkq6VRClpN0lSBMTty1FNFfo76.OhSqm63aNkGi2d_lgW_tSGG67UoGDCJC8TGG
 LhJhd.PGdcK02YdAIHZ8faka5YILV1ouYrL7VGnykUl_WBh1QLblWbT9Ac1b8jvyM72_3M8bj4L6
 WSqTItFYQqVowRocz6fkZyUUT6czFhPXDl_lYkYVwCHYxk1tSq4WxuvFLFGTPbDHazDJEkJnp_Xn
 aMdGw9dMwk0w3Vs5K9Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 May 2020 15:57:10 +0000
Received: by smtp404.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b498316bc3c2f4687f9c4237971a7493;
          Wed, 27 May 2020 15:57:06 +0000 (UTC)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <a75f3f71-66cf-e615-2cd5-86ac65a3bbdc@schaufler-ca.com>
 <20200527134842.GA250149@dcbz.redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f43921ac-2e55-7d9d-406a-d0f4cfd8ff93@schaufler-ca.com>
Date:   Wed, 27 May 2020 08:57:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527134842.GA250149@dcbz.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/27/2020 6:48 AM, Adrian Reber wrote:
> On Mon, May 25, 2020 at 11:55:20AM -0700, Casey Schaufler wrote:
>> On 5/25/2020 1:05 AM, Adrian Reber wrote:
>>> On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
>>>> On 5/21/2020 10:53 PM, Adrian Reber wrote:
>>>>> This enables CRIU to checkpoint and restore a process as non-root.
>>>> I know it sounds pedantic, but could you spell out CRIU once?
>>>> While I know that everyone who cares either knows or can guess
>>>> what you're talking about, it may be a mystery to some of the
>>>> newer kernel developers.
>>> Sure. CRIU - Checkpoint/Restore In Userspace.
>> Thanks. I blew out my acronym processor in the 1990's while
>> working on trusted Unix system security evaluations.
>>
>>>>> Over the last years CRIU upstream has been asked a couple of time i=
f it
>>>>> is possible to checkpoint and restore a process as non-root. The an=
swer
>>>>> usually was: 'almost'.
>>>>>
>>>>> The main blocker to restore a process was that selecting the PID of=
 the
>>>>> restored process, which is necessary for CRIU, is guarded by CAP_SY=
S_ADMIN.
>>>> What are the other blockers? Are you going to suggest additional new=

>>>> capabilities to clear them?
>>> As mentioned somewhere else access to /proc/<pid>/map_files/ would be=

>>> helpful. Right now I am testing with a JVM and it works without root
>>> just with the attached patch. Without access to /proc/<pid>/map_files=
/
>>> not everything CRIU can do will actually work, but we are a lot close=
r
>>> to what our users have been asking for.
>> Are you talking about read access to map_files owned by other users
>> or write access to map_files for the current user?
> If I understand part of CRIU correctly, then we only need read-access
> for the current user. I am sure Andrei, Pavel or Cyrill will correct me=

> if I am wrong concerning map_files.

If I do "ls -l /proc/self/map_files" I get the link name and link content=
=2E
While I can't open /proc/self/map_files/7fbde0c3200-7fbde0c3300 I can rea=
d
that it points to /usr/lib64/ld-2.30.so, which is something I can open=20
and read. Sure, it's an extra step, but it's no big deal. It does raise t=
he
question of what value comes from disallowing open via the symlink.


