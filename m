Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A792F24;
	Fri, 13 Dec 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104800; cv=none; b=SsdtyeRLAisqxz0pyWzLxmn9y7Ah+++K/9v/+EYV4y9j0GrrAsoPalseU+LT/WLs7NJIODGVMugzioAbY2CS0zX5lGxnZ5f8/HssPS3WRP1F0C+DyXaybfVGLf6zgqknSkhGuOGGAzNP9Vq2ap6Z5l+NfXR7txMK5MleZPEWE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104800; c=relaxed/simple;
	bh=yDWvwmhDMeacL/yRoDS1GfmjTJAOd+U0Gqm66CaMR4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBviH++RfxZehOn1fq5vqYd3RLtJDQEjzTQfGhpujACKUV5vAKUfZ2AHZRUC6W1ujR2rhh61/YGE1rkSMxSiGZCY+Mk3q8FylvtkZzernjuVqgsmQuDpBD5H4jROqGQRYtQypaIT0+XsJkzMs+SkOw7/mQc/YepJIBp/mEwE6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKnxpLP4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKnxpLP4"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-801c7e6518eso536976a12.2;
        Fri, 13 Dec 2024 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104798; x=1734709598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vXA2/urSSs2Rh5p3xBC9KaPnKWnmLtFXFX4YA6dOUY=;
        b=iKnxpLP4VwCdmM/zmo30MKcfO27kSI+W21doJW+LuBiN9vT/2sO05wK5zaaWdlfuiJ
         hM4h+yJrp3Z6WAXLR+w9W2aIlfq/SKyiNJgbgBEsoYG1mqfEuLkHypiMm1J75csYwf1l
         k/LNRMROHcUWaXoL3ms8xoxDm2/+2KpyXF5tJ7i17BZfXYZDU17O6Hr+ARqJpWz99rPb
         S4QOqUSpd6kTKnir3ojFkVz/IQM6AApQDG6MoQ/KwkA5GGbloxFvozuriSGfYAOKUs2o
         ltKmzI0luF9WsL10EoMlVy5jcGpInqElYQdWnCSZICONRJYRQTz3qzdffpjp4On8vJ0t
         Ltpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104798; x=1734709598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vXA2/urSSs2Rh5p3xBC9KaPnKWnmLtFXFX4YA6dOUY=;
        b=dBUjOwRySIW/aZFsBSFvlVdJnngfhEX34m9FgUnpfxem40zLQNdEv83/0Lf5ActPtp
         MhK3A+QDhloHlfvUhbrIynK+ETzoPQGLJNcI1IEOzi1rU+ly16Tsf7CN9Ai9FIZFqVdl
         1xmgCHlDqARfCQT7zO0oLd9KVEoxbYKP6sA6tPImVEyI5fTX56wLaezrneddFDuaPlYx
         PEoxzEisaI3RkMRC4uGLrXw+Z+u9Um0aUsaYeMZPfGGY0RQLl/ameAZ9ahi1f+5gnEsq
         Di6bXrpRJW1k4aJyLtioJWaoAdQYbyP/CvCcBg2WyfdbyhQ4T7qbfTLa+9LsV+XuukXE
         IXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPJ8fAHTiot+c5bSrLItQ5i8hmaGocpqjC6bBYmTKgL3nw15hkzi6/DKRNISZJgSvedwqoDT7TFZrWOqniWxJ6VLO3ek=@vger.kernel.org, AJvYcCXVALwkOamvqSUwxZEG57JJ93V4KyC7SWGVLDlQYBcZysBhOUysyshafh/kDTWNfWQhiwIOcPPY+A==@vger.kernel.org, AJvYcCXuPiikhpKOT4Q1UFjM5bQtPQBt9Vd6DKYJxCv+AO5G9D3C1OkRrar9fWsK+tDY6qibBpcDV1mD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SV8jx24feUp/8FTJdExIG5svKXJYUAD7ng17dkgjGnDBvH+x
	ZZODz79WOewgax5GRrqz8vYxQrl0QH5lzWSyZiAe8FgYZp8kGT3wbvFBHssn+3P8mw+KNOx5+YX
	PYw2CLw1DBatRylzL2CroMs4Yzc0=
X-Gm-Gg: ASbGnctImJHOAx4r++hlomCifrQItS7yhwCutPbS1erxgJmdZTZBfBO5/ipwzLRGHB2
	JtMN8AE4uodEwYyXjYFSTQ8Ti8IiUlWxQ8l3T0Q==
X-Google-Smtp-Source: AGHT+IGSoI1gRTcKmTJ6qDwY45AoOFeM+TOJQsXJVS1HcUojGwkYvMp1Yp+U2SfDzJ70oJ5suMPNWbUxXV0qJejlsjU=
X-Received: by 2002:a17:90b:3d0a:b0:2ea:4578:46d8 with SMTP id
 98e67ed59e1d1-2f28fb6f01cmr5075422a91.9.1734104796398; Fri, 13 Dec 2024
 07:46:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net> <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
In-Reply-To: <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Dec 2024 10:46:25 -0500
Message-ID: <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	paul@paul-moore.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:57=E2=80=AFAM Mikhail Ivanov
<ivanov.mikhail1@huawei-partners.com> wrote:
>
> On 12/12/2024 8:50 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > This looks good be there are other places using sk->sk_family that
> > should also be fixed.
>
> Thanks for checking this!
>
> For selinux this should be enough, I haven't found any other places
> where sk->sk_family could be read from an IPv6 socket without locking.
>
> I also would like to prepare such fix for other LSMs (apparmor, smack,
> tomoyo) (in separate patches).

I'm wondering about the implications for SELinux beyond just
sk->sk_family access, e.g. SELinux maps the (family, type, protocol)
triple to a security class at socket creation time via
socket_type_to_security_class() and caches the security class in the
inode_security_struct and sk_security_struct for later use.

>
> >
> > On Thu, Dec 12, 2024 at 06:20:00PM +0800, Mikhail Ivanov wrote:
> >> selinux_socket_bind() is called without holding the socket lock.
> >>
> >> Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
> >> of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].
> >>
> >> [1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@googl=
e.com/
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> >> ---
> >>   security/selinux/hooks.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 5e5f3398f39d..b7adff2cf5f6 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *s=
ock, struct sockaddr *address, in
> >>      if (err)
> >>              goto out;
> >>
> >> +    /* IPV6_ADDRFORM can change sk->sk_family under us. */
> >> +    family =3D READ_ONCE(sk->sk_family);
> >> +
> >>      /* If PF_INET or PF_INET6, check name_bind permission for the por=
t. */
> >> -    family =3D sk->sk_family;
> >>      if (family =3D=3D PF_INET || family =3D=3D PF_INET6) {
> >>              char *addrp;
> >>              struct common_audit_data ad;
> >>
> >> base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
> >> --
> >> 2.34.1
> >>
> >>
