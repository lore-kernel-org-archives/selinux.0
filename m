Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB430F928
	for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409332; cv=none; b=QouxjqjU+ZO6WjyvL3XN6u4I+YDx84fMhLZUV8LPCx9vDzRvjbUky/ZDXL2Z0emO9KqfQhR9qLgZDBgs/stOf717bZXTVb4ob59xy+/I0pWUTVUkigZ8ykU0hOBzzs0z3MVpfM1IvEX1sMqEiy7Y57pK6yyjDYHznbwA5oZC0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409332; c=relaxed/simple;
	bh=NtdKcL5c7BmMgBjiLJQlf8nBTackZ6fjdV2F7j434P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiiQujHIzVX5SWZQBATEjU1Yow4hZymd4e/LBCQA2D4LPophizA3IHm1jb4IA64sOS9DYSSc+Jsakrl/7cP6JrPpAJD1PUtoF/SJyzbiimiefXwUJkcNQRAXx5rxFnK8MmHdLnxkc30BXDaHDFWF68EbTw06mNVER8yfoZ/fxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JRwpY1vo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JRwpY1vo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2980d9b7df5so49035385ad.3
        for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763409330; x=1764014130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GY1ewbFuTn4dO8AQS35nS7vG8LG+KqyxlF8K2cI5yg=;
        b=JRwpY1voJ/JDSLsRpod9fLbW3kjApdnPbG3HjJ5Gj9vCnQMbK59WqylBJJVzed4aQu
         9tU2XRazWWF+OdGMKTYGT7GIMtMMDpxBCwPICSJcxZYmw+G/0ikUHtU9NXQcHHv+/asx
         O40M5nuWU+BhAJMG7iVNJII75tXxaTQQTaCcfYGTaT/ysKMpp9sOTZJW6THCuWl9fsCu
         pr6YGotBpW29eBugyGO0lXDWdWb2CPOhyxpngc4FoPjTmE789aTCUZK/AOrt1FALnt+J
         Tzf6/DS8jdns2b9Ew90/8y3KZ3+pj4y7LkddxPDDhFFwCqdFaQ8yCpSqaeiJFrEUx71q
         tyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409330; x=1764014130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GY1ewbFuTn4dO8AQS35nS7vG8LG+KqyxlF8K2cI5yg=;
        b=j/PZMRZlc/PNzSUr66gY8whwEJUF+MAaxh/BAWpDP/Mo+3cLagQ3bVk9kpE/nJMOIi
         h3ypxHQWu2pubmFYeATn1m9gva1Aa7THSKhphN6h/63GDp+ud8j/RTRhFimQ7CENUqaf
         3tqdDgZ1009bhrhQ57lZf1H+NHvFF5AOVXEZC6lYynDqLcJDgjWK4a5rMApo7ubT9yLv
         Fo/NZ415oXV909u+IklSFUinIddG4bUVp6Xsx9hqxu4Nuu+eM2hHIxbvkYWhL1FCp9Ni
         l1OMLwPFsZmFKe/877PtAj6DJDzYcT/MNfCDJ0sfh6XHPPtfTbJmny2xRrxHLqzr6ews
         Xxew==
X-Gm-Message-State: AOJu0YzSO/hzRpMB07gibBScgSNLDdbfeJhmfFlRKVONYs6f3qXveihd
	ecs2RPTwIQrs1rn7SCG+tAQplCNt7z0YnJM3k3ghnlrhKtdR4V5VgMshZnOfjWwYFTKj3L07idM
	BssbzY1wayputfRisPb8TVf14/KRDNF3xZEuvup2KivFX7PkPCxw=
X-Gm-Gg: ASbGnctCSNCHBn47MCOvtbntuWklQWkXfgAJ8wyXF6OGjsjTt0t888UhJC4SGloqWAB
	BdHYzpgxwR4DAVy46PbpbwprMd/papSlRplTIr1woZIveZwGouAXVJbndipe+EwgP0Ft8uKyDMk
	2MpxJnaIx2FFzvXPJZsc4MF+DG2Bf0MkIwLqnNZZ/86ACvxu9zRXIq7gzjkVbUwbW2WtMNGybex
	mIJGZMQRZAWc3ICpCM/9Fla2mtJwc1SuyGPykYwCW3nV2z9Q8lckA+Vsshv7wTZhj4qyI39K0H2
	sjBaSA==
X-Google-Smtp-Source: AGHT+IEfVa8YDob/5UUbaKax7KJ2M72DsdeDgpWwmVswpgtum50vuEqi4mNzVrL7M8RpWVM6C7Q+tgug0gDwn0G+NrU=
X-Received: by 2002:a17:90b:2f08:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-343f9ec96c6mr14490229a91.13.1763409329996; Mon, 17 Nov 2025
 11:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Nov 2025 14:55:18 -0500
X-Gm-Features: AWmQ_bk07FNkb7sraV8EEyijfvTIbLDVNiDLKCzt3Qy5qdW8BXCUs6_KnssFZes
Message-ID: <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: move avdcache to per-task security blob
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The SELinux task_security_struct was originally per-task but later
> migrated to per-cred when creds were first introduced to Linux. The
> avdcache was meant to be per-task rather than per-cred; move it to a
> new task_selinux_struct that is allocated per-task.
>
> Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path wa=
lk overhead")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 35 +++++++++++++++++++------------
>  security/selinux/include/objsec.h | 13 ++++++++++--
>  2 files changed, 33 insertions(+), 15 deletions(-)

Apologies for the delay, I was away the past few days.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a22b1920242f..0eea43e4a90c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callback(u32 ev=
ent)
>  static void cred_init_security(void)
>  {
>         struct task_security_struct *tsec;
> +       struct task_selinux_struct *tsel;

I know we had a brief discussion about this off-list before you posted
the patchset and I asked you to move the task/cred renaming patch
after this one, but looking at the results in cred_init_security() I'm
regretting that comment; the naming is just too ugly otherwise.

As this patch shuffling is my fault, I'll go ahead and re-arrange them
and follow up with a reply when they are in the stable-6.18 tree so
you can verify everything is still okay with you.

>         /* NOTE: the lsm framework zeros out the buffer on allocation */
>
>         tsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> -       tsec->osid =3D tsec->sid =3D tsec->avdcache.sid =3D SECINITSID_KE=
RNEL;
> +       tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> +
> +       tsel =3D selinux_task(current);
> +       tsel->avdcache.sid =3D SECINITSID_KERNEL;
>  }

--=20
paul-moore.com
