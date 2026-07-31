Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BA371D01
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538102; cv=none; b=aDkSeJCh/pjx/VVjaY7csfBoHvYLM+5x5yPtKRuTLPdx1iOCS91jSZ4NUoD5AVf7gPVMyuDMwKE4nqtUtgN1BtdCzYtNymahhsPkr5v6+gqjJt04Sd5zADLb24C6tkUjEbLTg3qg7n5UZAMi5fZKBnq4QjbOB94NxC20IqFFeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538102; c=relaxed/simple;
	bh=YAt9eFIIe3D3n5l6qZabScoWy3yuTrRj2itu8f37lrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Tv2UVgjLLVBFpU92I961z+y98lXaPWszHU/SRQNP8DAYvAp94k2NoJ7Qj5NJrpHiUN4PMVn1jEK+94aDslC7o0ZBh9yW7ZWlcGiEmuUV6PgTVmnNBz78atLpTiXL+27amv5FpOrOFhfDYjXHnFuHDmS29Q2YjVts2uwu7hVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TXuNGcHW; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TXuNGcHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785538100; bh=YAt9eFIIe3D3n5l6qZabScoWy3yuTrRj2itu8f37lrE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TXuNGcHWAw+SGYqH/xIb9+SSDOLerMhureZSfMjykJuW3Ysxp6ObjuL2kzo13YdIzq5UtMrowjQIuM9l/jz89ytXUWI5E9GlL+1EkM6+v610creb3EgyZcQQ4SMaAuEvXjuTqAZ6F+rWO1z89bzX76scqJ/ly5U2I9o0ub8uA3uBuBSPH0Og28iCj48+jtHEeMx/yAYiIkjJgm+1IsWDSvjcrnpSHAHNTGhpEVi+lkt/QpL824kwzxwR/Ym9emwaVwaowL+hTt2SE5DkHKvFXimTQ7YgAgfjwyI5MfUaGRp7uOqwx59vUh2te+e3TBA1t+7Oyi2pqeeIHBm8YN8WOQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785538100; bh=96AoV5phOK55RBC9/9PzdNzgWwmCX0qSHzrrrjO10U/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IJ6KtVwiUEK1cD6ZqBxi5Lncc5EwoPs5Y9CWiW22lUhnGsok+kSnce+kG9Y9xuNELuNsCAiNkMtwxrLLfkGicKGl6XZmRgOt1Xyg+Bf0l08cochIqCSSsEYpF7fQ35gDQp9SEjs9PJ/o7RVM6IGdv+7IeIYo81thkYh7pWTz4CK+4ZQ2Fcz4UU5ksaiGaNNpxSQnKe044HQEblEsnUWRwfhQBsZyd+RnLnN8GoCTcHF8cSglEaXrdrRK2zFUOX/kOXBpZNf18H812zCk8R9xiuAk4h3gVJrxzAo7QwuWUJN3Pnzmm8TfedimujAFlSSzuG1KRJuHM3LTnH9IWNOfNg==
