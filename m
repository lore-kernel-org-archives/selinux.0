Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165337207D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205379; cv=pass; b=Cassebuqe/e896Kv7hWwh/pyp+SM7zy6o0OmfUPBonPHBQX9fcqL1OdOmRl558ahGfx9FEzH/hnfuR8OoBdQwpCKDTE7NzZqhizBYouryB7JOHi4RYk8l9vVz9f4403LFzGbh6a5J8lhjtsTW2FhhQQq/L1zKaTf6wA2xemoqSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205379; c=relaxed/simple;
	bh=sr/eqOIX+Z9MB3/TpROL/v7EbPGXnEcmlsFfabUEQDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwHwOidTrQVPsSfjoxXzcgE4qaWQqydwcyjMZcujrG+zOyCRskcLjYm1ZxhXIraAsZXNaJ8pGzcVO1mxgAgaR7NJN76LG5IannFcLYRWuKNrnDlOQ421PFdTY3Z/3JaQuwHVG1ToN4AQhSLZWmY7MAUGhmKViYVapXQMyTHVUOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NtpU9GOn; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NtpU9GOn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc891373e0so35084345ad.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788205378; cv=none;
        d=google.com; s=arc-20260327;
        b=Yi2/LqqUXwZDf4ekbhE9ntDcX0dMcdOI2D9xUbB+ZPmDTG3jUptxcbgWnVQ4Ontcob
         3LLXDFkz5V68SS8K84nMrCBi9HyssX3EmNk2Kv5rLYNh8e+t/wYt97lS495DafBfF5Eg
         KciTTu1yx4tdPP+B0YFckqfcfDygSf5D5g2Mng9jg7V+BCwiDYGVx0OGrEadokkTvaTc
         CSIYBYaJjC2FbMuaIIuFyXx6pqwo3TLjEkGhC1XwL3xvN9Z9lCoixoVjNknpUTd2sl1J
         m/8XPqxV01FBqi3chH1qznnvZfLj6VQnFvfRlQ5DKUQO2El1smjlpb2bt0rhTUmKm782
         +q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHbz4BC4GAMuWvBa7024L+tDqIiPuF/BXtCWFjzaYSA=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=k7OLr05/U7pcWCQPBBerQLmhGjllHtBBB2trL8venOxsdLhVvjcQRd8hTAinA5AZmH
         4YQtd0J7KED5crOMmvu3R2zPNF1477kUB/7xWYv+sAloOBftJywnewgEwfa7zpI6zpRB
         8A2Sz//3VRuOsM8GTPXg8Yvel6sSg8bbLvWe41emwSrlwgwbfK3BPKfdA5EQg10yJtoN
         Lpp7hWioIqgC9IGdQR1x3lCk1oiekdF05pJyLnzwW0QH0j7U8rvDTfkMXX5EeH5qwWsN
         8g1dN2bxQxHjwEedO6swODkmtXYCrwdpG71gQx/8/DxoyZmsgRYcpR7UkPdKWrEBEPJe
         gOSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788205378; x=1788810178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HHbz4BC4GAMuWvBa7024L+tDqIiPuF/BXtCWFjzaYSA=;
        b=NtpU9GOnkQeeIrp5a7Ggkx5PU8VDYdGrB0LxEEK82iZNEMCMKAi9Vi2CHSpRSKzN7D
         +zTCQkztwlKAsvi5+NwtIup62bwVZFhSxqMyl7nu7jPoGu8ocUtPAxf/wdGToyTbu4xl
         /bmmOWwy0ywH3Gii0KeJ7uJJHQs8sb/RwuA4Dbeh0ZMzo8/Ucf7A3sm12TtpX1c0mHox
         0mWEfU5FX8x3az50Bj4v0yshIwQProZCEeQMH9p+II0dsbpahKjV5oqZdLtmYD1DmL7o
         imqbXoh4FEdpkXHbgZnVKIz7MF3MkHWTqSAduOhYhHVu231Ejq8S7QSrNSkm9cdx9D/K
         zVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205378; x=1788810178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHbz4BC4GAMuWvBa7024L+tDqIiPuF/BXtCWFjzaYSA=;
        b=M89I8A0yawFNQMkLyWOHf6zUuTb/1jkkDV63duxoomuk/l/CHXN8QcEjvrqmZjjg2y
         dQZsKlvD82ywNqSNoW1pXHKPH1KIEIxa5EXL/MWhw5MKZoDgkLhBVYoPUgmvPq1zS0eN
         BV4DF4PVyIlYe/EIE5nZAnKjpqAjSpN/rHavkc3ivONL9zY8mXxn7y/S4UcCjGCFzqHx
         DP62vUa3/Ins62iwMi/lwtMRpjvGJ+mCBPw8lf1Dlrdis0dOA60sSNdOw8y4KpF88HtB
         zxgsCcj5hwc9IeGb4FKkL6/718QGc0tcW0gCoNwK/4HhNuwprVUI2AdqNCjc8UhJhzaM
         IICw==
