Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C626F2BC
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275517; cv=none; b=GoqrO2NOsJtNaVzYsxLjE3YCi34Xt2pYTzUOBjw57JjGfSfo9yyfshqoqHcLMqAgAopCFNGWbH68hsjV3Opo8mOYrH4RUvDTczQvYw0EvaOGD6ICLlM6jgttrv6XC2OYklzGoPTOVEdQO97ghDTE4nDmf2+Vi8zNHBy1RhxK6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275517; c=relaxed/simple;
	bh=O3eXYFF7+W5lu2bvnbucc5iMVmnt8lxmZhNkom32uq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1B7iG3yeQxkM4tD6N2PAD/m7uDwqsmp/VgaiMRLp2QcGlqL6PL9FMl5YxGEXzYGxqVUp0WLF7pHsmS4Ti7wE2EAtE2ft56jX5W83sndFlF0/R3mUhdsDZIsKnKBLzSwyo3l2mnfyIleT+ZoqTUrEpVVyVYo64PW/vYtZqt8h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dmEtK9s/; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dmEtK9s/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762275515; bh=IWUUmuZiZgc+lI7JCUHKmELuWo0NVjY9qbyGRpwgMiM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dmEtK9s/UssgSvvX9oc7ase5GLsni2T+JmfaW6BQt5Z1I5wxm6W4PLKdv5TinXMQb4IjWnv3dkZWo56ynAJsU1NdPcIyRnd9lW3Ynlw+FuJOJqwwSZccDeB/2UK5ui/ljqDaEdouyPSWqy6EZTvM/A8E6Nqg+GUekD9ipHAdCNCx3qeH6m1iI8Sel2g9iqkOJEhdupkfEEO/dg1XMePfHWSGOO80iI6HOI5JvdI5npc7pnvVU2CSBCB/BH8w747cdQlvL7jWjIY9tT2dlALFj6ySQSXNW70dhOkHVjmq4T9x0X3KV+cD7nL1tyWv8KKEgL00cf6Y1nErcYISWbu4CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762275515; bh=QP8pPSTNHcU8IGowzZflt0kgz96srKlYj1I8uSBZCuj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=keHvrxENzDZ8qs0QtuRgmkrO53k+9kYFwe2hRBBQNu87bH8R8Og6qS7lPf9U99qqZuwfvpVrN2pMC+YhHUfXC6Vl/1ibnfjDb5hOliFNzIU1S/MgyrVguvy8j5IRuYHxyzLVKGmyFv8nNGfchWuS7Wavgdp17YjyguSRZ/3wyn0yu0EfEQtAzsTE86JLWEj+FqN5dktnb8T5krfxSTcYdHu6nT1Jr6fWHmU/JarLr8N24uuj0VklLLBh2M5Q63po23mber5tnbv5w5F/9JoNJYckdULQoRGCX91ftwl4EpxWR7dseBx+57wyN0nibrdJtk7dVCbW3qs3k6+2WJ2Slw==