X-YMail-OSG: YHJjAkoVM1nbExbT1WhaofDuzzQwMyU89QRdv7cR2RIQJCwn6DPP9ZTUIKkRQdF
 xT_Oz_UlCSAw7c1vgqD0uLC0pF_sk0_vJdvgpTMOtDTuni5H3xnsH_S.fc.Ilv6S8QQYAKpLmEmU
 ydA21HbC2I1ItCn5q3LZU8qCLEWokbEeM5E0KEriu3cdpo3LC70.37bziH1Bd5NcQQ0shoAz_UlE
 PsBRawdr0n8OVh4uINhNO9eDtAI.hDtnYstENakSS9mqkVtuuAXfHjRlPzw_9.0w6p6uAXefcXw6
 XhQswurRqoXC2mVocE3yfPp15hpCG7C8ejviSoZTH5GGDjt0SKLpdvLxqiNBHSFVRKFwZIoCIsLo
 b6P9G1vH8PoYXP.gFS9BQ3X3vWJhKoJ1Ep6C...EI1nwf2vi0uViuJL0EpN4dmuD0L5vLRu5uWUW
 SzJBvo1oaO_8hTBrbN1wFfRq_UVqj_DLIHQPXU65OnvjWR7ngPTCS0h5lW2ETwHDPDr4D_OHZzOV
 a7tU52eS4wipUErgx0nMVxs9SwMEb_dTrFA.eflJbPNRTeGr6PFiSRWk.dus3dwFESU.vbjFnBh0
 a4nNvBGbTrWOJhnOyGLAObaaF3p_BmjoQYD1qEg18bMIjudW0NJLIRW10qIXNuQUJ9gePrGVBYHw
 afVdAfBOs5HUp6aHLAJTnX.TCga7OYYHVYX8j2GO3Zpph2WQg8.q9s80FtvnscAALmaQGA7AW7_4
 9rI6kZV8R2Ur.WcSRyMjOHQPyF2RiOSw556obSFeEAz0hOK_pXnGFLM.s7mwpl5ImLoEzUL4TTXu
 7LbsId4wgrSO9Ychch6rQlC_w2UY390vPo9l2KAUSvOTi3kCrdFelb8.tiV317_GhX3j6Wz.okY1
 mnSvPzqFDjaPgkGSYXiJsFSiX8XtkwML7azKdl8.H5MLhQpgdUagfb2Mh_3A.1_rSnVmoh0OmAGI
 ti1j0cz4RBl_HPjiztuxBiAy1gSpIayk1ys.4TaLcPRksl5cagXIS7MYh.KzrqJeT._wlem6M28h
 xlY2Y6yFpZ8Mgm7JuHrdXkrA3DM01XBAMCorDIv4ONtt49N8Sj9S6ckvXciF15rO5ctxa2a9pSQR
 w_InH_U.r62YJNMfZ5pBGAUImcjE0YMfDK0y7bVXWXZjlDrN_8kl2sJIgynSbWb8h0ZLE1QywtXG
 pTSqiWOTFFNcXrDrJKUnxrWkJLadP8qdQJP5PNxPmLY0IWWtyBTRt_CrI8NBF9lUo4nBIXQ18C7u
 79qHIN8W_pChGYyiLpG7aQdCJVdfMVsX4zbxV1Z7m7T0zYNm8y_IhvW4EgwFFNfC77MLefLvCdsf
 fYu8KU6x3.JGWh5vgrebsq_x3NO1k27U1CcUGSZo2C633eajxXPUasJoisG2vBg1c4otYIG732w8
 LuMp7Bpi_TYmLIFEDoU55fejyc2IYbCQ4ABBVE8vsEuD36y3XuAjiOvShHr4H6pnoOEDG8QxRila
 i_fqx8p1eZMvs.PHt._hHR9GryyGIx48ofEWXU_wPWXL8FEQFdTMHX.y7GtUx2zWXYzaUktZSxsp
 jMDW.eDzTyP_0aeUjqExGH6Hll27nX9qJzhuBwWgUIYAv6QVuyQvKXndKIAHO5MyGc834jurXI3k
 EdO.9vhrCunIP8izzOFq03c6vIiAHZspfi0f19atmMBM.S.c._HV1jgQ.7nuFt13AR0.R7J0JPi0
 s8s.WxzQurLtukSYyAWruJbdfu9xS4adpRjcsxAHLntfNqpUYTfOkGaXlaZJtXxZCEWvat_m5u5j
 OFYwx3OK3L71iPrrP26AuWcGNU0G3haguQF_sJ1E2Tyad7DP.eaeV0wUnxmRuwn3nEORS2ngPXXm
 Jf.PjWF9cX63wR5vLi2A2OJ_4ZzA05yeJXxrMQgDiy33._KHfkNhCMar13YpHMgdwjxW0a1Vjvl_
 waO8O_B4qMVVrzrcStZQA9OtZhAv4.hqEEyC.AmaOgwuUp1c0.TN7iepWCGHqpfygk.RDzi3uci8
 epIHhMGYvkgmrNJSXfPh97LRTZFjZT23i6TpU9BEaTmEXT7ub9nmDnsRNYPHWYzmf7CRmNXTUvIX
 xNpY1aMmOdjKiLpyzgMMgZewKktMgM3czgli1RebJZMklJx9XXlPV.7NO04YVjLXBqToEiGTi8b4
 IX159.23JZ1lJdf0r6ElxNK.Ut75K_J0bBV6Rei0GgxZZnRL7HpDbC45SHxOVudsF2B9.BCt7Dd1
 WIbMQpdn8cTyM6gdCt5E4XOGY08pPGnu8qDhloApOEDNLKWdXVVrRblNdF4gpYR6iCzoJug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58773052-9edc-4e5b-b181-54767b6ce249
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 Jul 2026 22:48:20 +0000
Received: by hermes--production-gq1-7749664df-wnjhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af5aeb6cb25895ee9689066a9446e5bc;
          Fri, 31 Jul 2026 22:27:38 +0000 (UTC)
