Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67A30AAB8
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820346; cv=none; b=Zmxli9AbskoHuu1hp8cmQXKp0VOhdQZlwMkcIkOnhRnqayS3ZymF1kQNhl3cXOS3TPCUb5t17Hoe1bYocN4HClKpNanEZ+DHesyisEM6fu2wsAUxlPtbsFlMiJW/WVR8EcNhQuGO+6MRuuREIXPfbrnL/JZ3daxMGuni1Z9PsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820346; c=relaxed/simple;
	bh=POEaOebGnfyU7xrEEfeUeJQyZ4WT+Sk2hD5ExGExKHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Pjzke0wm9mKFZ888VXLrlBru//IxINne55whRJd5L+EVJx9KKeXdtbTl9LoXYCMsF2ZBXgrwg8i/f7WPTe88lIyrWku0t6YE6du0kVatdL2VNiWO4spxBxRIwpZHFFkPpUTzEA61jpv5Amg/CC4VJZS3dWUpzDn247tfp6m38y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dPnuYsSY; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dPnuYsSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820343; bh=y9ObnkauxxzF+GwrtiPoK6/quMSS3mLdCQjJiReBCRs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dPnuYsSY9cc0PW6UGKLuAT5jSo9ONYrNdoCn09BGwgqNc/WJ1hA+AhkOaBWEzS1Bz2rcuxhHpB7QKHsOy8RSYk3N/0vgb+4D5jjGlq6b0Wc3wJyYINSmcbFKtISikyBPDlb5JTnXx+ATetLknK65XF/d0dkK/9wxzC9qsihtP+HseqgyK+DylIXozVoYJ/o9VJ2TNt8UKrGV4Sr+eKhdTyDZvUn0MkzUax5+svB64Rmj+MT9pekHYo9B8WKK7hRF8ShnTVcCwUFWQF/Sh6YuXYDLn7/rMvVYUqYZMvIPPjc0G4YFORjiKwAjB9D0oFBaJAq2PIMNK1zoHVO53iJ51Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820343; bh=aVIu5MVtEl5/5J53MGGA15HvRtSY/m+IOxwjK5sW2D8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Dwl3GI+OEUE81wwPJJ3HcTPQROvH1XY+GKcae3VmPjNa7mUBRMWuibJCeiyuFQE3dAX5tmodKvQ0YmSLHRHdFdBR4MovdiXvUX0QIT9TChYEnWZWystq/zIx/SfJdGSMDXHeKszrHxof/rmmPQgYh9sXQcFA9JT8KaWx7ms79OtzK9xY6/okwjILOZ9Jy0Y+kXvcAT/gFFrPBF+gH3UBl0Ed2ni+xH3bGXriEttlL0Y4ux6GZwS7WjFFQuz2pIWDiqy9LobW6JJMmu6oPl+r6cT+sQ3+U80iDr0azmhd/sgX0x591Z37RrIL/57K46c2wTGcM2d+UNGxxtIKX+KLdA==
