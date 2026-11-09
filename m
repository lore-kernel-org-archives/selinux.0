Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255303;
	b=Aldf0ZCp6fifkjq1sxTBGb4+1i8zHYXAQgkgW95TMzB5fw08MTkqDxGDL0NGg01gcLvz
	 cYkket5Z2I6x7rcaZSq7s/CCvNz2io5PkDQprVSFbDTOSC3YfgRa2Ixy8c94xKjIrNEb4
	 iGBLgf8CKQgUSwIYxjrjx1lUCQZlfRO7W7JhDzDrEAV9DK9J1qYI4ZwnM5FQ8tQM8Ad2d
	 +ktiXN8RBUb3QxSG9MyQEP3dhYbCwiN3e9CKh7w1TRt7mmtCAwQCZv0H5SARrdAr2TDQv
	 u4bA5+bI7ATrJe4SZEdSEgX4/L0lAIv9rkuBMuLKbKHdzadHWkmeUTBaSm/dOm6G5Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
	b=YddkJHBNXiAOGhx3QsdHhxmut7swrjN98bJG82LEHSqHg22frYHikd8wq86xBWWTEMrV
	 QZmHXhci01KLt6xdrSL/+2HfrLB1iV0d8hGzyBCayvb1YDli15x+cNcaUF92cQ8FoJmxq
	 Mpjvq9sNLvzvKJ0C5X0KSZbMau4veA20x3/ThP9zPCcc68WnBS33CCauM3XmApDoSYi8c
	 eSz+H9mD4utBNs2gcMEFgDEYPimlCQxdDWXS8n/GyQLvv0CammyfLTXm8IN5NJ+02KOCJ
	 B2K/YweHVroFrj1a5nGX5jBxZVnMx/aeO/sqlDFppaUfbrZLDuAn+WXl+DOEw0ELIag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAB606A334
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 20:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CFAB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso590921b3a.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 12:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255303; cv=none;
        d=google.com; s=arc-20260327;
        b=Bm9UVPnyEi3oQcNveG1WbiCbJVgqscxbsLTqmucPUrsba4PGwZIU8hyXvwzS6ePPvb
         dDkt9JolB/q6pxC4n5bvmJncUkjc5hE6LZOstTAKHk1BDAaWbuPIylpq9nSKyZcwga9u
         8A2P+L/U3Lzzfibd2EbL4UoH90lfQEf0tv7fcaIvmDiWaDBZl1C0Dm6s3B5mu6TuiX5M
         J9vN1bEmR+jkEk+OjWuiJiQWLoWbjW0Vzzc0te1bMXtDIlTkKr5nTZX75Fj1JlQxWXjf
         8WN9OGmRkGnuYjh1bcr0SDHX9Rs2+6xdDTzr9EDFYk5lCngrBUAy0q86t+T5h6TpTuO4
         zxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        fh=s++bmpc6fdI503e8kyv09ZBr7Q8sBJgyHGBo25HJ54M=;
        b=iCj0gU1k7MuznFcEIlsjH8VHAkaIn2SXuAj0NICh7jOZzk/+9DrT6ajq4UU6wWUhGX
         XpT127cT3mbrPOCa/Dk2z0xrwRYJmBQGGk6r84sLV/sx+uoryxh4Q3iO0kymVgqmf1oU
         fw3CRkqAXbTbtgRBYpvp11qYWtm79TlgOKFecX9uvWFZU354NU1r5zb39Cs38VhnkLzk
         m55VVKDOJJ8Q+6Nzoh04XLCpM5nIy0avDR8v2trXY1UxYqnNy323R9baqNOJ86tKdgLv
         azesndv2FQP0hLwskROqz2gcwG592A7H9HhcAQ3iMbytmjF26W4iwem+fwxbZ3Wc8FbN
         zf0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255303; x=1794860103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=JM3aG7UDhE3ppbxcli+QQzARg2Kk347vy5ytnvpfinkJQjCez8mFUwcYs8+/PrAO8z
         qQXYwQgzy8NbHr19R7sZA4uRrRbYDLtCZTFfnP5xl9j5o2XEJs++ZuMTq6tvsc8/HEJn
         psFEtb6JYK9B1K2UCYWdaKijgaM/Sq6WoMXKjc08cwsZyhvosTpftZa2yma2RSbfY9xo
         Q3vHnPYquzJjxSmB1OqnqGohXqzBVuNzvCn+GTJhiNm7oW7SLON4wQa1VbC7cxzBbOjC
         DAXh9HTRv9+dK3JjCLtk1lYJ3Sq5ALw0klGRsuHQqUUOUkAIo4X4iR8NKPL5u45oL4wJ
         ht3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255303; x=1794860103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=2DYsq9JP6vQ7ucaiRkCiTzRl/K9oz/JJOf1bW1AkC4zRnH9cnL1XgadCsqpTft8Wnd
         x9EHX5kJZJMRloleER6N4tK2r75B8rQ8pN0JVm85ch0GV8vgjJqvx6R31R0fdxjcDeIW
         4NUcmo+8bRRQl09FebJZ/fEnKJfscCchVRr/drmJ+s/4W9X+FvMD40pjRqx+pMc53e8i
         dki2yOpMLWjUwNUWRH8nUP5+aIrAa5Sby2j8ZyDzx9gh/VPgtfSgrjso6S5u5IqRReqd
         Hejo1ODYS1JsWSSpf0MpJ+9JJQQHtm4ayurRxQXz41/0/lJ2Fba0zhEdYDHHRi9F5r72
         wvDg==