Message-ID: <45d2738f-de04-43cb-b37f-4370e6232678@schaufler-ca.com>
Date: Fri, 31 Jul 2026 15:27:35 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/31/2026 3:04 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>> On Fri, Jul 31, 2026 at 5:29 PM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>>>> On Fri, Jul 31, 2026 at 4:16 PM Kumar Kartikeya Dwivedi
>>>> <memxor@gmail.com> wrote:
>>>>> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>>>>>> On Fri, Jul 31, 2026 at 3:20 PM Kumar Kartikeya Dwivedi
>>>>>> <memxor@gmail.com> wrote:
>>>>>>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>>>>>>>> On Fri, Jul 31, 2026 at 2:50 PM Kumar Kartikeya Dwivedi
>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>>>>>>>>>> On Fri, Jul 31, 2026 at 2:18 PM Kumar Kartikeya Dwivedi
>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>>>>>>>>>>>> On Fri, Jul 31, 2026 at 12:32 PM Kumar Kartikeya Dwivedi
>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:44 AM Kumar Kartikeya Dwivedi
>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:17 AM Paul Moore <paul@paul-moore.com> wrote:
>> ...
>>
>>> I think you keep forgetting that you cannot unilaterally decide this. Both VFS
>>> and BPF people have told you that it does not make sense. What was clearly LSM
>>> specific code has been moved under security/ already.
>> I'm charged with doing the Right Thing for the LSM framework, and in
>> my opinion it is in the best interest of the LSM framework that the
>> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
>> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>>
> I think the "Right Thing" would be caring about your users and the project
> moving forward, who want this functionality, and figuring out the best way to
> make it happen while working collaboratively with others. Life is full of
> tradeoffs.

It certainly is. Paul has taken a stance that supports the ongoing maintenance
of the LSM subsystem. It does not have a stable API in support of the rapid
development of Linux kernel features *outside of* the LSM infrastructure. That is,
people like you. If LSM hook implementations were spread throughout the kernel
code it would be much more difficult for poor hobbyist LSM developers like me
to track them down when making changes. Changes like the ones you require.
This is about being able to continue supporting the latest and greatest additions
to the system. Like yours, io_uring and the network protocol d'jour.

Please don't lecture us on collaboration and trade-offs. We live and breath that.

>
> Instead of dictating how others should bend over backwards to agree to your
> arbitrary rules on code organization, which they don't agree with.
>
> Everyone you've pitched your idea on code organization to disagrees with you.
> Yet, you remain adamant that it's the only way forward.
>
> Materially, both you and I know nothing of consequence would happen if the kfunc
> stays where it is.
>
> As a consequence, everyone suffers because they first need to satisfy your whims
> on how all code and kfuncs written thus far are wrong, and need to be moved
> around ASAP, including the one being proposed.
>
> Not only is that a disservice to your users, but also people who've reviewed
> code (apart from you), and more importantly the person who worked on this patch
> set for several months.
>
> At least a month ago, you had the good sense of not dying over this hill.
>
>> [...]
