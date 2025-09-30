Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F718A921
	for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262495; cv=none; b=k2Qdnl7+/k3mAQGwUCuJK8PJYxBfDp0vesPOpcAsRJtq/xh/Ndi+L1uQt5H/lxSGxdz7RrNj8N8Azt/1/Sz5CzvPwY/u2DVnpGZVcTW5s8LVyUqysqMlTB/WCQGLbcVQJDppIFITUTc0IcKqIYsvNKzEplJduQGYwPDCSCkXYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262495; c=relaxed/simple;
	bh=7qXSXpwVfyrxaE3FEVMu6hX9GvP5VO3R8heXpEJLsCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfP8PQKwegTlMh7oe7kgj9WP1QEXPm3T8eTej8CfIRyRheN1tyk2KpmGjy6DFEJzbfbwF2/fsp9njxJTKTIZuPpoYmpogkGwHIVDe/QnnvukaKOgud4M1gCLUdx42APnyVTsg7pGdKNmKK5z6HkMu/MCKGxiilGyKoXl0FcuR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUf7Icdj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUf7Icdj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso316912a91.0
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262493; x=1759867293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWo/NJp/DPDiDhi3M8vILdvcM+qNCQ/99XIEYETWfbg=;
        b=GUf7IcdjOChsPLsDWM4vCCm0f2dHMAZlEgyHjbsCgNQ55d3qjxam2KNrC2tkC0yGBT
         tMeMxA4+5VJZij06LoHkx1q22phZFi9dsJNv8u6B02aRsdsqil2tYGT3TSchwR9k4PU2
         cjpVfin5nUDVcor8zKVriBZXMG558cMzPodme3FAz9pbq1gab5WUcxh59D7byc4mWCwR
         J4B/lHP5PV5drBvaaZ5V1XN6b4j2vdtZFl6TSApstloeeeFxaDc016EXQ7jL76nMTMZ5
         puqTvz2lcRI1UmdEqEiHfYHlJKTtsAejhMkxauzVTOG8K/xvzmNF7TDgbsje5CewGSim
         bhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262493; x=1759867293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWo/NJp/DPDiDhi3M8vILdvcM+qNCQ/99XIEYETWfbg=;
        b=IGN8GrWO7EWIGq/dT1SZCt9e3hpnXecx5UCe7I8fhv9Gs2+dcgrcCM/fU/gPqLAw/4
         J8/qavEsxvfwJiIVZZPerSHjT3sjusSUpp/FUYytkUP/41qIqTc8fUvKxRhTBE3v3GuX
         PzaAdaY1Wz6FJe2Dea6Ef9PWyx4G9nDWvxwd+q3PpHNTN5l/srCB6JlqAeToi7ue1tLt
         RdFy3eUXcrx1kNjhSUlouP4L95Gcfvh/NT8+D8X01uQuyOLFlqGU9X+Ri2Wj9nnXl72b
         feie1zUlel1FfO16xB2MqWmAXdiUi+nP49K/lwAqGjdtdU3CRzDByn6QpTZLHcIbL+JS
         APSg==
X-Forwarded-Encrypted: i=1; AJvYcCWqY38j0GUlvehUsESTDeWueeFu0MLfhvxKosE+Gn5G9+JkspqyOuJHQWK2bgsL3VzWZAnhh+9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4e0A2XWCA64QtYISwR6kOOybD0l8sD8kQoDq0gh5aroJWnhm
	3prneainCj+5TL7WxOzeHMY5xy2nkZe8fBMofDcyqeMQMTR+f91/Ltzu7E8mAWuCIlKwfUrI4OI
	V+hhx09w7FuQNC+yuobogTtWRVofYFY8=
