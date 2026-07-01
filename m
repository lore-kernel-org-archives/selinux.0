Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9B3C9EF0
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946713; cv=pass; b=d38gP+gOzQtiN3zfmV52Mp6NdHuXkjqdVQ01bq2vfxeOJtsbCKm1UWwU13iAOvGSaqS3+gY7+88ingFD1z+wTF2xCn0JmK/xLj7xdqUiYA1R0SA7WVYbo328GNr0l8DaECku1+YErUY9tgHyNLzTG2l6neOl00HSG4mPbSWGYfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946713; c=relaxed/simple;
	bh=v333IQ17seFPobRriFVv9irQiGfOh08ZeyJ80kHbi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ2zR0BF+tgk2xd1eKsFwKHEqiwP4exMcBHSiLn2WZYpeCdO56VtIPRdKxZrx5QRT3hvpdPQ9tlBADb+qp+LMrMCzGhwLh/RdCwEvR7GLfzTsbjIzqNQTSYuVYVqdXT9S3m9mi2Eha8v9Uo6vc9xtzQHiAONkSzml1L0K0s1PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMFLejt; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMFLejt"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so10096676d6.0
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 15:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946711; cv=none;
        d=google.com; s=arc-20260327;
        b=qmo2i243E3hqZkAvIc+ge+pCiBUjH1OcPgQzgZ8JZysrK5CmcX3I6aiz/r+H70S2GM
         irJhcWkOej++9sT4FgNc2lQqPquQByyPsHT6rU3ohe6KJEA8PvYKS7kYypY4p2Sb23WT
         XRFL3jnxgUUJiACa+GULbn4WNxss3Mb0wcsJ703e/f78GT5z0txKg1QN1BFcPhxz4a9Z
         +8i4ovAomKTLBQQOR2wuMbhMlg7FNhbk/Jx18aPrW4BsoktM7YeX3Fbl0y15x8voNAzL
         kzRZcR9/uCQdhoJJtjXABoEyvlGO+iRMI8y2+rIf6Q69dvT+8HfJCWXY+48YWiUuKVSO
         YN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        fh=ZOy0N3jHv4BMzWijYyIoVSH5DeKXXooxIQvy7+9UQfs=;
        b=O7BvcfznZc5q+PRSBt9SEAAboX8X3y+5YQEvGM9wYx2+gzZzkTkoowSAsJdTtgwLkT
         mw6GpXwFoC5XwuB3QZoE/vLIzE4bVTa739O0SqokzHRS4BRq8ZqQTmLaQofIpRYOX9dG
         uMbe7OThzngC7GXRRNxIwMaK7sA+BA7E06GjKQMStaD/S1aOzzTF7Cwj56vAJIDNC0R9
         RgrNUrR8l8gOLRDoRTCPjTtFzLMUkb+IQuJxDEVcsXOv8/cbxBpSnFE4ZKCQFFrEoPp4
         ZXuTqRB4iRvaiK9A1ltdSIQKAb7YwBPLRmAnGiwi10R97hXQdizvEceHa9lBK6S+Z9xt
         OFSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946711; x=1783551511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=FFMFLejt7D9ehe+p004hrq2XpYh/HnFijFKVfrm8olTlbQQ7Q7yb6sS8daedUAOGKB
         6ppRzKfwcFgKnNWKKZCE6lRbSrfVChgXrJ2eDvBGCtvSvvffEJgsf/boiPb+ZDxXdvM3
         jEmUVryajCTjqPWMW4oqmFlumVnrN9HEaI5FyMjkJl2TwZxGCHXsx/IhjQjvDSRsdW8y
         ci4HYwBhSnUhNKlgPp2+jbNcb7bE9UE9b8PV15OB0S0VWPHeifUM23eKuQT5ZR2Jwm4+
         guR9YrxXCt6E+5bP4RccjNaIhWPN5J4t5uV62EOTkayWIG7vRIM5AgvE/c5wYCTy8lnT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946711; x=1783551511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=SAtQScE1DPwq5qjCJl7kSsW70AGLKDoGppmYhU5+ouDvj5RC6iu6rJ2kY9pToYygEp
         JH38h60otH8IMiKqqkJskQPMoe4yPY90JvyW5eOlqHrzF9k0c9+TFdibeSgSQiXmv+uF
         Ivd/Q/FMNdyTorQRV462+8HOE1WuW/lexmsFAG5iXdJG1d0vVazZypycGi1Md/frsaXD
         ZtF+MGwL36aLo8Ww6DtKrpWiEstf/FTT2qep+m3svKFTKnSa/sf0jqSP5Q672Dwxc5XQ
         EJwNM/a6gH1BSdjDIXb1KGqMdAT9SlrwpFAFHFQ04+lNcalD34UOysBDs62Y1uQQOp/o
         0hFw==
X-Forwarded-Encrypted: i=1; AHgh+RryoSuA5oWR5KlFRqYhIipFOLNP+0V9/D4SRA0JDNoSiX2tF1U1hRWTlcoquSorOD4eakr4rke7@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpRsenJ59IDzcLci09Q+jZ6mYmgdO/EcvWOZ2ZRkHwDmTd2J+
	BH83dXGtJ2M1GFpdiTC5u6hHrsRL2v7ScoFU2vUp9EEFIBcj71jD0tdfrV9+aJfoweyHEKppwKz
	8JVM69WBDw0Uyiud5gJ+rDzVhEutmadE=
X-Gm-Gg: AfdE7clb/FEzpr8qLG8liAuDELXKFIsuWajs7ie5Kaojg5ImCi5TLK8V9Wq03w+rsQ8
	4dpgcuFq2j1uBJH77PlFGG6uRLXgrtOCnraqGIRHnQ4JQkZ73qdDRCF0lXollYBm9nlW52jz312
	6XouBmKa/WTVo3WNCkHXymb1azrRh0FxnJ+A6kuUR55o9+QeT1bdFdNZEw6x11cmHSpH+veYX0W
	xtTGEOWNZ4MPY2VWjSMNjsuyQMzJsCVaQqxEA/kc3AnvrhokUs7MkC8OyiqvZvaotj/n5MauWYV
	QY9lI7wfh3E0Tpft1N6PoT+UEDQ=
X-Received: by 2002:a05:6214:55c1:b0:8e0:c0f3:a2cb with SMTP id
 6a1803df08f44-8f24ead200amr108961456d6.0.1782946711091; Wed, 01 Jul 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:58:19 -0400
X-Gm-Features: AVVi8Cd--WxIEfBHVAG_4saw_HtYaBPqRNY7ATulZIzQtiR23TCVwYiJaDu_5Wg
Message-ID: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
[...]
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)
>

Makes sense, I can do it while I'm fixing the remaining issue flagged
by sashiko.

I'll route the LSM preparation patch containing struct lsm_xattrs and
security_lsmxattr_add() through security and the kfunc and selftest
through bpf. Does that work for you?

Thanks,
David
