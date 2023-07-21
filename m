Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E3EB64DD
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGUQnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGUQmx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 12:42:53 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555A3580
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689957725; bh=V9dOu9Ky2pqvJawWDuTlA/cc/wSDtbwaMovWTd36Ir0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qbbXeBScNl0vdISfM84hJyJsPPYE8fYFhtSJhaDXP40bv9fh+YA8besHHCyzu93K74QyMkkOnPtiAO6TejIlP+lWcaRZAnUy2NuoGQAn0z/42eFWmyFW2AvxYnyXCH/aYWqpI9vyJyu7j6+WuTWuwYFFddtFoEOesdrLYLzSwiw3W/oJyWocVXa7PkpaqscHObB8i3n4am/jNRl6wnnBGSNuXW+HQxB64EIcUwobuSwH+7xskqvCEE+wV9pN0Hj5JflDcaXFw0g+dEMPpmWU1DAVkCaAnP2ueyWQfmcG8K32b3Irr6yMWxUyyUguw6d94gCiG2ki76R+S5tC2jwE1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689957725; bh=shf7tvNtnnk6qZNEMOYpWN72RKOJ91fE2HIopW1AYDj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IGtYPa0pprgT2wRM7CZK6YRMXdODN8ETUpB1bYFLLbIP3PTy6kQC0/uqhKZx1s9d+KPHrt6vif0mtvlxBdNf9a6gvifjBkr6wBK7Cj/7Snz57yKtMPFHIefDz6LoKjESwmacwUptgzAbE25/qihc90xihWA/a0wt0PMgyxTGSiF4JsovA7FXdBRz9rjGBQLLrrwFTE2i5hftuYEv5aSwGxT7ehZG/jrWzQYThX0ruKqzY8KhY4hwnNMjoru4uuNt56SSudQOpMGjd7mE8P/KbGo34UhQWlLDAusYgZ6OtI+MKaq/gR9HAGJbeyCdvFqlNstD5v5Dqj25eHA2xxQtWA==
X-YMail-OSG: 2FHoy48VM1mlwbrEE8ShMTn9qIRrRRHE5aVtGc9B3MLESGI0uOE9p25.JLZwCV1
 Owc4Z45ZQwQR_p2cczv504zGiLBjX.TOecq1YUJuZDKrScE7zaPKT3Z74L710QcinQ2QaU9xZ..E
 zn09FEKfy_4FW2.2OssWBp42aU7QNxigO49fMQDKxArBsouBqk5.vObO93Ofm_qgh8Svw_DmHWZ9
 Xc3TT4xD3ztuuDVy8FuIsxOrOD7IQvcd40L0roUigQ72kf6B8Uv_DMuPzd9Ms29ifVU6KnEmOs8_
 V1IQWQyumUzN.uPzPqwW7l9dG2dQZNLSkgBdK5LDHk5h6Oiw1d3e8x3CHR3T9YQ1yz45tohCc56s
 qIIfD5J1blnfysQaV0hxp32WS2hhR1sNhJlPPUUtx31MHOUBnb9Zgd6pOBM_EuiPpYijvd1JWDE9
 XiDbtutJ7L7K2iND2B2_AX6Bj.V.bBGMs.nRRusG871KC1f60_gAfV2W1ltsLL7FBv7ug1kNcacn
 rcY53XdTz3jDP4QdlulTLaHEXe.lq_wHA4YhiUrUyx32V5G4e3QrWRMAuSrVb9CwmWfIKbP57dzu
 0yuR4y7jFmyobWvLcvTU.8x3nUEGJzLZJkQwqdjuKbuxJlWC5w7ruMHQWY1Sys.pXvqinZ5WG3II
 UCp_bBZMmOXK8LM8zi7sfCrIKagQpYkotZ_9pUMOSpkuUc.euemdFsADMVMXR2meYs4b4SqvCybt
 XGFDnT80B.jebXOuZWgKnKtCEFNg2oL1eIa7if7dV_pBA.zFZ50UzOByC1bK4s_.iT7akGn7u7Uz
 bxganHcDHdQlwKaIsxbvQikA8jzUUJR8PluZLRUBNh.I1K9uda3i0kVQSC4tzXdA5CcJAiEVJ3fZ
 VKIXOKNXpeOTp3FmvzrxUFCoqEx8XJw2v_78OxMRg17a.AJ90UMKB6jOvuyc0SKKRge_Bcu0T88.
 drCZ9Abalkxt_csnYHmhX0uQTllpx6mikiJ2Ie64XF6rEnWJDxCITy9xn1xHE0eHG2b121SxC_pe
 CQg2yp6tN0Oz7Rn3afA3AviWTvyZY_Yo_Pu87JqEDFPcVhu8zjMowKv2hOtP1nErACfvRMmdgLp.
 JvFGjmwTyOBOfhI28NicPdaup7WvBwFiHBKfS6Bs5RzarwcphZjRHXqslsE89uzYl8FA16Ke5Gzc
 3IgeW47anD4lYveeHmWI42jjE7CVzFDfyLI3w7qdEGRRm1.4VJFlSdhT9OV5wCtIIOA573dHCP80
 dqb8oyrXnGnfki04CghliU9qix_BYmb5Uj1OfCMg6SVjjD8s9biDme0O81oaGyhhMH4qOz4R2n1s
 Yo6GYGBrOkhjDAsuDDbO4cVh44JuU0xS2ZCSgrUZadJihUKCtr6zAdKYVogKB04qXygXUoi3wIlh
 hFt1LM1SfE5BY36N0y00IVf_Lzv0Sw2H7Zmh5AVAKPRHVNX0IwilbsTwFlWTgoOipplV7iHrA_.9
 9o6Sywq0VSWNyoeJY9Ybe8pPYV5h14t3elcu0r7IlekzL7ehq6gFVIDrl21bfSgp9TFsoMpI4Czp
 6vfOVOnNmLhzWStFCkZOGoinZYjsvx_1cAgdmhSax4osgbO3jJEU1oZ3qmSmArQ9dLrKt26BJoGX
 f8nleB0YZLijgaw7jYHATpeldB2IKGK3KA1jRmO1p9OYaJ3s8bBXD3lYI44RT_zcz.7urNNwYgOq
 Sw7gcXwyuqp3T1ZEG7DBEMDrJlv4o3.zVIMwGlib50N8wtdA9fUM2l5Y7p8CFRIefuUoy21PRTgq
 FtqhJEj6UpIZi1lalQOCOHwHBKfn8WTObBbdGvuSLLvTZeji8MZUbRYHsPSGwnHVAIJS2xaS57Gd
 JHMwQXfVcUDAC8S4J6ALAVQrHbzbVZRz0HaKl5bmEq25ZMC4r9aaCzVcsufERqLPMXjoCQf7hwVm
 qUYAy5DNBASIN31SFTP6qbfDzNwL..yh5GLJyaBzv7ccJC4yyt4cG_7lufhc9V3zUGIhLp9YAG2q
 JNAcebflXs23cu3gKNDmvrfVy99bmAWVxaBhh8RWGnaerRmMQtSMZbo_8OxA1mT6r_1YVsI9JixU
 w0EpT2gRSwyuieqNCPdQrNNmtf7mnNfWB2zY7op63d961uootplVnyk3vfSWJBrE1FTfOenSVVBM
 BjgO5gAdrv4GrP6CS6rYCI8jVCLYVlnv8Mm7GEAqJ68IRfT2MQaIDVOT2vRks7dxy3haCwXYWYqG
 xdDmquhE7He0U1STNJyEnbP.FnoPLzWNSXv43d8pai0JlF4RS8USu0IhGhdya4UBtxBLK2crRWR3
 rtW07Ppv4pg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0d35e154-3db0-441c-8f0a-9a6e0ee19a4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jul 2023 16:42:05 +0000
