Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8223ED68
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844346; cv=none; b=gdFmhKsS3rlUJXGoB5Ftfj9MmKyDDg8ZGuGxPMC97ha1iIePqwuxiYudeW6FtP1DRW8yVhEWc99z0ngJU6ROwTLzIfu0QqGkHxFeLp22zx4N9qqkF8LrpO18QxuE084soNUyMI+O4bM9cPWh+OHAa5oHu81m51eET/F25b4ApDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844346; c=relaxed/simple;
	bh=9KGTJBAij2oJilXXLjoLd9nWdXIAyABvDLZ7oyKnyoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZIm5MAuKKlFEzEpmljKxPWaaLGusiwBW6qxzNgdRRvyX9FREG01C4JZjxpWCvtGoXiCLK+4bYXgYE0k03n5vFk4hxaLqT0KRZCCN90nQsEeKqV7WRaKkzci55YDSVGaCcOPaF9Fe4saSk9xiDuPILisSJCjjPvw8F4LSiDGKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fuvoqj1z; arc=none smtp.client-ip=66.163.190.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fuvoqj1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744844338; bh=aGhH9OXD7DZEVuR+8ZNRXBzr6PP4/lToJ3C5tvpSAB4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fuvoqj1zmz1QFkOs/EDdj5G0hmjpq8SF61gTLKxsq3THKwOd4pOdR55uCP0e51+FE+MuHjOTPL0y4kInTeT1YGSyPWgzvKrcjdTeZ0hUOZy4YLtQch+2SFsZaQ9O1CqPR1N+Ruz0GciA1zHf07xtEYmpgEV+HLV7TH1WspoAIMb2aNMWQD9OWs8xp9s3Dra+yeCb98FgqfXquJ0dM9fKrYQf0fWAWjtjs9QcpufqDf+sRVQZZgAS5axFrREfjAfM16T6YjK/Xzfpy89gbV1jNWDaVbexcQtyqiQO4tIcMsIJWsXd4FV62LFOKgZlAiJRt7aezgEcoVndBTbsVz8zHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744844338; bh=uDpuVIXd+YfIBqzoLzJTaMMjY7bpSWXkm8Z9PgZr2yV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZWUl3Fx7wZnl9r6UcqvADvWMswB3szjeCS8LeSkG0EG+f5UUPdSOxtW+cS8MSUnx09irbCxZ1z0NIv6HA473PcvcngF2376bzEgDxNch8oyxOU7BIIUCHXNoUPCFRlpCStOVWRfPsZw1ImBRy39fna3ebG6BTh+52j0Iy2t373t2f9vICtYQlZEpWJTtHbN2iNSZ+F7Z699n/OUt4jIT6yzFwrXRrFVDwlQlK6RlmFjUnHx0ZIn5sFhRmUBAGW6sn6+6tw6hnGYWgNtbx1SGBGGXjbltghhJ1PeMeGsvUcqRIf2fFdOeqm7+3Oc6DK1r78rvG8EIv8fw2RiSpIbSag==
