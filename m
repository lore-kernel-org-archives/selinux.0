Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863213776B
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922318; cv=pass; b=VXTa/br3u3y6hI5/4QpxD0F940LXn7cfbrkHI2KTLVP1BhtOIXcarmIFDmXJsbvEdS13FM86Eu7cPQOaue0shX0+D2N73/9+lsTG6tmbjxX3hW2GrqqPmLxGIziDqs+3gz9+CX6a7DsjR69Vv/j54l5dBqhmW6EIOjKhPERTbcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922318; c=relaxed/simple;
	bh=pajnVni3fs8345lKRDE3FBdUZGFKUMVeC0hP96aTX6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMyKimPduGceG45ba8uV65NcYCgtRynaRiK/6fNxjiNtaP1juUWzqxYajqe6Su4zV2n5fGQcsA/16PUBVnWhb5yuA0N0ltXqgY+s4Yo3XHiz0NwgZ/JSMV7ircD+E0QFZ/ONJU3lu7HYilsE5Okh1cjvNPVeYHShYL6XfwQt4eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9xMtPrb; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9xMtPrb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso114075ad.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 06:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922317; cv=none;
        d=google.com; s=arc-20260327;
        b=W+/zHtUCr6Nu/s+AD/atu5Lf5oFwmsSUPOTtno+4HWpbV8w/xndUGndUtxQ2Rgfr/L
         rSE0w6qBG05SEm7aFK0bvMRaosP4ciihcT2yWuIJOVbirAf1VLQfcXM8Hdb8dVg3cG0U
         zUJ2vV5+9wEz/CX4pUtg7251QkzlHbJepsShL3a/NXfueUj5r3O2s6tmAaqTry+ytms7
         fUtvkaduKQHBy7k10MG7ralRe7yneQxFuzjxZeJcK1UIPuR+Zi2f6DtmnAS70tADm8EK
         3px1+L9zMBEP+63XJmNSl42TS6W2SRVH9UG44271aQx4UANU33Ii8AVb+CK4XGhDgMxt
         tcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        fh=KxV07ozr+sTNvEF5yzwnD28Scn27wW4/c/VshdIJ5A0=;
        b=dmg23fQ3+93c5woc4R+AkloAlo9s+QLcFmxdJxvLuidsyVOqLwI9h0Gb1bojPcSGRD
         fGGU1tUkLWbn+JoUQl0zLOWveeqYHaRKy0slsuUqVkgQmoccrDqWUeFoarJfS4ZvmyPY
         v+cC8WZDXqmKeuU8p+2S1/5qOeludhy4rxF5pv/sBPL5brX06DICCYHTNss6QpgGIdoX
         ainRFSM7qXJTVQnLMNhZQ9IKFhGP3HwXcThei6GbFwC4mevdBZdyx6GZ1/z6rhebmeuN
         EctCZptqbsGkepd5fJWVQ4KO88UWwuu1jLaRE0cryonhZ/o74Xy6gGnsi/ih1h6gyG5X
         9mLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787922317; x=1788527117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=s9xMtPrbI2x8d4KzdhJwQ75f7SuKGJFJduQsbl43byIuGIM+LumG6m7kK017wSxnsj
         5ephCSET2uQRpKk2fTa/VeI4zaQRGe+mqr4BJ9N587Em3ZPJFVxHuxi+kstCvGWO7ZI1
         Umk9Sh7dMT3DhbdU6yCbJTnCNOFlV/HvSdzxIhOB0JRJoOXIS1GfzZiTcNhepGp4FReT
         uygpTFo3O2Zm28B3M6FxJho8mLGv6iMg2nbAi/bfG8jXRQqTYuqv1BWavat6gYrgmKwf
         kHoxOrGmo2vFPk82zKAal7NBlRBC3DRJwhRAw0O/QJgs7vJprFtoso5TBzZcexaMFlfb
         WxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922317; x=1788527117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=j1MlNeLny17HdF/NR2X8bTXq4TT27gx905hCxwwqNgT2ty/ai7e4jKWxZQJY1DM3GT
         4Er+PuCWrmVHMxJTxyjqjtGbOMaokSMa46JYh7D9HrtHuoR87DE9voTHe9yRizEODmQe
         S2W6zkUewYbxoEfY9FlcEnV9EA1oH30d+OrZ9R6DJ93wV6mBGL4ZIfJ4128AWVwgCcq7
         h9F4zeNdTNO2tCFpizkdqnwmFxKBsB/xsELIfidh6lK4ImRRl0smakRCYJRhHiioWpAu
         jMmaUiZ2JfBNMfmm7WGaK/RkZpxSLqBtv9ge+IVDowRar91owIG0p4NDRRMxvDY5+wAF
         VL2Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Ebo+40h1D/ci04+Lvhm8nQ1Kfqu+Bmh/XyYsrTJVQGtADF/F+VrTOYsTxlpCLbTpmUesW+/o@vger.kernel.org
X-Gm-Message-State: AFuF++kYOdc5oyZID4nkAsQXyrekxv4ZHarjHsOGaPemVV8iEo1szaEI
	QKHx9Tg2kBCp39C4sHhjn6ZWTh0gnfWprhtLwgpbr95hOA3XyIkNkaRSDf16LnvpjuLsiNWSBO8
	m6vCjQcl7S7iSkjvbAF8f+2rz8lpDDKqdyS8vQv9a
X-Gm-Gg: AR+sD10Xw3waJ6soOaH10aIfaeBoUSIw85I9B+rt/Cq+PD5trqbLkkybnc+q3NMEePv
	zPUtgTDuQWoDxItbg3i8KYCOsldjj3J6A9FtzT/IyA6+KtdK6Rqq07EH8Lxcyg/y4wvXMhLhfk5
	JfDFe2DWN0tZb4PEAQ2EzglmIEssJS8T13X7JLkHMdw0Ogpp7eTpbh3kdr8bRM8XM0qeF+CNwMj
	t31Nzab/td/JVsXUW+87ofSo7uApLHNWTYJSCls1fQQGTc5mZIaXvi7A1ttoE+3mzSLxTDgw3B8
	GhChPmaF31bguvdInFHqprsiv0uGtBRjKfA41x6Biha5lDCtL1OZHCyOE671xkulEjNkUxhbHVw
	reL3PlQrUiiVqpX0cmGFbOuMsoomwkbg=
X-Received: by 2002:a17:903:987:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d75482c43emr5737145ad.3.1787922316046; Fri, 28 Aug 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com> <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
In-Reply-To: <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:04:38 +0200
X-Gm-Features: AcwNN1VyfOvZNu7ELf4xzHHJ3BQoTm58QSMty2PAZc7oNVjQteiUlR74XB89qaw
Message-ID: <CAG48ez1NsUqpZmr66RaeFXMicpZT2FjMfwqTJwcQva50XN6cGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> I realize not all of the SELinux hook callbacks use proper kdoc comments,
> but I'm trying to fix that.  If you could make this a kdoc function heade=
r
> comment I would appreciate it.

Ack, will do.
