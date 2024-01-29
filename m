Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580E158D68
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565363; cv=none; b=I+gFr7HeIYoVNF2JCiF7DuOLTudDjjVIolGIlyx+wqAiPYMNJ6m+iL5oqkE7ulU62XyaJDNKn7l6N7kjvDREx7oFghhH68d6w8IWT0bvkv7Mr7DzCjcTWFCBXOaZ8LymH9b1S65ROOJVfH86kHwdBIgk0cDwT+kBwv8ilgLR8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565363; c=relaxed/simple;
	bh=ZSZJK35l8EgwFmVZ8i8owr3cheq755BtsNinccw6QN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArbwDV3ZBXnvm44GEvxPcF3/l6bnBbggNX3NqFqyBnnu8p9CxxFa/mWpPCiiLDvxJ7/4ny6YBS0PmdJcxQtxj9EIN3goqxRqT2IMm3GExd7Z6fsJiVeHvN7185gTldcWhvFKCU05YGuIG83mswRoGbSZaDjq4GDmI+WBz2lbiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DpwbYrKn; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DpwbYrKn"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc608c3718dso2743556276.1
        for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706565360; x=1707170160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV/iIRO0zfu5R/kLa/LTz7qDudbKFOHxBhGDjxapsKo=;
        b=DpwbYrKnewJVloDgLdCCgId9G6zHLCpjrwt4IDRcETSqnrn8hfHc7rGGtTIalcgblx
         EFKhYuDy8J6dekShhRyQqE2U/HfL1BTAbokQp2i+r4DyMEHy6fiQLTgum5WL0XIwGh2e
         oHwXaFvwb76clXcz3MsAuPvprmKu4Hlx+Dab5khy2pAuTVtuXG0HXtMLr7hh8J9ngkCQ
         B2AQhFdHeL9Je7o71+4oI4ku815/HneT0GLVt+XUmep+rRm/c/drA/xwFMjDCIiwCfq5
         p4i4YV7E41Ixp2DMbfJdsb7B8rU5yJvHIiYuv7kSV7QtpW72tUqWVHLEH6HNJ/wTd9ve
         1VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565360; x=1707170160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UV/iIRO0zfu5R/kLa/LTz7qDudbKFOHxBhGDjxapsKo=;
        b=sdJf9JsJI6BfQGbPlQa28fMTtrCVn6Mwif5jZB2wURw30zBKTcS6EO+e4HiwNChOrl
         evXoxHNdlkNJcfE5gyCYWPD78sSXKgudZ9ZRdNxag8C3rbofXU/BClhPKFwTZUlZXrb5
         z4DWoVlCk1JqkzkdI39fZxPRiKsRx5TuK28Ndr2fXV2ArPd3S7+tftlrCRMwQ4wJxhcY
         G1UaDpF7aKe69tqdXiqyB56h1Aeor5qG9QYvuANMuCpqFhS9oZRZmbZ+kKgS20Vgqgc9
         ZiCo63YCmocz09c7C9mj3vwPTHTbdydrXR+TsKIOGXCU1hO9lOyk465Wyi4VDInCnZ84
         YWHQ==
X-Gm-Message-State: AOJu0Yx/d2mJJ1I6/wP05Rp0rEZ23+Kgl3/YLNb5bjCnORQ5XwF6slio
	hsaIA20qtqJjEX+GpTAPM90tgvFglM6nPdygB9gf3GBvIvwMv2uXU4g5JwGHX616luPz32+6CV/
	Rwn4Aw803RJy4UhLSCYvs5NG/MT9zte/EjEoC
X-Google-Smtp-Source: AGHT+IELjEtx1N3ZgC2LPqFWtfYXYDiqNnPtrpXq39glkGRg2Im482C6q3xB9Js6LaNJcY1os+w4qyb3C+vPGPfqqyE=
X-Received: by 2002:a5b:251:0:b0:dc3:6b86:f41 with SMTP id g17-20020a5b0251000000b00dc36b860f41mr4521462ybp.35.1706565360082;
 Mon, 29 Jan 2024 13:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
 <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com> <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 16:55:49 -0500
Message-ID: <CAHC9VhSG14u5UUYiU6kUDt8jGMPkHAs67F_kc5Xt+w_P_zEovw@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> unix_socket test is failing because type_transition rule is not being
> applied to newly created server socket, leading to a denial when the
> client tries to connect. I believe that once worked; will see if I can
> find the last working kernel.

If we had a socket type transition on new connections I think it would
have been a *long* time ago.  I don't recall us supporting that, but
it's possible I've simply forgotten.

That isn't to say I wouldn't support something like that, it could be
interesting, but we would want to make sure it applies to all
connection based sockets and not just AF_UNIX.  Although for the vast
majority of users it would probably only be useful for AF_UNIX as you
would need a valid peer label to do a meaningful transition.

I would need to chase down the code paths for AF_UNIX, but for
AF_INET/AF_INET6 I expect you would need to augment
selinux_inet_conn_request() with the security_transition_sid() call.
Possibly something like this (completely untested, likely broken,
etc.) ...

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..1c6a92173596 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5524,7 +5524,10 @@ static int selinux_inet_conn_request(const struct so=
ck *s
k, struct sk_buff *skb,
       err =3D selinux_conn_sid(sksec->sid, peersid, &connsid);
       if (err)
               return err;
-       req->secid =3D connsid;
+       err =3D security_transition_sid(sksec->sid, connsid, sksec->sclass,=
 NULL,
+                                     &req->secid);
+       if (err)
+               return err;
       req->peer_secid =3D peersid;

       return selinux_netlbl_inet_conn_request(req, family);

--=20
paul-moore.com
