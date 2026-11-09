Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241519;
	b=aIDYsYVej+3lpxRdh07iYCPGxhg/fJ8+SQLKA2qL5DqX8Fk8DAyfOcokWio7U9pCFt6w
	 5Tc3yBd+wxzk3J03bbVK2HfcDky7o5L0SbItj+75ZMcl6245D9zWTMe+wpz9eEoL5l97j
	 Iw/t3DtOal24LJbggzp57vM3XxV4AnbnayMYo0Mj/Z9w/DLPMNvXjtbosyVdXGUNFoY7B
	 /gdVjgBZO4O/vGgcLpsbDH9sJoAYnb/ZNnTzEkiP34bTpRTb7nAIeB9gwjps4BRCsoe+D
	 v6ZsRifqGu+t+I/b+PrWR8HxKYB9NsmkQhu5z4AIR5pfvO6v9XbXvrjiq+iw7z9IcAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C9Pncgv0qtiIHTENTtBT4u3VCHF4NXnZdO3wuIoFoBM=;
	b=thEloLqLmw6743lSbWyBBt+9Gld2kv0H2ApYib1oFAoCtAbbISLXi5i5p9Jw8DnLf0WH
	 fcZGunfHYG0S9xfESWn/ynZPqWL4cer6UJGbLoVeGdPN3D0+WvIn6wqrh5jl6dm+guN/9
	 ZwlJbWk81WoliBjQ5XSDX8q1p5qp3PWlVjZRhecyig74sXQ5TAiKbYJKsms58aKTUXVhO
	 6IX+kwzwVA3y4xUZwz+Ro8q3oRBePs/IDnmjLTIrxttZVXsxtrgq9TlmoEZxFs1NxKcR/
	 U0ZKzrZH+5Li+8hnUvHIRm4jh9Aj594oaSjhUB4JgYRPL96NnqfJEAY/2v/wQdFtBOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgrgih8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552A606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E552A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgrgih8Z
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so1654632d50.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241518; cv=none;
        d=google.com; s=arc-20260327;
        b=VrYqGK0sw/xLzy0lYMjhk/rJ7nTFgsHoTUyC6dqh41CAnjtWrnqNv4AX363xHGLZeF
         pJ/GWWSH7d1Mp1uFD8lDghq/CDHdZy6Ws/iFcRxkx5Us/YmyQBIthYppcRWjsIZvqS4N
         9XmtEC/hj/gpQByH402cM6+fwFshYUx9/Dg7Sc7m8cI9JoRx56EwqC0GKNY8TH0zOLWv
         Hsqwm9kkhAriKl4wCu9JXRsmMNL8XNhlW5nlXbCQWL7EdW4IZRzDFy6ioTq91m6Gcvnc
         FncxczXXHVjRtlE0joKIFXTYBjpcaQhB7h//AC0rwZVzdLVl0dwL1zh5qBN7/bwLGXGM
         bM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9Pncgv0qtiIHTENTtBT4u3VCHF4NXnZdO3wuIoFoBM=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=f9TKcV8vo3osZ1dTR7eQG82+uGrZ4PuKggppi3SnnpRVHZbz4FLnc0ekVTEAMtX33N
         qgmvbGMjiqSZ2vX5k7oAbogjY/VL4n6yeTxykiU1JBtH+Yrz6xbnXRiB5KY2B2DGZuUI
         dztoEi0JGoQT7GYWwWkORmLMvm+UEjtkF5ZTAbnz5Jj+txc6ol2oUppOZvd7/s+2OxWU
         kT+1t5sqJD6dvcGTrltiZieWMNby3Vnw/JV+imfNHSaHE8YrwCXENu45JAc9Fqz/W38x
         i+J52a6ixH8RhjoT1PCjYMjPe76F2CBS2DuKFPW8YX48xh7DHk4ylCxBFszdm5bpZ6sc
         Fh4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241518; x=1794846318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9Pncgv0qtiIHTENTtBT4u3VCHF4NXnZdO3wuIoFoBM=;
        b=wgrgih8ZdSXnsI4mBc+wAt8vyCNw1uQnEXhCw0Qjn5aZh/wb8NWBWzDos88EprAR0G
         yxC9DQWNUCBCwaUFdG34tAsk3Rv12U91svXirdHtWFgoH9F42tdQJOtp/knWitvpxKJ6
         aHMq0dVEwqneazLElcuc4j3/ZJaaMYgT9c4tcqBw+CvWoJU7ltm2TdtO1juQr1/bt2On
         lR5LuOC/rOmFZSqHATHuPZ+2NszwOMCeYh9hquAZ8hRVPKPA4hFVZ894HFDiMZcxCLUC
         T9X/vxmY4ZT/ShwkZulJIQiSfB12pzSALDhRZnfN3GJ967SZWhdn3k9u1E09th8wMiWh
         WsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241518; x=1794846318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9Pncgv0qtiIHTENTtBT4u3VCHF4NXnZdO3wuIoFoBM=;
        b=EQ8xXGjDTxNFcxLnrhvKigq+5Jrq1YQf9rrDnQgyGV0A412bmuSmQTSDIUiftMoyP5
         od1Yhsnei/lNYe30Dg7GM+8+XkeKD9gWTVrFF6wPpdJb781Lbx2ETAmXBt7th9x1OB+z
         N4fYjXjzF16NFHV/3yyMUEmaBvyJrAN5XvIh88bpYiWGMclSRFwFnkjWI9BN2VxLTY/9
         VdcIHf99699+KOT1rYE4JK9ycsc4ocYfrQ/w26vMunp25In9rIPBcyVijzzMUg2Xeb5r
         6zKK5vwanWLt4HDwZBQlomjiJtJYOyUrsQWmyHMN8RfC/pFqFzSv7DKAAl7Jqn1LG5ji
         Dhhg==
