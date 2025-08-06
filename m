Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23281221269
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517975; cv=none; b=N0q0EBsZ5scDar8ep+TIaeExGNcajDO8am35SOmid4yGp2K/w0z3ZsOFaVcYsyPlfm0ggqzdNC7hSjzYUvm8tIbdL0ILPjzUDEccuoIN9L0KryUQLfgHzFGzoiHpLjBRxv4wx7FOCRBMi13sGF5c/+aeGhYirAlm+gn3SHL+eIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517975; c=relaxed/simple;
	bh=AZb3s71JJh33LT/OJ6WTaBPpWMRvxVzhiysQxR+t4Yo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sC491FeUPUQJ4c5syDUOH0WuArGYOpBdYmLWYmkolYLrlv6KpQmNiwnbfMUZfMhDfC0zHJPGu0Fx4FtGGnzrO1iA69otAFELKNmFfslHRMf+jWxrOkM/FrnqyTtyQkffwui8cMYW9b3U5+8l7rWMYHr7RGeYVOI4lt/pui+6CDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KqKCtHbP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KqKCtHbP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aeb5eb611bso4104011cf.1
        for <selinux@vger.kernel.org>; Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754517973; x=1755122773; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=KqKCtHbPnuDXRIY+fhAZjVUj+3FIOk6+LdpoQun47mvWq3iDGxfZQx8mvZ+dM6OLli
         aEgKnWZL2Csvrc0hfMITHWLc0Rjmg/V+OyTpyWgiwe1hsreV3UUqV5s76tKJzfJZV3KC
         /5bVqqdquQlc+27y9Sta6Nw38+EBtZK0jiN7OEYd97+QcALMsrFucfDGHrxGcDoMvRUN
         X1b/APBElAfNVYTpDOpBUOH3aBrOcf39M2Or84eZwUKW9xs2Skuk3tgvkDKuKihOj1t3
         ZVP/us2flk87x2oHs8NTH0OCI+oCTChB1ld1gu78VBS1IKRFMzMZhJjLG2PFoyMAN6xr
         o/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517973; x=1755122773;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=IGdyexBN5+EiWjf7Z9daZ6yUToH/LJcRaEihYxWwxTAZvmJM2T4HbKCxPthHRzB8kb
         rQpeEKffAfC42KOFabwvqyx52dko0zGxDOjIYy93JaB4HYJGOWlZZ/lgBQk6dwpuCXrP
         5Vhgn6nzZbYwh2ODLFS+tpm3JUT1jyG5ko2PkueyxWPXJ5djSQ9HeQ0enTKkBHQWbl3z
         U1ycKKKJvOKlQYyiCPe45M+eV93mGqots0O3UZpk/ZP997sxsyKI8YlvSbq+KUcFYQu+
         8ZXXwGUAmqc95SlvLuNhuy9JdJj4bOVMQpoORPwPHSJCtpJinQ7fA9gd1w4DcL341pLj
         SBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdd1M43Io5wJhEqDjRsZDQmPllwOg8tthWOheOTT7mnK6L0V54pfjZtDW/BP/gyJiJG3+/zOx0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/Va5rwYH+DxzqUkc1CMpSME7YKy1ay4T7oI+PLGXmMZLdD79
	/bQeB+80mW466mwtby7Lceaa1z/4PCC2KAPgcREpM5RoXxepLht3tVdV18JvYg1/xg==
X-Gm-Gg: ASbGncsBsly+aOCQKKU8TdDXkI/Nxur5F6l2LB40ieJuGag5nDacFz1NaPXmltKFaab
	8hUKnCEy344kmPYUVBx0xsAWzLai45ERP+5SlWGhQlN+HbUvw07na4lz8EIbW81gTh58g5txI2+
	h2obzPcURE917AVJ51GYnfN1rhT393/TkbREZeH2WjEpZu2LkGdYlypqCAG0xPnb/rWZ6N6knKa
	62T2AoobXvZDzLgelSb9m+wTfVnR/HH1cOgReym8YgGlm3Se10sYp7/CLLJ+/IQXkLgjMVrW1jq
	heXqRX59Eyucm3K9jQvSHaKGh8ffBgnXXxv+kLHJvnzGCgjacX1sp5kX9tSfrqXIzhDKlWzpe1+
	H7n069eZ63mCsVH06tSLtPAmCV4t0o8BtkQJjTh/AaXhyydejsOkfTPcOWm4/2T/wsn8=
X-Google-Smtp-Source: AGHT+IG4WOTe52hbcaGbNLSDM3J6PCnYw/yKUN/TtQ1ElGqLlp3dNbbODonDRI+YTHlBq/QwlhefrA==
X-Received: by 2002:a05:622a:4012:b0:4ab:a762:4c8d with SMTP id d75a77b69052e-4b0924b5879mr63239841cf.4.1754517972960;
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b06f790834sm40991931cf.60.2025.08.06.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:06:11 -0400
Message-ID: <3e45e20228c80f9f6a126d09208ff995@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] LSM: Add mount opts blob size tracking
References: <20250617210105.17479-2-casey@schaufler-ca.com>
In-Reply-To: <20250617210105.17479-2-casey@schaufler-ca.com>

On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add mount option data to the blob size accounting in anticipation
> of using a shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 1 +
>  security/lsm_init.c        | 2 ++
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  4 files changed, 5 insertions(+)

Since you're respinning this patchset for other reasons, just base it
on the existing LSM initialization code.  If this patchset collides with
the init rework mid-flight I'll handle the merge fixup.

I appreciate the consideration, but in this case I think it's easier to
not have the dependency.

--
paul-moore.com
