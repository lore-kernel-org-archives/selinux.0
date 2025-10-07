Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF448488
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846596; cv=none; b=X+yNvAlSKeewrR3N6JGsu32a5CmIp3Ly2OoyvwQn+vaAKxoFFt6jFchHlQ8Q87zhDU4TgYcev3mV33dEX7hFU4of0HwaEPFV4rwnqiX/ov+OBlgUXyB3N0kRMrRfY1V+ojQ+AsZPtTZqTb0rRPMo+/ua6MX4wD5+1CcWmc6mqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846596; c=relaxed/simple;
	bh=iCHcElAykouhkug5L5BAJvesOX4lBVmv+vvlWYLqdys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8aRBwCfd3wxpgTFksyPN9Fvf8hNujoKVN/RMbQySGW2f7tZgpkGSB2rmKbvmuywL6MslOWMJKHuX77ofy9FJtY2sohH/FBlrz7SucaNblD0rUkYnxOncqwSWe5r6FD7CrBR3mZbk4Ryk/B3g9EDTIaQyCqI5OO5jbyYo6jxY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN7SZJ+t; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN7SZJ+t"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5520173a12.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759846594; x=1760451394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdOonYanretRIHwDalGK9vMPY69wQm6XUrFmq/uQYFQ=;
        b=YN7SZJ+tIMXMXF+YzrPZBGgSzS+vstLFQjFi4kim17apRJTcgqTptn+8uQfdBM5rZo
         RVr5fuc7j07YkWaYNww0EYon34wUzhT6hr39gBmO0DonuJ64ZG0wuWpfeN6jPd9ksflJ
         M+NGwaAq6E9lFyxmdjIjBuS7uEEI0jXnIPJPM3aqtXukkaiXkDgFHq7uE6B3ujpvY5hg
         FuKxM6n1dhcZbZ5CDyj3MHPFExs5eh72jEwH2X7X/8UaBsNYOeahhSEpl5SJUyKkE1v4
         VhKBgmXTBgh6mDFmGg8IL3cxUA4gR+oigmBO+ZFz57i5C7Azn1LvnE/m9hckBHdJeUDn
         pjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846594; x=1760451394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdOonYanretRIHwDalGK9vMPY69wQm6XUrFmq/uQYFQ=;
        b=TwyAXpOFceJD+Jt9bajsL0BloaRkp6HNZ2IIYIco2/FoTUSz4eI+jEauOuT8Pxjqhu
         bQ/c8cBZ8NBRlq+AAK0UYaB82gLxxRk4mlYEzLxA+sfUdgJBmfh+2C+4olN7Jo1e1ixI
         d/cnbwrCbkSRM+GTihaRgAYGijU0lTYUvA9uTc/JrZL63C/kihjuiiHktRru6/+K+ey/
         DpSjpiVUM4tn7aqM+5vkDD1h2sgroxzzValqOsWOmnDVoZ5RuZdJvz7qnwxQKYFnxx4l
         D0VeR+2rVsySdYsSZ50xrMrvDJ3KVeWTSVNkb/vn/MIpxGiD54FqMajj3bKeSkQ1sCbA
         kUYA==
X-Gm-Message-State: AOJu0YxYo1ffhMDhkjHCQ004YlZH4C+rjaXBy77OxSYVaaePiu+HEjqW
	o1IWOS4zCRwoHKJPZynJ+6ueN58Zk4luvBAI1RJe6asG0/pNXgITHJ2O4Q7KvEORPEOX3lWpdWY
	yIx+lLLg0Cz4zvT0yTzYRM4rfiZU6erZKaA==
X-Gm-Gg: ASbGnctrJu/vnWBNMi2eF2OTCAAxsrEqJIG31ixRNj9+DBj7Q/UMSwc+1TEaxrSVmX+
	UI41JbEXGwz6oC4IGuE1zWTYRvdQtqcgcBJITwwnkrmP3+ZCfjoZu6C7UrN6cKNyeN25UzWDW4h
	dd7ecYVg7FNH8Ktr4epffmKS0AdODGOSDhWfAl2FHyU/cSmaZqQ+fms7kTaUu8Z10wO4TFGC1cd
	WCBwbEEzIN3eUMxLHOXcaFntYi4hj0=
X-Google-Smtp-Source: AGHT+IHIQacChJ3MD7DK99c+KdKelGmxZiwDYgh0fUytbYEA9D2GhLzAeTPAkH1r/Idu6U9nnc5mXZbTzQbL0K/4fyA=
X-Received: by 2002:a17:90b:1805:b0:32e:9281:7c7b with SMTP id
 98e67ed59e1d1-339c2724b89mr20615879a91.3.1759846594293; Tue, 07 Oct 2025
 07:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716144435.1084767-1-vmojzis@redhat.com> <20250804170953.246873-1-vmojzis@redhat.com>
