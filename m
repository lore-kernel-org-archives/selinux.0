Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022375;
	b=xlqTOISP1f0Mrk/ygA+K/u7oYlEa8MWV7hoACijUXc+pbMYOQSEnrJE9zGEzc4sgpdPO
	 +xNoihV/OVULdG907s0XcsgRnB0HObkbzOG8cYr9P2d7ww2jsNZzyjqorB9Qkp9HjInas
	 86OH3dmc5OkvabiPHhBS0qqAVbty3xkY/ypZE4rMx3vU819xqSY3SvUDqamXor4eaTauI
	 tT9aSgrUJTk1Ff7fh709IgCExal3d6nUup5Eqz+sBbkw6prla0veJ5RXHF5125LD5tjVX
	 v8gTZsZ/PvVWPOu10myPSdChANRClcUncN1YtAtxjW/qnii2vteDfr3M9Te3agrmhOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fSIH3Idnbme5KjmN3IM0sSilw9A/JCHKG35LNvPVbAo=;
	b=k9UBMqb63g/gjw3erMZHWcdeEEim0xi62dE5yajYc3jDB2KkSxLiYeY8+DcYVDPsciLA
	 uLrnZ+FpyBYp+3XLMhM6cbX1XdgkAUo1njME7hTiEe2IYorkB7J2E5VfCxoZ88ygMO1KK
	 iXDUIIfJcDLbeops65VW/Vvo2zTYBc14kxX3VmXu/xMdtLrixn3P8/z0z0eR9yK50w2lG
	 lESR0zwRQ6CfEIRGn53iPpQgYHSPqmIB0m5Uel7hwgH1CuPMU74JZF9USi8Dxkox/a86O
	 oBoX1V3yimQJNY+AAjoIS99gIkNjn+eMDOKlmLPG2TKPTavtgIG2h2Evtx2S7veys1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Wekrzm/D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198D606A31F
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D198D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wekrzm/D
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679e6ab6471so3622662d50.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022374; cv=none;
        d=google.com; s=arc-20260327;
        b=QIKBERvA9QB7LQOiewk5FahVbxdAi19c5PU+sJJPMe+e5lrAQQ0sZ4HHlQlK4UUOBC
         /VPzBoeFFBXLAlMxa24S9MxGD+erm89Y7x7VKmLOpEkuyuXB2ms/nnWMUvibP0IvkjQF
         TyDE9k7Mp4g/PJKIVKUF68ufMBXj55/1kUOXTc+6svNJKZU0QyN1tkcpW3UjayZOk63g
         7/bLukkQcXiJ1frGL1PIvEWUVk7y6JCQ6/vqTDKSlNWnjZy2har9RRR4foOLTta2Es8e
         6KMB0lChefeLBlq/zJf9Pb+u37djV7KoEtwIz3H8geWo5kpweQ9BcX108ln/XVMjb3Jh
         s62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSIH3Idnbme5KjmN3IM0sSilw9A/JCHKG35LNvPVbAo=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=nxmCf18utAUcf0HiYYS6umq+FAOxLVicd5Vs8dDB5ICGgaCyfMt/8P4VgLPOS1PGaa
         bJY0L0Zh5xWeozZK5q7Y6mYAkVeie26GOmd0/Ckjmwvsu8Vj5GrYsBS5psqofylTBN8c
         11NyRo+rBy/EFuEcmjqyu4nsTHhX1BJhpckz6/A6zA3m16e6jUPSPd6nV8ZfL+Q//lMs
         MIvYX9+/VHQIczjoxC6SsBW64D/nD2n/rwzvnb2rGI4lRFB2SV/pVZuZjis+VVgNeZ+9
         GvHRQVXe3gXZyFZsBAvtrVrJh0WisHzvHrD4ex0q+bx7iHvB9vw4HRyPKa/UMOJzTPdP
         4vjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022374; x=1793627174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fSIH3Idnbme5KjmN3IM0sSilw9A/JCHKG35LNvPVbAo=;
        b=Wekrzm/DNjiGCJIlBgR2K9xHX2ddSaJkeHMjRyeXefa7pHb1nM9HTkMBKCOZ97tiTE
         jSvz5TbIw/A3U/vsXGOF3lyop3fDUZJYzdEETU920sx/MUBE0XfNH+JtfFgZPD6wkfQH
         v+InoMkwRcqI/rj21XwTWdp0q3bAG5ZEX4W23paV6HMVxO6wLH2auAAyaykXAve642z/
         3ZPM51U2KgQPZJXfdQf6s+zqb9Qmod9pNGQ76AwrQgxobaqzM4MBS0vMl4xtuSddgyxX
         F3zKj82cuFe3qhiQvou9blV3VKR9L02On0B1XNZC3usHXDyy46+b58OkdloKKJFgsSiL
         Km+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022374; x=1793627174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSIH3Idnbme5KjmN3IM0sSilw9A/JCHKG35LNvPVbAo=;
        b=WPokdPInu7/dbOowy1Pzh1AfvDYyyDVZnMa8GE/sHhXPveVGtUQuK1yDpks4nAIy4B
         eR2Y+ejh8mWjAIf5jxPLxM68g8TmJpw8nHKYUzYVoopr1buDzQbq4X7okK4oMPX0/aZB
         e919DSZ+VpO14sgCrq5+GL6y2OKtX+RVG0uBra9ci88qQyV6bZnb7ZBHPpSx6yNsjeFR
         A1H1Vnd+34RgLqghg3C6yj1X0DCmqf7HHhyGn7T+b2K0tLiGSih84aHu5X6qCrGnAQY8
         IC6MxReYicS6pUpjioYv9/JL1jXWjNSLQNq0kuWtG3dTroN8gA9EK5tds+otR2o59AJz
         ixVQ==