X-Gm-Message-State: APuU4Z+JTSWn47RLavJDzKe3spiVtfMHzA38i2fk2sGM157gasLhA1j9
	BPdCqg4tkZZH+ej1vMWYuUk2fA5aIRsWDODSL9cF95bHH6XeZTePRidX5JF5QqjkNWfnW5zb7uy
	BiBzy2HQBD9MqFVCTJOypIz3jGTfZPEe66Uja
X-Gm-Gg: AYBFou1YumaxdbST85mvaIiIEFLs6x/dMuCRA/fj+qoOF9JO6CluO31kuheHRLI6bvA
	7XhSfj7smDXCOpBo49zTUF5S86yJbVkAz1BI5Icg0ZJtHnHGIfGBTt/Gt/n0QiVJwPq3Kl97/BX
	uKYlmYQrYRrDW/ez6m9S9McRHUL6/FVTV1UQ/PYXhBdTSdWjX1WO3bq7kHU9J7QMX1teKPbKSvE
	Y/xwWLi7KzmU29v0p7h9Jqa+av7eJsvVv2okMT9qcxNS4ZVlU5Nw2XSBBv5bTBYCb/A+Umkdwyt
	vJE6cutp7sQCYU4TIcO/ZvD9xnzRxbvT2yOHHolRdCG58bRFCbdASUlUEDde4zb9DQpS2cjungk
	2+K0S1KBhe4gLhuqeKlDOqz8W+bFeb7xKNOLgTkda5V7PSt/7Sjo/W2LA5Hn0pGC7R64ccjScCb
	+Fa7TeguVoisC76AjLuYpRQwpgd1poOkcnyk1t9X3mi5jcVepmU22ApqFQ3A==
X-Received: by 2002:a05:690e:164c:b0:67c:3655:5875 with SMTP id
 956f58d0204a3-67c5660ca40mr63921d50.5.1794241516580; Mon, 09 Nov 2026
 08:25:16 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:25:05 -0500
X-Gm-Features: AclHuK_UI4kW84GBKR_7JzZR6vuebOqSYBFSy47BAYhWjZq7hwKU1H4zlSOGQSQ
Message-ID: <CAEjxPJ5gqia+ardsraOZou5VASK0tmgsPE=w-BJkp6bBz8rbUw@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsemanage: reject missing scalar configuration arguments
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The configuration scanner returns a NULL ARG for empty and quoted-empty
> values, as well as on token allocation failure. Scalar actions pass this
> pointer to strcasecmp, strtol or strdup. In particular, the recently adde=
d
> sort-local-fcontexts option crashes instead of rejecting an empty value.
>
> Add a shared scalar argument production that rejects NULL before entering
> these actions. Preserve empty external-program arguments, which have a
> different contract. This also covers older scalar options with the same
> problem.
>
> Add 114 regression checks for scalar rejection, valid values, parser reus=
e,
> empty external arguments and token allocation failure.
>
> Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by=
 specificity")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series except for the audit2why patch which conflicts with the
just-merged series from cgzones has been merged.
I'll rebase the audit2why patch later.
