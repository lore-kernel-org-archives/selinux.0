Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46824A7D3
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962154; cv=none; b=s3oGMzc87MrUSBX1Q2Ik7+zYYsGgvL+pjr5VupAeVe4PiOZeuNwHJLjlA+zfbYXjwZn5KcHKaemNlDB/wMdPKDz5sMpZbfUL7nzqHe+G0x7n6WiRk/hPn2jUPCARvCOu9K0VrvQ60N9n2Vxcba7jUFg+RFWjN2s+BhHQaR/u2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962154; c=relaxed/simple;
	bh=3Z1wSVgu9DX6AWGrnMgDcHJwzXFHWiHjrrJ4Z85mw/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSDepodudEPUV0VDS+iYtDxh+YYWEIWAokD8arRa1A9ZpfAOzIih2fGWFc8iM5Ge/qaMTKaCmJJFP6LYf7rWHWooAO+iYUxBHB7e4ca1eywTs0YwRNYckNAFtz4IuXsjqQAct/msDOR+1gkdh/xZ1SaLyAGzTv5dLFuC0hSOJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TRIUlqMJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TRIUlqMJ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e398484b60bso10590631276.1
        for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736962151; x=1737566951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ho5vWfIyGqdayu0mn5cAMk4IND86P5Ih3gYUlwO5LM=;
        b=TRIUlqMJE7d1zVK9ChVpv7d6ClUBY/2hoiK+SOVUclGH6kA5eY2bFaGIzGLXRArIpT
         iQBva0NCv/M2jM61LEsXvGZ6hA7CWda125KdpOsjXAwP2RUZh9QTTBKfEsC0nc3LTbpg
         wUlMS/B2JSLsJIKC+JVa/jOvbUBU1loq4QWabxkAuB9YdFcPH/IMsOgYCYxgfeJDTfr6
         iZHMjt7zNZJvnAKTDB4ACEmN3Nvyrx+3wQ3Ilz9qhc4qzmfLOKD2Qq6WlmzrjTJBQOm+
         mopnlxZsN6rlh97C5tQCN6QdVGpA6cL5C8lYSb9Cm+xzajIoYwv2tCQHOiXIEvis0PSj
         o5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962151; x=1737566951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ho5vWfIyGqdayu0mn5cAMk4IND86P5Ih3gYUlwO5LM=;
        b=p5nwPYNQ8/HtgQTnxGpZ6Y4TUROdLDJujJ6edVrF7HALGFfyT3KyIvUASd1fmRE+Is
         +qCyvcJ8sIJMRzwH034+BT3G7eQhqJyRDqYoQIJBROgwXS/SU0kGEdP1+kdLIDKAnq+o
         QlPZuVCbeDOwVL//7lnTeaxrr3atwPqsBp5Q+wNRcGZ1CzC4ZAnwDa1Gn843vnZ+w59S
         WYIsb8gcxlydHRsMtw5U+f8kb9G/6j2GNl2F7UEWnV5TDx9H4C1JFqeEyg2ZFHEg4Xhk
         /g3J7nPfouT4m5ytAWvfVjeoOAvVP0xHHe7BtlV700S/i675YHNPHY09vVIKB8ehnf1A
         s0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUzFqXpok54J3UJhwa3J7H79TmuI3YTKm5UEG9jZehSMpVxTBHI4CrCMLh/3na0/5TDhxrk7ex4@vger.kernel.org
X-Gm-Message-State: AOJu0YwINva7O3iAigoB6PJuCHoIvKosWtmJQupZmELsROqi0/dyHcZ6
	YumRlddPP1C0UImOQ5D98aYIC2CMMtfjJbucPBoiNyWuQoDjx4AE/oBieoLrJ8M9m2YdHrlcPfN
	kYFh5eP6A3sw1uL3cJNst0KP56pL5YTy/2b99
X-Gm-Gg: ASbGnctBJDKEFNhUPYJgkfWM2e98iVblAJIJrCcfR2CvuZ5nMq+xnLiJoeA4TlfHUHc
	QupivEZ5PjN/1ne23DuFbLYBQ8XVpBoGdiQWE
X-Google-Smtp-Source: AGHT+IHS9tYzd/oT/05LvfCuU2hNDmtanssgntueoSZkgq3iiJ1Lv/I4SGzz67OKeocKZFDPgvn7fKFXoNeXkBKiHdY=
X-Received: by 2002:a25:200b:0:b0:e53:b023:70a7 with SMTP id
 3f1490d57ef6-e54ee17e99emr16507763276.22.1736962151420; Wed, 15 Jan 2025
 09:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108231554.3634987-1-tweek@google.com> <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
In-Reply-To: <266861ab-cc0d-4a7c-9804-6bf4670868b1@6wind.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Jan 2025 12:29:00 -0500
X-Gm-Features: AbW1kvYRgCbUKUHzVWUmDyI1Ip0ALStXj7NY0DVlm3abI5HxYcmUbQZx-kxTFEQ
Message-ID: <CAHC9VhTFBPG2Ai7zT80m=Ez7RRN5J+1rA+n=q4SrAjrVvs+Dpw@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>, selinux@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 4:24=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Le 09/01/2025 =C3=A0 00:15, Thi=C3=A9baud Weksteen a =C3=A9crit :
> >
> > The mapping for RTM_DELNSID was added in commit 387f989a60db
> > ("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
> > expected from userspace, other RTM_DEL* types are mapped to the more
> > restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write in
> > case the implementation is changed in the future.
>
> Frankly, I don't think this will ever change. It's not a problem of imple=
menting
> the delete command, it's conceptually no sense.
>
> I don't see why the DEL should be restricted in any way.

While the RTM_DELNSID messages are not generated from userspace, the
presence of the SELinux access control point is visible to userspace
and thus we have to worry about the backwards compatibility impact of
changing a "read" operation to a "write" operation.

We could likely have a discussion about which is a better permission
mapping for RTM_DELNSID, read or write, but ultimately I think this
should probably be treated as a read operation since the kernel is
using this simply as a notification message.  Sending, or receiving, a
RTM_DELNSID message doesn't affect the state of the netns ID, or the
netns itself; in other words, a RTM_DELNSID is not the cause of netns
state change, it is a notification artifact of such a change.  Leaving
this mapped as a "read" operation seems correct to me.

It is also worth noting that the SELinux netlink xperms support that
will ship for the first time in v6.13 will allow policy developers to
target RTM_DELNSID messages with much greater permissions granularity,
largely solving this problem for those who care about it.

Finally, looking at unhash_nsid(), the only place which seems to
generate RTM_DELNSID notification messages, an access control denial
on the netlink notification operation will have no impact on the
removal of the netns or the netns ID, only the notification itself
should be impacted.

--=20
paul-moore.com