X-YMail-OSG: 3fN1zqIVM1lqpaXflJ.rdarMi8y1R6YIho98w73J5HkJHJhZEySuBNuUFqO3U7D
 1wHWrh.4ObQtHor_MM23G_G2dYJHiitQRV8TleSgcKVdCy4CtHw3L_dBxG7VQHiArXGJqaRTKMnw
 zsKxfB_Ykcvgyz2Bi.TGbpeAEPBHLIKKz9X7Pjc7QlDmR4bJ8eTdxU.zxnnwBnLsQ1klAR2Ikxdm
 fWhcMTJ_rfc_JsN1ENHKxgL5uBoJBSSkE2mY4p5VFMX8poiBxsHxYJ4Y1nGaE.sBwbcOTT2Hss7i
 D8peCR1uRjwYr4tZyvdbg3A4hO_vHNOTyArhFYRyNb27JK5Y3pAVrxv05xobfCh8iArvijv5oRoW
 4ZEybACEzNlHMCa8xpk.lt8sJxqaMbc8L7JD7eUvOc2sTyO6LApuNsumz1kdnMRbFUX_s9YvW9d0
 rbMAZxXSxZxr.d4M9zHLHJT_KCYIHbQe1PrJe4B4LI7vxc8ZXay4GQozqcwAeH6u_V_7dOhjg8Va
 CgxMD5poUBiw344S4Sb3W2SVVjrhIHqBTjAYpIblULufTcxMuA1fATNmn9c4A6Mu6ZTChKXbJ0Sy
 8NyJivBDegvb3IIQ50yIbK9X03B3.iztD5i3WsUTLf3aloUh3Wpa_Er1oB6dEhQ2SwkS4CgdApbB
 ZbcvcR2n8eKOJNQv5bQWTB1DEkCg9nYbT1c3plK06pXrrJO7DbyaRUXrno7VWyFu5TfZRMNaX2aS
 B4GXB1IKC2TK3KPwrrFjH2m9sqkJ530ueV054hTXlr2sJCCD7u0GLj6aeReFRRomvlGUKjJPSU8w
 UFdKPrifqd2Gl_RESrku2Ww4dXF5aFYyX0BCKhQSnjzymjT9UsFpmOjeNCmizsIosrrJYUuOQaSF
 NNxDySzMd7eUqOGz8LxmsB68j7tasMeF11FBcyAzwv3GpeI4VbHxZnfvkbhEfugte1IyHu2_EKsb
 7ruYsyifLSymm9AV5LAfBz3fnNbhCTXevB5RBbycekYdMLtLMo__TtEnvhGZgyU3EzNrxZFHX8nL
 LJjxs37QrR1803bmxHPN.EQcCfXnFGvWjrQ70cuGe6bQoRgH5uxE6W0sus6FkqZiJbmRFR6niSDM
 IUTNBY9UYTeEoYzCRQXuAc65bl2EcvuUJ6K.xV2rz_exh87IcrQVROKYawXxZgU_mQIhubYfHyu1
 rEluwDtiRiNMTImfRE_4472pDD3xOODFGU0K.fVSliO6QmrxPPBduTCw4.2R6lnysvBX8Z4Gs86u
 26VjS1SpgZVUv5fEqKbG.UoYE58_4MuOnOgV.sX6Wxex6dx9mUJMicRyIf1L0_X0j21SSjufVa7.
 qrAOr28Osthv1rAiyXw1NY.ZKIFkW340hxpt3sqjjC0AHfw_RmjdEk3OKfT.JtxxBEAUcssf07kw
 FAlUcWMiLhIWVYD_yK3YZGAnUiyAR_beOuAsP_hDaNBHOhQ3Qy1.q7EG7iLA6faWgiKTwZLH7coK
 libeAjcl0qqo_W1fAibuTKdTVXtqWlrQLvGZpAZYgLY4EDu6XT8ac2drCwF8riPTRvEuUZXjyQSq
 blOVyXgOWX_r6.tseGd935psU7bjrQZvfHvUu.XZ2vNHTCBTXMvoI_t3f.mHfF0.aH0b8KrmLRdE
 x7D.5U1gSK_RvP7N.5mGeusC.mcR8P2gWDqmScWY3wsdemyEBRk6aW_nO82px9mCDJFg15_wRAdd
 OQvyeQVqyIO_dcSTAGS4yqB5UbJu8WeGwQOo7aMYU6ABKiH1mWBOq99y5NRFiPpkEYc6lXAZkwfN
 zX_byk0dKpkxAEXVE_jAVXD.sdB9koR7zrIs6xUpSXzPDcVsPF.O6HD5TT2SkiFCMoJqM3UJuQi6
 hHAIkdAYNOvwWjETBZkHhqXYl1ikiNxMtnmgoDbT_VKXlCVkzlo7rMS5lu0ccO6T0b28aoG9.T7w
 mWXhz01lm7vOVmBtu3eTXbemWJRV4DyTx6b07QuQXj7r9ilRNmcQ7mQlx.Q8fdy7gCk_YZYPv3.S
 GKP7b6Xe28MuNXPrbKhZlmOirpLPhhljhQEm461MTMkT19CwbOjX444P_53i7HTXHEssqccWPPiZ
 0MkAWQJzrrfIE0hGOOX8ZnzzlVfLGfPHXM58dapH1ZPCBXh1JrcUCzF3e.ZllgiFW1pyDBrcAisz
 Mp9tRhQCebn2SRZanNLnv8jR.vbyq856SMnP7hV0ChQ3tqujBCIYIo8XoHi3edEfaVeVhENoAVzs
 sXWO3LNUSQ2AwTHM4mMum8AIrzE4vXYhjCenNWtHbTe65ZOS_gwUFQr2649oaqo7SxxOqE3S_tWA
 L8nXuoeVMqVDNpZKQmNc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6a8213b9-e48a-41a4-9463-0c714f5997f4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 16:58:35 +0000
