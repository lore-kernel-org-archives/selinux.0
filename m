Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B31F8AD1
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476946; cv=none; b=PjItCdTTA97I3EBFiySziximccrDgiEnHGeEFRT3Q2fTitYBAvb0YCqibxzWETY9JPzSKVELwieTEgzQkivg4IzU7I/d2WSmRrBXxdbolYU4Gy76FwNsAUKADLypV+MB7hxCwlcEOXhmVQ9DskOOk3AIH4eNGiuIhlZakkv6Wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476946; c=relaxed/simple;
	bh=P9txNihx61dQc3GsRMOxHA8GYlUJFQzSrOaA/iizhpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=uWfdDSdfci2BIqoU5T17WqgECNs4WH4tHbqPz0Zt4sapwFhrgVpR2TwyRgJH2KZrIrFYcY0W/E78vSMKT6qs5w2IMhnyt769QcGDHh9VZ2n8HhLsdK/j7HNGANTGb3oZdt//NSZbTVcB+PRtmt8iHRSPisHQcWW/HNtnBO34guY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N9usoOIV; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N9usoOIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476942; bh=z7NJ8/1znUx68XlhXMBSprJ7aIfiQiyXZZpZcn2yhqY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=N9usoOIVKPuDLHyx1gmjWV+BwrW8ZTQIqA9B9JTi7M78r97h5F9wKouaLLxwxVy7nOtTe2GvcnfdU5UcmBB2Xqdw/fiUx7BX0yHuNH5/dOsPHJdCbuXym2uMVgRBw5vhoxfVYmSfM6eo3d2iQtIzZr+La3qkCraDFlLZ6NnorckpJjifjRVYn4CeHdySQ0mfdpRGc24xzjwXtYPsKnOKlq1Z0E6r+d/JsXDOdvCKpyOWRqa/N7ukcN4VjY07foZ10Wq5QkHv3l7Z6i80Gi+3qLheKrwaXRMMrRpWfys4C7iWu5oPr3Lmtn97nppDD5M+VwEOm2b0Pb9T/VWoaF522w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476942; bh=P0tV8DVS57G4tLJIVKtMmm9mZcNntBZv52s47TwDbmp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lzrBQbaXbfmF7w+smNlnY+qsthMRg//myVEg9F9DHrID0WCQms4qjrTdzCtKdZKx2sNNXfqfMhMXWszbJylSBKdo5a2SnsVaFIIXrtIWwUR30/+ZLVn2QT9y5dYevaBEKoc21v/j9Emxp68gjS1ewHzEteUOZx8Zfd66KekopNRYtsOkJhUQcT31tJpRurG4XnODjNX3lU9GQXSU6nPsXBuvcrMpfdTP709gYFSYO/jHmyoieCBLAV3bjItRchx9Ah3508g+qJjXvDwjzd6Uxq6mEH/LXmSu2UZ6PR/wzLCzyJptEGE7md2v9n2Fvljnf0WjjmIWqE4LtlzCf98MfA==
