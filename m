Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CEC28D13
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiHVSIv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbiHVSIu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 14:08:50 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3FF1CB2E
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661191728; bh=oP/N6KS5wSBiE+3V3kkU3OA9huJCowaXakxbqZA6178=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZNhVEkv2hUz2G+GbljbzeSv1YPV1jbo0BeUnlPdhvfSBy1OmkrJtILMkn0ywa/WWXTH1w4MrCeSg7fLV+TYQxPPYZJxk+PdgPdbzW6qe6WxeaiGECmvwxnbwjJnUPwAgQZDEO60Ij2UGeeArX9ZGG2a6TCskeIs0NpIiTgNwUqKUejp+I+AzrJ2euBPvAPvMmMSWRGuDucXAUXNcCBoksNZRQl8iNmOBzsDHqB+L3MCqbwhA9ggoRJ+RSUhMYjCJ2U2Bf7LmkqcxIPEDc1ovLqVGmVy5GxsdtS9L760SpbsQgX8A/37bi4XYgOZa8ttpdOVlJs6Pnlt+Hs8TM92maw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661191728; bh=xHIIhx2Maq2ae2GYaY1gm664Wz8wxC7868TQidcf1xg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WHSXdZ64F9rCJGBcJvERIJ7FvtWdS4OL/tExdzawGRAP8ehuZnGITVWLaeqeI/XMsFjUNJiKFqDOsNrWwb4Zz/e3d6tFX9FizGznfikMyL0CLuGq6He4aWqLfXHX6c7lXoLaepKpJpdUSARVJ6cSSPVg4kzPrW259eJEob3xyhbt8h8hf85Xn4ooPkQ5ZEWYt3rGzrO98CoHx+n4q0gbj01MjOm3h3neO6oBZejaLU7QQLbvbv9yz98bRAaZmw4eHbftOnwHb1KU+jsX2PtKO5qhMNsaVMYp61mjpYdnPYQ+hqHL7A9ayoXf/kgNdmqgFRKEtHQwBTQjiae2Pi+gqw==
X-YMail-OSG: 9H0GSl8VM1mPO4okieEAhGNjcv6Gg43scRXdbxbgbI9vdOEVBlujXlbi8dW_hNd
 c8pt_hBjqweFiC3YIPEXvoIk0seQO9gkL_i_NaOFOUZxjbhRRUShKf_sQd9z4Q99apgvOODID2mG
 _ep9n7gPYVcKEhfm9IT79jj.IrKtJ9sOuT5QakuaRVXu5DCOQVElShLoLmYeJFNoq_LWZ_Tm5HDz
 U_mFjmb.Nw_xS7_edwZbdwCFIJx6ypjOnctOvorDgmKT6r2A4q2Wbhsw0H25zE.JLjOg2ffr5Jrz
 L.bNlcgwuOpAOtQ4isfriVzKwiv6ve4D9Q2CKcT.3pZu_QswsLIMAfRNxism.QGZzoPXC98HDK.W
 VhOM1.vJjkzlr76bURTDYlO7CUz9NI.mCJJNPND7Z9jxdAIeWntdTYLjuxZV.RvFZySsTvVqYT0q
 iz.Mw6cFkgyXu9v4K.TO51RofEyVtUcNzrhu2RhtOHBdVN_G.Fv.8sNTaEUr7uWRR10wFe_CHda0
 5U7RRh2_IgWSNhSmzHxKhItSZujzCccOixg7rsE6cV3APKy20qZJtBAuPvIQGeFBwmgZjuwudjXG
 VUXucbM4vq8ZM2cehNn2Ctf_ABrWSL7NyYEVOdhOJINciQB_Lq4Myi4t3zpN54N5GXwiYbz2t3.f
 fgi1dzVQbnrIT3eqbc.qWMD4bJ_kMYxHkYX0FvLgiwsw_WJz20jlNbtfAQ_WqbXy.9LGR436AiBo
 qaPeE_QXbUrG7TYAPeN51ME43_kqkq1CLvHNPMtBpPT.Qynf38fbo9e2knQnxeJ1dbaLDpOtthxA
 fjzxfwM2SCNLi_JwR00xN7Qi9tVLUor_525HdPOZxk8IRcwAOiFE54iE42nNhOJRXR0PPfcGcCIs
 QWsPyI_z1Gm4aMxCFQNv14n_rlvVIyw5VT6T4BcavQWKleo9Go1aMoMA7HaRWA3ArkZYpvYzSJ21
 ESTNFB6ON4nHV_3f6iTnA9cK.TKlGDS_Ml_QXSqD3DxXcKjUYhnO8vnSG3M1xhmsmHpJIgWahACq
 MeEIPoaNIYw0gARA3VkdloKZSHV7wDaYTPz1UDubAokk03lA9vMpyCJbT7yBdNVV9aJFROK9XKTL
 SA8oNrfX2iYEQEHBJTMXbgrbXYprgscACTyU_nvwYtgK1EVkwrj34BvVm96s8ZPHjLYB5_ZQS655
 xIN_XRlwehUlbUUG6dC7MWshzvp15VNbAlZya3bpXKZvWj0Ll4Nz3M7A7.sw0v0DSAVQmVV2McYh
 ztz08nnB1Oh53QGq.RCu9VNYitw0GFIXF8P6aQ8zO5J6VckWpoUOWk6UYO3fG1YvR3MKE8o4yp47
 mN_1vrP0Z3AGu5g_tXC5PCsDmuSSb8Rqk.a7r3tx5Pgl8bMhgUE9cEyFq9nPP7TUU6quGtZgJ4Y8
 S_p.NkUPXo4l46Wb7xdRpVWa830RB95ipILXCalNmykjswOC9Bg1SjAx1wvce8KM8ApnUAcrDqpE
 ThGpV0B8PkXQo2ZjhJTo4IDaXFvyfAdgZvusHgN9Nk2Tia9i1tEg3lWpewXLRR3qSMphCWlk_t.u
 sXvs4hYHIjCMKW62tzHxNxK9zb85DkgMb5uC9kSnMOmoX6yu4HAq0omMMxhUMGePQs6Psr6EemNZ
 KXmowqITrfwnrUz2HIjgwo3SjljuRtYh7N3NNmWdcj_w7r2IKHnTIdOMHMLKbviAXrlty51M1LUY
 8Rq87vbXI5mMI7eDInhKH3CKl.E8dxQPmgA9vAxZtfODmbymDurzcfJogFrvgjybkWTCF.OcWjGA
 xJzfZF3zjIkDiYwtgXNNSlzQSl5c4Ra7UgfrF3JqMhcBLLqusHL7hvoCHVo8CDSLGUZcx0_UWwfT
 0gq4FOR57wp3cf5lveY6TWNkqs0M3pV6AklIzGEREaTmdabdIo1KyxK98EJ5WtyOG1o516Wz26sr
 sEmtmChNpGChiPGUW20U5Jl3t16gpulpb4F_.plnIU_oFFIWn5xrQuT5SxG_HjelMPzwHqpKvvz7
 U2NvAXIWsu.k1FPLz7swdp0fRbL3kYIpm4erWN8FZYot_nW0FSYHPy1npZWP4YnIOt0JrS_wvdjE
 smWsKyBss.X8mrqldsIbdXaxyfnDY6x5k2HCu5a35eIb7x_Y.ieU.yX8nchCkI1qiVli0rkdgEK6
 YJu65Oj1wK5XqN6oXuRKjrLyVtq7TuVCxn5T4ixUTVeK3fhmdCIiv97gLd6JtWWXHUGrAXeN5A1w
 PV12zeqG2d2TFmh2Edje1ijbkuWokeIQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Aug 2022 18:08:48 +0000