Received: by hermes--production-gq1-bd8655d9-7xpnt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b706e7c81629f6388fd2ab54890fbdd2;
          Tue, 04 Nov 2025 16:58:28 +0000 (UTC)
Message-ID: <c2f1fb7a-e28c-4f45-831e-83ee8fd6e0dc@schaufler-ca.com>
Date: Tue, 4 Nov 2025 08:58:26 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-2-casey@schaufler-ca.com>
 <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
 <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
 <CAHC9VhTr_0XtFfp017vXmaQVm77kkN+4ZqxNqNnBOW6MpFQqkg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTr_0XtFfp017vXmaQVm77kkN+4ZqxNqNnBOW6MpFQqkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/13/2025 3:11 PM, Paul Moore wrote:
> On Fri, Oct 10, 2025 at 11:03 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/9/2025 11:49 AM, Stephen Smalley wrote:
>>> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> The network secmark can only be used by one security module
>>>> at a time. Establish mechanism to identify to security modules
>>> a mechanism to inform security modules?
>>>
>>>> whether they have access to the secmark. SELinux already
>>>> incorparates mechanism, but it has to be added to Smack and
>>> incorporates
>>>
>>>> AppArmor.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/lsm_hooks.h        |  1 +
>>>>  security/apparmor/include/net.h  |  5 +++++
>>>>  security/apparmor/lsm.c          |  7 ++++---
>>>>  security/security.c              |  6 ++++++
>>>>  security/selinux/hooks.c         |  4 +++-
>>>>  security/smack/smack.h           |  5 +++++
>>>>  security/smack/smack_lsm.c       |  3 ++-
>>>>  security/smack/smack_netfilter.c | 10 ++++++++--
>>>>  8 files changed, 34 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index ad163f06bf7a..e59e3d403de6 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>>>         lsm_set_blob_size(&needed->lbs_xattr_count,
>>>>                           &blob_sizes.lbs_xattr_count);
>>>>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
>>>> +       if (needed->lbs_secmark) {
>>>> +               if (blob_sizes.lbs_secmark)
>>>> +                       needed->lbs_secmark = false;
>>>> +               else
>>>> +                       blob_sizes.lbs_secmark = true;
>>>> +       }
>>> So if I understand correctly, the first LSM to register with
>>> lbs_secmark set wins.
>>> Not sure that's a great idea - seemingly some LSMs may want to insist
>>> that they get to use secmark regardless of registration order?
>> But what if two LSMs insist on getting the secmark? The whole point
>> is to make it possible to use multiple LSMs that what the feature at
>> the same time.
> My current thinking is that if two LSMs *insist* on access to the
> secmark, one of them has to fail to load/initialize, even if that
> means a panic on boot (we should flag that as an invalid config in
> Kconfig).

That's sensible, but why should an LSM be allowed to insist on access
to the secmark? Best I can tell, SELinux rarely uses it in real life.
Smack currently always uses it, but that's fixed in this patch set.
I would be perplexed by a "dog in the manger" attitude on the part of
any maintainers. 

>
> Perhaps the solution is to have lbs_secmark as a tristate value: don't
> use secmarks, would like access to secmarks, must have access to
> secmarks.  Upon registration a LSM that requested "would like" could
> check to see if they have been granted access and could adjust
> accordingly.  A LSM that requested "must have" would fail to register
> if the secmarks were already taken by a prior LSM.

I would be unhappy if any existing LSM decided it "must have" secmarks.
I can imagine a LSM that really required the secmark, but it would have
a tough time getting accepted.

>> The limitation on a secmark being a u32 is a huge problem,
>> and Paul has battled with the netdev people over it for years.
> I suspect the only way forward at this point is to convert the secmark
> field into an IDR* that we could use to point to a LSM security blob
> that could store LSM specific structs for both secmarks and general
> LSM state associated with a skb.  This would also allow us to do some
> cool things in the forward path that we can't properly do now and
> would make it much easier to handle a wider variety of packet level
> access control scenarios.
>
> It's on my todo list for <hand_waving>someday</hand_waving>, but if
> somebody wanted to do it that would be awesome.  Just a word of
> warning, this is not a quick task and it is probably only suited for
> someone who already has a few netdev inflicted scars.

I expect to be dead, or at least suffering serious memory loss,
by the time that work can be done. :(


>
> *I see that IDR is now deprecated in favor of XArray, I haven't looked
> that closely at XArray but it looks workable too.
>