X-YMail-OSG: kx_iWJUVM1myVH8yXC0jEiI4TgDGfgJfea.sTiMalmSa37QuWTha1LcqYrN5_Iv
 TmFK1VJqY.hrotmVVGEOH12q3mYVEIqhSk4ZsOug7b9heMNhUiuzw1xtgkzCWocU7o33paNqhkyl
 MQPX_lEN8BHtCxcDFvYxbJGmbbLZkp3s4430ErNXCWDazLMdvXsWQjpKXdU_FKuAXXQzfojIksv9
 SgInQ3hnslzZM2alDUJ.ibsqRHzbSnMkm2pDdkxf9m1MWgAu29PKSXsXQGZwKDlqTMv0JTkQ.8HR
 koWepITHaNo7FWhTxw059qm0cP7BN77vfOtHdlA2wmKiZX9eN2QDlVjSMSBcqUrZ5YcflXSNHzwg
 ON7l0pJr4thWfDYAMk_H_26tprlvRBpAr.XZT._H2s8JkHxL..qIQRjx6D9m0wSsbOGN3dNEX1Jl
 3T6x07NPHo6ca84kIRHXEnYT8z9TfNIKiaTatNIKaDbY4qDO8d9WpSCvwv4XqA16lz1FvbUptKlD
 nUl7FaDdF3ehQDkuo5mvQCP1vtVC5QM7lTS1YHYWHPGHOV8EwQchrK0VGsSA7mO0cQXNJSurf2Uj
 uxih0wXPuUh5piT1K83dcjhHz0OU_hxFthufJOh9oIUXTy969ZGP6CAtMcr6tHbSzY6KOovVbNGx
 w8I.Ht58JCGq7H2uI5VVcz35BPzGUG02rUAdxvFbz94vshjbUbI7wt9pL3hBMAMy89I3415xFl9w
 pHqmTHE7V0EIPqlwVoCMN2QV4ss1S8tsj3VTPSpPwEDAaZVoW3eflFpiGmPUTXo25KzmWpqQBM.k
 PoS3DxYvUNq.knU4jQVZ6QuTkRVF1Xw7Rt5dmmn.QbdMxoGOIl0huavCSWHEs2GaHbrx3rOR7HwS
 hQD.7DlS6ZU2BtFELXyurpZxqoFAxWIUTekPskSPys7EXu8HC8pHIqDQc_A4sH1kZ1.ePX2AsohH
 Sm3hdNaTYOiPY1MjYG_LguedQsnKIi2Ex8rV0Lh5r90ztnd_6mU4hbvsjgWZkXZuN9weuIW6npVd
 xl2cGAFfdUNRbQx6SXckVpM4jxAy77DsKabEVyhpDPIscHAwxodM_oSzLxzcePgCE3XAiE8x8q.O
 _2dgFeStsFtV1uIhSjrOk.6Z6xPmWeljoPAB4eF.DQr7opkuh4JsyVhPgfI3yiv1amV2P6nW.7pR
 l544iWl_OfiyBcVKvn8BPVX.b0psWD3xOyKjOxhogViEBBltnlVgylKWFh_.FM3Uisn8g6NJNVAf
 stPH9YUzRztGUNNkfuLn0l0nnbPhtF07Kg19RGOvvtOe5gZ8Q4rEYtPG2S9g.PvEa5BWmlNCvBBW
 3HmHmB1Z1tV7tNpuAKBf77HdKNK09eSS1NlloLYtZagT8ixEnXmYOrVtpMDLoN3dJJHyjsKzK27W
 qC.O9oGROM59REVDLAD6kCOMvE6aqlKpt6BKk.tAKal2lsvr2NUNXZcJ7MJlzxxnzZtcXYtYeuV.
 iBuOA1buBJObQNror2vM0TM9SBU0ncN5IiCtkC1NqsheDF3xsqvO8x4pUkxTH4XmRNrg.cU3s0Wi
 qjXPgUKd5wWmGlA4k3BalfCBoHwL0tQmSq4_rEdE9I7VmVQZsHxC17BOVHfvNpJ8YWxQsmG5PPQ5
 kZZ1OBfOP7nF_Psc9rgM6vkSE748hwkSWyLKpmp56etLQVQUyUbQOTQHNMmeLP2EER1yEQKoP2gm
 Nr2VJPm2hsEQHNc195kPrRXGg8tUgcsS68I.5Qzj5oY0P6Yc8SyJU_4XdKn_WKF_oI.g1NpO3lwV
 paqgkbVYKPEkrnt6HdE9L3Ar0XjYpHJHyQ8.ixZ5V_Gjfo4PbpcpYaIhZmj6NwAtGPpL0C3.I5hI
 EMY8ptGZ8JYOCPRJJWRTjeWTLpT43TzDexV_qpM0jyMNLOiCizy62zmZ5JdudjZJubSWy29EK.ss
 3BM3ju6U5UHRE.eIsy6V_Q3tUtRWSJHTNT7xhYkY3phyTpBK6Q.YRHg1vkZs1LdQhnSTA3wvJv2v
 N8TX2Flx2.xAbkRzdb8ND27yRYyR8eEGd8ZNcpAQzNGi4pfOPRToHL.qnOCVQx0Yt.boF09hClNW
 2i83KKtcISfFUFiiu8B95nYukdAyXsk0pT4En4afHyzk8RKFUpdWPNdM9tGJSpJVkCvNZ2kgJQNv
 VUea0_M5QgVVg89CtEEy4Rl9W8k6Q_wu1qBZtqiYAHvL7y18mh13AbsXd.OKyrYzwFDrr1C9faod
 CVYg9oo6Ke1YGZGUo1D9D97jb6nPw1lCQ1EAAIdZv1C2aLI2r600_eJM4v80vs7VG1jY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f3096bb7-d5e1-4278-b87b-771935d0acca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Apr 2025 22:58:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 74ea1250be9b6111ec046bddcc0a667c;
          Wed, 16 Apr 2025 22:58:54 +0000 (UTC)
Message-ID: <9a4b0f45-1eb5-4eb7-b120-6b50ea0d4835@schaufler-ca.com>
Date: Wed, 16 Apr 2025 15:58:54 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to
 binder
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, cmllamas@google.com, surenb@google.com,
 omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org,
 bagasdotme@gmail.com, horms@kernel.org, tweek@google.com,
 paul@paul-moore.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org,
 hridya@google.com, smoreland@google.com, ynaffit@google.com,
 kernel-team@android.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20250415071017.3261009-1-dualli@chromium.org>
 <20250415071017.3261009-2-dualli@chromium.org>
 <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
 <CANBPYPgfW+3jeTPZmpHfkgr=hX8sRkMLgrEeLFYa6rOPftXeFg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CANBPYPgfW+3jeTPZmpHfkgr=hX8sRkMLgrEeLFYa6rOPftXeFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/16/2025 9:00 AM, Li Li wrote:
> Thank you Casey! I'll resend this specific patch to linux-security-module list.
>
> Should I include the other 2 binder patches as well as they are using
> this new permission?

I would appreciate it. Context can be pretty important. Sometimes 
"why" an LSM hook is being added impacts who reviews it.

>
> On Tue, Apr 15, 2025 at 9:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/15/2025 12:10 AM, Li Li wrote:
>>> From: Thiébaud Weksteen <tweek@google.com>
>>>
>>> Introduce a new permission "setup_report" to the "binder" class.
>>> This persmission controls the ability to set up the binder generic
>>> netlink driver to report certain binder transactions.
>>>
>>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
>>> Signed-off-by: Li Li <dualli@google.com>
>>> ---
>>>  include/linux/lsm_hook_defs.h       |  1 +
>>>  include/linux/security.h            |  6 ++++++
>>>  security/security.c                 | 13 +++++++++++++
>> This patch needs to be sent to the linux-security-module list.
>>
