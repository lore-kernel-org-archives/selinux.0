Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2A4CE681;
	Tue, 15 Sep 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504999; cv=none; b=LdOTphCUTUuSuDbjnwCH+x5YcphHpCU+sg7LIq2e6c46FH5OgB5Kr76MMPxHRiExbH0/WSjgMFmXPTLXvrw5RvAQdec+BVuZ2PUmvVFa9k9dlTJhexw09HH+vjxX37LnnxGGz887H0G8jrRqn4YstxswvVxQLOJTC/G9rbnwrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504999; c=relaxed/simple;
	bh=0vIflhtXXxOwOBEDRe71mQNwlgm5iE/KJItxt8teBsE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u5pkwN216rXtSzmFkwr4gbn589dSD+TZAIhz9YdWnBtwxzgmDB0VwHs7WN31z6Nm77WqgvluAV8fnFCvLAJhZs6Q36zqrPhCVr+o5wJBbpWLZHiWbfw20tGzwqFlFhRU8YyUD8qUGr3Zhm6ifkvPDM0PrsQ37vWLPgIdOfqh12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eC43FpzQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFTfdROm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eC43FpzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFTfdROm"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B34087A0157;
	Tue, 15 Sep 2026 16:43:13 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 15 Sep 2026 16:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789504992;
	 x=1789591392; bh=15pOBlFMsh5jfKoNMrL//3KNxWvcFV8EfGKeQla5sKY=; b=
	eC43FpzQI3LRK7U5lutYM/Ets47K++Iotu0sPzAGHMZ0XkaYHvZMdYSAsqWuj8YM
	pS1R3AHUZCdfZROFvkJYYodJkaUspravVBFrIpjnSmJnemrbNdfnuOLO31kyPV/j
	qwaH6tHxiDxn2arKPZWMeNkIrTATNXyq3mMpO3/VQjBaOlBo1XAQRDJCOu2Y2Fju
	c3NEFfLw7xHa71qlbJagKAOqroS3Brp04tssU+C7+tagGOQPr3XAqvYVUWpvBWpZ
	07bD8yLa40Aa3TGrlw00tHxQhlq2rawDAkH2YzCab88RJn5ANKvZagb1zNk2V55A
	FXgVveCHm++mZVyNmOm5aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789504992; x=
	1789591392; bh=15pOBlFMsh5jfKoNMrL//3KNxWvcFV8EfGKeQla5sKY=; b=m
	FTfdROmnjRy9O0gkMPdWKSto4yG0z/zWGj1xhW3iBzORXg6+Qtw/Aah98yRHpM6M
	dGiwSm97Mjas8WylnP3JwnoV2SJ1rOyyWVqJUIBkrLvhXTXtcZckSaY2PsJlN4xz
	Ci6XM6J+i2QhLeJ094pgUebybULluTIkG0MhYFS42XHdrMCSslc/wPO2rqOZsx2P
	XWu4eRjHjmASZNklEgEUqZ/lr/WGkGb7J26xKfaE9Jt8gjDUlQVSJkP0qv0+JF2m
	IBEIOfP/rr2/6NkX0EQxBMJcu8CyXt2aHJUFUJlrfUY9u248WUL8ZrZ6Mb/gwcvX
	EIDwOH362F/89RqSw3W2Q==
X-ME-Sender: <xms:3q2pamNLttbg7Vv3oyivkLVZiN-AY2U0k260_GHWeiQWhi2tC_2NTQ>
    <xme:3q2pavzeK2g2cMOPAOah0OaXLCmZ7jn-Lg6wNm1anGKnN0Vp82hHYqSXKTa-3lR54
    Wom-ESWhIB5XMZp0wGO1HDBE2ZqrIm73Xa9Y0fvWk5XXvwk8gPMFc0>
