Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B61DA62E
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669967; cv=pass; b=GPSGDMHpZzJF1MWRp4DaIShxByG0CzctrOiHQetS+656pNODRQsugiV0zu197ImMmJytJGNaRvoJltjEaqGYCCqjSrxFkjkpPklSaM30JV/e8tiAB8ETHmm83KCySiWKnw9d1EGeAr/jsdrTI2Du2xvIf21XYrI2inQL7Tkq8B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669967; c=relaxed/simple;
	bh=w83kjkUHr8DPRzA+nQ5sOqIxQOTrCp0HCchqUFHTfPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nkq9vqKmmIhV7ZVEazA5S49V5XU5Qup5zrHw+VVgGfIGphet2MGvgK0OJ4Lp0VGJiZtWOMThM0r/E5mUoEAiOUZCO9JMljWGwyx/epxaTJ5Gn/+d6hVL3HA0UX41M9dU58iaqhdTGicUtir6F/LP7Eknt1LQlpT3Dk/82AQMT6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb/qklDI; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb/qklDI"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa63daf2a5so2028705e87.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780669965; cv=none;
        d=google.com; s=arc-20240605;
        b=T7G87/F/5suEi4mOVLKP1P0tPNdNNO2yeaflRrnMJVqJkLVcJ7Hfm43qDjPjEjRPgC
         mWv/S6QI9iIwtDZwa3Awy2f91cdZKjBCW4ZMivgGRKZ6/GehQu2okL/VxzeRohKHZsqM
         h7HvcM6V/YijMVCp3fLiZQxcED3bfGRcMzppZtUKgLzD9KqYHbFe78cKkXiTpezZpSeT
         4rMs9wDNFikqoV3D8XIMV5CCq7S+x1JYC81qlCFIvz5seIRsj20ntfF5i9ljIEEVWTJ1
         MYiu094xjyfwifB/pwf73umbW22j9u365U3MOOoiq/0VwPWfpuuLiG3Kw9Zu4ahYzDFH
         otHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KCyBNJ/ylx5emz4aUuzKv8JbqXU6LzcxMdMp1pmZQIo=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=c95DIZ7nbVewmlv2om/UQQtZNM/spKk/uCtL35uxjnOP6ve2NOhDIQk1VVjYoZ4cmt
         gBLWGgGhPlJ6w9JV8Nrg5Sf8q2S171XJDE7bEIf2jK/JK4lLrZWoVeNh/MUwU+xuvpBR
         8uWHGPo0+q+LHXzjV9SZgwwzZopWExRv7U16SPJ8HmZAFcXTC3HV+YzijUmqGTgUaSRp
         hUfTDOqcpFvNComLlQgjs+58SMGLluP22RUkBfET0xdMxHl37mIAp8f48HyeoegrjPyf
         BBvicn/lp8L6uxT8Ml6zGrPzvc9CMVdE47aXCK10phEjhBuf84LUZo+YoYIpJDZ0+y40
         +WQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780669965; x=1781274765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCyBNJ/ylx5emz4aUuzKv8JbqXU6LzcxMdMp1pmZQIo=;
        b=nb/qklDI1QVPVVcKQZqISfUKM4h8SDUCb57UTJCti8WvGdKUdHQgmHqxYv6WuL0OkQ
         Ie020++lAot9Io3kl84mWt+j1W1qRCtpi1Z5yuL4/37S50SlXfO9NT6NVlHHP/39Dwr6
         8Jn1NXJMjn5Qiffn3BDCwGyzP1/pxqO52hhcAEY9JjkFZuOILZ6X5Z+KEHmXjcy1/mtP
         mwg0YIjM1CQC07IfgzzQJj/1cWltdq3dbk1Odg5npI2P6Tk4Afn1K8/UYDk0CLg4iGTV
         bF9f4zRgvfoH8gulElldRhUtdalM3HnGBaWltKGMlVQs0/fxtzw4CBOs1FTdYAPf6+RR
         6EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669965; x=1781274765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCyBNJ/ylx5emz4aUuzKv8JbqXU6LzcxMdMp1pmZQIo=;
        b=Nn4LhczfCLyS8KEc0ouDyaOz1fXMV1q+8zimRkDXiZOkB9SMi2l7AjNvPsZBg1bqxL
         bDiAYBRzH9qCeVJfZeqAqDUVjioi/cM5HxGkeZ9TlchvIYiW9g70eCl7BK/9IqXKNTgd
         hQ07xyZe6W9L0Nu4aB19PMjs+I+DdKaz+YM7T2YtqiYAOuyG/9ek3mi7HrXMfKMJwAcr
         MywBcjPxHpB0YvoAESe7I/zTOArvDswy8oUmDCMbtii0tCzJDRnExd/byygxgd+W5LyP
         rKkWdAmuoVVyepl3LLdvjv80kEpWJpbUeucBzMSkPAIjeQf1K0n+ta6mLiZYM3GDh3kx
         u/pQ==
X-Gm-Message-State: AOJu0YyfXjp1Fs24eYgLJdVcygTb7qXXlhWdrS9EI6TjIEZPb/iOVCQ1
	0T4OnUb0gFLqkXnBgOcUASZBcGADYWOFT5t6uWm/oSMHBQtuaI/9s5BHYBk2w+qFxLNvvIPx02e
	hBIdT114k807JY5/I9SPngbuRUmYFin8=
X-Gm-Gg: Acq92OF7P8O9GJLrG4SMXdK5ZMsZ7y3bX37DwhczdH8MKX10cWW2IODZJsy5/4btwjI
	w73yAnmw0gvOf66nnz81WdczLSCIBo9arW3Bush98wz8by+s3WHCF/r5gSY4fxukeeZUE4UKLLo
	/rSW7RGrZjlhDatOd/QV/R3mvw22inmWt0h4uGfMqob7eqsapeQBBA9YAUEIMI2IXRHD+akN3em
	BLljMHZypaDokJLCRXu7Ld2dLQT/ySovstTXORfgl5ANJz9AplNiT4EKE7YinOUVgKZTWcX9WRm
	Bf/k/d5Wm/brTxw=
X-Received: by 2002:a05:6512:1301:b0:5aa:6946:6e4d with SMTP id
 2adb3069b0e04-5aa87b7da75mr1086831e87.19.1780669964308; Fri, 05 Jun 2026
 07:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171912.263475-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604171912.263475-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:32:32 -0400
X-Gm-Features: AVVi8CcmQ4uGVXFHn5JwAPveZAml4pR0YHUMa0wEKkhIlfBXeoQzA7vRZPWKM_8
Message-ID: <CAP+JOzRJnb+3AegCrUrmf=2eS9Ax+Enm65uFOy7iPqOe+ZfGng@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selabel_close: only call func_close if set
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:19=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> func_close is assigned by the init handlers and may be NULL
> on an error return from an init handler prior to setting it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index ad40440c..dcbd60ab 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -394,7 +394,8 @@ void selabel_close(struct selabel_handle *rec)
>  {
>         if (rec->digest)
>                 selabel_digest_fini(rec->digest);
> -       rec->func_close(rec);
> +       if (rec->func_close)
> +               rec->func_close(rec);
>         free(rec->spec_file);
>         free(rec);
>  }
> --
> 2.54.0
>