X-Gm-Gg: ASbGncsPCbJzhY9ymKOYzQg+7+Yrj/AeW4056lDOEWAfUZhmGw5qnhB7Rp84+4tSVR9
	gnN1mW3Crh3IVc++7UpvD/Y5aor3MUYrcXLR+rc80TwOfBvXF17FAeSNY2JiuhxRHsNCohwlFTH
	aEqwFxfy2XAjEZ0DW9a92VMEJjyyrQauv++vRb1leDJwa+Bjh7kKYn8Ofj1P38nvjnjetL8U+u1
	xJKqNgLMziwtI35Id0WYukH+n/sLOfq/kutBHKZ0g==
X-Google-Smtp-Source: AGHT+IFxATyDJkay6p8QMh9yzWv3yKV+bBLM0X9MlYJEySTUExIFQU0lrSPEVy/e9b8CyfriTlVARknRoz8I1/ieR+s=
X-Received: by 2002:a17:90b:2241:b0:330:9c26:bf3d with SMTP id
 98e67ed59e1d1-339a58b74abmr1094619a91.16.1759262493116; Tue, 30 Sep 2025
 13:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87pldq40fr.fsf@defensec.nl> <DD4XI30UAJ8U.1XMTXFPG4NYJ2@gmail.com>
In-Reply-To: <DD4XI30UAJ8U.1XMTXFPG4NYJ2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Sep 2025 16:01:21 -0400
X-Gm-Features: AS18NWA9EuY5JyyTzMWfm-n6I6s0Fu39KnzJ0fVAhe04DW1mUJzCkbZSYHI85pw
Message-ID: <CAEjxPJ7UHmeQcxDETObNm4sQHAD1uvy8LsBq4JRCf=UvAwCfdQ@mail.gmail.com>
Subject: Re: systemd.exec(5) PAMName= with libselinux
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: dominick.grift@defensec.nl, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 10:29=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> Hi,
>
> I think this is solveable but this is going to need a new field added to
> default_contexts + $selinux_root/$policy_type/contexts/users/*. I had a
> look around tonight, couple notes:
>
> 1. We can't really change (and shouldn't change) the function signature
>    for get_ordered_context_list (3) and friends.  However, we shouldn't
>    need to do that (see point 2).
>
> 2. So long as get_ordered_context_list (3) and friends still can parse
>    the user context files, we should be fine.  They all seem to rely on
>    the same underlying function to parse those files, get_context_user,
>    so along as we update that to support multiple "fields", and to just
>    ignore extra fields, then that should be okay. This should mean that
>    backwards compatability should not be a problem at all.
>
> Then, we adapt pam_selinux (8) to use getseuserbyname (3) to lookup all
> fields it needs manually (without using any of the libselinux helpers
> for that). Alternatively, we could add a helper to libselinux for that
> that supports the new "fields" so that we don't break compatability. If
> that's a desired route, any suggestions for that?
>
> One concern I do have (and something I'm trying to keep in mind) is
> ensuring that libselinux doesn't have a dependency on PAM, or at least
> that our entire user login flow is completely dependent on PAM such
> that it's impossible or hard to replace it, given that we don't have it
> as a hard dependency right now, and I would be cautious to make it one.
> However, we are just adding a field here, so although we can have that
> new field by *convention* be for a PAM login stack, other software is
> free to interpret as it wishes.
>
> Another option would be to try and deprecate default_contexts, given
> that it seems to be showing some age in terms of no longer being enough
> for one of the major pieces of software in today's landspace (systemd),
> and introducing a new file that supports a configuration format with
> some kind of KV system so we have named "fields". However, myself I am
> not convinced that this is needed or worth it right now, but of course
> open to ideas and suggestions.
>
> Thoughts?

I'm not overly concerned with requiring use of pam_selinux and/or
replicating its logic in whatever authentication system is in use by a
given Linux distribution for user context computation/selection.
Others (particularly distro maintainers) are welcome to speak up if
they disagree.

I'm also fine with incremental evolution here rather than wholesale
rip-and-replace, but since you would be the one doing the work, it's
more a question of what you want to take on IMHO.
