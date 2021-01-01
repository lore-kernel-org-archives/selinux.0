Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B586C433E0
	for <selinux@archiver.kernel.org>; Fri,  1 Jan 2021 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A265221E9
	for <selinux@archiver.kernel.org>; Fri,  1 Jan 2021 11:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbhAAL6v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jan 2021 06:58:51 -0500
Received: from mailomta6-sa.btinternet.com ([213.120.69.12]:56595 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbhAAL6u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jan 2021 06:58:50 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20210101115806.LXOA29410.sa-prd-fep-040.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 1 Jan 2021 11:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1609502286; 
        bh=Uxjglha661kHqfiitKx+qdSAt5nLX8EavmcxtfsBqLw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=lGMfHtDjwsJeYoSXSHDNmgqoz+GKMJWUB/YWSGT5zc3ABGYs9wmEkXp9I4gumgsgclFEwnkW2wkdx2kdJAc5O91aM5GJbVpLEg5wr/4TYA0cqXI2Osd8bMKn6LauZhxRc5CkrVK/zpNyOIcku1A7STbGcBtrJ2qSfnZoNojGIicWWqBCrWq/HMp4mFwJVPv00a4CSK0XEmUeSneCWSOoOqZZHd1u1PrGHjVw1xwpf68jt/39MNJBK2s4lLN58p7u4hd7G9YtPHmISpO3di5KQ+GSTTQPMqyLp0A6/G7Jn6QjhIXgYtia0qMoayttn1cPTFXFVJInvltk69m7iBQjlw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9B661212201BE
X-Originating-IP: [86.143.182.60]
X-OWM-Source-IP: 86.143.182.60 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrvddvjedgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeiudelheduuedtveejveefheekheeiieeufefhudfhtedtkeekkefgkeefteeuveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgslhhoghhsphhothdrtghomhdpkhgvrhhnvghlrdhorhhgpdhlfihnrdhnvghtnecukfhppeekiedrudegfedrudekvddriedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudegfedrudekvddriedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorghshhhishhhmhesmhhvihhsthgrrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhr
        tghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.143.182.60) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B661212201BE; Fri, 1 Jan 2021 11:58:06 +0000
Message-ID: <19d0b6c1856836b9d99008bb33747bd4969582a9.camel@btinternet.com>
Subject: Re: Inputs w.r.t understanding of selinux notification and
 systemcall
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ashish Mishra <ashishm@mvista.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Fri, 01 Jan 2021 11:57:58 +0000
In-Reply-To: <CAP2OjcgmOz1UDfp0mt-jfO9PetYgRvfBGJrrMPCNNBgUubPvCA@mail.gmail.com>
References: <CAP2OjchiEZH7sxKipY0Q89L6e4mG9By4JYDKXf1HUWp0nWPtRw@mail.gmail.com>
         <CAP2OjcgmOz1UDfp0mt-jfO9PetYgRvfBGJrrMPCNNBgUubPvCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2021-01-01 at 12:45 +0530, Ashish Mishra wrote:
> Hi Group Members ,
> 
> Good Morning & Happy new Year !
> 
> Can group member please provide any input / feedback for below
> functionality support in SELINUX :
> 
> a) Is there any mechanism to generate an event / notification for
> selinux denials
>      I came across Logstash, Logentries and Splunk , which i am
> currently looking at.
>      Is there any selinux equivalent plugin or any other way for
> selinux specific.

Have you looked at using the audit log services (auparse, ausearch
etc.):

This has the code and a number of examples for detecting AVC entries:
https://github.com/linux-audit/audit-userspace

Some sample programs here;
https://security-plus-data-science.blogspot.com/2017/04/writing-basic-auparse-program.html

This is an example where I wanted to detect specific events in the
testsuite (you should be able to pick the relevant bits):
https://lore.kernel.org/selinux/20201104164913.11536-2-richard_c_haines@btinternet.com/



> 
> b) Is there any mechanism to block certain system call / library
> calls ?
>     I came across "seccomp" from https://lwn.net/Articles/656307/
>     But is there any selinux equivalent plugin or any other way for
> selinux specific.
>     or "seccomp" should be the preferred way for this task .
> 
> Any pointer / feedback / inputs will be helpful on the same
> 
> 
> Thanks ,
> Ashish
> Thanks ,
> Ashish
> 
> 
> 
> 
> On Sun, Dec 27, 2020 at 2:17 PM Ashish Mishra <ashishm@mvista.com>
> wrote:
> > 
> > Hi All ,
> > 
> > For one of our internal projects we wanted to evaluate the
> > functionality below .
> > Can group member please share any input w.r.t below aspect can be
> > implemented or any pointers on same :
> > 
> > a) Is there any mechanism to generate an event / notification for
> > selinux denials
> >     ( like say we have an action which is denied , so instead of
> > user
> > reading log
> >       file if there is any notification mechanism which can be used
> > )
> > 
> > b) If there is any mechanism to block calling of certain system
> > call's
> > / library calls .
> >    ( idea is to discourage certain instances of container to avoid
> > calling some
> >      predefined system call & library functions )
> > 
> > Any pointers or comments or feedback on these two points will be
> > helpful .
> > 
> > Thanks ,
> > Ashish


