Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437CC433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD522053B
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gikCS1Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392193AbgEZTTU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 15:19:20 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:35704
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392424AbgEZTTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 15:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590520757; bh=McQf4xkfVmcPDoX/8Wv0zGs9ac8orRRGPfVxajFbeb4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gikCS1Pc7edctO/bqMR2mDoeyJavWGougEkmPf7Pmf0qtOrEcNfH08diLU8e6dswdFM+wo1uZIrenHbHDnVuJkE5r5w4t3FG5M2IiYVdGXAcV2xQSBRDlR1hZzlUnYe8LHWee+M5PxmFJAwwUXRdw3XhqWqzwv3JOY64wDtVfCXXqaWH8wED0ALaz+e+7CPemUthwrrsNPNN9m4aXrmwn9UXfZh6i6zbpNyO2uFeBqNGljRt96wDK/WdZz7rytROTgDkcwUbkpFlpKgsaEofagoxl2darceDflXiK7n5196aVXdHT7wnSgNsssg/tUCqEzO3iqmvXGC1ELyo1O/AbA==
X-YMail-OSG: 63H.NUwVM1ltrxyZXq.kNvHWQVKP9oB7tvvKHWWND.WGLsOXmb0kRAmRzErbrNC
 YJxgD.t8xjb3E06QRiX3xSKBvcyLfHU4POA8S9Vz.AfqSYdBxSAxpNzppss1An4Z2X9FzciioJI9
 b3QtIp1vVt7F.EjxCYxCK8iPYt2YozMnXZRcCgveiHVn7D9KT9FV1VtgYkEz9kTNP.WMf7dpNcRH
 .HWILw1XRpWZx8Ko7bh1pmthcXiAPa99otauyAV1ktzTTZ1drPGpFEJnEIE4gh_S_eFdQpsFbt2o
 z6avzfzJbW6lMCsAtTL34fGTPVfUTDhqpwljkYtWDYzqG2MzILkTW1Se7z35tT1fDCrJFH2SV.02
 CrKYAFRGr6V_KFep5ws4nqojqU12Z4Ga1QFnzc59TDbHtgn2KGOVy7v_J_BpfTcO.uEPfrGb0dPL
 OyfkK9aBLas6WuflAunL2z3tmCWWOaiL7dF0WS1dwKfh.hIH6H33rJqS29XdJEGOz7W1hHKmeJ4Z
 _HW1bpwCbqOTAL2uByZnFCATeFauM3J.rf.sHO1J.LVll8EAHM9HSEyg2zpmj7FAJbCRVkjVEq9Z
 jQ7zkDEhUIuVOJVoWteq41kceo.UUHto4oV_LsEbumKTbH0cgmQyqCbV.32qzQj8YmAg3PJxCI7K
 geCrdTT8bCbphFrqx5TQzdSkKhw0B_q5zek.be8gAEQL5kGYUwLL5TJd8OqXbC_B7ZEIS6Kf4CNs
 nq1nW9sxg94lDSvmnWaBrRoJfZYzKY7qUKto534ObYyb4Y92nQVt9Lp.TFxJMtPVFJBGnrRxVCv0
 xeDQ2RrEUg9QGlhQaibFEbwug2JAANzhHJ3rQhebibtC1HL7Vreu1of1rUJxoOeLfl_GnJi93F5y
 txg.gzHebwHNejRwXTC_C9mKPl9iscqe_hkI.LYBQgE_TcFvv2AjfENwxtoYJHoVWf6ijRhdHXPE
 vMb0vpr2hU0Iz91PF.JHRQY7QGQ6dl66oxW9E6qq1l.qsmDPDgpRgTAKvWIV133xBsH4NwKrkbSZ
 DHi3CKitadYWgEhef2nJIU4Xu8zPegH4rwdHXvoQalj8aPpvzz05VyF.4yXa82EaWJlv_nBBZDzc
 FhTZgJWrvFjqZuWl94zE6jIzTOlkzeb94eGwapEvdM7TZ62NtG2f7XnoJLRHCgoj8JLVozzi2UJQ
 3C6CkFSp.ytn6KCSgV7TEZ0a41oBnmoUV7UotmMyCr0iV0NXeuCN0IP6ElzzukptPEYdnJpawAWb
 mEBbhJTm_OwrvX76lT6cFv7LAanePIFUOcrc0iDUUWb_Bs3ipHI2wuwe9ppEQ.mADCfoblZZTnIL
 jd_C6ky2wjCdzDec6TCic6vXPqBhkY4nSP5_vwWzBui5PmLy.yTRjWretx6vaMimv.myWXHjgGAB
 YEQnctxEJLcC6dDTrDQn4heI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 May 2020 19:19:17 +0000
Received: by smtp404.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 74c883f4172faf6794e783c66f95f465;
          Tue, 26 May 2020 19:19:11 +0000 (UTC)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Christine Flood <chf@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
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
        Jann Horn <jannh@google.com>, "Haley, Andrew" <aph@redhat.com>,
        "Bhole, Deepak" <dbhole@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <877dwybxvi.fsf@x220.int.ebiederm.org>
 <CALKUemw0UZ67yaDwAomHh0n8QZfjd52QvgEXTJ4R3JSrQjZX9g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <b7797029-2fd3-3773-a51a-bf073a96c848@schaufler-ca.com>
