Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26901288DA
	for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030334; cv=none; b=iKxKRE++lGLp/bAFgaR5oKiuD/13Pj71xrFuLNJhAwT0N6LhVJZds2Y4YXDSdih3BSMLqxM2ihQS8V6G9TB9EOu1s6Nh8DToBLSUdUPVXzClbQgu4seE11/vUGnBKxjt/AGnhVFLfAQ2nZ+IBHglXgrqb4NqUp2VPuUWqVcLTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030334; c=relaxed/simple;
	bh=8xaXkPmWKfkB2ab8ceqVGe5yrovplXm9DWD14PcMWuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMHPuBS3QWhFxVpOUyYl+cq0lHeUy+LwaCYxCinXS8aze8ZI/a49gjn6aycJMB4lV6ouCoudRUTa3Gm1mH2S8AIJEyH6Mqev05d3MxHailRe6zRUclAbFnShBldyX7Ps6k7SP5+2wLEhl6PWUIM0KB45EqSSDUdKitCDR0iRXwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tuI7kjW2; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tuI7kjW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746030324; bh=wTyyjWshVn5wvE3l6zMgjZApCQP/U8Q7BG3H6o7WAZQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tuI7kjW2QMLOX3MmR0UI1DSb2nEh4SfQkcIsl7stUKMhPd2/RGYNMg/MRJRpx+7cFvhzd/p6jghryEzlhNr9E66es/bsvl773I3sV0B6To0wr9X3WqJNMrpbcWkQOkvsIdMOeYB0qYRyVLJJQoLnvDRsPeSjWKMzqTXYNsBlA2F4YBm3fq/RdcZ/5SCXIlnornegK3BbWfUahv2jdQRK/g4IwgVAMOwg8d/q/9cOQG60d9lG0Bm89F+4n5q1KKEckv5Hl3pz7TTNIRRgzvsV1RZX7/RqO/9Lpu/eBh7jTOLZnkcBznONPo9J05fl/DzPCZgmUbWuL1fJUveBlNKIQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746030324; bh=ikW1u0XX+JymWfqIWBcNCVNZpcVt73MDHOt36ArnoyP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KF/sUt0tK7L4f5UJAkmlIMW9pYdEqVzgo4wCb2NoIoBcMu06D4kWjnaWhVrvOO0/vGwf+3eF+aN0C2qAKcZoV9Aik6ZpbHxRM/2VrSlKoBcIutwWB8jXQOG1vLE9K+1V98zW6Zm3bSn7nWS0FRNSVwrbPNUE0WZACbQ6xQWPNBxyXb8VjQvRw1FZglC1+EAQdTkp/sMpfKG6WIbVZ/8OouvYjNs/yS0kol7Le+zxLMtfS0xLN9OEFbwkhtV0dZsFtFcc4qLB665sgeldk8EXzV3edVlR5OXI2bDCYjdvCrMISxWANyFeA8C6LboC9Li8Rw8XNQ+K5x1iPQgoGLhoBg==
