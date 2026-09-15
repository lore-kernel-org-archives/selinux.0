Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA674D8D9D
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504612; cv=pass; b=T8jCXPE9kVHY9JMV13KharWlvMvt0g0l/AJ0/xG6SFKUtdt9G7EBSHkwj1sEJ0MqE/l86lQfBs1SMamaLElcnS2snf8wwvqmdEofc7/ERXSHwxOQDFAA/pwU4NkBmmVXJmFgXrsvrt9TwAgjYBpZH5DfPl566mbrCiEdRi+u4LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504612; c=relaxed/simple;
	bh=9WcvYvFtOqMYK7EIn1YIdYN71/uEzIgCfxjX9fpWMcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb7AMyDAZDaTcseNnvJGJgB682bx5AHqgz9gNZcybHU0zxZ11YwFHOn1wpqdFFk3RDpKuoRmZynyPUwcJSXCCNkDW7ue6kNbKyr/MXmIRNB61Btl56p30ynG3d4d6QZ/TVJoqQrGCR4HdpWXegmz9SLwjg/utc0ggaOeN2KVVsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KkdQ/Ire; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KkdQ/Ire"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso1853185ad.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 13:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789504608; cv=none;
        d=google.com; s=arc-20260327;
        b=SSDzvwpPUjhd8fiIyCq3e5oZaHT1WYUY/0x7mA9LHShjan7bV8wLLbc4vL1QLVCKVM
         cJN8Jonl2RVNFFNlDawP5Q1N4WYbKlg56lj5W1Hng1ZxiGmaYaiTOMo9wDtwbKNjvvTw
         Xf7o1qVY+xwPmYSdZ3gt3GzWsBy8LXi3T92XmJt0jsIjGWsGgjWPUNg0wLXjD/0aHEoq
         LzhBo+Q1zuhih/aW8L9kHkPC3wyiRPHoYqDiI7jrQJb0jifH2GRsZ9D9uLrxn3lvc/xk
         Y3+CjvZBdKDbWEhrcZYTMHXQil8sLjTBDUSN7FiitY7MraY0q5YeyQUySZBwZ9uVvYSZ
         3URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUOmM8p23AWvA9rdklSg6OWCkYp4tYqVvEdtNkochK4=;
        fh=pYxkEUt5+tSseev7LX3rsr0F8On813ZyZ5Aa0kW830w=;
        b=O0yQCBodSuiS9YcqMK7rRCrQawOlxmj/ysXf3B1SS5U/RSD6gzStKB7I/9tp5lGnJL
         MmZ1ewhDWUKb06QebdaisvtjX0WroZ04/kSfp52R/0DJPTJyazfO46VOQDApnUgKA3YC
         DH+SbTZYlZX0JhduKa/tMidYkXLCrDLnKuehrkv++7WT0PLyoB59wx0wpV/ITUKjoVQP
         ZRHE+YcuBWUD7vQaFjG5e8ooeDccr1vPUd1s8WTNM1vLR52KQiCVWB1ZuTV58X4IyCM2
         7d/TAbJeK5LO6G76vLiN8OU/h/MN1kJKSJ4xYCoNZrRhixFLqIpm07MN0aBmm/Rh7R2s
         lbUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789504608; x=1790109408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUOmM8p23AWvA9rdklSg6OWCkYp4tYqVvEdtNkochK4=;
        b=KkdQ/IretfrePX9PBVLRTMwQXzn2WX/3IRZxF6FcQ+fga7lynTB/dgppCVztU5Speu
         ir4hFnBUKAU4e33IVDJvwi8GyanD58F47I9Nphesb1udV6tMfWBQnMJ3ExLfihhZ5W63
         I538t+mK7dmkWXUgBWFXn92dKESqRhAfXGZTH1xfm+3sT27psWqLvPgz2317CRG508gZ
         THYbJSoPvU1MRFrHj47D0JmFRXNU9Ml+l3PrHcBQMHgvcFSEAjeEqz0upF75xVz6ze6t
         KOaVXQKnsT4x4t0bq6J5Qb/qtJAQV0bduRO1bSQiXDKoiDLMt65I4ac56a9YvXpSl3ZC
         s9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504608; x=1790109408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUOmM8p23AWvA9rdklSg6OWCkYp4tYqVvEdtNkochK4=;
        b=mMS74+GmhZTWZT++ic7gTjwrQuYspWCgpgti0MWtgWxzLpLQsHU37555xwfzrvYGRc
         2qAHtQdDIiiKjTiyHfCERgynpULsNdKu+YP/Qph7hDZ6DsOjoJq857JQ7T7XBLto6cQa
         iGO5fV4kQIdJwif7k8ODVamQ5sr/vOjHfUus5mKYd7pvW6Ag1FVtm4GYGxkUEcR5OnGS
         2g3ujz1u7lRwOVawoYE84+hvBr53R353RJADqtfj/PrzingvJS78UHZ7Snb8dYuo3WiR
         hJ3FBOiDd1No/XPZATkfWaR6nQN1WPi/lX0m0DEfZ1Z+yrUHuONsoeBVOZhcxx57YNR/
         nlCA==