X-ME-Proxy-Cause: dmFkZTFxMghYPF+YRfPPYYPknJQjcOeaaG4ChTx7OF/GTfAYXJumfELWaQ15UOtE3kfYWX
    cIqMqfXou/29BjJi0QYlY8BSoFAC8C3IaaWm2k5SFlzaEKb6BFCNfrZsEMX/6xPjYRIkVo
    +cSQrDFEVqhjIy41EMuR3Oz+CdEOytfazJHWjbwS9Lh2vvwfE56Xv4zmeCy95DhOeNu6Vw
    33WWzcasVwmRS0e1edFWMe+sSOVZQeGSxcrHdLKVRk+MQb/pkVlSCb2NWEOZtLD7mindfG
    jDQLMsaNC6yKsX2CO4LhzGT8leLk7jvTkKaVgpq2tb6UeqMQulMYTgNMALz1QKs8EAhII+
    G124qdDtSxYVnZ1oKNMa2/Pgdh2CWaPLegLLLigIdgAd2WJLn0HvemwQD2rJoor9s8HpZW
    BMlPLTeOyxuHHk9Rk4yPh/69lKdsBXehZqg2cqnwLNG56gYuutUNilLDwH9IAB1PnDvZ29
    BMavl7wuqWq6SIgV8oNvtncJBTdrg0JdsiGXW0huKuhyPCCkPs8bvh32ucltPwYWMhvl0V
    RmiKl86883a9/HOGgTBITMq6gxgAKiS5wEpxOYjUE3ZGWMCvW61DqWTEVxiQTN8kSc4uxN
    hjIUybdKGYU+M5cW0LQ6LtVOVBQyyLvzmi1HhSH1GD/PuVonS0e8hOJtR1Fw
X-ME-Proxy: <xmx:362patvqCaJaV3sqL9f3L978wacVHOKH1tNfS_VIBN6bIOHYVkFGRw>
    <xmx:362pahbgTeILqkU8vmztCeQETpjwSdgWiF9L_UExWjxLjjI4eCsLJg>
    <xmx:362pavyjzAijm5H9rhQiq8HyfMULBNx21V1go7_dh0EZyLsgL8GpZA>
    <xmx:362papg-lE2UKg_Y9rp5YQ0_5TIcBIMP_HiGjGRJMWd4wyqjrsw_bg>
    <xmx:4K2pakKzC1-nG3iLmN6wsxEitv1sgYkOwV4WJdd2-6qejWpDerzonuOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2BEB732A0081; Tue, 15 Sep 2026 16:43:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJz9fPW9cgrZ
Date: Tue, 15 Sep 2026 22:42:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul Moore" <paul@paul-moore.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5a285431-9b60-4d87-87c4-a5b52021ea65@app.fastmail.com>
In-Reply-To: 
 <CAHC9VhQwkwrEgnuyP-u_NJxmjgy3Zp9XN4cAqCMqH3ugV+jrsA@mail.gmail.com>
References: <20260915195728.3519469-1-arnd@kernel.org>
 <CAHC9VhQwkwrEgnuyP-u_NJxmjgy3Zp9XN4cAqCMqH3ugV+jrsA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use explicit 64-bit division
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026, at 22:36, Paul Moore wrote:
> On Tue, Sep 15, 2026 at 3:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> On 32-bit targets, the division of a 64-bit integer by 33 causes a
>> function call:
>>
>> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_=
read_class':
>> selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_=
read_perm':
>> selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'
>>
>> Replace this with an explicit call to div_u64() and div_u64_rem() to
>> annotate that these are potentially very slow.
>>
>> Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from u=
nsigned long to u64")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  security/selinux/selinuxfs.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Thanks Arnd.
>
> As sashiko pointed out[1], since we don't really use the full 64-bit
> inode space, what do you think about the following fix instead?

Ah right, I hadn't checked the actual value of SEL_INO_MASK, and the
description of your patch made it sound like the 64-bit space
was actually required.

Your patch is better then, you can treat my mail as Reported-by.

     Arnd