X-YMail-OSG: swX9CjMVM1lcYKXMkHtH5c8FnROHECm.xOOFjIlyPvUCR7kebnTe01uYx7xXQpF
 2VA4VmHp4UfTqXay7IfmpxrOSiOh5QzWz7j0uccP2kZx9DFSjN8FJBaajEU6cZ8r2oR_WDNcXue8
 P6WpKpJy9MDppBe66suMf1DTXh1ecly7j7_mlPkLs31Gsw4F5yKs05HRjF3RyeYB9b7zCZnNxvG1
 L9fGif7oP4RdE1wccM7r3pXOE7ZoqqZcmKEdLd9723k.OHQzmwJAFeSkLEUnz8Gphj.21MG43TbJ
 ctcwBRl5QHc_ImF.X9_ux9dme0SubvldofYMlfC1UrgmOMxugmQQAUc7yXh77r6Xh0J9rz17EStr
 7prVYXitFWHEdx4G2BA5XcLNTNodcugClg4d.JiS6LnrLUlinTsHIrxlXhnUubQCkt7OkSAEbvEW
 LhQDkH21HqxcjrHiRSxjhAS1OLaeY22cjRkYJmgReHid6hJnQmatERKDaKegUDEvxVDJunwvPcl0
 _l.DjdMKaR60T2fzkHg.ZkwLlXKj1tlG9hSlwdT4ziddKdoDKi3tVthYEF8oa4nu8x84rWEq96Cn
 jd4oEl0gEdWnDZk2TNNmFKwPNN7t1qg18u0aGoK1Jhd.dg9DJttYg8YyeVlb9hTj9xgIU6socOen
 TBXCrZOAGz3y.LQx3o0cnLgEsm4ilI0uOPloHkv4L7zTi_E753anjFtcAvc7jipgzyw93KNXlxm7
 uoXu0k0dH44BGCswqEQS.vw2tjJrPfpQ58WiX.90NLPXQa35rwY.BfF9hfCs58__vaE_47ZXiF4f
 _.w6.QI33g63P4mGCAUKKRZ3Lelc7LAk_g6BVVPlH.F48XrYlpWlXUyGOdl_u6L_Vt.B7LLsAHCe
 _Eo2xeMjDFyheMPePaPr1Jc62nuDWaEj3f9zk3VHQqNLtUwZvpuAl2QP8gwejYIHsGlviJulz0Mk
 MZ5B41sLNpOBQzx0w0loerQOief5G69dxmOBzHVwt7ChGyoWHNYenehOT4ro2k5db.6GOqQpiGx_
 ReIdPTwgworI80NbPl_4RZaMKsqOaOQycUFbcJnLfNWap_cTjSiPbLj4wIdhj4UiInFSKECp3Ndy
 fhdtcxEhyw1QwmJNoni.h8imhiw_F2awkv9uDaV0wVrxZ3C6M1dekwvdvRasuU2Q_iqrxkhgNdIg
 7k_EguOL83sQE8d9fR9BABkncKaIwdnwlKmwBlrLk9YwoSleLybpJO1zRn6ODPfdmecfMkR5rd16
 NwiSgHISCvAvcylybyOPX_.jgqjAwmqYzqhoVmjovcQxenHLBuL8pmvoxshQx6CjXRsULvmwSVVw
 3.JIk_S2.XZJkbhsKAij4Z09oBIMVTgpjQtFWRIpb2oF2vHXhYTcdAMzY.RtrZyG6MqyXQc.OxTP
 Gd.Z8ZUFXFDlfPyzg.DdX47cUCsIqVJzQShyQwAhpIaKV8QXHy.aVhyWHbbqsMcEBXQte6tSo6aW
 3isotr8t9cAJollxo7Ir9VIkMsOqo9KS0zFMiT3qFG8uo60mL5vKSu1cB.T8Jl2KbIxw5NN0l2V6
 POsvCblimla0dD4nl7EplEkiU1XwuPGR0HziTauLIB9XT8Ne0eCSkXzkb.4UCQvCiCfv9dmxcPjt
 .AN.cZgbIpCtK7X4zxVau_vPJfFcIKdoy3leMEHVKoA.ymA7QJBihaSBy.HoUhJa4g8DhdLfzG5Z
 iwFF.u2DtcyS7bwrSVSbIvGylLmWL836a054ijZBWpW5auQHGXQi3bhUaw7FM9iKyuOAyCGZa3yD
 53syUwZcts2g0nOs.6d4AI58ELimXQ4ZqJ1ZXARgjdtmlGGZtd_bhuMpUaJrxUlOKTCwk17TPFof
 q0r3rTtCXAnqxMBXWBETdzBGw9l2G3RspxSjEHdgdRs2uqAvFxKTagef_DW.BEQJ5zoIcQMz9vbh
 qw9YqzrU77iGlrPlVbPI83.Imyh1ZjSJSXqNPPkYcOJ2ZVUJsyZuV6UwxZxZyOLiGeH96SzqkWbu
 mTblei5maxqJ8aZahhEAGENDyeDEUJbsawwZ031eHpyKTpnBP9l9_Pt5dtqAp780cuKz933ir06R
 W1Pw_sAl.JA6uXBCAeV2KfyvbQoIjjie8fdOmoQTRnJBt6cYXmjmYFF1.WWlkNa7JWpc7MdXv9HN
 T.SB.wubuusGxHuIFxiM4D8EPhJJEwjIvDrHHKFBDMRdPvYaVfLxI3iyjMVgBKvz5ZREtbpfcEI.
 drH1l9pthpQDhK1HPLCS0YgMdDi9th320nq2lUUadi3EnAn_1eLB58pWUO_wk2ycMkNHqcMCSn4B
 8kafB9q7kBWF9FmWYFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 021774ac-c5c0-4e61-a643-fe8c350548c1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 30 Apr 2025 16:25:24 +0000
Received: by hermes--production-gq1-74d64bb7d7-k2g2q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 66014ee8f32867ad8fa2a902011a1406;
          Wed, 30 Apr 2025 16:25:22 +0000 (UTC)
Message-ID: <c53cf38a-f159-48b8-922a-550bd21b5951@schaufler-ca.com>
Date: Wed, 30 Apr 2025 09:25:22 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250319222744.17576-5-casey@schaufler-ca.com>
 <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 4/24/2025 3:18 PM, Paul Moore wrote:
> On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
>> This is used in netlabel auditing to provide multiple subject security
>> contexts as necessary.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/audit.h        |  7 +++++++
>>  kernel/audit.c               | 28 +++++++++++++++++++++-------
>>  net/netlabel/netlabel_user.c |  9 +--------
>>  3 files changed, 29 insertions(+), 15 deletions(-)
> Other than moving to the subject count supplied by the LSM
> initialization patchset previously mentioned, this looks fine to me.

I'm perfectly willing to switch once the LSM initialization patch set
moves past RFC.

>
> --
> paul-moore.com
>
