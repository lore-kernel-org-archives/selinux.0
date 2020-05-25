Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED15C433E0
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 02:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7602073B
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 02:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ElwM1OmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbgEYCCE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 May 2020 22:02:04 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:45304
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388647AbgEYCCE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 May 2020 22:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590372122; bh=tYESN0eqAx8PHt4e/6wtNye6dToYMIDWe9kIG2IyPIw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ElwM1OmYfifcqP/OYp8yN9Xv6U3F/0vfWpYH58b7rNEKS2M+FsOCjkLs748pcpLd3cSK+hxoClHvGqCscYcB1t2CXe0g5c/o6sJQIp9NxRzBYC8/qtR2F54bwGBht3A2UimG+7SAsjeCiUPMFO6izHWqMrTcPk8vFOYe95AE+85vHs3QrZ84yo53VXUhRr5pe0ikFHJHgIGYVKqq31nLi1JF7EeVrlj6/eNf5E99SnwjwHkRWQatg3yFkNSIEzomcc9VrtqIPRU3VVYjl36tUSG9NPbI2IFm5WyliQkJNF3QGjWtzb79zXjxJLxMj/E/16EKv+uf5ew+NHr9ag9uFw==
X-YMail-OSG: KV9IxboVM1n0WgLyPXf_e3aHyKzRqcSYvwZJGEzzS9JFxs0TC1PWTJm8LQPIiq8
 Fyf9Dg95NfyCGlPH.lxjbX.TJl2vIXUoak3B5ACibto9QaPmHdD5fhQu0t_h1uufwVSsAGsGxXN_
 gxZZ5TrtejmRL51BO4FmmKnIp3Tu.zL.HLq1a_CAeX3LvToMQC1SpdGLLziMJUKCl2XkeOIyUFmp
 O5Q.GQM2S7SihKGjbTbRv72pZmegKkCvqPfsUIC8_kkIf6_pKTdsnkKtZ8GAozHHO9WymioBObsS
 44WUMN6vBSJZw9rODb3PjIgFV5mIJzs36n0AUvUyLSmDwM8S7wV14wAbVnV4ER.iAxvkywDjtcRU
 Q9NhAExe7vc7eilSb3I5u4ATpM9Las2Fdejg_HM3pOC4g_MxSl9FzYfxQmXvL9tahtuSJ.ik5lMW
 OD.lSnO69qxAqNyfT2P96wNXCTFr7edNA8HTew6zVMm_AmTOI.Z930xxqFPXYRbvrukVY06aLd90
 88RD3DqVNMYcQyRilr88A4cR6YZUdSeBlRu4cnS83CtWha7t9dqtME3gFYu3yd.VsvatMPecmWDp
 jj6hK71x.xoGnsXqyMxoj4vghI2poaS3iPJVWTmWbIsaii..mD1u5kG7htT6btYExdMjHL9jkZhh
 bEP64HwAyW2DQaKo40Jt2IqKMGfG0ndAw1MYJPgUtwniNfin.5DLGjotVsW.wsTrHT50jQ7plOdP
 iobsVzseBeNpmVzWo_a_VH4nV0SrMf9HCsI9JiwUEuyhocctPcbc5X7xS7gKjbSeEpL.faw5zhuE
 LtT0xF6Ar.j7JQS07lX8lkN7.YEblCs4Z1QCFb90IEeOd7tWRXnJRM9_FW1oCmLWLekio3LVoBEf
 sZWQFORCD4.B3bvLVtyVoema6KVKMDzkrlPdUccIah4tqKNS9yYlML3Ngje_x_WgIvW99Vy8Qm.l
 nx5CGehjo9dnzJ6DdWshgjXpweTrKWCE0E5F5x12lO.dBL4QM0f9naXXQJ8dDO0OPVYiQ9PETIhc
 66.rXepOC4fbMHdC8AKAZI02jGgFBG_gFLfaLL5Bbe8tZTKF0QzOzULmiWnOWIJsRegj7dR.mz6d
 XA2EwGP2daHt9mIadv_aoB560y3bj.BgtAFa1JDTBQJInbbgFjIlFfVK0RA45fX9D4RKoAaF0IMH
 s4D1oYStcoo4ED8WK46lsw0a0jsKBwKs27g5FxVzA1125Sf6lsBnYGie8mTed6rxMPHVZ1_Ym6qq
 xkXqsqkzjS0OcXbp8xgUaqnqzEn8vVtTqPSVpYwCu5IXJliu8H7lyISEvAYaSl9oKXE7GM.MnSxz
 j4un3AU4zXvKkypUEjzawziUZ2SZFxiJZZ3Cu7XSBt4W1tpHRNJihxG5TpGNaUVLFVNaXHWrZvU_
 kWB3wrc91GjP_jZHpdSMdsmc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 May 2020 02:02:02 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID eb555deb44d72beca2d23355708db932;
          Mon, 25 May 2020 02:01:57 +0000 (UTC)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
 <20200523042749.GA19115@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <cc9e5272-795f-9275-ba93-90233bf1addd@schaufler-ca.com>
Date:   Sun, 24 May 2020 19:01:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523042749.GA19115@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/22/2020 9:27 PM, Andrei Vagin wrote:
> On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
>> On 5/21/2020 10:53 PM, Adrian Reber wrote:
>>> There are probably a few more things guarded by CAP_SYS_ADMIN require=
d
>>> to run checkpoint/restore as non-root,
>> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
>> separating out CAP_RESTORE.
>>
>>>  but by applying this patch I can
>>> already checkpoint and restore processes as non-root. As there are
>>> already multiple workarounds I would prefer to do it correctly in the=

>>> kernel to avoid that CRIU users are starting to invent more workaroun=
ds.
>> You've presented a couple of really inappropriate implementations
>> that would qualify as workarounds. But the other two are completely
>> appropriate within the system security policy. They don't "get around"=

>> the problem, they use existing mechanisms as they are intended.
>>
> With CAP_CHECKPOINT_RESTORE, we will need to use the same mechanisms.

Then why call them out as objectionable "workarounds"?

> The problem is that CAP_SYS_ADMIN is too wide.

This is well understood, and irrelevant.

If we broke out CAP_SYS_ADMIN properly we'd have hundreds of
capabilities, and no one would be able to manage the capability
sets on anything. Just breaking out of CAP_SYS_ADMIN, especially
if the process is going to need other capabilities anyway, gains
you nothing.

>  If a process has
> CAP_SYS_ADMIN, it can do a lot of things and  the operation of forking =
a
> process with a specified pid isn't the most dangerous one in this case.=

> Offten security policies don't allow to grant CAP_SYS_ADMIN to any
> third-party tools even in non-root user namespaces.
>