Received: by hermes--production-ne1-77c6dd44c7-b2ztb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9db050f78d2d5093cbc6bde4da7a5542;
          Fri, 21 Jul 2023 16:31:32 +0000 (UTC)
Message-ID: <4c4e6d51-1ee4-46bc-b355-c15151b3214f@schaufler-ca.com>
Date:   Fri, 21 Jul 2023 09:31:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
 <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/21/2023 8:34 AM, Paolo Abeni wrote:
> Hi all,
>
> On Mon, 2023-07-17 at 16:27 +0200, Paolo Abeni wrote:
>> The only
>> remaining perf-related pain-point I see is the indirect call at the
>> security_ level, and tackling it looks much more difficult... :(
> I spent a little more time on this latest topic. AFAICS recently such
> overhead has increased due to the bpf lsm introduction. My
> understanding is that a major LSM and BPF LSM simultaneously enabled is
> a common usage scenario. That means 2 indirect calls + 2 untrain trails
> and 3 additional cache-lines used per hook.
>
> Under the assumption than having multiple major lsms enabled
> concurrently is less common, I hacked some (not exactly spectacularly
> beautiful) code to avoid the above. Basically, after initialization,
> for a limited number of hooks, it checks if only the default major lsm
> and eventually the bpf lsm are registered and if so, converts such
> hooks to static call[s], using static branches.

K.P. Singh proposed similar changes recently, and Brendan Jackman
had something in 2020. The performance benefit demonstrated has
been encouraging. The approach has two serious problems. It doesn't
lend itself very well to special cases, and the code is incredibly
ugly.

>
> The idea would be to keep the above infra usage restricted to the most
> performance-relevant hooks (e.g. one-off initialization or
> configuration  are not relevant from that perspective). For obvious
> reasons I started from a few of network related hooks ;)
>
> As said the code could be more nice: there is some quite heavy macro
> usage and some duplication I was not able to avoid). On the flip side
> it shows quite measurable benefit when enabled, 0 impact when disabled,
> and it's available to all major LSM, except tomoyo (but even the latter
> could be accommodated with some effort).
>
> If there is some shared interest for the above I can share the current
> status and try to cleanup the code.
>
> Any feedback more then appreciated!
>
> Cheers,
>
> Paolo
>