X-YMail-OSG: kBPFPMEVM1mxNYaE58FKnaqzLaskGTtta7M3eBjcDMIp4R1iHc7LAKLrDJJWxiG
 8tHwWyeDj_8fjawP6qmWHrgrLwVFrao3rbCdf5DyzX2fTSt10VZjAUz6m2SoGW6zTD5rfSwGqfDm
 Nam1oCQcZeggkrGhquKZO5MavSqGyS9m.WLToVbDKYYZ9f_Ql6TYgZYEJNl0I8qd0kiu5tkq8x1s
 WzcpSXRIGHj8o5RNg.eULndmE77Lr6aGOAiSD5SUkEkkgUcp5tNMV4AzAgFx03l_MGzmH9V146M9
 XUCe6tNETPwJOzx1ZkVKzZZJu4Z.qou0shOVGoOkc1YK_F2xniy9w6pb6c9dsWhHjJwUVCs79AQM
 H_PJJaZb6jGiPwdInuWViAw_9u_tEeSNb1gQ2PdG71QrEHrJ5hOyCdERgNw7QQTz5b8NyOGs8uT.
 1WE8meUv11MNr1.AX.Rrt2LTamQHasd0Oivvupuo7NKqq5v4y7foqtN9RocpZlhvyp9NaixvPB4C
 PGSo8umSRVTWh.4XWm4IXb8Tkvpur3NuJBXd.YzEv9765p.ChXxZ90OZIBCfWLNuqlZdY5UH8PHi
 xLnGOmShCFNlQYMD12KeuXzu2P5IsHHGXjQnACD.lpE5xUrCH2vvDpqFu72lg35usc5BijtyjfWV
 dMzD1QGtKZ8s4Hj8cqCjspNDUo96th2W1M6aid9UNoEEfCsDGCDyTmluUlcdhHl6dEIor3xhkPLc
 GoPcNYYBP_eGxfCA97qZtKjmMkPrPmpTAA8gucUIhXGaEdgMRZrN_2FXva_C9ip25nPcs68aKZKx
 Qy0Z4iLrZvGAJ3CKBOedIgTjZVWEX7UeBDyjStoZA2h6YYfWQ.KBL03g.9Nv91EHBs.ryiSd5naN
 gdoiNMvUjQhvqvs0JphZzD8veSndODC6HLGJBjCfc6cgN.uIbCMSeS_4oS_Q2tUgYlIGUwAv.8M3
 o7rZx9b2pnES1E_aKBCZ2f110SFticEgvb2vvr_Y2e_lvKG4gb9CFFqr_6QRKUVr_9IMR0ng7p_d
 d8TQi0mYbTtpmgtD_NshEqztoxo0EU9mgpsehyV5ot9arRT3RmbLgsBJ92qXFpeqoqWEcd6aRQl0
 ABGFvf80u9CnLNx9b9y5biGdrpj1eqpsHgy04pikHV6178oM2l.PJx3cg41E9PZRpW8yp2YfwSgP
 BvaAB6C6JYn4nO7ZMx2MLdUfKcjMlZO185ujH8hoIl63J7zqBKiV5Om7zNnKosJuKdPHVoZnVlDT
 ehGKoSjRIFwiIXcxU_DwnLn7ManDE87QbVz3_26EaJXfCERgVNFlrtCWxVzCgodld7FqVWXlU7ka
 Gl5rLApqqTnVBdooJuzu9onCXi5upSZKMFxfS3xztiFn32XVJr7D8dZ6zVhldUnVWU9QYdGHPjUL
 JNkZOnGb8YnxpCep7Y2OmSrCPwMHJTsPK8AsHH_JVYs_gk7g_Gn3oV6IhD.4U_I7_gaueTXQkbUb
 dKiRsEvHWMkuPvAzV9St3WX9vZMOXEjYWibr1MMfDNHnaUiq6K_MuN5pGN.3NzF.Z6CPIOhvlycj
 sW1U3KHFw0nCuMVaRZUgeM8UKIQTyjVqZFrdmEj4c.tDs_2tt7nT7UmdRPtEdfNhcHtBOexWmp6c
 tNlI.WAWr7LiIudGR7gqckAqXXrDR7jo7zKc.5pyA9M8277Py6MudjZdQo_2H1.qYybSJzZsw9wM
 Vnt6JN2i60VQhqxPL3c2NmNTQJ84IwuDqTw_tdSzRO6PXvF.Xhmrn3UvQlu_hOEnH1xTa72VZkl.
 VplvMF.YzYuKwX7b.Q5MyKQF.BON_Y2T.P.6mTm5lHTaSHI90t9Tej_WCxFg6vsCnQSGQ6HN1.Xf
 UP3nZDxKvn2.dasEXW6VzK5tlhwr27RuUcL_cStsAxGz4MSOvGfTGvsAbIY8AgN0M1bSjC1kVVd_
 34iFnbEJBb3jzOzCJX5i0haoSV8uHAN0osi4O_TluT0ZujbAMtnDXPMZmRnKo7h6SJ8E7wNK2Hxl
 gZy_daZUSWElC99IvzQP37pA2_m9xmHG7ZmA4DHCn9g0kP16cKpc4IwhCOiVIRcEAnKtKfdE9e3u
 5FoUEh_rk_J_3SliLIrWurX9tb7__CigFExETN4RC4Nmbec5s2zVzyD_UxnubVMcSmfhWVHAg_i.
 pBR4lQaeZuxGy75.E56zLvo4ljLqT6ip1hIJTZKUAOI1svXXegoNDmVzXfZW8yYbETFBJD9NGpBO
 1e9T7phs9BnQHY6SvswsgnkgeOa82yPPJfbQj9Z527XyFYId_2taVW01e9dPxFP2UZWb9y3aivcN
 QWuFexFRlN3H3m12k83ajcxQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8c920e8a-2f43-4971-a2a5-25c6ba293a10
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:09:02 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 617dfd7e8dbc08c7e277f225736da47f;
          Tue, 17 Dec 2024 23:08:58 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 0/6] Audit: Records for multiple security contexts
Date: Tue, 17 Dec 2024 15:08:48 -0800
Message-ID: <20241217230854.6588-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241217230854.6588-1-casey.ref@schaufler-ca.com>

The Linux audit system includes LSM based security "context" information
in its events. Historically, only one LSM that uses security contexts can
be active on a system. One of the few obsticles to allowing multiple LSM
support is the inability to report more than one security context in an
audit event. This patchset provides a mechanism to provide supplimental
records containing more than one security context for subjects and
objects.

The mechanism for reporting multiple security contexts inspired
considerable discussion. It would have been possible to add multiple
contexts to existing records using sophisticated formatting. This would
have significant backward compatibility issues, and require additional
parsing in user space code. Adding new records for an event that contain
the contexts is more in keeping with the way audit events have been
constructed in the past.

Only audit events associated with system calls have required multiple
records prior to this. Mechanism has been added allowing any event
to be composed of multiple records. This should make it easier to
add information to existing audit events without breaking backward
compatability.

https://github.com/cschaufler/lsm-stacking#audit-record-6.13-rc1-v1

Casey Schaufler (6):
  Audit: Create audit_stamp structure
  Audit: Allow multiple records in an audit_buffer
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: multiple subject lsm values for netlabel
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  13 ++
 include/linux/lsm_hooks.h    |   1 +
 include/linux/security.h     |   7 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 233 +++++++++++++++++++++++++++++------
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             | 105 ++++++----------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   1 +
 security/bpf/hooks.c         |   1 +
 security/security.c          |  16 ++-
 security/selinux/hooks.c     |   1 +
 security/smack/smack_lsm.c   |   1 +
 13 files changed, 278 insertions(+), 124 deletions(-)

-- 
2.47.0

