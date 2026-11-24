Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544138;
	b=J8nndoHE0ZASnpsnlCPswg9/KIOZIRDYIqe215EH74R13USXQy9goRFUUsJSKsERLfEF
	 5KINcv3CxMR5er/xxdpLiJeP2Y8ug3C8RMnG7+Rh+tqTt8gQS5IWR0tRYeCwLIzaFbeQy
	 FKbRvxwNiYWOBLObnyVWreo7HWXRt7SQMdtGGCrB5OuSCVx8HCdpdt0+Y0NB0Yx3FNKU6
	 XEaLaH1eUWYMe0ifHOF/KAPSFf2neLSN161ZTE5my/yHd2lvL+ZK33aCOSeJMKY+d2U5z
	 WGXCClOyWJkBUlp/EiGd5LrD7VYcHVCyt/f/qGOFUngpNIXJ5tdVUKOtfjP1bQUorRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544138;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=Yen8tBrnMyXOkESmaCf4yWwXX80nKkuZvGSV8PP1uLk=;
	b=RJyJ5xIJDXAK15JHbKB6A0cr0GvO/1v/NcBtJIjcELJtw6uiTyfcBJ1DYCwGTRCrqEtB
	 xylovws/503sdfwnuS5PDI2hZMI1nwfan+OULLbgHLolgJyvVhsrEUL2QFSxZPQ/mAD3F
	 lZ2dAsOXU4JOYAp94nsLIYM1wbTBgHTlTAfyq6G2FLmKjfS9ofPofuWdYJNCjamZC4W1Y
	 nO3A7uyAzCSSdbPWnhdV6cOxFtHqFf3OZ3uw6RmgFvJyaogN6Axibgl+DsOXkMmH/cB7y
	 bfOp5jxmK3/eiVI25qPc6BYT8gfLcxVrsi030l4ky+WtFcss1KM1LnqGF91kZ1JoqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YtnlOIi8;
	arc=none smtp.remote-ip=66.163.188.154
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355B606A323
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 18:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C355B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YtnlOIi8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795544137; bh=Yen8tBrnMyXOkESmaCf4yWwXX80nKkuZvGSV8PP1uLk=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type; b=YtnlOIi8HENTqFgwQwpBSr9ad2Mm+WYCjHDciiT6jzHU87GXNwmG7Hy9LmjLn61jvTw2a4KeVsbrBzs/zDq7ZSlWzPYQHKWYujZ4Hi7/mZUjlq4pjswS5gHVGakNyBf94QU5dm+QBnetg3YT3QiguOx4IVYb7bVZ9xCAF79eLvT0CVRYLWI5vjWlKl5tjWaCtrmiZBjjHxm70AthfX0RzZnjamJY5SCphUSdZiUGe58gGqw2p2WjFqvic91FjqdrVLrTvkyUFMMoSdbfUsOn/kjmHJY0u7Ui4+YKncGPEf/I7Qg3tBpeHRzsb14HY0tfcyU+6OjtDo+ka2ParoYwUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795544137; bh=l0Xh7gFXohjF87mFO5jlVxvS0KacET0ujUeGf4CwjWO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HvNVscaCPKX5LTugJfvYwwrLfZfLm7Knbh/FIYJ45nBtge+LFZADHfEuhWr4Vfb2n+/0FDdUWDjcgSHgwhrTvA3ZrAicte9pBlTAofcBFmBFUfMfRGKPiKLIu3WIHvo3A4+housxIaRIsOUwfnB+Y4zgvbHg42ibiXfaAvXd8PpLRnaDQmh+F7lJjfBNNfQ1AOHGp4SkbGkXLuIdyR22lytfmQ2oxI8qBgU4IM1ztXL2cZCzSOHwu5URxDx54JaSOOKU9+GK2a6Y8mukrIxbRULTvmjLx8T6Iyv9YrZn1Z5rdoHowHU2EusLuDLLTu6Mydn3e22+9aBZtraxDxBVjg==
X-YMail-OSG: qwMjzWsVM1l0p3pVH2uf46XYh6CsaWP3JkqmibBKjz5JEiaGS.f2ffJYNqQIwuu
 d4qz58p32sqC_uiklyGr15hqVotJBrufgC8NQox_FDhwww4Hhtvx.mq2N7JDEPv6OnB1SP0XtgMh
 LAzyH4xLZOaHFy3l9rm43wtj4T.5rf81rJz1KIiAIHt2R8bzcOh8QPHirl0iJlpCv9nJFI6ftA.k
 Ro0iJ416bU6SVH59gMDEPaG5HlZcrl_3RsW3rAKCL06geoDyQ2viRVvOUMhc2BcVCOFZYqMOo1jg
 eShqA2b_xuA.zgfI8BtrVieph5immixMm5WATlT2HE8gVQLBuVfLJCyYin8rednt.HPxVWOsa9ye
 l3Ii40J6TZyRxr3lJKhmTMpoDRWIk6K9eu0IRtaTEhmwZ1CWuxPhZIuCF6Ab2QGyKanyVMy2OR1A
 5An457WNpSLHGXUqLgZstL4OyX5sj1JrEhVgHeS8amNS.WKK6abIY6zByqhswippIh3JzEi0XUZD
 _Zos15bJ_YE0QkRuYzi4mCC.cGlq4wsX9juQZ1ZbMMEb8TSRvPhzG5szeYJ_jyUaUhvVl9HcjQKE
 e8U9NYSOOGKFo4UROfCGPySgzTz4ni6xWWkq._44PtrtaDdBHVEtD5ubV.2DcOUDDFum4V4cEoD8
 2uqkeF5fmO99gNGnsNB89vPTiz.xv6sxsFfD_WMJdGX.ekJpdofbeVUbewzwyXdxuej0yyKQYpaW
 4Z__lyPy6Fl0g5nBBxlfcXpkvK7SdTmGPUERjLMcI1Qrko28ljltsNxewECap_CS05LanzCBPUUW
 P3Otw1mcEM.jwrLiWVq7zRl0abt1X0foIigLi8AYB7rAaaMQ7RYifL0a_0IZAFFYTRzgXf7xq7G7
 3MjeDLhgg6FKyC2IfjiWWzDqxxO0_Ew6SXbakrdmG4bB8xF06MXfPFMDosJBGjeX.4LrEkSD0HqT
 yYTIgZc_Di74q59d5MegdDoiz.DeiXemwS2HyVfdRJcRXMaspvq.8glj0tVoQvW4r1KjODI_7A2B
 mmvZ4_9gFZU.9Cwhr7VV2CKr967s4apcb0n5zzljtEG9Q5Xu8dlbMO.il3e4VgE66mle9JJSQI8z
 cMYu1zCFIrL6K_ar6y65pMYLGv0ZC_bBHQ7v13RsXV.q6ca35A4Auua9k9XnW6zIgr9GTEMPrZMm
 eYhNeB4RKsr.PAPTtBjan4rbXD09Mkj5Av4OYXPOGvxRxh_KGjKlrRVlV_.gGE8M4T08LcEsyW6D
 fQoq4OR3xioOzvB_BBug3drGQpis7KGGVLYubXIKpmuJoI_gwoO4pggg8U5mM3Jbgv.C3zAuE3Nd
 I1Xpsng20i1IoTqBssdZQtYJPM8mrQBoQXL5CqOvPpq4MbCyJ3yjbnaP5nSFbjD.tFIXESLOuLrX
 7r7gXovLBbqb3eQgsVULXH9Yj88ytaiQpEWsub1DKXTh2DMZdqt03iRwwcajrphnWyUVI_y26_Ys
 MAdyBnPsCIr9vGM4niM4KdEtMpZYtaqb_MHXEJcKnDOn_f8a4IV6epSXd7DA69qpp1g.ZqgnRQgl
 YtQ6y99t.IlHuOJoSNcTFAZNZBqHpN31TC6Jz_4kKwPPuyn.S3jeWTwjC6dcyj0mX4UCJGCmG3_S
 QME8zz9UoeXfwGXpET_RzfYZfEdS9kUD3aqVGW5G7ar7TbPtUdilJd4Hqy1BPLUfMRaS0ssKrc64
 Ez1N9eu8zOKW_Jk7VFkLre0daXCzAOZwzWWks.6fYWzS5xrBqX.q6qEquM5BsVT5u67VQFs.T7Kh
 NJSwiErpJoRtiFLbfyaQ1W9CXIVc5hb.YFmABQzTQHF5SEDnhjSKP4NGnTjboKKVww45_gxsDC86
 FHFQsy9nzv5jRPx5VBcu_wveCFeabJmWiew0e6SElMW5joxbg_9xMRo6fNnzbGKcPGF0bBfj5S3F
 m7evrhAPw5oiuALqn0Jneon0sZ.REhJCAFAwNjouriwijSeIhVCqXxpe0JhZiLJzTC9d2y4CZrH2
 SjnZHE0dgO9zCCbnxLgIBhCHnmpnIKd7cZlNVaF2QyVssGzdUge8ReMHe5QCbVSWNiE_7v1JLyeK
 LQ1p08Cl0V4MyRsc5v6LESE64uVVzNFLa2u_TaBddx0sliDdAhlp_tM9a96toIBhx_ZOMyfIGgIR
 48FhN4HCIi8ym9zQsdS2iyzMnKxgAZoZ4.GwhyAEnFdtokD37Fr7gvgN4EsVfsz_g0fVGXEtxvJy
 XAHlfQB3Yf91LyXoUvCVvki3RQA0u_AI93MV0IEIzownOLmYET8oq7WKPRcz6IJrFBzb6Hy1mNmW
 4zGCrvVKbd0Dxqyy8n6V1EWY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 08257e48-2c07-48da-95e2-e7a121109326
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Nov 2026 18:15:37 +0000
Received: by hermes--production-gq1-7c58b65db6-g64hz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 89675cfbe13ee0a2bc6abba71cb35f1a;
          Tue, 24 Nov 2026 18:15:34 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH 0/1] LSM: Mount option data management
