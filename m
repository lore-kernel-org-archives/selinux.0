Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFE13B584
	for <selinux@vger.kernel.org>; Sat, 14 Mar 2026 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773448349; cv=pass; b=BGSyzN+qxB5WGcny6Bwr56EW6nw53kDiEudkQkC2kMamPPPRP+1+2oyV8JHdgmvyY4JmMT81eRvtDsoUgl3zf4vVUzJXkJBBxKcIBK4Vt+q5qwK5mQFCyj63tGNlq2h7+U1+bLgP7Dv0PSLggkZHwG8HluxyNbrOkh6qDudOHYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773448349; c=relaxed/simple;
	bh=zcn3t1p8ZHRfGiAa8SDTvYSe5yh6XutktfgK+z6O+Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK5jxsVGj/GTiAvqQU1iYh8HHzlN+CcMDs4C7TiLYzK2VxBOYkRzSkIJxWvHygwSCkRk/R5QpdU1ITdL1gYilo1FVHN2tmMgrQ8RR90r5qcel4N4Q0/Kp4BHmTB2Nhab6nf37pkpQ3/mlLLqaUlq9TpXDAED2d94deMbRmVRfFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hp184NcG; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp184NcG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50906a98ffeso192681cf.0
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 17:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773448347; cv=none;
        d=google.com; s=arc-20240605;
        b=MwMyrsgVWMMaEjxumCjggq49LUsF4RrYxNUgLwqg4BLGHgloz6C6kke/m7iO3H6zZn
         fuMR0Ad3CV6euVpjrdRUUlbGg5jeO1u49TPddYepGDM2PofU6G92pQEbVy0JGlMGKVij
         D7jWRdkyl5883VQ8qA4PjjKITxdEuTFw/v5J2Y1BBfAXVAMwvaJzUpfEdUTpPHiH2KSv
         Evjn3p1AaFOwmbqw3Bxp4lxGw/IMF3CYZq/sw6HtlZnSL+7VmrvsKDpOcbrFuIfg47bK
         0aeGjboT69fZZHxWjPOk+5sjRoK8sl2q5y8Sg2nSgwlxo8uaFM0J1lXhpzeezEoUcb6L
         llnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        fh=ZsiczlnOpNv6N0a9B5AQIWoXk8pS6VQj1zrxoQQ5wvk=;
        b=Bw15vp6NccaTPyjZCP23CI6rEp36sAVFxdZTFrw9TLUVaM9gbolPTNdGBGgjXcUnr3
         eOTtvdPYKahTHMjxA98/aqFyOhLoPEe52nwhTTu5EPuyw/A9CDQs+Bp5gSEKhS3fqhJh
         D0HQzMZ8OhuES4smvDuia9s5QSjnpVk50geUMSkojlc7qbuQNcXTWeoNthvI1Hefm1F5
         DS44rDGkswIeRAPywOndy2eyY06Mm4BCybfESk2dmL4TmNv3e0ybxTkmCM7L+IF5ycvf
         Ut7yVNMLArMVSYIj81h5hGfnkewm9Es3CPiNr3bDTDH/q2tYWGKvc2wxXPw1TZ4bKPMw
         XAAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773448347; x=1774053147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        b=Hp184NcGLx0UxHjjI0BYZpi/G31UWsaLLFjB7WikfzxL9UAgRQPhEIulDqU88cyMgP
         ytJZwMj5Q49sDIWgCbR45VCEix8hlgC/Znfvd0AE7969hCka3cLfWqPyg5h2eLXKQVvw
         5Mdxj5l8IA/4Whq2CqOaqTGSS+bjrMcWhtLQrUTVeS/iiOufTI/6sK120HvqggvmOphj
         IGIinOGV7GP3URvVKSBcwb8bTGGUMH4TOfc5gtBSgbP7f7Gnl+vmtroaahbe8ZS+kEMb
         o2fU80qC4I1B6BlEbWste1avoFOjnDq4dpcvxdmsPYcXqujdIbP5vGasGTLyzeqNt5DT
         UOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773448347; x=1774053147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        b=JrvG3GCSFIiO2YTGRA6DH0DK1EIU8Uy3o/5M1pHe6f2Z2MreG4O68xeUEesO5odtTE
         PVgOFVlQ+aCyoQ4doE5hu1nSEb7P51vpZNTwrkF+5tEbs1IPOnACslYQzHWNlQyurB4P
         W4vZZjsBnwHASNLnNhzrH2YSm5y5pUEQDUR2dFmaq8ccoHnOAtaL9CqUMezwmW1vEfA1
         r2AjWbjW+GfD5TgB1TFQ60w1MefhmoctlMEWU7LTIclZV6iHtZX1yvieh4s41sGa26r4
         uo/IXukS3MT11shjvb8c5OBnxLRiZ3m/8zDJ07T661YqF98Hh2DhY3Q9bFWzpnHbIX9g
         zfmg==