X-Gm-Message-State: AFq9FYIGiw97hBThKB8FuHzX909IMyF3M9mGQe6hQjUrX7XzxTZjt4MA
	TRyKD7+mmE75mCrOsGXx4Iqjxaw/2qNGI6aAAnzCEu6DsnGBkdCFQwt1zL5oXlmVuxU2DldK1Hi
	mw+qFX5sbovkDPlG6swKNoGwzAKBw9YVOni4oBvg=
X-Gm-Gg: AYBFou0cNTEj7yvqhW9IjOA15MRExQhR7mNDzB2n38lFsH2sBKxtyNDrg2vaJZuE6P6
	Dxj5uHPNNhiLYJnpCJpdLleQnmtNzuPn8lf/00tgf0sgtmwdtj2l1lTLXqWqZO45hEY+p31MA22
	3u0BW8XjTAq6Mr5eswt4Mo+/DI8JQEkcd9GyYgxjI59BpLJH8ZX74abNVk9jg3Ey6uyjUrszzE5
	6a8fTEd0bBUHgnpKmyte+un02rWX5COHLMXvxb4bnqVt/JTUIF23OQqQHdhvG8Em6uYCsJPacN9
	G8nQiLVmYvVcBRT2KnfnAQ9D8f1wlGGCVSy7Web6ckNY0vFuU9Zve+6yhu9CQLZEAduHWXvsL9k
	+eSmEiIF50dXRsW2P0kia8KN4gkMvfljFSjBGsHJIPQbfbSqurqu4G1Ku4QBBoW97OS3dO2px+6
	yC1ifEKcd6dUTanLQg8r+dzA==
X-Received: by 2002:a05:690e:d84:b0:677:b2d9:de8a with SMTP id
 956f58d0204a3-67a45938d76mr4257772d50.43.1793022373940; Mon, 26 Oct 2026
 06:46:13 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023193159.63971-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023193159.63971-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:46:02 -0400
X-Gm-Features: AclHuK8JqDL65o542nyF9WuFu5hT89nD3ZkhxApHYh05gfk0OZAtoOF0iT8LuA0
Message-ID: <CAEjxPJ5kZV8fG2GYazFXMgbYkVu4Etaj2GOo9Hj4XH=E-79Gpg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: use the availabe user name when a join fails
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:32=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> A user join may only have an extra-data record. Its error diagnostic
> unconditionally calls semanage_user_base_get_name(record1), which
> dereferences a NULL base record before the logging callback runs.  An
> allocation failure with diagnostics enabled therefore crashes instead
> of returning an error.
>
> Resolve the name from whichever input record exists before allocating
> the joined record, and reuse that name in the error message. This
> covers failure of the first allocation as well as later cleanup paths.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged with a typo in the subject line fixed.
