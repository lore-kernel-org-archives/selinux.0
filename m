Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1BC433E0
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAC82065F
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="ZhdzcU06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGJAJm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:09:42 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:52014 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGJAJm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jul 2020 20:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id E2DA1DB757E56;
        Fri, 10 Jul 2020 03:09:38 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LZKSA2N_waWx; Fri, 10 Jul 2020 03:09:23 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 8300FDBB9C420;
        Fri, 10 Jul 2020 03:09:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 8300FDBB9C420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1594339763;
        bh=ffkikoxuTZNCaWLELHBK7IoJqgyERNTu/6sNv/uK+9w=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=ZhdzcU06VtYuutCxsBUHde1Vkp6GnlT4h1tZC8wkWh4gqtHr7RjsHTO7qdCyiPa7D
         8yw4pduveD5PuvQE3rxtm8TNDF6tpfbBstG581BNAbQfwyRvSsQ/h2sTCXV3/b0JQk
         jVTt2K7BCGTfczPCvWq/JIMAWO9E00puzipjCPDhASJXrsLzsrYmTUq+9LHbz6f0cK
         I1HILksDIsbtWR7AQLvGLkUe5voP/eLU7uc2TNdm3pqgAT1dH205ZMHyWeWq1Khj1R
         lOoWjWblThrPBo6177GAy/GDJ5wYDs8zX0GElxzXF1JJbe0BRwRkl3l5QbEc5F2bmG
         W3HFVsFiBhzWQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hNJuULFEHb9J; Fri, 10 Jul 2020 03:09:23 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-5.ip.moscow.rt.ru [90.154.71.5])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 45676DB757E56;
        Fri, 10 Jul 2020 03:09:23 +0300 (MSK)
Subject: Re: How to off RBAC in SELinux?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
 <CAEjxPJ7nwA2qFLYZN-X8V9Sqbdbcx-7e=R5j9y=khHTAsbe=yA@mail.gmail.com>
 <7132c007-b6ce-60e2-b86a-491b43553a49@rosalinux.ru>
 <CAEjxPJ7N16U3HS0GivOJcHPiqmkNL5wV0Nx8jpGbjBBRGeb94g@mail.gmail.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <1874af19-79d8-ed6b-31fd-9a29bd39bc34@rosalinux.ru>
Date:   Fri, 10 Jul 2020 03:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7N16U3HS0GivOJcHPiqmkNL5wV0Nx8jpGbjBBRGeb94g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

13.06.2020 23:08, Stephen Smalley =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sat, Jun 13, 2020 at 9:44 AM Mikhail Novosyolov
> <m.novosyolov@rosalinux.ru> wrote:
>> I am aware of this and that is why I want to keep existing types,
>> domains and labels and not break those exceptions. What I want to
>> change is make the kernel not dissallow access when RBAC/TE is violate=
d,
>> unless MLS rules are violated.
>>
>>> What you could do is to reduce
>>> the policy to just the minimal set of domains and types needed to
>>> support those distinctions and leave most things labeled with the sam=
e
>>> domain/type.
>> It would require reworking the whole policy and rewriting MLS exceptio=
ns...
>> It is very near to writing a policy from scratch, I think.
>>
>> Patching the kernel to achieve this will be OK, but, after studying th=
e code,
>> it seems that the whole selinux was first designed to block access
>> when RBAC/TE rules are violated, and then MLS was added there... So it=
 is not
>> obvious which part of the code would better be changed to achieve this=
 aim,
>> and how hard it will be to achieve it.
> IMHO that's not a good plan.  Consider for example what happens if you
> allow a domain to override MLS constraints (ala mlstrustedsubject) and
> you don't enforce TE at all.  Then what prevents a untrusted process
> running at the same level from ptrace'ing that trusted domain in order
> to bypass MLS, or overwriting its exec type with arbitrary code, or
> any number of other things that could be used to subvert it.  That
> only works if you are willing to rely entirely on DAC separation for
> that kind of protection.  That's more along the lines of Smack's
> model.
Thanks for explaining, now I have understood what you mean. Sounds reason=
able.
> From an implementation point of view, it would be easy enough to
> modify context_struct_compute_av() to just initialize the allowed
> access vector to all-ones instead of zero, drop the nested ebitmap
> loop for computing over the TE rules, and then walk the constraints
> (which include the MLS constraints as a subset) to remove any
> permissions that violate the MLS restrictions.  Essentially
> context_struct_compute_av() reduces to just the constraint logic in
> your scenario and the rest of the function can go away.  But that
> leaves you open to the problem noted above.  At that point you might
> as well just use Smack if that does what you need.  But understand
> then that you are relying on capabilities and DAC as external
> dependencies, so correct configuration and use of those is crucial and
> not something under Smack's control.