X-Forwarded-Encrypted: i=1; AL+hErGMbzWSZqqocSsPs/z814s9R/mfxaJq46awlBdWsu8MZZ0OAwWP7WFG+Fni4UVOx5efGA3trE/K@vger.kernel.org
X-Gm-Message-State: APuU4Z/C2DJFFlLh4Yz9mc95FwPvan4caeDL+k34ji15LQIacOOTshsO
	kzXH4NDTVQegoxFTgEFKfNdkJxsf/3equETRX40RI10P57qM5CWOiRaWqJJV3/8jNXEAP73II0Z
	sK2dEXNsnrYJenKv1nNL0hkjXx2BQhg3RYDqBe4vP
X-Gm-Gg: AYBFou0tbirIdqRKr8F+KOr9Lle9ZCUdiss3Z3JhygXEYj9EOML1EIb1iepb9NB8C5A
	yHjDQOWhOq4RPXmOstWDAKByyzmcX65wuk3dJl+Xz3Xh1daRFi55NvqF13CAXx4o4riEKBNO52A
	nKLWUf76zscv74hgkHQy7J4zzAcl1BGEG/FYcMPKPYLp5RmimU6xm4AdoV6yilOrnNaScJ8paYJ
	APei3xTua4hIDH2Nq0NHkgkYImHvo7mkP5QpWAotxfTXvDJv/3AfSP5janjN7tMffMMF+teiwGX
	Fn6m2mePDhQUBdu8rXXnR384YeEwMUsLBNookBmHK7zkrAg1Y5CVh1oJQ4nc4/B8TrG4JD+fj/C
	jwpSjo9DXSNCeh6D8iX6O7mrSZzMFglidrHHFsW4ajFcx6hBtU2MeYZqljwOweE4Ljlop
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id
 adf61e73a8af0-3f18f4ac9aamr162563637.27.1794255302075; Mon, 09 Nov 2026
 12:15:02 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
In-Reply-To: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:14:48 -0500
X-Gm-Features: AclHuK-R76EHDsnszW-O6Vgi4DzxwqLyNag33759siqThBnXu2JAqQRN94reBA4
Message-ID: <CAHC9VhQGms7L3EL19tB+TRKvNP3ttSumHOdWcNM2377-fQiEOA@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jann Horn <jannh@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:06=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le ven. 6 nov. 2026 =C3=A0 22:40, Jann Horn <jannh@google.com> a =C3=A9cr=
it :
> >
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I've sent a separate mail with a reproducer to Paul Moore.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> Side note, not for this patch: Smack calls netlbl_sock_delattr()
> and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
> not exclude a concurrent lock_sock() owner such as
> setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
> old inet_opt. This already exists in the "cipso only" branch of
> cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
> the copy branch has the same issue.
>
> The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
> this from lockdep. Smack should probably use lock_sock() like
> SELinux does in selinux_netlbl_socket_connect().

Casey?

--=20
paul-moore.com