X-Forwarded-Encrypted: i=1; AKwUvByb/GD8TFE7tgEJjDmY9Ra3mHC3c1p0onfoI1OmA83vWUA0Zb4uSRqmuYKusEkTl8t0F+vjF3b5@vger.kernel.org
X-Gm-Message-State: AFuF++nf7Vpb8U15F0HrUAbO4Bt7Cq8edso92W1xbOHNx0c4AgDLH0e+
	Ypdoi19Jq1VYI/M0WBXTXQ0gPFKjvlWWCcM6CHmafnNlQoZcc7eNeYEphEb1Mgd78KH/4lVJgCZ
	6RoHqNJAVWt1pTHC5STqXSrqcrZ1mFRshJ0NCk6UP
X-Gm-Gg: AYBFou03cQ7uvMAltVx+kLsuR5MF6OdVynPeBemD1dSumKl+qVfXgQ8r+KT3NI7fFIY
	iGCZdZ5+QHhsZzLt5aDH0HhBAyFwxv4l2OeRKqxgo/lAasGBVuB+B9Jk1LPLWDixzidZVlnCQ0m
	dLMufABA9duIix/IXdSVNPlBU6VPaRVheoldOr39/xBv3GA3+NC30MDxBRRxgJKgcv9xxUUNleh
	dPW/JJs/gvhmSvSBL8pYngjT3EJXuzi7rJFzRre2Wo1ZOUxtsVi3KLbL+aQVieGqb2BbyYfVtCV
	nZePcRMv5ZgVhcc54wTt9rkPNoQMa0YUXstrnOs3mH1QJ+BUUWAyFgWGqEciLjVZCGNEnzO7g0k
	7hLXtIXc6+0I=
X-Received: by 2002:a17:903:2984:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2dd8384cf05mr46727925ad.11.1789504607574; Tue, 15 Sep 2026
 13:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915195728.3519469-1-arnd@kernel.org>
In-Reply-To: <20260915195728.3519469-1-arnd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 16:36:36 -0400
X-Gm-Features: AcwNN1V6m8jOnx9-xPyfQgHGwm7Z__xUNz7kqqwu2ohNObqJy8jRS_eFOlsi664
Message-ID: <CAHC9VhQwkwrEgnuyP-u_NJxmjgy3Zp9XN4cAqCMqH3ugV+jrsA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use explicit 64-bit division
To: Arnd Bergmann <arnd@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> On 32-bit targets, the division of a 64-bit integer by 33 causes a
> function call:
>
> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_read=
_class':
> selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_read=
_perm':
> selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'
>
> Replace this with an explicit call to div_u64() and div_u64_rem() to
> annotate that these are potentially very slow.
>
> Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from unsig=
ned long to u64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/selinux/selinuxfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Thanks Arnd.

As sashiko pointed out[1], since we don't really use the full 64-bit
inode space, what do you think about the following fix instead?

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..d864c314c873 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1574,7 +1574,8 @@ static inline u64 sel_class_to_ino(u16 class)

 static inline u16 sel_ino_to_class(u64 ino)
 {
-       return (ino & SEL_INO_MASK) / (SEL_VEC_MAX + 1);
+       u32 ino_masked =3D ino & SEL_INO_MASK;
+       return ino_masked / (SEL_VEC_MAX + 1);
 }

 static inline u64 sel_perm_to_ino(u16 class, u32 perm)
@@ -1584,7 +1585,8 @@ static inline u64 sel_perm_to_ino(u16 class, u32 perm=
)

 static inline u32 sel_ino_to_perm(u64 ino)
 {
-       return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
+       u32 ino_masked =3D ino & SEL_INO_MASK;
+       return ino_masked % (SEL_VEC_MAX + 1);
 }

[1] https://lore.kernel.org/selinux/20260915200522.BBC8A1F000FF@smtp.kernel=
.org/

--=20
paul-moore.com