Date:   Tue, 26 May 2020 12:19:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALKUemw0UZ67yaDwAomHh0n8QZfjd52QvgEXTJ4R3JSrQjZX9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/26/2020 12:01 PM, Christine Flood wrote:

Please do not top-post on this list.

> Java applications suffer from slow startup times due to dynamic class l=
oading and warming up the Just In Time compilers.=C2=A0 Not all Java user=
s have root access on their machines.=C2=A0 Enabling CRIU in user mode so=
lves this problem for us.=C2=A0 We are about to release a user library th=
at will allow check pointing Java from within Java.=C2=A0 Having to run t=
his as root would severely limit its utility.

The performance of dynamic loading is a well understood issue.
Please don't conflate that with the security issues involved.
Security is *not* the basic problem. If you are having problems
with application start-up performance you really should be be
addressing that directly rather than implementing sophisticated
workarounds that require system security changes.

>
>
> Christine
>
> On Tue, May 26, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.c=
om <mailto:ebiederm@xmission.com>> wrote:
>
>     Adrian Reber <areber@redhat.com <mailto:areber@redhat.com>> writes:=

>
>     > On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
>
>     >> What are the other blockers? Are you going to suggest additional=
 new
>     >> capabilities to clear them?
>     >
>     > As mentioned somewhere else access to /proc/<pid>/map_files/ woul=
d be
>     > helpful. Right now I am testing with a JVM and it works without r=
oot
>     > just with the attached patch. Without access to /proc/<pid>/map_f=
iles/
>     > not everything CRIU can do will actually work, but we are a lot c=
loser
>     > to what our users have been asking for.
>
>     The current permission checks on /proc/<pid>/map_files/ are simply
>     someone being over-cautious.
>
>     Someone needs to think through the threat landscape and figure out =
what
>     permission checks are actually needed.
>
>     Making the permission check ns_capable instead of capable is a
>     no-brainer.=C2=A0 Figuring out which user_ns to test against might =
be a
>     we bit harder.
>
>     We could probably even allow the owner of the process to open the f=
iles
>     but that requires someone doing the work of thinking through how
>     being able to opening files that you have mmaped might be a problem=
=2E
>
>     >> > There are probably a few more things guarded by CAP_SYS_ADMIN =
required
>     >> > to run checkpoint/restore as non-root,
>     >>
>     >> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
>     >> separating out CAP_RESTORE.
>     >
>     > No, as described we can checkpoint and restore a JVM with this pa=
tch and
>     > it also solves the problem the set_ns_last_pid fork() loop daemon=
 tries
>     > to solve. It is not enough to support the full functionality of C=
RIU as
>     > map_files is also important, but we do not need CAP_SYS_ADMIN and=

>     > CAP_RESTORE. Only CAP_RESTORE would be necessary.
>     >
>     > With a new capability users can enable checkpoint/restore as non-=
root
>     > without giving CRIU access to any of the other possibilities offe=
red by
>     > CAP_SYS_ADMIN. Setting a PID and map_files have been introduced f=
or CRIU
>     > and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capab=
ility
>     > for checkpoint/restore would make it easier for CRIU users to run=
 it as
>     > non-root and make it very clear what is possible when giving CRIU=
 the
>     > new capability. No other things would be allowed than necessary f=
or
>     > checkpoint/restore. Setting a PID is most important for the resto=
re part
>     > and reading map_files would be helpful during checkpoint. So it a=
ctually
>     > should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in=

>     > another email.
>
>     Please if one is for checkpoint and one is for restore asking for a=
 pair
>     of capabilities is probably more appropriate.
>
>     >> >=C2=A0 but by applying this patch I can
>     >> > already checkpoint and restore processes as non-root. As there=
 are
>     >> > already multiple workarounds I would prefer to do it correctly=
 in the
>     >> > kernel to avoid that CRIU users are starting to invent more wo=
rkarounds.
>     >>
>     >> You've presented a couple of really inappropriate implementation=
s
>     >> that would qualify as workarounds. But the other two are complet=
ely
>     >> appropriate within the system security policy. They don't "get a=
round"
>     >> the problem, they use existing mechanisms as they are intended.
>     >
>     > I agree with the user namespace approach to be appropriate, but n=
ot the
>     > CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things=
) of
>     > what CAP_SYS_ADMIN allows.
>
>
>     If we are only talking 2 things can you please include in your patc=
hset
>     a patch enabling those 2 things?
>
>     But even more than this we need a request that asks not for the lea=
st
>     you can possibly ask for but asks for what you need to do a good jo=
b.
>
>     I am having visions of a recurring discussion that says can we add =
one
>     more permission check to CAP_RESTORE or CAP_CHECKPOINT when they ar=
e
>     things we could know today.
>
>     Eric
>