Date: Tue, 24 Nov 2026 10:15:21 -0800
Message-ID: <20261124181522.30415-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261124181522.30415-1-casey.ref@schaufler-ca.com>

Mount option processing does not allow for multiple LSMs to process
options. It requires that the LSMs manage the data associated with their
options and assumes that one LSM will do all the work. A second LSM using
mount options clobbers the data of the first, resulting in mount failures.

In order for multiple LSMs to provide mount options the LSM management of
the data needs to change. A mount option blob replaces the LSM specific
data that is allocated. This still needs to be allocated within the
individual LSMs due to mount options being strictly optional. Duplication
and freeing, on the other hand, can be managed in the infrastructure.

SELinux provides a special challenge in that it defers mount option
handling in cases where the policy is not loaded. This requires that
additonal logic be added to detect if an allocated blob was created by
SELinux or by another LSM.

This is a substantial change from previous approaches to the problem,
which failed backward compatibility. Hence, it is not a verson 2.

https://github.com/cschaufler/lsm-stacking#mount-262221

Casey Schaufler (1):
  LSM: infrastructure management of mount options

 include/linux/lsm_hook_defs.h     |  2 -
 include/linux/lsm_hooks.h         |  3 ++
 security/lsm_init.c               |  2 +
 security/security.c               | 29 ++++++++++-
 security/selinux/hooks.c          | 85 +++++++++++++++++-------------
 security/selinux/include/objsec.h |  8 +++
 security/smack/smack.h            |  8 +++
 security/smack/smack_lsm.c        | 86 +++++++++++--------------------
 8 files changed, 129 insertions(+), 94 deletions(-)

-- 
2.56.0

