Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239E2E719C
	for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194685; cv=none; b=j+GEdEs+IIsbnURmNx4twMl3hdtay9xZlGbG5zMfanB08ddJjRm8SMDXqudAWxXQSJ0zo3sfVFT9nZGE1u5qiFhEzHfXPZIGXSdyralmj5EP7GK0cxNAs4DeJ+heDHwFpTDN0J8jEySfedNRUCG7Yxo1lQCuvGFW5Nz/KXTOFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194685; c=relaxed/simple;
	bh=tCT/IkQxcE0Vbq14CwG/Hp5G6xxf/831Jyydl3V67Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=nLcCmiSf3d4T3UF1G0OZMlLoCHl5ZANaJ5t94YM+hc/dOHnRuhtbt4GZ48PtloBMJeOMAZ0jEDU26ZtB9JJZvLFxm7GLztakRV34ELKXZX6/8J1e/brh/9ceA94feQsbXNM4KnapeGNevZiIVwZ8z+xZ7iDcB512FYYKIbojagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GehDkvdi; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GehDkvdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=AK3vqdHMB3C88L5thv0zFgtAigMgw0Q4QfxeUz6vjpE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=GehDkvdiEYxw6cCBCZ64pQ/I+8a52zdIih9MdhwCWfboiHM7GfCXPz/Ao7hRsW8qbjZdz9Ht9gqxd34cTMqNghnM9Yzqg4H09V4Iu0C0vqX/lc5D5+hBNyGog702W+G9crUY5SMM3IooahejfoBi+SHxgPBbQVq+rnsc8lxGze8B1rK00hQZzU2ePXhR1y3A48w+5XUI4C6CO0koN/vwsPJQcbO6xK6VDzcFZkQbAAxqGA83nKy1ofoIN9btygznrgfzywFtEV6M2kaa54woIkuIdu+c/O+rZ9mxlJfb01FzcMl7N7s3fdGWfdR+1kZ1Vo+zo6cKmebDCtngtIez9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=ZjkGokEkxW1DqBxVKYiSYeI8CkZ3WsfIRu077hPZK1f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kt4F/oluG4SAiLDGcHz5xSHrF44XhoB/2wP2iyU3vgAFXmGsMmGQN+e+qfv8ePgk7FDFi/3MNcfA4RoSkARJ+LmnVbgNPaPS2sk+4ok6TNk6xqIcnqIt8Ty4vgeEwBuHCQp0XTynFFLFH289ANRIRakq8foM14uBvFdKLVyTFwLM0wZ85gNIx+3jRg/fBcmGyb7fcoAyqXkm/fyytQTE/kVQ3/ayksWOOfv79V9bcjIhOpkCmBSdlpIxYusu80t1Az2KgeM1XBuAZeJmoE/oNHs3droLv7XFgT5oBR3RhFebo5Ewzh7e2GxI3hQjALonC4nf39gC9BNS6B5U5vNYgA==
