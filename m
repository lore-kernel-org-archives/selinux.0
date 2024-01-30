Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD982D99;
	Tue, 30 Jan 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629477; cv=none; b=NIniYS7OoIihMgCRYCqdqjrqrV9gi1yjJ5g+5aylHkHIe06vxsaKSkZjKboFgzFw8pcCQkHQc4MjbZ3BuiQ8TU2ajy42+VcbI3y0cltQmgWDxpF0N3g2RG9wnKa3DrvCFw/NuWntHVOa3eSiwbtbQGAl400o0LfIzuJHNSzMwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629477; c=relaxed/simple;
	bh=Sp3/wjlYLkhjCCUEox3te3THVEOWEpAkrVpDclnzU0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsiebXpQKGFhiTqFj9bUeECxLLDNAm2yeExMB5R0xb7zROxd7jdVOWMX+MeHIhe8LAPYT5n03xzq0TZYGauSw6yj/uSzVY/y+1RsxGwB/URTN+LQ4i4ck4VlQStOgF7t6khOeH192XblA2nZ4zn6a96Y5GV0bfnuRmN+9l/vqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkzwJ6n9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkzwJ6n9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2178232a12.0;
        Tue, 30 Jan 2024 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706629476; x=1707234276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuaT93LFLz+ziGCScWJ84839ONmvBlLAeDp+fGdr6Vo=;
        b=bkzwJ6n9LNtVwL/KrkP8Z/2KKqkfAQStq6h8tP3VJc8fjG5UCc+mgiReCLzTTgeuPi
         PiTLqcWPxWPwV/eoc+RZdwcr8fRp7OKtufJ+ynbQBG4zyPBslgZRfTtiSVqYZnoWpg60
         56/3MZsA4KuOHIqZVjwZz17F9S49h2E/0rNA/acRwxnNOdNNMCynpOKKaMCQWANEPKVd
         zSAhl6onza9mbk4M+6ZdYXIlDhKylkJ2LDh88N4/ZDnG8OIPGY6OLoMLB8sNnBWCZICe
         TA35lJQiylcF6rRF+yQgwX2NqEK4//5CP2Y+qhEi4nTGMfG1h6v0DDTzcuJxNDuPMUFh
         stfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629476; x=1707234276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuaT93LFLz+ziGCScWJ84839ONmvBlLAeDp+fGdr6Vo=;
        b=dDEG4o3Jgf0tlc3cB+PZwrNafhNylHt6JRngemoHFFLuSId78uCw8a0NUP5KT4qbOW
         ADj11HYHLbXjkjsEfcqsRVLEhN5LUw5rwH/xEkiDbDTvVtSgOQANtBiablGNakJjz99a
         y7YHUlDpFNMxxsZia/ZADrbjaL/CqZ0OyXrMsfBVexaYMWanG0Va9Ea6qx7HmermzJ2s
         mlDBLYti6YdT/pkV1WD0c5PqfI1WMvaQXy5XbhoEajDrznW6B1Jylzj1dvwdL/Iir3+A
         8kfY6TwnDhxF9EVCabLek1htBOQWrMUdI56XCoQtQzfheeQNQ4d3pfF1n97l45WZDie2
         0s/Q==
X-Gm-Message-State: AOJu0Ywg1qhTHt5Xbo1n045RGZcqb70Xq5iOIaLCZpc6fJdmdqINMXj+
	hm+XIFXKfk6xz1vbviA8fhoBAnq2/ScY2spUrTxoP74M5ifRLHsCFKEHkQErFUs47YzGpLXwVoS
	HIvEBWdbnKn7JupV0kEdPBsGN4XExsv1d
X-Google-Smtp-Source: AGHT+IFbLruDDd+WSlpgHH9PAcKDo21TrcuUKHlh1jO7W1AT2jj1JMnw5wLgn+KF3e4itajnKljvWvkBVjpaEmt9McM=
X-Received: by 2002:a17:90a:c8d:b0:294:abcb:13cc with SMTP id
 v13-20020a17090a0c8d00b00294abcb13ccmr5449767pja.29.1706629475609; Tue, 30
 Jan 2024 07:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
 <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
 <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com> <CAHC9VhSG14u5UUYiU6kUDt8jGMPkHAs67F_kc5Xt+w_P_zEovw@mail.gmail.com>
In-Reply-To: <CAHC9VhSG14u5UUYiU6kUDt8jGMPkHAs67F_kc5Xt+w_P_zEovw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jan 2024 10:44:24 -0500
Message-ID: <CAEjxPJ4bUoJNhjGAdrPAuHQr3DvK-hLRwt8xUS1tuZgqx3sJVw@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jan 29, 2024 at 2:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > unix_socket test is failing because type_transition rule is not being
> > applied to newly created server socket, leading to a denial when the
> > client tries to connect. I believe that once worked; will see if I can
> > find the last working kernel.
>
> If we had a socket type transition on new connections I think it would
> have been a *long* time ago.  I don't recall us supporting that, but
> it's possible I've simply forgotten.
>
> That isn't to say I wouldn't support something like that, it could be
> interesting, but we would want to make sure it applies to all
> connection based sockets and not just AF_UNIX.  Although for the vast
> majority of users it would probably only be useful for AF_UNIX as you
> would need a valid peer label to do a meaningful transition.

Sorry, I probably wasn't clear. I mean that the Unix socket files are
NOT being labeled in accordance with the type_transition rules in
policy. Which does work on local file systems and used to work on NFS,
so this is a regression at some point (but not new to Ondrej's patch).