X-Gm-Message-State: AFuF++kraXssG6Gn11mXKEgkstsAsQV6C5+zTb6Jtp5pXEoUcNEBbJHC
	/4EnzHpEaYY/VlqQKVrBVH4LHJHhmZn9WQek4MUbGAZgRUyWf6hBy5/rEeYepD6S05/BKa4jfpV
	+wHXeJCn0YhDzbXTxD5tCxwLA2CaiWg58P6nZ1kLiKaJdPxsHlH2keA==
X-Gm-Gg: AYBFou2nBBsfFm2ex40gKczlgKx/dArOLlye3Ab29skTmwjOdhAWouRCtsSlEE/W5jk
	hayJcVjbFcs4wqUDcC1f8n+Aqw4NphqJqV/3NzuL0IFCttJb6OE97Ieujlec1g/x/TouePtT5QV
	dVrN8Y0fPGiquCATYgBJAQycqIX4kiN6qoVXXCJsoTaB0fxJzv6mvlSI6pF7SFiGXnG1/7baeOC
	AZJKOtynOER22ehD11ADkDyhCkl5+mxGbd2gIo+iT+IVg0Mmvhu2lFZPYymoBhsrkBVKLsIRAlv
	tcqXnHwzEghIii75m/ZvJ6SVPuQxV06GotxVA1//rz0I
X-Received: by 2002:a17:902:ce86:b0:2d7:2edd:d140 with SMTP id
 d9443c01a7336-2d74dbfd59amr401646805ad.3.1788205377742; Mon, 31 Aug 2026
 12:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151203.108111-2-paul@paul-moore.com> <CAEjxPJ68+3+OJnm3Kwh06CN1dqO-9mWM6HDc5ufrN3gK3sG6jg@mail.gmail.com>
 <CAHC9VhRCQ5Y7C5R_jra28KUkwcWVgL+2+3qHzQnyt5Y3ZW-Y+Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRCQ5Y7C5R_jra28KUkwcWVgL+2+3qHzQnyt5Y3ZW-Y+Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 15:42:46 -0400
X-Gm-Features: AcwNN1U-c4PVMr4C_XgEsbT9yKxVuLb-wdcx3JZc6lFq2LhwjLz2QBNNHuz02aE
Message-ID: <CAHC9VhR3+UHKrWWVHWKhqWPBmzFxHWK2stz5duOetuqvaTqFZQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert selinuxfs inode numbers from unsigned
 long to u64
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Aug 27, 2026 at 12:40=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Aug 27, 2026 at 11:15=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > Starting with commit 0b2600f81cef ("treewide: change inode->i_ino fro=
m
> > > unsigned long to u64") inode numbers were changed from an 'unsigned l=
ong'
> > > type to a 'u64' but somehow selinuxfs was lost in the conversion.  Th=
is
> > > patch corrects this oversight and converts selinuxfs to 'u64' inode
> > > numbers.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Thanks.  Merged into selinux/dev-staging.

... and now it is merged into selinux/dev, thanks!

--=20
paul-moore.com