X-YMail-OSG: CmiiD3kVM1lF8nr6aByo9uKrSzwl5ndBGlwrglVaGB.BrMl3h3RmzxlmJ.okEzO
 nZjVZ7RM._Jvji.sYoDuzWY9P5TXt4JuqLEo4.yOo5Kz36Fcl1Rhx9894fGrwLWhuFC4.HYDBU8x
 6CFIBeBE5Vd8cJt9TpThJrlMsKBRM5lmEeX3v9WzCR27KJpl5laS_ZTWWPHNyM1h7N8BEzS_s813
 O3vN0FNrru6OjjZ4cj5KTcNAq79aQ6UTqEq0rNH3WBzGwxD6mjgMnc4LyswslyMlj3kh4NyaLrPR
 _9nLNDt9vgGs5Ais1aK5vI_9knyjahzlNCQF5elpxKi.Y6rjxS71tSV9A5I9hZnSPYB0xuUppW0u
 4tXIKnDWGhEQM3H1VGJ8w0AJkYIeCNxNvqxch_.7A8kpAT4JdjXc1r4pbN9N1JY2veZuFbPhrBvh
 JY6YT0spN7nBleg..q88V6y3lamaQefZPjTtF_ir5efJek0ktJKb3idUxwwlrRpMUMOgqP3lnLci
 nSUOJO0.wGOjYyr5f9HMn1O4ZFKaMbWymBW8ZEz8VG3t9wnTG_vg8uLKdMRv4usaXkGmGdFFQaUu
 VjKXsc2_xvf4hqtrD7EpLGnOQvDOWmt_6qTsuopc.5g7Y5_HAge9Rw0W4_.CGBI45egzTBDJILRm
 vnE8HuSZIQR6hHawaHmbC.JnS7.r6F.QhPF4x3jWXn8bMLSOIklrHpjMCIGJVphurxPq1Ad5P6XM
 Futq030Z0s1UPPt9OD3a9iHu0IX8zASeVlR1Se4hoIjWlehN0TBNHvkEmKXNSpmfhoQ5rQ07rllw
 7Srbw4syl6.cJakJWCyqxQKd.ECRIXFq6sidLNcH.gXH1AtukTBtU6RmAE_Q1nD4U.VZkrBHOd7P
 P_w0_GOXctHXfq0teGFiiGbxak3kyGSaxEYTjrcrACLxvpzJlK70YxE5FQTwizYVa0CXsALo4MCt
 2Hxw9onBt0EKsfgvbhWPFAcTw06eQ6BMvEY7NRmoHzOcB1SxqHplhdz89siKjYHZMDSRM5zNnH1b
 iTsOdFek3icaMKf7BzjVk3KpSvUxNyrlHMpVC8tn9UftupCc.Vq5b4cuRKk0Jp7OoGTlda5MVO.t
 57UPjxg3mQvNE1ijs1UxfjwR3RYiPFkCk9RPqqs4iZ7fiFlzZ3mV_E9U.MR0MYjKpjO1K_tlmyYI
 y5cfq4V2bZuTbBDXcyrxhpDJtncU2Hh0TnMJUeJDMA2WqtFVW0K2UjR6pEb6q0FlbAxbhXGfP.eM
 hIgRKm0Rn2camj0Ime4m5gjnrhOimbrc0faHRfaiBuF2aklfOVocWmS.sSRU2lO2UWDK_Nf0eQDI
 1qL.QLP31fjWALlm.3TRnbNHLwniAnqUt17k_SU.gBShUn7ErHT2zPmXaBFXoXojWNY1LCRFw8xs
 dCXioZyqETT1vLWXTDesSV9BeoDLV_orXJE2iQh77vAcGnUFym2g1rneoe5zfoSpyKnws_1dMsix
 PpkaJERfm6fJid3WIMi3SBxynp3xx6taM2M.b3SD.ID6YZeiidI5uZa22aXwvwAZkd3LXSaVPvys
 UfoQKrOfRb.2xZW3BEtsDEvKM.juF5ACJYsm4IMdL8CEPToeLI.hs_XrvGN5AOyHnBAEMuQvG.cH
 2h9R8s2yKUmjGT8rqCWDf7iC9FmYPoe49bg3f0.gcXxQi8JFXP286aP4PkQX63LgKgreCGK1YHPX
 CKhGgWQWrj28mm1JXhhRnqklgrrcODflS9ToMCgrwVb4_zDid9QzegN.AyN4l9JKF1Raia0b.280
 RyWKOWGniPuX5NnKHnZyo_5JUXOAFERUCWDNSYMBCbDfESZfC7syGomHlDXgqs1SKeE7SnIRaPmx
 DSJHg0FUwNWQ0HWOQsCi9p2MVW7MjurUafE5li4tfb3g5XKcIXXlTvxfDRF6RBEfmKaiSYB6B2kc
 BsaFkTeg5sbymwyklgFydo0uZqiRbZBpnsj95ZnWDnedQVZwmDxAtYLqpq0x_pdoKs4M2WT.oGz2
 xhC1zu_HH0De_kjTg7g2KbOO0asROk5ZDFaHLxDY_QEoLjkEjUUunUq_wHGnFOWSKumJjR.c3U12
 q4TyH485nfXigywbtr1Ya87Q72Qdx6yQgOkOHFA1LvJ79yGGspPrBrFYUuNPbGX2nSfXaKy9n.Mr
 XcoOw3Y8kAOFuzKWzearPpdhtGNQWRKs_CHvCiHvuHfJkjhpL.KFuvi2juvSwwpusfQGrWyZQbfI
 aT10WbGePkIyD6hHBZCLPc2u3ReWUZMWMGSxJdBXYKpMg2JxMhiknq0qu2XNWkGm4MTXa2pihV73
 9O3PZLKu6DDQEYb82h3SG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a49fbdf7-9ef2-43a4-9495-e293cf104fcf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Sep 2025 17:12:23 +0000
Received: by hermes--production-gq1-6f9f7cb74b-bmbkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6f3ba4c112cabb90c4068fa90708916c;
          Thu, 25 Sep 2025 17:12:19 +0000 (UTC)
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
Subject: [PATCH v2 0/2] LSM: Multiple LSM mount options
Date: Thu, 25 Sep 2025 10:12:06 -0700
Message-ID: <20250925171208.5997-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250925171208.5997-1-casey.ref@schaufler-ca.com>

Linux Security Module (LSM) that support mount options, currently SELinux
and Smack, allocate their own data for those options. This patch set
moves the handling of mount option data out of the individual LSMs and
into the LSM infrastructure. This allows for multiple LSMs to support
mount options at the same time.

https://github.com/cschaufler/lsm-stacking#mount-opts-6.17-rc6-v2

v2: Significant rewrite to move allocations out of the LSMs.

Casey Schaufler (2):
  LSM: Add mount opts blob size tracking
  LSM: Infrastructure management of the mnt_opts security blob

 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 44 ++++++++++++++++++
 security/selinux/hooks.c          | 76 ++++++++++---------------------
 security/selinux/include/objsec.h |  8 ++++
 security/smack/smack.h            |  8 ++++
 security/smack/smack_lsm.c        | 45 +++++-------------
 6 files changed, 97 insertions(+), 85 deletions(-)

-- 
2.51.0

