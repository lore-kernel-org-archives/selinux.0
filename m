Received: from mail-yx2-f17.google.com (mail-yx2-f17.google.com [74.125.224.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC352843A
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687486; cv=pass; b=BZ2gb5y99vK0evFQca1Q3aLuKGXGmCr2qKYm65dWoc1GJW3sjaWRsnaZfT7gxlyckdduZgBr7ojpifd9w0Pr4sd6XY628W4mNO7hYM03OzUj+fWh6N8phEYIBYCfCswbSR5+7gbKzT1O63L1/IucpI4Ftheay8csPToEIDp0PuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687486; c=relaxed/simple;
	bh=5g15xvX4uufs8IMCe3M+URzXk8ibMRbv6qQWDjPVJBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzCpfYh9D3h2VbMQOgE6AeySmSvhJLr6AkH6XUafJxrk3yPWz9UKVqzYU79ZfENFNTWYlXv5H0Ii1uqnFmJeAomjWMT3ac1jf0uF6EJZSypei8EemDt/ETm0rTr0126Cn9fHwwevMJ8mgQvcMXBKji+ahE9VqNdkGwJV4MD8/Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soc/WPQ8; arc=pass smtp.client-ip=74.125.224.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soc/WPQ8"
Received: by mail-yx2-f17.google.com with SMTP id 00721157ae682-8ab46253999so4699067b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687482; cv=none;
        d=google.com; s=arc-20260327;
        b=YrkfYYT3V5bnJxpOhENvCtO3zAi7Nht6avKrJv8JrdrvxW/BwYh9bsMORmxDxXp9QX
         3I0enPCAq0War5FHA0ruyMxXJk48NpRGp/kUMvqSrvwKv5fmnp+pl1PXOSH4A2US28Kf
         fur3JvtVajvDMOkb9mmpLakBewgzORLsOmR1/yJa8VEYblnYmRXdozkRxNvRZrTGqjhX
         oGSvehsfrwlUV7x+/VHjT87yz10Zz9qsuMfc5g4r7NQlwnoj0tggZ0XFdQGVhGEp/Ufe
         r2Si8pxoNj2B90LJdAUd2jrAE34bKGlQFtOlOa79FKA8FL7LDNBSN9IaRL7mFJHJO5oc
         /YmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5g15xvX4uufs8IMCe3M+URzXk8ibMRbv6qQWDjPVJBk=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=L8dcDJqzCjhHJ6s1lEa78NV5XXLYSy5hhP0IFNr9dXPRDZWIh59RDvobvNtXeRCXKB
         y0YyF+7ORKO5s2be/yK8PnBmgqM78TWjUmNxmWZQVUTMi3TTz0VSlKSc+TPKlN27X5K8
         SDRhB41zLqEWZsuTCMim54wOobIiNWSJcry4iMLgziDB813B17tQUKOOJS16cAoQn9gq
         pnfnm/6jaTctMqlMT+8lWRbnQJDTI9f4X4ib3OBczgi+93KR1XCVWzSbiWkWLIPIcZQl
         YNyaCV46mA/s4kyupnDe0OY8YRJfuRvSag8CUdHf8/dT1X1r+gV3cxtqarxZh9aSJzwN
         dCwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790687482; x=1791292282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5g15xvX4uufs8IMCe3M+URzXk8ibMRbv6qQWDjPVJBk=;
        b=Soc/WPQ8pssOfKY6TkjPkX/ZxXlDqmz3er3uRRUYWqctX5hw1ghH79SctUGZCjgwD3
         eXgH8xlOLxIh/21egXjhhwI9nl1kC38ztcG6UQgAWUphpunP3e8yCNCghH79PIO53/R9
         ORg8jUErrfFjfH+vRCj+jam8L96N5+8/CNeThpge3VUmtfE/RLQBjehnSpcOOcaFgmcO
         kFm1wI0xtAdEJsp/hqIpkToDp2vO5IGDcp83poPuITmzfwvCD5Oyhd+nffdlrvipS9cl
         nAz6OWK3Q7cO1PfaHCAjy14LA0nMlUkwDTgT1GRqsuUTwkN/dihTE5NF7RfqHaeo+3j/
         pYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687482; x=1791292282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5g15xvX4uufs8IMCe3M+URzXk8ibMRbv6qQWDjPVJBk=;
        b=Tr4JYV6+lr6lEXvx7LswRFzch+YaJTZCXe6RY32MkvTh9P5sx75kQQcu/rJFEl7itU
         uFQh8P+bi8lpoGsiGN7DyQRySde1qufPRCmJM662YOJj20D8Djs27bcwO6I+1WfoYMAV
         qZoyA2PgFfZB4mBlWmAZ0rkzh8lSOC5h+On8+WA4QrXRNUZ0MW1EpHr/hrDZwC9ETCR9
         jB79N39JZSeSIJAy1xMvxjDjaPfuw9Jxbz2tl8LnCSMBeSl0VsQluyE5euuSFR2k2Sex
         6Jl9/riXGpZzLrzHkIhpKuYVQ7acYQXCtpkIMNcMjW/YSXOZB82gt6YwABugNAiLUQuu
         tPbg==
X-Gm-Message-State: AFq9FYIFowoc1WDqM3hMfxmrrZKQaHimF9elLSoNU4ch06fSjJL9W6Yy
	aU0911mh55P+B/Z00OHUptaEwa3cDs0hI8jB3ZRiKFvwwUE8wn5Hxxoft5KW9p97ZVf9w5sJHSb
	c41Md8+zM5nDUUWa5ohtdy+MQzcVJtPOwvQ==
X-Gm-Gg: AYBFou1R7qVGlhRrTcMi0Y+Ny7rn1tmPersRpiOs/ZnEOcJ5MBKd7i6j8J2bobHjFc1
	T7ec6dRUSw/AUBN5p5VlYqD707u996JRNRYZE1PS3hVi2FFSTnqVONJ/5G5x9TA47QJAfRPC4I4
	zEZX3v+tIIxMfFLvVdqMlghLWpTGwMmzjI25u0uWFtJQyW+IF8BqaLrSebhoJCMBRyL//L0r/wY
	rUQ3l7ds1UIDdfOs3p3J+7k3d2nw+FDxnonjH0VIq647unUldXsd3j9nJlHxMbCeN4DLOhQIL2r
	id1a7FWiIf0oiw768ZNzzqNMxnhkhNjUf6zM7IGe1doYSeHZu/N5CG0=
X-Received: by 2002:a05:690c:e3c1:b0:8a9:977a:4118 with SMTP id
 00721157ae682-8a9977a41eemr39704017b3.58.1790687482215; Tue, 29 Sep 2026
 06:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 09:11:11 -0400
X-Gm-Features: AclHuK_BKbcRwtDw3oulrzOxj5Eyt2xCa02lwj22kolqOZQBURjAosm4geqCEp4
Message-ID: <CAEjxPJ4wTLNn3pmDiBSYbE15UggddijD96FP9Rg3Tc_Y6PLkAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: validate user MLS range and default level
 at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
