Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86134C19F2B
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiHCCPz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiHCCPy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 22:15:54 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5DEE21
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 19:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659492952; bh=czbZKI+7ne+6MjJjKvFfNixmTf7LgjjXQNZuwXBJjzA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d5kotzC+3wGShNjVdnrLZdv7dKx8DKFLcJ5uEwXU6NJ5DKJVvU94kTzkD4y0bAp6zGYUFmeRO6zHJh1UcShyMcumY9dTooix2KUcNfcKrNfIYJlQYncYhVex04k/pQJiVeWKWfPowH0yucAmsw3hxPkrXhLkTpXCYIHiImoi5Wxx0IdfcIW47XKN4o5wDBBaamxSNPpcoF0x2qrY1tbaAq74jBbJhQ9tXqTpZa4KQ6+r6Gpj8obs91M7E2vqWSN8BkLVkV8WUGyLRTPu0t0kpiZRrNATRqZqVY0qPuoRrO5cZz027kU+WBOx7tpnTLPq6lV4ciZLvBWYjgZrzSApLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659492952; bh=DglI1X8n1NrkrnZLt7ORi7tDLUbXj+hHLdM/bv4vN25=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qtGvkP8Yp+Q816eun81x4q5I0tin/ckGebs4IiR1ZzANBppGQYBdo5DGVDFINpDhruyFaZpfnmvgxFqqJWB0pIwyxxe1/v9Rl5ctPnh7Mo7/8FzRaDm90ffWoY7fSKrwrUyE/NG5u2Z5WNBS1yqpYA9pm4tpjQXjaf5RPR50KNvSnycppxT9RA+PXQVRuSV/h8tWkicHaPxsxJF3yVL9e+rP6xQfCb2UhJ4qSgf7DmvXiRVPDXCKoctxNDO+RVUg9/IXloSCZOBD+fJ3lroDfTGhmiAy9c6oC5rLG9gz/opbJT2PtOFOVcopvyrSiRdY2Bc7tugMn2dwwR85A0R/OQ==
X-YMail-OSG: s6.kH7wVM1mcz0XBx3KBfLnoxY4jtFJVIIdv5HipgwTjVP2bc3zJS2l6VVX6XKq
 4cRFm4nt05jcwGoKmc3WXboIyVaCKKupskrBxwisHokqmOqfX8dHwIMd_GbsKWNoipB6uCY2V.wB
 kAcleJrxUMfnncHJIeNoyS9SAykyJhCLRSYw8Cs.2WHhwRu2l9P5Nx4EdA6O9njLJkLwhWNrEltN
 vwsLEFqLBI.sIHpyHjwnfACUYGASTUCm6VItOupESgejH1rLkYOySvUlpfoZbr6eDQZoe.H3vg0g
 xmJYGj3H5XQjhBKl_kKejcMYypCV6hGI7oELNP0cJptFmRoe6ZPTuhw..7CteewUytDUre5mCSf6
 BI8SvrsTbZ82UcXf6Z4SRSfHBu3u48l0wmilUOpoLWoUuloMKWJFmk33Ze2E6vYLxVPDlYmT.rh8
 RcsI7ItvSWvWeaBsaRX.iCOMque6z6nvLQg_i0osUhMXSB7kOcoo6MTPlvY06ufTe775ZeZqcTMf
 rcuyhjpkCl9w8MmD4_xbkIF9Ay.5MFXUjkufW4d6XaTZ_scociXLb57SMcDuYq4nG2iQeNMO1NQG
 RwkY5EVVQaLgin06xW18g13oWHvR7b5r13kCSv3.eQeJBnzylH4I5jZ5gPepb7sqv44VzYBJ8e49
 p5qnK7zmQXMOZPFkZ4gWXTbJwsMQ67STYXuMjcWp6jXd.xP9Hoc283EWsACQGSvblZ0_UMMXbJay
 Y3l7hMGdg9XQXZS_4HswjvFrBY4Rg08MN8CA8kKFjbMFFZ18MTvB7DLuFUikFanATFoJGgcKgMGf
 YOc8I5pnD7rPBHDmiT7ot.Qjxr6_NpMoNOiAGD5Hxj0Kq2nDokoPZYL2XkUhBKa6cqgZiYUoVJhZ
 8IL4SyrbmL6kysNsVdpf8QNrR8PmVFg_anQK1.b_rLin..D8tg_1CW5q6Ztxy8sB8LtI_6EnfQ1Z
 6QvOrJoH2KhhrDxJA10fDF2gLq9ZKXNmo_YODjURLWLLIBrentvesKH9DaAm3oPN0KAeJNh0SCji
 ZN3k1.q_hYD3RiMaZHjWrkzU_lVfUvUC2dennh8aw1M4Xap2GcPrNM3rWXaNJRQHdrCyJbTn5xCi
 qub3XhcVhhlquVVx7zK.M6N08qeSeWSsk8I_FTeafoaKm3273roZOb1Uf88MoZl_kF0nBfoIQGxX
 B.1.MynN6kXTJ_RAGyQUKIizPksAiHDjYdCSs.CFWX1BW5GAbENdtlYV.eG62YyHLmzYtZRX9BJk
 my8sB2jNsILNncmgz1lFGmTeOO6otPABxYj5oKGQB7pHdBw6tNieZYOz0DpqjpnHNv7BjYWCqI3G
 oKh3SOeXaUE5miSNKgE7zlQfGQn0qWSHhwseY9dGpOlocQvp72HgZ7rVMW5sEV8sy6YnuGZzb3sJ
 02b76upShzFssKXGJr7V5MZLdpZOcPl4noPDhr5d4YbJDvwN2oMC2yRAwq0mv2z9b3sYr_0W9d5e
 d5kRlNAO_12N.3EQamLTyvSmOZn755MCXimCpYly1Pymj7HehFUqqPGVOvJjb80yRHMreDvNZVSQ
 Z9FrS_h8UDMC6QHLqTFMTivl_UDsHRdz.PZV2rZ_WBKTqCEuMWXcSytJTwXr.IJiYmUpqB8nH5Vi
 BRWEDghKIL7VQMItrC8fGxcIlHOsk2z6QVEHlxTmC5t63s8ZsfaK9gSRtsKv7JegbfPMjKwkOUiN
 I2QCF45.EuC_fBH7EJX9qb8NwUTBqJtiEQqBP0JclBXaXUORKYBbEi8W26eswx0.12QGiwBRq_dG
 HSfR0OYX2qttX0.Tap.hJ31btEQAMCI.Vct7Q2I4pCAQZ2V0BOOMQJVNUhGsptUPn27CnMFYueoP
 6ftDqEMOg.33Mr11WCzJO__Blh8SIy1pP7QkIVNivXfYIn9bEO8aiYhW.7DWaccwnCvkwEnp_6ey
 F2uMt9J0ib_QdzzuWX0.Xw8Mv1cK_6x6Yo4VtIxSJje5S9.h2tbjGuH_pXioJFj5P33K9sepBoHj
 aRbGXPyvI5IcbOUf5.kHhHevlifLLrL9qNHSWC9AutLe_1ZPnVNNL1oiX6s.a5lXAhn6.5Y5pzeT
 w5gHp5fW7PZJ4Vo.EEk5Jq3eF0USdV4cPsMSYpJ7bDwrPRiawBb4QlkRl46SvKA_EIKN.qZSMw7V
 e._1wwQ8FsXY4pZmRI716RcQxPzegsG46.BLxHvtknrPQPLx3t8Gjb88J_5UBpinnLnj.4HmL8fE
 uaVDw5zLy5.Q8aMbsD6Bku1fri19uFUc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Aug 2022 02:15:52 +0000