In-Reply-To: <20250804170953.246873-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 10:16:23 -0400
X-Gm-Features: AS18NWDNEhlYgj4XQ870UvnJEThMF0Ox1ctK926Jy3oLRI_8gtLQFdY7kyDihbg
Message-ID: <CAEjxPJ7v3ij+vCf+1qw5O1+y5cy+shOORBoQzsZ8av7dW_BDYA@mail.gmail.com>
Subject: Re: [PATCH v2] secilc: Add test for attribute assignment to attributes
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 1:10=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Not sure I understand how/if this is integrated into either make test
in the secilc subdirectory or the selinux-testsuite but at the very
least, please provide an actual patch description before the --- that
describes what this is and how to exercise it please.

> ---
> Added a deny rule to the mix, which also behaves as expected.
> To be honest, I gave up on more complex examples with deny rules, since
> they quickly become hard to understand (but at least never caused a
> compilation error for me).
>
> Please let me know if there is a use case you'd like to see tested.
>
>  secilc/test/attribute_assignment_test.cil | 79 +++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 secilc/test/attribute_assignment_test.cil
>
> diff --git a/secilc/test/attribute_assignment_test.cil b/secilc/test/attr=
ibute_assignment_test.cil
> new file mode 100644
> index 00000000..dde3be5e
> --- /dev/null
> +++ b/secilc/test/attribute_assignment_test.cil
> @@ -0,0 +1,79 @@
> +(typeattribute a)
> +(typeattribute b)
> +(typeattribute c)
> +(typeattribute d)
> +(typeattribute e)
> +(typeattribute f)
> +(typeattribute g)
> +
> +(type ta)
> +(type tb)
> +(type tc)
> +(type td)
> +(type te)
> +(type tf)
> +(type tg)
> +
> +(role rr)
> +
> +; Basic attribute assignment
> +(typeattributeset a b)
> +
> +; Assignment with types
> +(typeattributeset b (ta tb))
> +(typeattributeset a b)
> +; Expected: a includes both ta and tb as members via b
> +; seinfo -xa a
> +
> +; Chained attribute assignment
> +(typeattributeset a b)
> +(typeattributeset c tc)
> +(typeattributeset b c)
> +; Expected: a includes tc via b and c
> +; seinfo -xa a
> +
> +; roletype assignment via chained attributes (tc -> c -> b -> a)
> +(typeattributeset a b)
> +(typeattributeset c tc)
> +(typeattributeset b c)
> +(roletype rr c)
> +; Expected: tc is assigned to role rr
> +; seinfo -xr rr
> +
> +; Multiple attributes/types assigned
> +(typeattributeset d td)
> +(typeattributeset e td)
> +(typeattributeset f (te tf))
> +(typeattributeset g (d e f tc))
> +; Expected: g includes tc, td via both b and c, and te and tf via f
> +; seinfo -xa g
> +
> +; Cyclic assignment
> +(typeattributeset a b)
> +(typeattributeset b c)
> +; (typeattributeset c a)
> +; Expected: ^^^ Should exit with error
> +; Self-reference found for a at <test file>:38
> +
> +; Allow each attribute some access so that they don't get optimized out
> +(allow a a (dir (getattr)))
> +(allow b b (dir (open)))
> +(allow c c (dir (search)))
> +(allow d d (dir (search)))
> +(allow e e (dir (search)))
> +(allow f f (dir (open)))
> +(allow g g (dir (getattr search open)))
> +; Expected: ta is assigned to "a" and "b", while tc is assigned to "a", =
"b", "c" and "g" and so are assigned permissions accordingly
> +; sesearch -A -s ta
> +; sesearch -A -s tc
> +
> +; Deny rule
> +(deny f g (dir (open)))
> +(typeattributeset g tg)
> +; Expected: tg (assigned to g) is allowed "getattr", "search" and "open"=
 access to g,
> +; while tf (assigned to both g and f) is only allowed "getattr" and "sea=
rch"
> +; sesearch -A -s tf
> +; sesearch -A -s tg
> +; ^^^ the "open" access is assigned via a new attribute deny_rule_attr_X=
XXX,
> +; which is assigned types in "g", but not in "f" -- tc, td and tg
> +; seinfo -xa deny_rule_attr_XXXX
> \ No newline at end of file
> --
> 2.49.0
>
>