X-YMail-OSG: _hgOV7kVM1n4ZMKNDdy4PekzRCpTxDP9kddLdxBfz_qoLBkpRVTQxWTTc7adBQg
 JSANU4Mq1AeCT7Pq.P.Oq1xmQ5osBNuXz3yAH2wtTwPt4O0OEVv7qJ83Er0e5FcWRsH4HKExPm4z
 ikc1lhEaJjaXYWKMqa5stGcHPHLVun4IUHQZdS5FZWs3EGHPjpuSl.tLx64WylX2P6RBd1s0gNmK
 2dmisQu_arHAbxBz3MMMHdQWsyEn05wZIm4sCyukdceu2CD9BYCu3ks_5jt0HRO9jZkWF1mPMazQ
 3WM8ha.7b7FFJZ7b8dRq0NoJp4TiNix0VU.lpAMzyUKEQ4M.gtKCq2qnGX21ANMCLBBXa3mLjsQv
 rLt3ulFnkNsykJCMxzHapi_tm2y.LYmSKBM1XnEEN.eS1_du2hnvk0X34wuOVpb8WGzvKqFkoXMb
 9p_fb_7L3HbOOi55kWS16FDV6w1NbCR2QaQyDG2PUjfkL_LXwlA2MlDuMOsmyclxlt7JlEPXa8JO
 rkZ7v8A6nddkG7p6TNFPb0Ok0TPunTZCuW9tFER4_paFwRG3T76sL7f7FSYDw8NtkQ9SujzcN9lW
 YzLZoiPsN_Zc9ujvcLaBA7.0.Qn72OtoJ8mapePAtesWmZWcm3pekz5MluyTI_q8G.TLJCUiWoeN
 9sBT1bHfHl7HxP74MEdXXl8NOuILcMMyLMDYB7FxH.ju3VHFVza_TWpG1dKKPBkJiz7RHoXLuJbU
 HgtZduGxhNxbHn1lyCtQ2pznmkKwNps77.wn5efDXGNSyMY5.4GrcQjm.povo64ZpAg_iujvpbPt
 T3JV4PnavJ2ben__G.6Xofcw3cPh6HqXYScTcxfMl4Rjsrh4bRvZrTh6Lit1vnozoOIfSicKxBnd
 btoz55lDNPZshLiIfVEi1B1VT9RzQG_P6A4DRBC1TImRnOHPbsZQ4RFXAl9B2v1ToOiRVDRuM1u0
 YsSgNxV7dePB4mJqN.1dUVP3w1wy2Zc5MmrtA35oCgpQYPl2lPRBtlO.hyvxe7VtVhVuUfw1.lIB
 W0XbDAhYS5Yk1xgNB9mKqEgR0A.qgLT0sQVJB.Ng9dPNKw1VmbccoJhbji4RqxypHcVGy23Jn7aW
 TbfW7xZOWVgf6NVG37hrS4KrrqjyE4_QwePWd20SJ4ryUdxxtaqMa.hkwjCeG9A0RXzsXif5wdgR
 8Wqo.TZLNeQhes2T4TTqJAbe_UK9zORGnEgaeOrUndQ9atrFi9tYCturZdvVFgL9yL03d8cVJubF
 .GqVCTjZE4RG7oi1tKD3_CgDC3xL8SSzq2Uv6p.PqfWvWv4DJBiyxnkRtN4ZjIP5VVqdrhAoMgEl
 nxSWtkDfgmbMOZ.oJbjqbfCHvIquxBknfapiUo149anlvpr3SQO0s87iXU6JBLHYIgDz5gyoz.mR
 NyQ.teUdlb_ghkBm7w.hyUKXmS4PydTUOkUzQKAQeu.ApvxV_U3grkY2tg7s191vRsqWbZpmhq9L
 uLS_52Z0cQK9Zwb.of7GjEAJXF5v_guITiUvBJRzow6LpIsEJM9xhVZZE_W5dWsf_PUMsaMZe_fj
 a_ybaGis9WujqtMxrssOVXdzYPLmw8.PXBfWBoBc0vRiMAZtBIJDgb3D1zQ.99sLtkwHBX8uYCaK
 JhvNC0KzbPgO4RahJfR4D3hmfpYuoXmYHftkJ4Z9Feb8L3ZfzhvonvG8BRRHnAWtxxK3u1hg5s6n
 vywNEoNOuajKtigOwyI1jrELBzvFTdIVELm.V5SP0nIUbREk5znILTTXxq7Yvd4BVa6alTsZO8pu
 5MIXbDHr2PGL237sqn4rwFTfqRCl9.Zi5NydwvU8Cy2JCA0ieZt1gTaR97AaLEwU9Wq5WhiN2sBq
 bEKH.AuPAIMDoUH4.MsKYdazp_2Y0ZrYK7qhD7sqdtEWUDG.1wmo0b4OhEUHilYg28j9MNETloRN
 1BARNFrn6UR_0KhAFE0dDhJwkpWdQ9pXYj86aehGzjNub9GxdXECB11b9zY8QoNjSpF5pxWm_HWK
 x85ncHnnULOOugYJOUQXIs79WYbe1nwnVYd53gbpxKfZBIFDtC6mp.l9BsZ05XFYcUqb2HDjAOBi
 lBgFFA6rL.68ImcUtPFIK9fpGVcYJfcIsoj_YcQpNQGxS2FypEsbe6Zf.qQiLcDt5KQ56HzOVQew
 LbY24tDaeFZ0xRPaIDiCFu_kyD5o.goZb0yIoN1jzX_6HF4D6.rp0jnxMSrj16cRZWhvh.An.Jw3
 Tu95kNjX704vnyMPKJxd40hcgomJcQTnIhxBa4TOYsLyGPKSxEPX4zHMXndL3FR.K35aWvdmaIEg
 q7O9RFuEPihKTw2qEXmCM.A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bbaa3d12-d970-4f7f-8d3e-d76350235311
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Jun 2025 21:11:22 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c2f63bee58180d330568dcd5f1b3323;
          Tue, 17 Jun 2025 21:01:09 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 0/3] LSM: Multiple LSM mount options
Date: Tue, 17 Jun 2025 14:01:02 -0700
Message-ID: <20250617210105.17479-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250617210105.17479-1-casey.ref@schaufler-ca.com>

Linux Security Module (LSM) that support mount options, currently SELinux
and Smack, allocate their own data for those options. This patch set
moves the handling of mount option data out of the individual LSMs and
into the LSM infrastructure. This allows for multiple LSMs to support
mount options at the same time.

https://github.com/cschaufler/lsm-stacking#mount-opts-6.16-rc1

Based on patches Paul Moore's LSM initialization patchset.
https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/v3

Casey Schaufler (3):
  LSM: Add mount opts blob size tracking
  LSM: allocate mnt_opts blobs instead of module specific data
  LSM: Infrastructure management of the mnt_opts security blob

 include/linux/lsm_hooks.h  |  2 ++
 security/lsm_init.c        |  2 ++
 security/security.c        | 26 ++++++++++-----
 security/selinux/hooks.c   | 65 +++++++++++++++++++++++++-------------
 security/smack/smack_lsm.c | 62 +++++++++++++++++++++++++-----------
 5 files changed, 108 insertions(+), 49 deletions(-)

-- 
2.47.0

