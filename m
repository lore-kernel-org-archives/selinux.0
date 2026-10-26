Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793045597;
	b=ltBSDXvmTiX3t/uiIZlSfSBRS2SDpd00RFyQvKi+xHfOqpFRJvKaY5cbEohVJYmcxuiu
	 aEfofA0HSexhhlHsnpZpcaBg/9wWp5xAObcNR5/SnQXTa75JcA6U6Nv8ICeSGa3E7pXFU
	 Wp1w3Qpg3iY2gR831167tLnR9vMOJt+yYiARGJiavapo64d+72iDX3uYK4vq0rarv2AS7
	 aeINT7mwsyK8XiWnNElvMtId26tyD0O13VGeuIQJauHeyk4URBHauMmBVPU4nxmf/VMLU
	 eXoLOJldUXN9XXSsrgKNhqe47FXTbIMADX7GpYT3jFaAAlmaVJKKI/KiGQfXZx3NNmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VApk8RPCy0Isfp/74lkuD0sS5p6hBmEBuNwhyLUKhrg=;
	b=NMPNBGjJnrg7inW2B1mXUTft+mHM0SGKlZrnUv608cBnYrRBySFU6Sa199GTXNJjOYCX
	 rblVGVcFgLzhQp1BpsM/Mj+ViqTxtlGVYWSwIaUJQrTyn8jwPdg9JICngph362JDAGtI3
	 tVpEzi1dZd4mZ/9xl2qPANN88bCQ31mEtcw8rSqnJg4d3Z9Hvhgn7aUgQaQ4xosjIt6Jd
	 9D2XdpT8JsEo91D5OUAn64ZCU+SxMidU/afwk6khXmjZfKXrz8e9i1BxRm+IKoXBtfwxs
	 S10o+Hh3Y3fy5AYcWmmR1ZtOOUE4bTqp22/xRRMFcjL1kWZfHJPykYFYgQZZX//eNkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yn1ZRrle;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0D606A320
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 20:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B0D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yn1ZRrle
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798eb0d13fso3587733d50.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793045596; cv=none;
        d=google.com; s=arc-20260327;
        b=l/aHww+zFsXyUFKcvXeUSOzbsf28tFxsuOZB5NkRfI/l8f718E69QvqGvGLK2l3Stp
         rkqhMjw7fYWs0eohagoX4P3xnZpShflDAlmotKO3+j1Tpst6VQcYX8vxZ8EQY2Bey0YX
         iNgAZVchdp2kDCOo78Q1scld7hQS7SHl8XLzRjlF0GpfiAW30qi7Up4taEnAM+7AL2oh
         r4yx6k1ccFvh4NPNBdFM1LdJqaERb7wnrbytdyLVoS3COA9qS2D626cx0isG/qpAoy8H
         B7r/Qr2DH8P+vkCt4j6THexUx4pw/YDFf2Y/Ymf1uBs5Fkr6c3/jMVKTtwOTpzyunvLH
         0aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VApk8RPCy0Isfp/74lkuD0sS5p6hBmEBuNwhyLUKhrg=;
        fh=99TLgBUCiW7lpV1N792WBDDaz1uWxETRBfhRBi4L9U4=;
        b=Du3dWEoi+NgHDmPC4Wo9ekpoTtZ1YiCum2Y2oxNjJ7wusRBwmXr1oUjglm8Y+kQIUl
         XKECy2JPOOcIiMe1gIT+wB/BjyuhWWRKsOP/k6K0XRrOeN4O/ou7ci4rb2BfnKLXP4/3
         PAT065KtHrBdIaLdYV1HKXwsDRGw1jIMOeMKJ92C1s7HI1jaqUcy+jhJwwFt5GzVpacu
         evip5ug5c+gsxUcglxjM5ISp4VNgsHtdXaNXfQquYWAqdYW7XyMCeBZOnlF6UZP1n93+
         fo70op6oDpX+R/mguhz6cPk2vIp/YR7bSUjcYV3QD1hPEbm55SmfOrY0EppHwrvNXs/c
         7+WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045596; x=1793650396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VApk8RPCy0Isfp/74lkuD0sS5p6hBmEBuNwhyLUKhrg=;
        b=Yn1ZRrlesT70B/Mx1NXPaXJb4mw8QkwJICHnuYlZpofh35d4KNBQiD/YA6A+QGlt26
         V/FTW0SI/wf1zs6jyF/Os62VsyUK7fwrVomXTgNc8betIw0P2/Z6qhRLIVewOcnTi286
         uHdJzPy2ekQqJ+jLPHnds/T2xTFNWRSaQZkOHZzUGsEJCT/kOfd4UasKKxxbgstZKBSC
         chnDNmb4xMrskuiDEDew8JgBEpQxCaAyUFCfvbHOxVdyHAPNIPEW8S6LjyWBsN/LBogm
         KJCyXLEItV1Gi98kaZEVCPUQN/qNBDjWQUhBg5hJt7uICZ6iVeIYS2lbptILIk/qm/5T
         gGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045596; x=1793650396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VApk8RPCy0Isfp/74lkuD0sS5p6hBmEBuNwhyLUKhrg=;
        b=Iu8n70PoV2L3eQfx4MpXP9FbcHayKWdwKPv9IPE4uL5ktRPGqa/tJ/MWdGNSc41ADj
         YQD129RCnmLzb2ERoQRriHQSpndHwHJEpE/G0Bfa0xwMxnPmnn7B77BHHPASVT8Aa/Oj
         1gMjrCa5XQCo+N9HoZqT2Hsk5x6C4xDUh6ls8oPS056kusA53W582HK9f3ykCYTQGyyj
         EGWA0KeDxPJXNWYHbe1YHVo/ZMy7biIJRDBxb8hu+6X1R7NCdlOe/S4vfSfU3RW1ZV/i
         2MpwINS5JBY3hm5frM0tJlU0+mCjzmCsFTHTN1QWVfsfXZQ3zjgaQofZYS0fHurC34JC
         Ap9w==
