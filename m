Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD97C33CAF
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 00:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B6C20728
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 00:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gK0l2wZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbgAQAtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:49:53 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:38315
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgAQAtw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 19:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579222191; bh=UFVKs+mVKSnxXr+yxt87hQVWt+x5+3ofIhWbMEQmGsc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gK0l2wZBtnG6tNOS2CbKeUTMkzZrAv18E7gpQrYr6vuDKq28bcVUKvBfrROb+RyIcFRFiWzHTOD+GfPPOwyLQ5xOqfRUod+LlRBYNeBobBqv+8+nIaPsIVrMYsEZCsnt9jjaoRZOtLyh3fH/U1xS6T9z3uBEdbtSIFYtFJbvG6fxo30Ky97frDFXYFHq5ycDq2fpzbK3ddqD8ljaYWPdFmlbdozgxz9SQvBcN6M9/q+wWWK0q9neinvxZ3wdT2/VlppOD05PaYXJY8B5YF/VWJ+rKmvLrqer0jd9HxUQpCgF6oGESfkIiqrx7bg8jeq4EgMcRTDAGdBGtwyM75zowg==
X-YMail-OSG: 2wFFJWsVM1mPtry3WH2pSMknugwGbNhkZjS7JHd3_QgTK4qBIKpbyoWuFmW818t
 29g5CyhBzMeTa5CpEkX2xtsIRZh60S3gQ6zw6LhzAvHt3M.TYmXyY84gTNz3IKnWi4MTwGEv1luk
 DILZ8kZB0tl9CUACi6W6lJXvNIcD._JrFHs97Lul.1mTsAEulOesp6chkCJ3lq9449jdTzchGVuA
 YtVzJTDnfaBYZh7ssHHMKT8RCz3Ud.1JcfohXRLhITABob0.JEOyuqspQijOLcETOq4Fma21BcJd
 _6GMuLQbJqqa7dg_i5.Xn41U2xqvCONpVfJVOeqa8eVtzTaeN9Jez2W_hfKcpV4Lrw7OpCEPYxva
 CPZM8VxfUzqS7T82V4o1xCBxK1ovy.EtJOR98kmH5K31xYhzr.f.puHfbcB6wrGhTfL6ppLhON0q
 j86tPbbtZW2w89Jl44pSonJJgz6kZyVntmfld.61X_mznnZyr2iumB0ZG3IogLV0gi8nuQuTcpUL
 Ce1E4XG_XErQGGPlNW0dWwqIc3hQF032TOdPV7r2qtC049NnlxcGgDnZWacEYyRaEkmd8KHwlAlF
 5hnUkC_0s3lgbYajpJKPwg.ze0jJZejQzoVb1OYwpEUS8XtyOmEHL2wydXA0TFsKrvKFh2.gtBQU
 _YpAvYlMnRo1VV2R0rJ7UNpvLwBxAXTn8ERsmJBcIbfgi7oARDyYla2.9O1I6zmr.2h9fbjZzwLw
 NsIlQib2MiclkVfI5AQezy5mZxwcdLg3pArfnE014z8m1MZUicCQVF77qCDAzewEi8XUs8lafikj
 kB15EkMMv3Wr0fjnEr50gkwC6bMG0EwLdIxjWE25lx6iT.v2jIDlLTIIx4pmin4bJoQV9FkwUOmR
 SJpYsrRFGV5DUZ0FPrgb_.Da28PKzRUkZp4g374e73TOic8CGEnnPoKhWPsbjehhNOwlpBaLtDkv
 tQRjQLFkP5WtQWXnwizNLPdsu2z1RNhwSUzlt4Qh.gaO2dT4N1XvHCM5lp2GcEjpP2j.w.tr4bfc
 5Wf0o1dN3uZ_kjow05owu5L.O8VJ3iatuOpZU4.1iyMvepY081hJnmL.fLTjn_vdMi3TIHMRR4tn
 9n2xKQ.L0RGsltLs4iRTeUfCOLqlnsaD27iiDFQEzB0N7kNfwU5qsHdjsBJlIHOjWqIXxEcE9x16
 oa3CQQXGBIoRKWm8qPW0.iwYbCLrhgNY6ptR0y96Suvfe52A.f4btZYdsxYBxVfarPD2v_lNNloi
 3j_yS2SrtrOzj_.KjWtLY.JNF7Yn7it6pLJWmYvZxz6bLejgGH01ioJalXB.6PBXTa7p7kQjWhby
 9oq1Z5lYx.DBOYTYNqL4BYsY24cKCwHsYTlTDv9.Suxk3DBF3MBF_O5dg7x3H7vs7gxRIZm9ZDeX
 XOcRq5bZM1fK9OW84_JggqBg8MFwYj8zksHhRsyOwqWY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Jan 2020 00:49:51 +0000
Received: by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b7a3c8f35a435a78c2359899c7815df;
          Fri, 17 Jan 2020 00:49:48 +0000 (UTC)
Subject: Re: [PATCH 0/6] selinux: Assorted simplifications and cleanups
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <bfa5a08c-9e72-5de5-4f57-c89debd94590@schaufler-ca.com>
 <CAHC9VhSGW9OwTPf1yHLea3oN6bRrpawsF4kSSgK1NkX9sXn5cQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <de3d7e3c-c37b-7051-f1ab-cb8e767cbfba@schaufler-ca.com>
Date:   Thu, 16 Jan 2020 16:49:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSGW9OwTPf1yHLea3oN6bRrpawsF4kSSgK1NkX9sXn5cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15077 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/2020 3:59 PM, Paul Moore wrote:
> On Thu, Jan 16, 2020 at 6:09 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 1/16/2020 4:04 AM, Ondrej Mosnacek wrote:
>>> This series contains some simplifications that I discovered while
>>> working on another patch. I believe they also save some run time
>>> (although not in any perf-critical paths) and some memory overhead.
>>>
>>> The first patch is a cleanup in security_load_policy()
>> It's a real nuisance that the security server code uses the
>> prefix "security_". If you're making significant changes in
>> the security server it would be really nice to clean up the
>> namespace collision.
> For all the people lurking on the mailing list reading Casey's
> response, *please* do not do this (without discussion).  That change
> has the potential to wreck a development cycle.

Of course discussion is critical, and breaking a development cycle
would be a Bad Thing. I only suggested this because I'm seeing a bit
of clean-up I would consider to be in the same vein. I was not
advocating disruption. Carry on.