Received: by hermes--production-ne1-6649c47445-2j6hg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4827bba04b7cf527f3d029421a1e1057;
          Mon, 22 Aug 2022 18:08:45 +0000 (UTC)
Message-ID: <88819e59-3137-e2ed-818f-3244683d4dcd@schaufler-ca.com>
Date:   Mon, 22 Aug 2022 11:08:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: SELinux testsuite on 6.0-rc2 binder BUG
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <359d1273-135c-33f1-940a-7ff570a4fda7.ref@schaufler-ca.com>
 <359d1273-135c-33f1-940a-7ff570a4fda7@schaufler-ca.com>
 <CAHC9VhRtO78=N2acDrsMqXE-oSWGmPGRPqRRwH+CPZy2ZQ6gMA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRtO78=N2acDrsMqXE-oSWGmPGRPqRRwH+CPZy2ZQ6gMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/22/2022 10:51 AM, Paul Moore wrote:
> On Mon, Aug 22, 2022 at 1:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I see the following BUG reported when I run the SELinux test suite on
>> 6.0-rc1 and 6.0-rc2. Is this a known issue? I'm running on Fedora 36
>> under KVM. There's nothing fancy in my config, it's lightly tweaked
>> generic with the test suite modifications applied. I've attached the
>> config just in case.
>>
>>
>> <4>[  471.300818] ------------[ cut here ]------------
>> <2>[  471.300822] kernel BUG at include/linux/mmap_lock.h:156!
>> <4>[  471.300842] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> <4>[  471.300850] CPU: 6 PID: 4666 Comm: service_provide Not tainted 6.0.0-rc2stack+ #1380
>> <4>[  471.300856] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
>> <4>[  471.300860] RIP: 0010:find_vma+0x34/0x80
>> <4>[  471.300869] Code: 48 83 ec 08 48 8b 47 78 48 85 c0 74 18 48 89 f3 e8 f1 85 fe ff 48 85 c0 74 12 48 83 c4 08 5b 5d c3 cc cc cc cc e8 e2 5b a4 00 <0f> 0b 48 8b 55 08 48 85 d2 75 15 eb e3 48 8d 42 e0 48 3b 5a e0 73
>> <4>[  471.300875] RSP: 0018:ffffb5f041cefa18 EFLAGS: 00010292
>> <4>[  471.300881] RAX: 000000000000033f RBX: ffff8fa55ce76810 RCX: 0000000000000000
>> <4>[  471.300886] RDX: 0000000000000001 RSI: ffffffff9e68680f RDI: 00000000ffffffff
>> <4>[  471.300889] RBP: ffff8fa64175f700 R08: 0000000000000000 R09: ffffb5f041cef798
>> <4>[  471.300893] R10: 0000000000000003 R11: ffffffff9eb44b08 R12: 0000000000000008
>> <4>[  471.300896] R13: 0000000000000000 R14: ffff8fa64bbc99a8 R15: 00007f61f5cc2000
>> <4>[  471.300900] FS:  00007fa9a3afd800(0000) GS:ffff8fa6bbb80000(0000) knlGS:0000000000000000
>> <4>[  471.300905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> <4>[  471.300909] CR2: 00007fa9a3c2eb50 CR3: 0000000059488004 CR4: 0000000000370ee0
>> <4>[  471.300918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> <4>[  471.300922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> <4>[  471.300926] Call Trace:
>> <4>[  471.300929]  <TASK>
>> <4>[  471.300933]  binder_alloc_new_buf+0x4a/0x850
>> <4>[  471.300947]  binder_transaction+0x553/0x3120
> Yes, there is a problem in the binder code.

OK, thanks. I'll proceed without the binder test.

>   The good news is that a
> fix has been identified and a patch is working its way upstream.  I've
> tested a prior version of the linked patch below with good effect.
> Unfortunately I was still seeing some XFS problems in the test suite
> last time I ran it which I haven't yet had time to investigate, I'm
> not sure if Ondrej is seeing something similar with the XFS portions
> of the test suite.
>
> https://lore.kernel.org/lkml/CAFqZXNuOvt_p0ZNjh89Vt9sGQ=CE5_GLr+XOT6OkzxcHdEHgKQ@mail.gmail.com/T/#m49642734166118c4666b0d5f84f4e9f96aeda12b
>