Received: by hermes--production-bf1-99ddd9c9c-k9wng (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f0e3073cc048946dba34eb348525059;
          Wed, 03 Aug 2022 02:15:51 +0000 (UTC)
Message-ID: <d54b304b-ac52-7bd8-5444-334cad48bfac@schaufler-ca.com>
Date:   Tue, 2 Aug 2022 19:15:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/2/2022 5:56 PM, Paul Moore wrote:
> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>> patch set in the LSM next branch for 6.1. The audit changes have polished
>> up nicely and I believe that all comments on the integrity code have been
>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>> There are serious binder changes, but I think they address issues beyond
>> the needs of stacking. Changes outside these areas are pretty well limited
>> to LSM interface improvements.
> The LSM stacking patches are near the very top of my list to review
> once the merge window clears, the io_uring fixes are in (bug fix), and
> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> and SCTP stuff can be finished up in the next week or two.
>
> Since I'm the designated first stuckee now for the stacking stuff I
> want to go back through everything with fresh eyes, which probably
> isn't a bad idea since it has been a while since I looked at the full
> patchset from bottom to top.  I can tell you that I've never been
> really excited about the /proc changes,

I have been and remain perfectly happy to do something completely
different provided it works. The interface_lsm scheme as implemented
is horrible, but it's better than the half dozen alternatives I've
proposed. At least no one has pointed out a use case that it can't
satisfy. I take full responsibility for mucking up "current".

>  and believe it or not I've
> been thinking about those a fair amount since James asked me to start
> maintaining the LSM.  I don't want to get into any detail until I've
> had a chance to look over everything again, but just a heads-up that
> I'm not too excited about those bits.
>