X-Gm-Message-State: AFq9FYLtCwqC2qxJfnc6OyuOzuVo/Jekb3FL2Oa3p8yvTDO93Xwy3vKb
	nNTUXXmDkmwL7AkyD6DXXvk4QYyR0uE+pLv19sSyLDh3qofp4DnEkyt9lvubJPqbvEm0woFbt3k
	EdL3oiaMW9nsr+yumNdPok72qtdYcw9QU9bBiuPw=
X-Gm-Gg: AYBFou3WqTe1WRgHr6WetT/pn6yiLQ8zrtGXt3V+7NlKERRFO1vGCXUp+2eANVYKthL
	iZdmxJQCrDwAv6KDK4P07MFVEYzkued6md9OxOu48Tc7T84+cRY8/K54jOM8JzHLbGgncYSUN/Z
	EP9wRdLjCTTRqqff4TpaGQOx3LNNZjDxmXYYhygwopIl7j2+dFfboQJvfBZvMcLfHZLUIxPtqBW
	+qfE72a4YtcdhMit/Vo4CWtp6qzZ+Bd/C3E43zPB159fN89AIhiyL4KF2ZRzldTqEHGNhPrQvAn
	cu01JaRNixhpOB1nHmTdVmtPL6Nnn+mZK9NgQD+drK4omV0elt39zfYMzvZvjorVhzQlNZgdfEa
	VpDURSqmQmhn2biD24uD1HdQNEBQ40+Vv7FRY4AWDXv+Vrb3kX7Pv4hKA1QKfZrlNh6d6TgDT8I
	xBouKmSPuWcURGs2MC3y3EKa1xYUBUqsRVYHMk/vsPPro=
X-Received: by 2002:a05:690e:4193:b0:67a:3417:1747 with SMTP id
 956f58d0204a3-67a454179demr3903524d50.106.1793045595797; Mon, 26 Oct 2026
 13:13:15 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SA1P110MB166157581CF3D150601ED288AC61A@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <SA1P110MB166157581CF3D150601ED288AC61A@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 16:13:05 -0400
X-Gm-Features: AclHuK_5sM25nVVOZvQ06k3qI1Dq_P7ai4vBRgxtnHCJJjrKfrQPxt9kCu98ku8
Message-ID: <CAEjxPJ56sJtPYT7nptEcMTP3HKh_dfyMOdfGQnxsQn3uaWZn8g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Allow unknown permissions in permissive mode
To: "Sloane, Brandon" <bsloane@owlcyberdefense.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:37=E2=80=AFPM Sloane, Brandon
<bsloane@owlcyberdefense.com> wrote:
>
> In selinux_check_access, we first check security_deny_unknown, and allow
> unknown permissions if that is not set. If the permission is known, we
> proceed to invoke avc_has_perm, which handles permissive mode.
>
> The above leaves a gap when security_deny_unknown is set and the system
> is in permissive mode. Under such a configuration, selinux_check_access
> would fail on unknown permissions prior to invoking avc_has_perm. This
> commit updates that behaviour so that selinux_check_access treats
> security_deny_unknown as unset when in permissive mode.
>
> This new behaviour is consistent with the Linux kernel's behaviour,
> which allows access in permissive mode for unknown permissions, even
> when deny_unknown is set.
>
> Signed-off-by: Brandon Sloane <bsloane@owlcyberdefense.com>

Your patch was corrupted; please submit using git send-email, see
https://github.com/SELinuxProject/selinux/wiki/Contributing.
Also, see below.

> ---
>  libselinux/src/checkAccess.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/checkAccess.c
> b/libselinux/src/checkAccess.c
> index 3cdd2413..18e4abda 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -26,6 +26,7 @@ int selinux_check_access(const char *scon, const char
> *tcon, const char *class,
>         security_id_t tcon_id;
>         security_class_t sclass;
>         access_vector_t av;
> +       bool allow_unknown;

If you are going to use a bool variable, you need to add #include
<stdbool.h> to this file as well.

>
>         __selinux_once(once, avc_init_once);
>
> @@ -47,11 +48,13 @@ int selinux_check_access(const char *scon, const
> char *tcon, const char *class,
>
>         (void)selinux_status_updated();
>
> +       allow_unknown =3D !security_deny_unknown() ||
> !security_getenforce();

This is a fast path regression; we switched over to using the SELinux
status page to avoid requiring extra syscalls to check such things.
Use the status page interfaces instead.

> +
>         sclass =3D string_to_security_class(class);
>         if (sclass =3D=3D 0) {
>                 rc =3D errno;
>                 avc_log(SELINUX_ERROR, "Unknown class %s", class);
> -               if (security_deny_unknown() =3D=3D 0)
> +               if (allow_unknown)
>                         return 0;

This create a mismatch when a caller specified AVC_OPT_SETENFORCE upon
avc_open(3);
in that case the callers wants to ignore system enforcing mode.
