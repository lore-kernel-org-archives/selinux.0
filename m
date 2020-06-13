Return-Path: <SRS0=oduP=72=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACAFC433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Jun 2020 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1541F20792
	for <selinux@archiver.kernel.org>; Sat, 13 Jun 2020 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="MFwL1Tji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFMNoM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:44:12 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:52896 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgFMNoM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Jun 2020 09:44:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 41171D850FA01;
        Sat, 13 Jun 2020 16:44:09 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nIbux306tFIo; Sat, 13 Jun 2020 16:43:53 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id BBE4BDB2801CE;
        Sat, 13 Jun 2020 16:43:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru BBE4BDB2801CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1592055833;
        bh=GOkSR2O4Zvah8HHITuRISfE4kjAAZD5hleynwYfnV90=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=MFwL1Tjisal0oEnFsN/dsB2Uu8VY7TzkECPDPCLF0QdcNSmO3rhuWzOJ5VutKafDJ
         UtlzXOuF4UMVGicp1h2RdvLJ61e+GmvJBTtUae7yPYcyIxl9yxhyXijsp3+pP2JzR/
         F9pQJqTmfHWNJqZXgJ+UmUqYNoXpPmqNe5aw35FXNomtQtkig7g/ADkek5hhrvA+kY
         4id+AaE4jB86MHhTyZjTczgMQQU/RfEUMIv2UFCP0fPs2Ahm9Mmy0A8ak2Ypdmf8WX
         Ug57TC+QQew4wkc5H+AljmdQCOS4hJHuHVHHNv4wkiKZMVUfbGB769MzjP7u7h6fxn
         RJloxbZ5G5L2g==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0FBeR1M8vALh; Sat, 13 Jun 2020 16:43:53 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-204.ip.moscow.rt.ru [90.154.71.204])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 81725DB2801C6;
        Sat, 13 Jun 2020 16:43:53 +0300 (MSK)
Subject: Re: How to off RBAC in SELinux?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
References: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
 <CAEjxPJ7nwA2qFLYZN-X8V9Sqbdbcx-7e=R5j9y=khHTAsbe=yA@mail.gmail.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <7132c007-b6ce-60e2-b86a-491b43553a49@rosalinux.ru>
Date:   Sat, 13 Jun 2020 16:43:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7nwA2qFLYZN-X8V9Sqbdbcx-7e=R5j9y=khHTAsbe=yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

12.06.2020 23:44, Stephen Smalley =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, Jun 12, 2020 at 4:05 PM Mikhail Novosyolov
> <m.novosyolov@rosalinux.ru> wrote:
>>
>> Hello,
>>
>> Is it possible to remove any checks for RBAC (role-based access contro=
l) violations and check only against MLS/MCS rules?
>>
>> What I have:
>> 1) a system with most files labelled correctly according to a Fedora-b=
ased SELinux policy, which in turn is based on the refpolicy;
>> they will probably have to be kept to make what I want work
>> 2) RBAC-based control from SELinux is not needed, e.g. it is not neede=
d to prevent httpd from executing 3rd party binaries
>> 3) MLS is needed, e.g. it is needed to verify that httpd cannot access=
 "secret" documents
>>
>> If I understood correctly, main calculations are done in context_struc=
t_compute_av() (security/selinux/ss/services.c), but it does not query ML=
S separately.
>> Also, all actions are prohibited by default, the problem is that the p=
olicy specifies what to allow, but I would like to wise-a-versa specify w=
hat to deny, but keep MLS parts working as is.
>>
>> The question is: is it possible to make selinux ignore (2), either in =
the kernel or in policy?
>>
>> In other words, how to make SELinux make allow-or-deny decisions based=
 on MLS/MCS only, without RBAC?
>> The only question that must be answered is: does this action violate r=
ules of accessing objects of different level of secrecy (sN:cM) or not.
>>
>> Please give a clue where to start looking for a solution. Thanks!
>
> The problem you would quickly run into is that you always need
> exceptions in any MLS policy, e.g. files that need to be readable
> and/or writable in violation of the normal MLS restrictions and
> processes that need to be exempted from them.=C2=A0 The way you do that=
 in
> SELinux is to use different TE types and domains and provide OR
> clauses in the MLS constraints to exempt them.=C2=A0 So I doubt you tru=
ly
> want to disable RBAC/TE altogether.

I am aware of this and that is why I want to keep existing types,
domains and labels and not break those exceptions. What I want to
change is make the kernel not dissallow access when RBAC/TE is violated,
unless MLS rules are violated.

> What you could do is to reduce
> the policy to just the minimal set of domains and types needed to
> support those distinctions and leave most things labeled with the same
> domain/type.

It would require reworking the whole policy and rewriting MLS exceptions.=
..
It is very near to writing a policy from scratch, I think.

Patching the kernel to achieve this will be OK, but, after studying the c=
ode,
it seems that the whole selinux was first designed to block access
when RBAC/TE rules are violated, and then MLS was added there... So it is=
 not
obvious which part of the code would better be changed to achieve this ai=
m,
and how hard it will be to achieve it.