X-Forwarded-Encrypted: i=1; AJvYcCVvjPwe8xF4kBOI9P5//EeG0OzEbj1Wp23IfhbYIz2fx67/fBhXuj6TGQQIKZKq+xFCb0M7km4m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx831HhQ1VJh/WgXWPzbz9gEoYpN2m7sbkkQVkyNZxVXT2ErzuP
	kke3WAtN08vhowe0uudhEMKU55vyi8/BGoMpsnJoBGllGoqPGoD9QoQxDB6SOYPg6HkDF/wKNau
	RV6d3dp8186jPqYizUZL5lIYv6zTFD6f0uPNqMcns
X-Gm-Gg: ATEYQzzi68rhNU/iw3BTOgHwg/FNGieNhpE4+cjWL50O//DlG3n7jbAUWqi05tYS1CY
	fB6zVtl99nf3JXwcJBW7frlWQjzGOhvsgaHwmb3rcOjva96AZuJExm1IY+OToxon5kWKbVC0rzX
	37v46yybgLV9j8aapWyle2ernJwgK3VaB5N0JU2wWCCeYml/oRSoSfP7VwJWphDIoEGsWQGAz9D
	2MFXcqwPTasgE1AqCLORnB/kQDh2S6m/lp3q4+KnAltou26Wa7rplY+eO9CoNFIjRFY5wcaG7Z9
	as+lyW9TO7dRufnFh3vDdEWaCEpztMSv6MJ9Xw==
X-Received: by 2002:ac8:7d05:0:b0:509:371:f2ab with SMTP id
 d75a77b69052e-50969504334mr6040711cf.16.1773448346543; Fri, 13 Mar 2026
 17:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit> <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
 <aa2K8pXXipCH8cke@Antony2201.local> <aa_750R5Jm5qPbNs@krikkit> <abBMMZWNp_zN23xL@Antony2201.local>
In-Reply-To: <abBMMZWNp_zN23xL@Antony2201.local>
From: Yan Yan <evitayan@google.com>
Date: Fri, 13 Mar 2026 17:32:15 -0700
X-Gm-Features: AaiRm52S6PUaJxrK8Lt6NKYUuHQdExbomiEXV3nbZSeh5kp55Rm_5BrVQohqTNA
Message-ID: <CADHa2dCdFKE4Wg-uSmYLmh1-JEf=rZOA2WUmRbTy0S0rp+rz+A@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
To: Antony Antony <antony@phenome.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Antony Antony <antony.antony@secunet.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Nathan Harold <nharold@google.com>
Content-Type: text/plain; charset="UTF-8"

> yes I can add that. I would add XFRMA_SET_MARK/XFRMA_SET_MARK_MASK together.
> If you set only the SET_MARK mask will be 0xffffffff.

> I am actually using xfrm_smark_init() which will accept both.

Great! Thanks for supporting that.

> Option 1: add XFRM_OFFLOAD_CLEAR to xfrm_user_offload flags in uapi xfrm.h:
>
> #define XFRM_OFFLOAD_CLEAR  (1 << 7)
> When set in XFRMA_OFFLOAD_DEV, it means remove offload rather than configure it.
>
> Option 2: add a __u32 flags field to xfrm_user_migrate_state in uapi xfrm.h.
> There is a __u16 reserved currently used for alignment, but 16 bits feels
> too small if we want to cover clearing other attributes in the future.
> A __u32 at the end of the struct avoids that constraint.
>
> I am leaning toward option 2. Any preference?

I'm also in favor of option 2 for better extensibility.

>     - XFRMA_REPLAY_ESN_VAL / XFRMA_REPLAY_VAL : may be later replay type
>       should not change.

I agree we should keep the replay type immutable. Changing ESN flag on
the fly would make it hard to keep both sides synced, and I'm not
aware of any use case for this.

-- 
--
Best,
Yan
